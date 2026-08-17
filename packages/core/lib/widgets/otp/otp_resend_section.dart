import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/otp/otp_countdown_timer.dart';
import 'package:wasel_core/widgets/otp/resend_otp_row.dart';

class OtpResendSection extends StatefulWidget {
  final Future<void> Function() onResend;

  /// Passed through to [OtpCountdownTimer]; defaults to that widget's own value.
  final Duration? countdown;

  const OtpResendSection({super.key, required this.onResend, this.countdown});

  @override
  State<OtpResendSection> createState() => _OtpResendSectionState();
}

class _OtpResendSectionState extends State<OtpResendSection> {
  bool _canResend = false;
  int _timerResetKey = 0;

  Future<void> _handleResend() async {
    setState(() => _canResend = false);
    await widget.onResend();
    if (!mounted) return;
    setState(() => _timerResetKey++);
  }

  @override
  Widget build(BuildContext context) {
    final countdown = widget.countdown;
    return Column(
      children: [
        OtpCountdownTimer(
          key: ValueKey(_timerResetKey),
          onExpired: () => setState(() => _canResend = true),
          duration: countdown ?? const Duration(seconds: 159),
        ),
        SizedBox(height: AppDimens.space12),
        ResendOtpRow(canResend: _canResend, onResend: _handleResend),
      ],
    );
  }
}
