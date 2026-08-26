import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_shimmer_sheen.dart';

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
    final background = isLoading
        ? context.colors.primary700
        : context.colors.primary500;

    return AppShimmerSheen(
      enabled: isLoading,
      borderRadius: BorderRadius.circular(context.shape.radiusButton),
      highlight: context.colors.onPrimary,
      child: SizedBox(
        width: double.infinity,
        height: context.shape.buttonHeight,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            // Loading is not the disabled look: the label stays readable on
            // the deeper fill, where primary300 would sit near 1.5:1.
            disabledBackgroundColor: isLoading
                ? background
                : context.colors.primary300,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.shape.radiusButton),
            ),
          ),
          child: Text(
            label,
            style: context.styles.bodyLarge(
              weight: FontWeight.w600,
              color: context.colors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
