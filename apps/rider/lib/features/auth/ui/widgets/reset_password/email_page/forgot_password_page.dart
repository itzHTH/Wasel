import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasel_auth/presentation/providers/reset_password/reset_password_controller.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_back_button.dart';
import 'package:wasel_core/widgets/app_inline_error.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final VoidCallback onSubmit;

  const ForgotPasswordPage({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          const AppBackButton(),
          SizedBox(height: AppDimens.space24),

          Text(
            'نسيت كلمة المرور؟',
            style: AppTextStyles.font24Secondary900Bold,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'أدخل بريدك الإلكتروني وسنرسل لك رمز تحقق لإعادة تعيين كلمة المرور',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space32),

          AutofillGroup(
            child: Form(
              key: formKey,
              child: AppLabeledFormField(
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [
                  AutofillHints.username,
                  AutofillHints.email,
                ],
                validator: AppValidators.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColor.neutral400,
                  size: AppDimens.icon20,
                ),
              ),
            ),
          ),

          Consumer(
            builder: (context, ref, child) {
              final error = ref.watch(
                resetPasswordControllerProvider.select((s) => s.fieldError),
              );
              return AppInlineError(message: error);
            },
          ),
          SizedBox(height: AppDimens.space24),

          Consumer(
            builder: (context, ref, child) {
              final isSubmitting = ref.watch(
                resetPasswordControllerProvider.select((s) => s.isSubmitting),
              );
              return AuthPrimaryButton(
                label: 'إرسال الرمز',
                onPressed: isSubmitting ? null : onSubmit,
                isLoading: isSubmitting,
              );
            },
          ),
          SizedBox(height: AppDimens.space24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تذكرت كلمة المرور؟ ',
                style: AppTextStyles.font14Neutral400Regular,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'تسجيل الدخول',
                  style: AppTextStyles.font14Primary500SemiBold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space32),
        ],
      ),
    );
  }
}
