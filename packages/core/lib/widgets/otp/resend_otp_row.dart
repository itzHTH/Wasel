import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/widgets/app_prompt_row.dart';

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
    return AppPromptRow(
      message: context.coreL10n.otpNotReceived,
      actionLabel: context.coreL10n.otpResend,
      onTap: _canResend ? _onResend : null,
    );
  }
}
