import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// Skeleton loading for the Wasel apps.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // Built here rather than as a const: the shimmer follows the active theme.
    // The ramp is picked per brightness — reusing one pair would make the
    // highlight darker than the base in dark mode, so the sweep runs backwards.
    final colors = context.colors;
    final isDark = context.isDarkMode;
    final effect = ShimmerEffect(
      baseColor: isDark ? colors.neutral100 : colors.neutral200,
      highlightColor: isDark ? colors.neutral200 : colors.neutral50,
      duration: const Duration(milliseconds: 1400),
    );
    return Skeletonizer(enabled: enabled, effect: effect, child: child);
  }
}
