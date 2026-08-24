import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
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
        Text(
          context.coreL10n.otpNotReceived,
          style: context.styles.body(color: context.colors.neutral400),
        ),
        GestureDetector(
          onTap: _canResend ? _onResend : null,
          child: Text(
            context.coreL10n.otpResend,
            style: _canResend
                ? context.styles.body(
                    weight: FontWeight.w600,
                    color: context.colors.primary500,
                  )
                : context.styles.body(color: context.colors.neutral400),
          ),
        ),
      ],
    );
  }
}
