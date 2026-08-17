import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';

class AppPasswordFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?) validator;
  final List<String>? autofillHints;

  const AppPasswordFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.textInputAction = TextInputAction.done,
    required this.validator,
    this.autofillHints,
  });

  @override
  State<AppPasswordFormField> createState() => _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AppLabeledFormField(
      label: widget.label,
      hintText: widget.hintText,
      controller: widget.controller,
      obscureText: !_visible,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      prefixIcon: Icon(
        Icons.lock_outline_rounded,
        color: AppColor.neutral400,
        size: AppDimens.icon20,
      ),
      suffixIcon: GestureDetector(
        onTap: () => setState(() => _visible = !_visible),
        child: Icon(
          _visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColor.neutral400,
          size: AppDimens.icon20,
        ),
      ),
    );
  }
}
