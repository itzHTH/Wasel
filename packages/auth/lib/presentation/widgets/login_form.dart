import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/forms/app_field_icon.dart';
import 'package:wasel_core/widgets/forms/app_labeled_field.dart';
import 'package:wasel_core/widgets/forms/password_field.dart';

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
            label: context.authL10n.email,
            hintText: context.authL10n.enterEmail,
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
            prefixIcon: const AppFieldIcon(Icons.email_outlined),
          ),
          SizedBox(height: AppDimens.space16),
          AppPasswordFormField(
            label: context.authL10n.password,
            hintText: context.authL10n.enterYourPassword,
            controller: passCtrl,
            validator: AppValidators.password,
          ),
        ],
      ),
    );
  }
}
