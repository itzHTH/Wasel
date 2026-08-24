import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final VoidCallback? onTap;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    final radius = BorderRadius.circular(borderRadius ?? AppDimens.radius16);

    return Container(
      width: double.infinity,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.elementBackground,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: context.colors.scrim.withValues(alpha: 0.06),
            blurRadius: AppDimens.radius16,
            offset: Offset(0, AppDimens.space4),
          ),
        ],
      ),
      child: onTap == null
          ? child
          : Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onTap, borderRadius: radius, child: child),
            ),
    );
  }
}
