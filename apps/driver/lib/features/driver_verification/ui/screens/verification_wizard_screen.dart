import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:driver/features/driver_verification/ui/screens/selfie_camera_screen.dart';
import 'package:driver/features/driver_verification/ui/utils/document_scanner_launcher.dart';
import 'package:driver/features/driver_verification/ui/widgets/capture_preview_sheet.dart';
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
  const VerificationWizardScreen({super.key});

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

  // Documents use the ML Kit scanner (Android); the selfie uses the front
  // camera with face-driven auto-capture.
  Future<XFile?> _captureSelfie() => Navigator.of(context).push<XFile>(
    MaterialPageRoute(builder: (_) => const SelfieCameraScreen()),
  );

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
    // TODO(provider): hand the captured images + vehicle fields to the submit
    // use case and route to the uploading screen (Phase 5).
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم الوصول إلى الإرسال (Phase 2)')),
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
                          _capture(_licenseFront, scanDocumentImage),
                      onTapBack: () =>
                          _capture(_licenseBack, scanDocumentImage),
                    ),
                    VehicleStep(
                      photo: _vehiclePhoto,
                      onTapPhoto: () =>
                          _capture(_vehiclePhoto, scanDocumentImage),
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
