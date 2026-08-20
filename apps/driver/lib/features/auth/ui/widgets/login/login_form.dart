import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';
import 'package:wasel_core/widgets/password_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.passCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppLabeledFormField(
            label: 'البريد الإلكتروني',
            hintText: 'أدخل بريدك الإلكتروني',
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),
          AppPasswordFormField(
            label: 'كلمة المرور',
            hintText: 'أدخل كلمة المرور الخاصة بك',
            controller: passCtrl,
            validator: AppValidators.password,
          ),
        ],
      ),
    );
  }
}
