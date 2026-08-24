import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/buttons/app_back_button.dart';
import 'package:driver/features/auth/ui/providers/register/register_provider.dart';
import 'package:wasel_core/widgets/otp/otp_pin_input.dart';
import 'package:wasel_core/widgets/otp/otp_resend_section.dart';

class RegisterOtpPage extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController otpCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final Future<bool> Function() onResend;

  const RegisterOtpPage({
    super.key,
    required this.emailCtrl,
    required this.otpCtrl,
    required this.onSubmit,
    required this.onBack,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppDimens.space24),
          AppBackButton(onTap: onBack),
          const Spacer(),

          Text(
            context.authL10n.verificationCode,
            style: context.styles.headline(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            context.authL10n.otpSentToEmail(emailCtrl.text),
            style: context.styles.bodyMuted(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space40),

          OtpPinInput(controller: otpCtrl, onCompleted: (_) => onSubmit()),
          SizedBox(height: AppDimens.space24),

          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(registerProvider).isLoading;
              return AuthPrimaryButton(
                label: context.authL10n.send,
                onPressed: isLoading ? null : onSubmit,
                isLoading: isLoading,
              );
            },
          ),
          SizedBox(height: AppDimens.space16),

          OtpResendSection(onResend: onResend),
          SizedBox(height: AppDimens.space32),
          const Spacer(),
        ],
      ),
    );
  }
}
