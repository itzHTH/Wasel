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
    return SizedBox(
      width: double.infinity,
      height: context.shape.buttonHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colors.primary500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.shape.radiusButton),
          ),
        ),
        child: isLoading
            ? AppInlineLoading(size: AppDimens.icon24)
            : Text(label, style: context.styles.bodyBrand()),
      ),
    );
  }
}
