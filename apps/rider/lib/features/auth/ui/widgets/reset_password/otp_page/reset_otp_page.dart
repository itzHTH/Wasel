import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_back_button.dart';
import 'package:wasel_core/widgets/app_inline_error.dart';
import 'package:wasel_core/widgets/otp/otp_pin_input.dart';
import 'package:wasel_core/widgets/otp/otp_resend_section.dart';

class ResetOtpPage extends ConsumerWidget {
  final TextEditingController otpCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final Future<bool> Function() onResend;
  final VoidCallback onExpiredRestart;

  const ResetOtpPage({
    super.key,
    required this.otpCtrl,
    required this.onSubmit,
    required this.onBack,
    required this.onResend,
    required this.onExpiredRestart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resetPasswordControllerProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppDimens.space24),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppBackButton(onTap: onBack),
          ),
          SizedBox(height: AppDimens.space40),

          Text(
            context.authL10n.verificationCode,
            style: context.styles.font24Secondary900Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            context.authL10n.otpSentToEmail(state.email),
            style: context.styles.font14Neutral400Regular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space40),

          OtpPinInput(
            controller: otpCtrl,
            hasError: state.fieldError != null,
            onCompleted: (_) => onSubmit(),
          ),
          AppInlineError(
            message: state.fieldError,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space24),

          AuthPrimaryButton(
            label: context.authL10n.confirm,
            onPressed: state.isSubmitting ? null : onSubmit,
            isLoading: state.isSubmitting,
          ),
          SizedBox(height: AppDimens.space16),

          if (state.tokenExpired)
            TextButton(
              onPressed: onExpiredRestart,
              child: Text(
                context.authL10n.requestNewCode,
                style: context.styles.font14Primary500SemiBold,
              ),
            )
          else
            OtpResendSection(
              onResend: onResend,
              countdown: const Duration(seconds: 60),
            ),
          SizedBox(height: AppDimens.space32),
        ],
      ),
    );
  }
}
