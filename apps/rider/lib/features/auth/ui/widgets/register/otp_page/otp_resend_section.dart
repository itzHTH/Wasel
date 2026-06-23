import 'package:flutter/material.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/features/auth/ui/widgets/register/otp_page/otp_countdown_timer.dart';
import 'package:wasal/features/auth/ui/widgets/register/otp_page/resend_otp_row.dart';

class OtpResendSection extends StatefulWidget {
  final Future<void> Function() onResend;

  const OtpResendSection({super.key, required this.onResend});

  @override
  State<OtpResendSection> createState() => _OtpResendSectionState();
}

class _OtpResendSectionState extends State<OtpResendSection> {
  bool _canResend = false;
  int _timerResetKey = 0;

  Future<void> _handleResend() async {
    setState(() => _canResend = false);
    await widget.onResend();
    setState(() => _timerResetKey++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtpCountdownTimer(
          key: ValueKey(_timerResetKey),
          onExpired: () => setState(() => _canResend = true),
        ),
        SizedBox(height: AppDimens.space12),
        ResendOtpRow(canResend: _canResend, onResend: _handleResend),
      ],
    );
  }
}
