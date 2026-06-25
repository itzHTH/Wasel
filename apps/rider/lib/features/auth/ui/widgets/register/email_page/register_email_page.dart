import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasal/features/auth/ui/providers/register/register_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_header.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_social_section.dart';

class RegisterEmailPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final VoidCallback onSubmit;

  const RegisterEmailPage({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppDimens.space16),
            const AuthHeader(title: 'اطلب تكسي في أي وقت'),
            SizedBox(height: AppDimens.space32),

            // Email field
            Form(
              key: formKey,
              child: AppLabeledFormField(
                label: 'البريد الإلكتروني',
                hintText: 'أدخل بريدك الإلكتروني',
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: AppValidators.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColor.neutral400,
                  size: AppDimens.icon20,
                ),
              ),
            ),
            SizedBox(height: AppDimens.space24),

            // Submit
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(registerProvider);
                return AuthPrimaryButton(
                  isLoading: state.isLoading,
                  label: 'إنشاء حساب',
                  onPressed: onSubmit,
                );
              },
            ),
            SizedBox(height: AppDimens.space24),

            const AuthSocialSection(googleLabel: 'سجل باستخدام جوجل'),
            SizedBox(height: AppDimens.space24),

            // Navigate to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لديك حساب بالفعل؟ ',
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
      ),
    );
  }
}
