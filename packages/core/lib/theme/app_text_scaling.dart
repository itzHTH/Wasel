import 'package:flutter/widgets.dart';

/// The ceiling both apps put on the OS text scale.
///
/// screenutil's `.sp` already scales type for device width and the OS factor
/// multiplies on top of it, so the two only stay in step while they share one
/// ceiling — neither app gets to carry its own number.
class AppTextScaling {
  AppTextScaling._();

  /// Past this the layout stops being legible and starts being broken: the
  /// logout dialog survives 2.0 and first overflows at 2.5.
  static const double maxScaleFactor = 2.0;

  /// Shaped as a [WidgetsApp.builder] so an app can pass it as a tear-off and
  /// every route inherits the ceiling.
  static Widget clamp(BuildContext context, Widget? child) =>
      MediaQuery.withClampedTextScaling(
        maxScaleFactor: maxScaleFactor,
        child: child ?? const SizedBox.shrink(),
      );
}
