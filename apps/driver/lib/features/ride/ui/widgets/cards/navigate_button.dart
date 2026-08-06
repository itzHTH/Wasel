import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      width: AppDimens.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: AppColor.neutral200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Icon(
          Icons.navigation_outlined,
          size: AppDimens.icon24,
          color: AppColor.primary500,
        ),
      ),
    );
  }
}
