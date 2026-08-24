import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_fonts.dart';
import 'package:wasel_core/theme/app_type_scale.dart';

/// Semantic text roles. Size and default weight come from the brand's
/// [AppTypeScale]; colour and weight are overridable per call site.
@immutable
class AppTextStyles {
  const AppTextStyles(this._colors, this._scale);

  final AppColorsExtension _colors;
  final AppTypeScale _scale;

  TextStyle _role({
    required double size,
    required FontWeight defaultWeight,
    required Color defaultColor,
    required double height,
    Color? color,
    FontWeight? weight,
  }) => TextStyle(
    fontFamily: AppFonts.family,
    fontSize: size,
    fontWeight: weight ?? defaultWeight,
    color: color ?? defaultColor,
    height: height,
  );

  /// Splash and full-bleed hero moments only.
  TextStyle displayLarge({Color? color, FontWeight? weight}) => _role(
    size: _scale.displayLargeSize,
    defaultWeight: FontWeight.w700,
    defaultColor: _colors.onScrim,
    height: AppFonts.headingHeight,
    color: color,
    weight: weight,
  );

  TextStyle display({Color? color, FontWeight? weight}) => _role(
    size: _scale.displaySize,
    defaultWeight: _scale.displayWeight,
    defaultColor: _colors.secondary900,
    height: AppFonts.headingHeight,
    color: color,
    weight: weight,
  );

  TextStyle headline({Color? color, FontWeight? weight}) => _role(
    size: _scale.headlineSize,
    defaultWeight: _scale.headlineWeight,
    defaultColor: _colors.secondary900,
    height: AppFonts.headingHeight,
    color: color,
    weight: weight,
  );

  TextStyle title({Color? color, FontWeight? weight}) => _role(
    size: _scale.titleSize,
    defaultWeight: _scale.titleWeight,
    defaultColor: _colors.secondary900,
    height: AppFonts.headingHeight,
    color: color,
    weight: weight,
  );

  TextStyle bodyLarge({Color? color, FontWeight? weight}) => _role(
    size: _scale.bodyLargeSize,
    defaultWeight: FontWeight.w400,
    defaultColor: _colors.secondary900,
    height: AppFonts.bodyHeight,
    color: color,
    weight: weight,
  );

  TextStyle body({Color? color, FontWeight? weight}) => _role(
    size: _scale.bodySize,
    defaultWeight: FontWeight.w400,
    defaultColor: _colors.secondary900,
    height: AppFonts.bodyHeight,
    color: color,
    weight: weight,
  );

  TextStyle label({Color? color, FontWeight? weight}) => _role(
    size: _scale.labelSize,
    defaultWeight: _scale.labelWeight,
    defaultColor: _colors.secondary900,
    height: AppFonts.bodyHeight,
    color: color,
    weight: weight,
  );

  TextStyle caption({Color? color, FontWeight? weight}) => _role(
    size: _scale.captionSize,
    defaultWeight: FontWeight.w400,
    defaultColor: _colors.secondary900,
    height: AppFonts.bodyHeight,
    color: color,
    weight: weight,
  );

  /// Numerals that update in place — countdowns, fare meters, trip timers.
  TextStyle timerTextStyle({Color? color, FontWeight? weight}) => TextStyle(
    fontFamily: AppFonts.numeralFamily,
    fontSize: _scale.bodySize,
    fontWeight: weight ?? FontWeight.w600,
    color: color ?? _colors.secondary900,
    height: AppFonts.bodyHeight,
  );
}
