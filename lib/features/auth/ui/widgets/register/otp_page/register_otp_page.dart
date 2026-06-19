import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/core/theme/app_text_styles.dart';
import 'package:wasal/core/widgets/app_back_button.dart';
import 'package:wasal/features/auth/ui/providers/register/register_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/register/otp_page/otp_pin_input.dart';
import 'package:wasal/features/auth/ui/widgets/register/otp_page/otp_resend_section.dart';

class RegisterOtpPage extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController otpCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final Future<void> Function() onResend;

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
            'رمز التحقق',
            style: AppTextStyles.font24Secondary900Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني\n ${emailCtrl.text}',
            style: AppTextStyles.font14Neutral400Regular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space40),

          OtpPinInput(controller: otpCtrl, onCompleted: (_) => onSubmit()),
          SizedBox(height: AppDimens.space24),

          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(registerProvider).isLoading;
              return AuthPrimaryButton(
                label: 'إرسال',
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
