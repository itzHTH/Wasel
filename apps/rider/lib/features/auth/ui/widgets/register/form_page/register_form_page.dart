import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_back_button.dart';
import 'package:wasal/features/auth/ui/providers/register/register_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/register/form_page/register_form.dart';

class RegisterFormPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const RegisterFormPage({
    super.key,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.phoneCtrl,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          AppBackButton(onTap: onBack),
          SizedBox(height: AppDimens.space24),

          Text('أكمل بياناتك', style: AppTextStyles.font24Secondary900Bold),
          SizedBox(height: AppDimens.space8),
          Text(
            'أدخل معلوماتك الشخصية لإكمال التسجيل',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space32),

          RegisterForm(
            formKey: formKey,
            firstNameCtrl: firstNameCtrl,
            lastNameCtrl: lastNameCtrl,
            phoneCtrl: phoneCtrl,
            passwordCtrl: passwordCtrl,
            confirmPassCtrl: confirmPassCtrl,
          ),
          SizedBox(height: AppDimens.space32),

          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(registerProvider).isLoading;
              return AuthPrimaryButton(
                label: 'إنشاء حساب',
                onPressed: isLoading ? null : onSubmit,
                isLoading: isLoading,
              );
            },
          ),
          SizedBox(height: AppDimens.space32),
        ],
      ),
    );
  }
}
