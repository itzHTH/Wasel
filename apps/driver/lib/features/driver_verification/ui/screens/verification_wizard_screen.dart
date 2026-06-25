import 'package:camera/camera.dart'
    show XFile, CameraLensDirection, ResolutionPreset;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:driver/features/driver_verification/ui/models/verification_submission.dart';
import 'package:driver/features/driver_verification/ui/screens/camera_capture_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/uploading_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera_overlay_painter.dart';
import 'package:driver/features/driver_verification/ui/widgets/capture_preview_sheet.dart';
import 'package:driver/features/driver_verification/ui/widgets/capture_source_sheet.dart';
import 'package:driver/features/driver_verification/ui/widgets/rejection_banner.dart';
import 'package:driver/features/driver_verification/ui/widgets/steps/license_step.dart';
import 'package:driver/features/driver_verification/ui/widgets/steps/selfie_step.dart';
import 'package:driver/features/driver_verification/ui/widgets/steps/vehicle_step.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard_bottom_bar.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard_progress.dart';

/// Driver verification wizard — three steps (license, vehicle, selfie) over a
/// swipe-disabled [PageView], with per-step gating and a persistent footer.
///
/// UI-only: the captured images and vehicle fields live here locally as
/// [ValueNotifier]s so each rebuild is scoped to the smallest widget that
/// observes it (no top-level `setState`). The marked `// TODO(provider)` seams
/// are where the Riverpod wizard notifier + use cases plug in later.
class VerificationWizardScreen extends ConsumerStatefulWidget {
  /// When non-null, a rejection banner is shown above the form (set when the
  /// driver is routed back here after a previous submission was rejected).
  final String? rejectionReason;

  const VerificationWizardScreen({super.key, this.rejectionReason});

  @override
  ConsumerState<VerificationWizardScreen> createState() =>
      _VerificationWizardScreenState();
}

class _VerificationWizardScreenState
    extends ConsumerState<VerificationWizardScreen> {
  static const _stepTitles = [
    'رخصة القيادة',
    'بيانات المركبة',
    'الصورة الشخصية',
  ];

  final _pageController = PageController();
  final _currentStep = ValueNotifier<int>(0);

  // Step 2 form.
  final _vehicleFormKey = GlobalKey<FormState>();
  final _modelCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _vinCtrl = TextEditingController();

  // Captured images, held for the whole wizard session.
  // TODO(provider): lift this session state into the wizard notifier.
  final _licenseFront = ValueNotifier<XFile?>(null);
  final _licenseBack = ValueNotifier<XFile?>(null);
  final _vehiclePhoto = ValueNotifier<XFile?>(null);
  final _selfie = ValueNotifier<XFile?>(null);

  /// Everything the footer's enable/label/back state derives from. Only the
  /// bottom bar listens to this, so a keystroke or capture rebuilds the footer
  /// alone — not the page tree.
  late final Listenable _gateListenable = Listenable.merge([
    _currentStep,
    _licenseFront,
    _licenseBack,
    _vehiclePhoto,
    _selfie,
    _modelCtrl,
    _yearCtrl,
    _vinCtrl,
  ]);

  @override
  void dispose() {
    _pageController.dispose();
    _currentStep.dispose();
    _modelCtrl.dispose();
    _yearCtrl.dispose();
    _vinCtrl.dispose();
    _licenseFront.dispose();
    _licenseBack.dispose();
    _vehiclePhoto.dispose();
    _selfie.dispose();
    super.dispose();
  }

  // ── Gating ─────────────────────────────────────────────────────────────────

  bool get _vehicleFieldsFilled =>
      _modelCtrl.text.trim().isNotEmpty &&
      _yearCtrl.text.trim().isNotEmpty &&
      _vinCtrl.text.trim().isNotEmpty;

  bool get _isNextEnabled {
    switch (_currentStep.value) {
      case 0:
        return _licenseFront.value != null && _licenseBack.value != null;
      case 1:
        return _vehiclePhoto.value != null && _vehicleFieldsFilled;
      default:
        return _selfie.value != null;
    }
  }

  // ── Capture ──────────────────────────────────────────────────────────────--

  /// Runs [capture] for [slot], then confirms via the preview sheet. A null
  /// capture (cancel/unsupported) or a "retake"/dismiss leaves the slot's
  /// previous value intact; only an explicit confirm fills it.
  Future<void> _capture(
    ValueNotifier<XFile?> slot,
    Future<XFile?> Function() capture,
  ) async {
    final captured = await capture();
    if (captured == null || !mounted) return;
    final confirmed = await showCapturePreviewSheet(
      context: context,
      file: captured,
    );
    if (confirmed == true) {
      slot.value = captured;
    }
  }

  /// Pushes the manual camera screen with the given framing and returns the
  /// captured file (or null if the user backs out / denies the permission).
  Future<XFile?> _captureFromCamera({
    required CutoutShape cutoutShape,
    required CameraLensDirection lens,
    required String guidance,
    ResolutionPreset resolution = ResolutionPreset.high,
  }) {
    return Navigator.of(context).push<XFile>(
      MaterialPageRoute(
        builder: (_) => CameraCaptureScreen(
          cutoutShape: cutoutShape,
          lensDirection: lens,
          guidanceText: guidance,
          resolution: resolution,
        ),
      ),
    );
  }

  // License/selfie are camera-only; the vehicle photo also allows the gallery.
  Future<XFile?> _captureLicense() => _captureFromCamera(
    cutoutShape: CutoutShape.rect,
    lens: CameraLensDirection.back,
    guidance: 'ضع الرخصة داخل الإطار',
  );

  Future<XFile?> _captureSelfie() => _captureFromCamera(
    cutoutShape: CutoutShape.oval,
    lens: CameraLensDirection.front,
    guidance: 'ضع وجهك داخل الإطار',
    resolution: ResolutionPreset.medium,
  );

  Future<XFile?> _captureVehicle() async {
    final source = await showCaptureSourceSheet(context: context);
    if (source == null || !mounted) return null;
    switch (source) {
      case CaptureSource.camera:
        return _captureFromCamera(
          cutoutShape: CutoutShape.rect,
          lens: CameraLensDirection.back,
          guidance: 'صوّر المركبة داخل الإطار',
        );
      case CaptureSource.gallery:
        return ImagePicker().pickImage(source: ImageSource.gallery);
    }
  }

  // ── Navigation ───────────────────────────────────────────────────────────--

  void _goToStep(int step) {
    _currentStep.value = step;
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onBack() {
    if (_currentStep.value > 0) {
      _goToStep(_currentStep.value - 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onNext() {
    switch (_currentStep.value) {
      case 0:
        _goToStep(1);
      case 1:
        // Run full validation for format errors before advancing.
        if (_vehicleFormKey.currentState?.validate() ?? false) {
          _goToStep(2);
        }
      default:
        _onSubmit();
    }
  }

  void _onSubmit() {
    // Gating guarantees every slot is filled by the time Submit is reachable.
    // TODO(provider): replace this local payload + push with the submit use
    // case; the uploading screen will then observe the upload-progress provider
    // instead of its fake driver.
    final submission = VerificationSubmission(
      licenseFront: _licenseFront.value!,
      licenseBack: _licenseBack.value!,
      vehiclePhoto: _vehiclePhoto.value!,
      selfie: _selfie.value!,
      vehicleModel: _modelCtrl.text.trim(),
      vehicleYear: _yearCtrl.text.trim(),
      vin: _vinCtrl.text.trim(),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UploadingScreen(submission: submission),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onBack();
      },
      child: Scaffold(
        backgroundColor: AppColor.neutral0,
        appBar: AppBar(title: const Text('توثيق السائق')),
        body: SafeArea(
          child: Column(
            children: [
              if (widget.rejectionReason != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimens.screenHPadding,
                    AppDimens.space16,
                    AppDimens.screenHPadding,
                    0,
                  ),
                  child: RejectionBanner(reason: widget.rejectionReason!),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimens.screenHPadding,
                  AppDimens.space16,
                  AppDimens.screenHPadding,
                  0,
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentStep,
                  builder: (context, step, _) => WizardProgress(
                    currentStep: step,
                    stepTitle: _stepTitles[step],
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) => _currentStep.value = index,
                  children: [
                    LicenseStep(
                      front: _licenseFront,
                      back: _licenseBack,
                      onTapFront: () =>
                          _capture(_licenseFront, _captureLicense),
                      onTapBack: () => _capture(_licenseBack, _captureLicense),
                    ),
                    VehicleStep(
                      photo: _vehiclePhoto,
                      onTapPhoto: () => _capture(_vehiclePhoto, _captureVehicle),
                      formKey: _vehicleFormKey,
                      modelCtrl: _modelCtrl,
                      yearCtrl: _yearCtrl,
                      vinCtrl: _vinCtrl,
                    ),
                    SelfieStep(
                      selfie: _selfie,
                      onTap: () => _capture(_selfie, _captureSelfie),
                    ),
                  ],
                ),
              ),
              ListenableBuilder(
                listenable: _gateListenable,
                builder: (context, _) => WizardBottomBar(
                  showBack: _currentStep.value > 0,
                  isLastStep: _currentStep.value == _stepTitles.length - 1,
                  isNextEnabled: _isNextEnabled,
                  onBack: _onBack,
                  onNext: _onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
