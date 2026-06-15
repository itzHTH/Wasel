import 'package:flutter/material.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/core/theme/app_text_styles.dart';
import 'package:wasal/core/widgets/app_text_form_field.dart';

class AuthLabeledField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AuthLabeledField({
    super.key,
    required this.label,
    required this.hintText,
    required this.validator,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font14Secondary900SemiBold),
        SizedBox(height: AppDimens.space8),
        AppTextFormField(
          hintText: hintText,
          controller: controller,
          validator: validator,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          isObscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          backgroundColor: AppColor.neutral50,
          hintStyle: AppTextStyles.font14Neutral400Regular,
          inputTextStyle: AppTextStyles.font14Secondary900SemiBold,
        ),
      ],
    );
  }
}
