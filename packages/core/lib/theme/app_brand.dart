import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_shape.dart';
import 'package:wasel_core/theme/app_type_scale.dart';
import 'package:wasel_core/theme/palettes/driver_palette.dart';
import 'package:wasel_core/theme/palettes/rider_palette.dart';

/// Identifies which Wasel app is running so the shared core can resolve the
/// right brand palette.
enum AppBrand { rider, driver }

extension AppBrandPalette on AppBrand {
  AppColorsExtension paletteFor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (this) {
      AppBrand.rider => isDark ? RiderPalette.dark : RiderPalette.light,
      AppBrand.driver => isDark ? DriverPalette.dark : DriverPalette.light,
    };
  }

  AppShape shape() => switch (this) {
    AppBrand.rider => AppShape.rider(),
    AppBrand.driver => AppShape.driver(),
  };

  AppTypeScale typeScale() => switch (this) {
    AppBrand.rider => AppTypeScale.rider(),
    AppBrand.driver => AppTypeScale.driver(),
  };
}
