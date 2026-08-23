import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';
import 'package:wasel_core/widgets/password_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.phoneCtrl,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // First Name
          AppLabeledFormField(
            label: context.authL10n.firstName,
            hintText: context.authL10n.enterFirstName,
            controller: firstNameCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => AppValidators.name(
              value,
              fieldName: context.authL10n.firstName,
            ),
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),

          // Last Name
          AppLabeledFormField(
            label: context.authL10n.lastName,
            hintText: context.authL10n.enterLastName,
            controller: lastNameCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                AppValidators.name(value, fieldName: context.authL10n.lastName),
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),

          // Phone Number
          AppLabeledFormField(
            label: context.authL10n.phoneNumber,
            hintText: context.authL10n.enterPhoneNumber,
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: AppValidators.phone,
            prefixIcon: Icon(
              Icons.phone_outlined,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),

          // Password
          AppPasswordFormField(
            label: context.authL10n.password,
            hintText: context.authL10n.enterPassword,
            controller: passwordCtrl,
            textInputAction: TextInputAction.next,
            validator: AppValidators.password,
          ),
          SizedBox(height: AppDimens.space16),

          // Confirm Password
          AppPasswordFormField(
            label: context.authL10n.confirmPassword,
            hintText: context.authL10n.reenterPassword,
            controller: confirmPassCtrl,
            textInputAction: TextInputAction.done,
            validator: (value) =>
                AppValidators.confirmPassword(value, passwordCtrl.text),
          ),
        ],
      ),
    );
  }
}
