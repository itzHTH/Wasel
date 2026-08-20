import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The primary call-to-action button for the Wasel apps.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.primary500,
          // Loading is not disabled: a spinner on primary300 sits near 1.5:1.
          disabledBackgroundColor: isLoading
              ? context.colors.primary500
              : context.colors.primary300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppDimens.icon24,
                height: AppDimens.icon24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: context.colors.onPrimary,
                ),
              )
            : Text(label, style: context.styles.font16Neutral0SemiBold),
      ),
    );
  }
}
