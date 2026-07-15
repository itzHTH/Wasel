import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardShell extends StatelessWidget {
  const RideCardShell({super.key, required this.child, this.padding});

  final Widget child;

  /// Overrides the default internal padding when a card needs tighter spacing.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(
        AppDimens.space16,
        0,
        AppDimens.space16,
        AppDimens.space24,
      ),
      padding:
          padding ??
          EdgeInsetsDirectional.fromSTEB(
            AppDimens.screenHPadding,
            AppDimens.space24,
            AppDimens.screenHPadding,
            AppDimens.space24,
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
