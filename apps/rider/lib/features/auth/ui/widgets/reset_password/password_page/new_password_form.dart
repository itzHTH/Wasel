import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/password_field.dart';

class NewPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;

  const NewPasswordForm({
    super.key,
    required this.formKey,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            AppPasswordFormField(
              label: context.authL10n.newPasswordLabel,
              hintText: context.authL10n.enterNewPassword,
              controller: passwordCtrl,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: AppValidators.password,
            ),
            SizedBox(height: AppDimens.space16),
            AppPasswordFormField(
              label: context.authL10n.confirmPassword,
              hintText: context.authL10n.reenterNewPassword,
              controller: confirmPassCtrl,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) =>
                  AppValidators.confirmPassword(value, passwordCtrl.text),
            ),
          ],
        ),
      ),
    );
  }
}
