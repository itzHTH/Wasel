import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class CompletedCheckBadge extends StatelessWidget {
  const CompletedCheckBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.icon48,
      height: AppDimens.icon48,
      decoration: BoxDecoration(
        color: context.colors.alertSuccess100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        size: AppDimens.icon24,
        color: context.colors.alertSuccess500,
      ),
    );
  }
}
