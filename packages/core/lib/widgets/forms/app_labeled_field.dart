import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/forms/app_text_form_field.dart';

class AppLabeledFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

  const AppLabeledFormField({
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
    this.autofillHints,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.styles.body(weight: FontWeight.w600)),
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
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          backgroundColor: context.colors.neutral50,
          hintStyle: context.styles.bodyMuted(),
          inputTextStyle: context.styles.body(weight: FontWeight.w600),
        ),
      ],
    );
  }
}
