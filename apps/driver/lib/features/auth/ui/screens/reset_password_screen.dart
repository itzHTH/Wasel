import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/widgets/reset_password/email_page/forgot_password_page.dart';
import 'package:driver/features/auth/ui/widgets/reset_password/otp_page/reset_otp_page.dart';
import 'package:driver/features/auth/ui/widgets/reset_password/password_page/create_new_password_page.dart';
import 'package:wasel_auth/presentation/providers/reset_password/reset_password_controller.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_step_indicator.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

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

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleEmailSubmit() async {
    if (!(_emailFormKey.currentState?.validate() ?? false)) return;

    final sent = await ref
        .read(resetPasswordControllerProvider.notifier)
        .requestOtp(_emailCtrl.text.trim());

    if (!sent || !mounted) return;
    _otpCtrl.clear();
    _goToPage(1);
  }

  Future<void> _handleOtpSubmit() async {
    if (_otpCtrl.text.length != 6) return;

    final verified = await ref
        .read(resetPasswordControllerProvider.notifier)
        .verifyOtp(_otpCtrl.text.trim());

    if (!verified || !mounted) return;
    _goToPage(2);
  }

  Future<void> _handleOtpResend() async {
    await ref
        .read(resetPasswordControllerProvider.notifier)
        .requestOtp(ref.read(resetPasswordControllerProvider).email);

    if (!mounted) return;
    _otpCtrl.clear();
  }

  Future<void> _handlePasswordSubmit() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;

    final reset = await ref
        .read(resetPasswordControllerProvider.notifier)
        .setNewPassword(_passwordCtrl.text.trim());

    if (!reset || !mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.auth,
      (route) => false,
    );
  }

  // The token died server-side, so the flow has to start over from the email.
  void _handleExpiredRestart() {
    ref.read(resetPasswordControllerProvider.notifier).restart();
    _otpCtrl.clear();
    _passwordCtrl.clear();
    _confirmPassCtrl.clear();
    _goToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        if (_currentPage > 0) {
          _goToPage(_currentPage - 1);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.neutral0,
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
                      onBack: () => _goToPage(1),
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
