import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasel_core/theme/app_color.dart';

/// Skeleton loading for the Wasel apps.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  static const ShimmerEffect _effect = ShimmerEffect(
    baseColor: AppColor.neutral200,
    highlightColor: AppColor.neutral50,
    duration: Duration(milliseconds: 1400),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: enabled, effect: _effect, child: child);
  }
}
