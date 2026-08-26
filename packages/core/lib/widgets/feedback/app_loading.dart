import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';

/// Covers a surface whose content has not arrived, shimmering in its place.
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({super.key, this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: AppSkeleton(
        child: ColoredBox(
          color: backgroundColor ?? context.colors.screenBackground,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
