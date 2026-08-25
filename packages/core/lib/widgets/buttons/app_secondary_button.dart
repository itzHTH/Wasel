import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
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
    return AppShimmerSheen(
      enabled: isLoading,
      borderRadius: BorderRadius.circular(context.shape.radiusButton),
      highlight: context.colors.primary500,
      child: SizedBox(
        width: double.infinity,
        height: context.shape.buttonHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: isLoading ? context.colors.primary100 : null,
            disabledBackgroundColor: isLoading
                ? context.colors.primary100
                : null,
            side: BorderSide(color: context.colors.primary500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.shape.radiusButton),
            ),
          ),
          child: Text(label, style: context.styles.bodyBrand()),
        ),
      ),
    );
  }
}
