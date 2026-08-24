import 'package:flutter/material.dart';
import 'package:wasel_profile/l10n/profile_l10n_extension.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/forms/app_labeled_field.dart';

/// One field of the edit form.
class ProfileEditField extends StatelessWidget {
  const ProfileEditField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isEditable = true,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.valueTextDirection,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isEditable;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? valueTextDirection;

  @override
  Widget build(BuildContext context) {
    if (!isEditable) {
      return _LockedValue(
        label: label,
        value: controller.text,
        valueTextDirection: valueTextDirection,
      );
    }

    return AppLabeledFormField(
      label: label,
      hintText: hintText,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
    );
  }
}

class _LockedValue extends StatelessWidget {
  const _LockedValue({
    required this.label,
    required this.value,
    this.valueTextDirection,
  });

  final String label;
  final String value;
  final TextDirection? valueTextDirection;

  @override
  Widget build(BuildContext context) {
    final hasValue = value.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.styles.body(weight: FontWeight.w600)),
        SizedBox(height: AppDimens.space8),
        Container(
          height: AppDimens.fieldHeight,
          padding: EdgeInsets.symmetric(horizontal: AppDimens.space16),
          decoration: BoxDecoration(
            color: context.colors.neutral100,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
            border: Border.all(color: context.colors.neutral200),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasValue ? value : context.profileL10n.notSpecified,
                  textDirection: hasValue ? valueTextDirection : null,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: hasValue
                      ? context.styles.bodyMuted(weight: FontWeight.w500)
                      : context.styles.bodyMuted(),
                ),
              ),
              SizedBox(width: AppDimens.space8),
              Icon(
                Icons.lock_outline_rounded,
                size: AppDimens.icon18,
                color: context.colors.neutral400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
