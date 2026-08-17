import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasel_auth/presentation/providers/reset_password/reset_password_controller.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_back_button.dart';
import 'package:wasel_core/widgets/app_inline_error.dart';
import 'package:wasel_core/widgets/otp/otp_pin_input.dart';
import 'package:wasel_core/widgets/otp/otp_resend_section.dart';

class ResetOtpPage extends ConsumerWidget {
  final TextEditingController otpCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final Future<void> Function() onResend;
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
            'رمز التحقق',
            style: AppTextStyles.font24Secondary900Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني\n${state.email}',
            style: AppTextStyles.font14Neutral400Regular,
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
            label: 'تأكيد',
            onPressed: state.isSubmitting ? null : onSubmit,
            isLoading: state.isSubmitting,
          ),
          SizedBox(height: AppDimens.space16),

          if (state.tokenExpired)
            TextButton(
              onPressed: onExpiredRestart,
              child: Text(
                'طلب رمز جديد',
                style: AppTextStyles.font14Primary500SemiBold,
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
