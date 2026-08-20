import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/providers/register/register_provider.dart';
import 'package:driver/features/auth/ui/widgets/register/email_page/register_email_page.dart';
import 'package:driver/features/auth/ui/widgets/register/form_page/register_form_page.dart';
import 'package:driver/features/auth/ui/widgets/register/otp_page/register_otp_page.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _pageController = PageController();
  // ignore: unused_field
  String? _sessionToken;
  String? _registrationToken;

  // Email page Controllers
  final _emailFormKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  // OTP page Controllers
  final _otpCtrl = TextEditingController();

  // Form page Controllers
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  // Navigation
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Page 1 - Email page handlers
  Future<void> _handleEmailSubmit() async {
    if (_emailFormKey.currentState?.validate() ?? false) {
      final result = await ref
          .read(registerProvider.notifier)
          .initiateRegistration(_emailCtrl.text.trim());

      if (result != null && mounted) {
        _sessionToken = result.sessionToken;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم ارسال الرمز الى الايميل بنجاح')),
        );
        // Navigate to OTP page
        _goToPage(1);
      }
    }
  }

  // Page 2 - OTP page handlers
  Future<void> _handleOtpSubmit() async {
    if (_otpCtrl.text.length == 6) {
      final result = await ref
          .read(registerProvider.notifier)
          .verifyOtp(sessionToken: _sessionToken!, otp: _otpCtrl.text.trim());

      if (result != null && mounted) {
        _registrationToken = result.registerToken;
        _otpCtrl.clear();
        _goToPage(2);
      }
    }
  }

  // Page 2 - OTP page resend handler
  Future<bool> _handleOtpResend() async {
    final result = await ref
        .read(registerProvider.notifier)
        .initiateRegistration(_emailCtrl.text.trim());

    if (result == null) return false;
    if (mounted) {
      _sessionToken = result.sessionToken;
      _otpCtrl.clear();
    }
    return true;
  }

  // Page 3 - Form page handlers
  Future<void> _handleFormSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final result = await ref
          .read(registerProvider.notifier)
          .completeRegistration(
            registrationToken: _registrationToken!,
            firstName: _firstNameCtrl.text.trim(),
            lastName: _lastNameCtrl.text.trim(),
            password: _passwordCtrl.text,
            phone: _phoneCtrl.text.trim(),
            city: _cityCtrl.text.trim(),
            address: _addressCtrl.text.trim(),
          );

      if (mounted && result != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم التسجيل بنجاح')));
        // A freshly-registered driver must verify before using the app; the
        // gate checks their status and routes accordingly.
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.driverVerificationWizard,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _registerListener(context);

    return PopScope(
      // Disable default back navigation
      canPop: false,
      // Handle back navigation
      onPopInvokedWithResult: (didPop, _) {
        // If back navigation was invoked successfully, do nothing
        if (didPop) return;

        final currentPage = _pageController.page?.round() ?? 0;

        // Prevent back navigation if already on the first page
        if (currentPage > 0) {
          _goToPage(currentPage - 1);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.neutral0,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              RegisterEmailPage(
                formKey: _emailFormKey,
                emailCtrl: _emailCtrl,
                onSubmit: _handleEmailSubmit,
              ),
              RegisterOtpPage(
                emailCtrl: _emailCtrl,
                otpCtrl: _otpCtrl,
                onSubmit: _handleOtpSubmit,
                onBack: () => _goToPage(0),
                onResend: _handleOtpResend,
              ),
              RegisterFormPage(
                formKey: _formKey,
                firstNameCtrl: _firstNameCtrl,
                lastNameCtrl: _lastNameCtrl,
                phoneCtrl: _phoneCtrl,
                cityCtrl: _cityCtrl,
                addressCtrl: _addressCtrl,
                passwordCtrl: _passwordCtrl,
                confirmPassCtrl: _confirmPassCtrl,
                onSubmit: _handleFormSubmit,
                onBack: () => _goToPage(1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Provider listener ─────────────────────────────────────────────────────

  void _registerListener(BuildContext context) {
    ref.listen(registerProvider.select((state) => state), (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });
  }
}
