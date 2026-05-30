import 'package:flutter/material.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/core/theme/app_text_styles.dart';
import 'package:wasal/core/widgets/app_back_button.dart';
import 'package:wasal/features/auth/ui/widgets/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/otp_countdown_timer.dart';
import 'package:wasal/features/auth/ui/widgets/otp_pin_input.dart';
import 'package:wasal/features/auth/ui/widgets/resend_otp_row.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  bool _canResend = false;
  int _timerResetKey = 0;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onTimerExpired() => setState(() => _canResend = true);

  void _onResend() {
    setState(() {
      _canResend = false;
      _timerResetKey++;
    });
    // TODO: trigger resend OTP API call
  }

  void _onSend() {
    if (_otpController.text.length == 6) {
      // TODO: trigger verify OTP API call
      // Navigator.pushNamed(context, AppRoutes.registerSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(height: AppDimens.space24),
              const AppBackButton(),
              const Spacer(),
              Text(
                'رمز التحقق',
                style: AppTextStyles.font24Secondary900Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimens.space8),
              Text(
                'لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني\n${widget.email}',
                style: AppTextStyles.font14Neutral400Regular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimens.space40),
              OtpPinInput(
                controller: _otpController,
                onCompleted: (_) => _onSend(),
              ),

              SizedBox(height: AppDimens.space24),
              AuthPrimaryButton(label: 'إرسال', onPressed: _onSend),
              SizedBox(height: AppDimens.space16),
              OtpCountdownTimer(
                key: ValueKey(_timerResetKey),
                onExpired: _onTimerExpired,
              ),
              SizedBox(height: AppDimens.space12),
              ResendOtpRow(canResend: _canResend, onResend: _onResend),
              SizedBox(height: AppDimens.space32),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
