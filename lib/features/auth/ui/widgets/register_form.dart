import 'package:flutter/material.dart';
import 'package:wasal/core/helpers/app_validators.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/features/auth/ui/widgets/auth_labeled_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailCtrl,
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
        ],
      ),
    );
  }
}
