import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

/// The single loading identity for the Wasel apps.
///
/// [AppInlineLoading] fits inside a card row, a label line, or a button slot.
/// [AppLoadingOverlay] covers a whole area (e.g. the map) and swallows taps on
/// whatever sits underneath it. Both draw the same indicator, so a screen never
/// shows two different loading visuals.
class AppInlineLoading extends StatelessWidget {
  const AppInlineLoading({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ?? AppDimens.icon24;
    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: CircularProgressIndicator(
        strokeWidth: _strokeFor(resolvedSize),
        color: color ?? context.colors.primary500,
      ),
    );
  }

  static double _strokeFor(double size) => size / 8;
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({super.key, this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: ColoredBox(
        color: backgroundColor ?? context.colors.screenBackground,
        child: const Center(child: AppInlineLoading()),
      ),
    );
  }
}
