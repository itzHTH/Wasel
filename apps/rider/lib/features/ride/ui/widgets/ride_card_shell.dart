import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardShell extends StatelessWidget {
  const RideCardShell({super.key, required this.child, this.padding});

  final Widget child;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: AppDimens.space16,
        right: AppDimens.space16,
        bottom: AppDimens.space24,
      ),
      padding:
          padding ??
          EdgeInsets.only(
            left: AppDimens.screenHPadding,
            top: AppDimens.space16,
            right: AppDimens.screenHPadding,
            bottom: AppDimens.space24,
          ),
      decoration: BoxDecoration(
        color: AppColor.elementBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius24),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary900.withValues(alpha: 0.08),
            blurRadius: AppDimens.radius16,
            offset: Offset(0, AppDimens.space4),
          ),
        ],
      ),

      child: child,
    );
  }
}
