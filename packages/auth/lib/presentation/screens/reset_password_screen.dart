import 'package:flutter/material.dart';
import 'package:wasel_core/widgets/feedback/app_snack_bar.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_dialog.dart';
import 'package:wasel_core/widgets/app_step_indicator.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.doneRoute});

  /// Where a completed reset lands. Each app owns its own route table, so the
  /// destination is handed in rather than looked up here.
  final String doneRoute;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  static const _totalSteps = 3;

  final _pageController = PageController();
  int _currentPage = 0;

  final _emailFormKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  final _otpCtrl = TextEditingController();

  final _passwordFormKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  ResetPasswordController get _controller =>
      ref.read(resetPasswordControllerProvider.notifier);

  bool get _isSubmitting =>
      ref.read(resetPasswordControllerProvider).isSubmitting;

  // Errors are per-step, so they must not follow the user to the next page.
  void _goToPage(int page) {
    _controller.clearError();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Verifying the OTP rotates the token server-side, so there is no usable way
  /// back into the OTP step — leaving the password step abandons the flow, and
  /// the user has to request a fresh code. Confirm before discarding it.
  Future<void> _exitFlow() async {
    final confirmed = await AppDialog.show(
      context,
      title: context.authL10n.confirmCancel,
      message: context.authL10n.willNeedNewCode,
      confirmLabel: context.authL10n.cancelProcess,
      cancelLabel: context.authL10n.continueAction,
      icon: Icons.warning_amber_rounded,
      isDestructive: true,
    );

    if (!confirmed || !mounted) return;

    _controller.restart();
    Navigator.of(context).pop();
  }

  Future<void> _handleEmailSubmit() async {
    if (_isSubmitting) return;
    if (!(_emailFormKey.currentState?.validate() ?? false)) return;

    final sent = await _controller.requestOtp(_emailCtrl.text.trim());

    if (!sent || !mounted) return;
    _otpCtrl.clear();
    _goToPage(1);
  }

  Future<void> _handleOtpSubmit() async {
    // onCompleted also fires on paste/autofill, so guard against a double send.
    if (_isSubmitting || _otpCtrl.text.length != 6) return;

    final verified = await _controller.verifyOtp(_otpCtrl.text.trim());

    if (!verified || !mounted) return;
    _goToPage(2);
  }

  Future<bool> _handleOtpResend() async {
    if (_isSubmitting) return false;

    final email = ref.read(resetPasswordControllerProvider).email;
    final sent = await _controller.requestOtp(email);

    if (sent && mounted) _otpCtrl.clear();
    return sent;
  }

  Future<void> _handlePasswordSubmit() async {
    if (_isSubmitting) return;
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;

    // Sent verbatim: trimming would silently store a different credential.
    final reset = await _controller.setNewPassword(_passwordCtrl.text);

    if (!reset || !mounted) return;

    AppSnackBar.show(context, context.authL10n.passwordChangedSuccess);
    Navigator.pushNamedAndRemoveUntil(
      context,
      widget.doneRoute,
      (route) => false,
    );
  }

  void _handleExpiredRestart() {
    _controller.restart();
    _otpCtrl.clear();
    _passwordCtrl.clear();
    _confirmPassCtrl.clear();
    _goToPage(0);
  }

  void _handleSystemBack() {
    switch (_currentPage) {
      case 1:
        _goToPage(0);
      case 2:
        _exitFlow();
      default:
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleSystemBack();
      },
      child: Scaffold(
        backgroundColor: context.colors.neutral0,
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
                child: AppStepIndicator(
                  currentStep: _currentPage,
                  totalSteps: _totalSteps,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  children: [
                    ForgotPasswordPage(
                      formKey: _emailFormKey,
                      emailCtrl: _emailCtrl,
                      onSubmit: _handleEmailSubmit,
                    ),
                    ResetOtpPage(
                      otpCtrl: _otpCtrl,
                      onSubmit: _handleOtpSubmit,
                      onBack: () => _goToPage(0),
                      onResend: _handleOtpResend,
                      onExpiredRestart: _handleExpiredRestart,
                    ),
                    CreateNewPasswordPage(
                      formKey: _passwordFormKey,
                      passwordCtrl: _passwordCtrl,
                      confirmPassCtrl: _confirmPassCtrl,
                      onSubmit: _handlePasswordSubmit,
                      onBack: _exitFlow,
                      onExpiredRestart: _handleExpiredRestart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
