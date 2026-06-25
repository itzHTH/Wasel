import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:driver/features/driver_verification/ui/models/verification_submission.dart';
import 'package:driver/features/driver_verification/ui/screens/uploading_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/wizard_footer.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/wizard_header.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/wizard_pages.dart';

/// Driver verification wizard — three steps (license, vehicle, selfie) over a
/// swipe-disabled [PageView], with per-step gating and a persistent footer.
///
/// UI-only: the captured images and vehicle fields live here as [ValueNotifier]s
/// so each rebuild is scoped to the smallest widget that observes them (no
/// top-level `setState`). The build is composed from [WizardHeader],
/// [WizardPages], and [WizardFooter]; capture lives in `verification_capture`.
/// The `// TODO(provider)` seams are where the Riverpod notifier plugs in later.
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

  /// Everything the footer's enable/back/label state derives from.
  late final Listenable _gate = Listenable.merge([
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

  bool get _isNextEnabled => switch (_currentStep.value) {
    0 => _licenseFront.value != null && _licenseBack.value != null,
    1 => _vehiclePhoto.value != null && _vehicleFieldsFilled,
    _ => _selfie.value != null,
  };

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
        if (!didPop) _onBack();
      },
      child: Scaffold(
        backgroundColor: AppColor.neutral0,
        appBar: AppBar(title: const Text('توثيق السائق')),
        body: SafeArea(
          child: Column(
            children: [
              WizardHeader(
                currentStep: _currentStep,
                stepTitles: _stepTitles,
                rejectionReason: widget.rejectionReason,
              ),
              Expanded(
                child: WizardPages(
                  pageController: _pageController,
                  onPageChanged: (index) => _currentStep.value = index,
                  licenseFront: _licenseFront,
                  licenseBack: _licenseBack,
                  vehiclePhoto: _vehiclePhoto,
                  selfie: _selfie,
                  vehicleFormKey: _vehicleFormKey,
                  modelCtrl: _modelCtrl,
                  yearCtrl: _yearCtrl,
                  vinCtrl: _vinCtrl,
                ),
              ),
              WizardFooter(
                gate: _gate,
                currentStep: _currentStep,
                stepCount: _stepTitles.length,
                isNextEnabled: () => _isNextEnabled,
                onBack: _onBack,
                onNext: _onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
