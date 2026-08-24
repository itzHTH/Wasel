import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_shape.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

extension AppThemeContext on BuildContext {
  /// The active brand palette for the current theme and brightness.
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  /// Brand text styles bound to [colors].
  AppTextStyles get styles => AppTextStyles(colors);

  /// The active brand's shape scale.
  AppShape get shape => Theme.of(this).extension<AppShape>()!;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
