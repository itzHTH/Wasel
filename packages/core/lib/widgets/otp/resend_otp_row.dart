import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class ResendOtpRow extends StatelessWidget {
  const ResendOtpRow({
    super.key,
    required bool canResend,
    required VoidCallback onResend,
  }) : _canResend = canResend,
       _onResend = onResend;

  final bool _canResend;
  final VoidCallback _onResend;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('لم تستلم الرمز؟ ', style: context.styles.font14Neutral400Regular),
        GestureDetector(
          onTap: _canResend ? _onResend : null,
          child: Text(
            'أعد الإرسال',
            style: _canResend
                ? context.styles.font14Primary500SemiBold
                : context.styles.font14Neutral400Regular,
          ),
        ),
      ],
    );
  }
}
