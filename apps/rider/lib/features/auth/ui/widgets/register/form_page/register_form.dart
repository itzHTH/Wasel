import 'package:flutter/material.dart';
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
            label: 'الاسم الأول',
            hintText: 'أدخل اسمك الأول',
            controller: firstNameCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                AppValidators.name(value, fieldName: 'الاسم الأول'),
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),

          // Last Name
          AppLabeledFormField(
            label: 'الاسم الأخير',
            hintText: 'أدخل اسمك الأخير',
            controller: lastNameCtrl,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                AppValidators.name(value, fieldName: 'الاسم الأخير'),
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: context.colors.neutral400,
              size: AppDimens.icon20,
            ),
          ),
          SizedBox(height: AppDimens.space16),

          // Phone Number
          AppLabeledFormField(
            label: 'رقم الهاتف',
            hintText: 'أدخل رقم هاتفك',
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
            label: 'كلمة المرور',
            hintText: 'أدخل كلمة المرور',
            controller: passwordCtrl,
            textInputAction: TextInputAction.next,
            validator: AppValidators.password,
          ),
          SizedBox(height: AppDimens.space16),

          // Confirm Password
          AppPasswordFormField(
            label: 'تأكيد كلمة المرور',
            hintText: 'أعد إدخال كلمة المرور',
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
