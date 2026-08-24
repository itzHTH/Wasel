import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.shape.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colors.primary500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.shape.radiusButton),
          ),
        ),
        child: Text(label, style: context.styles.bodyBrand()),
      ),
    );
  }
}
