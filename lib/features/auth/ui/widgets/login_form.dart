import 'package:flutter/material.dart';
import 'package:wasal/core/helpers/app_validators.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/features/auth/ui/widgets/auth_labeled_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final bool passVisible;
  final VoidCallback onTogglePass;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.passCtrl,
    required this.passVisible,
    required this.onTogglePass,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthLabeledField(
            label: 'البريد الإلكتروني',
            hintText: 'أدخل بريدك الإلكتروني',
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: AppColor.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),
          AuthLabeledField(
            label: 'كلمة المرور',
            hintText: 'أدخل كلمة المرور الخاصة بك',
            controller: passCtrl,
            obscureText: !passVisible,
            textInputAction: TextInputAction.done,
            validator: AppValidators.password,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: AppColor.neutral400,
              size: AppDimens.icon20,
            ),
            suffixIcon: GestureDetector(
              onTap: onTogglePass,
              child: Icon(
                passVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColor.neutral400,
                size: AppDimens.icon20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
