import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';

/// Per-brand shape. Rider rounds generously so its surfaces read consumer;
/// Captain squares off so its controls read as equipment.
@immutable
class AppShape extends ThemeExtension<AppShape> {
  const AppShape({
    required this.radiusButton,
    required this.radiusCard,
    required this.radiusSheet,
    required this.radiusDialog,
    required this.radiusField,
    required this.radiusBadge,
    required this.buttonHeight,
    required this.fieldHeight,
    required this.screenPadding,
  });

  AppShape.rider()
    : radiusButton = 100.r,
      radiusCard = 20.r,
      radiusSheet = 28.r,
      radiusDialog = 24.r,
      radiusField = 12.r,
      radiusBadge = 18.r,
      buttonHeight = 56.h,
      fieldHeight = 54.h,
      screenPadding = 24.w;

  AppShape.driver()
    : radiusButton = 14.r,
      radiusCard = 16.r,
      radiusSheet = 24.r,
      radiusDialog = 20.r,
      radiusField = 12.r,
      radiusBadge = 12.r,
      buttonHeight = 60.h,
      fieldHeight = 58.h,
      screenPadding = 20.w;

  final double radiusButton;
  final double radiusCard;
  final double radiusSheet;
  final double radiusDialog;
  final double radiusField;
  final double radiusBadge;
  final double buttonHeight;
  final double fieldHeight;
  final double screenPadding;

  @override
  AppShape copyWith({
    double? radiusButton,
    double? radiusCard,
    double? radiusSheet,
    double? radiusDialog,
    double? radiusField,
    double? radiusBadge,
    double? buttonHeight,
    double? fieldHeight,
    double? screenPadding,
  }) => AppShape(
    radiusButton: radiusButton ?? this.radiusButton,
    radiusCard: radiusCard ?? this.radiusCard,
    radiusSheet: radiusSheet ?? this.radiusSheet,
    radiusDialog: radiusDialog ?? this.radiusDialog,
    radiusField: radiusField ?? this.radiusField,
    radiusBadge: radiusBadge ?? this.radiusBadge,
    buttonHeight: buttonHeight ?? this.buttonHeight,
    fieldHeight: fieldHeight ?? this.fieldHeight,
    screenPadding: screenPadding ?? this.screenPadding,
  );

  @override
  AppShape lerp(covariant ThemeExtension<AppShape>? other, double t) {
    if (other is! AppShape) return this;
    return AppShape(
      radiusButton: lerpDouble(radiusButton, other.radiusButton, t),
      radiusCard: lerpDouble(radiusCard, other.radiusCard, t),
      radiusSheet: lerpDouble(radiusSheet, other.radiusSheet, t),
      radiusDialog: lerpDouble(radiusDialog, other.radiusDialog, t),
      radiusField: lerpDouble(radiusField, other.radiusField, t),
      radiusBadge: lerpDouble(radiusBadge, other.radiusBadge, t),
      buttonHeight: lerpDouble(buttonHeight, other.buttonHeight, t),
      fieldHeight: lerpDouble(fieldHeight, other.fieldHeight, t),
      screenPadding: lerpDouble(screenPadding, other.screenPadding, t),
    );
  }

  /// Corners for a square control of [size]. Scaling keeps the brand's
  /// roundness ratio as the box grows, so a badge and a back button of
  /// different sizes still read as the same family.
  double badgeRadiusFor(double size) => radiusBadge * size / AppDimens.icon40;

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;

  /// Without value equality a rebuilt `ThemeData` compares unequal and
  /// restarts the `AnimatedTheme` cross-fade on every frame.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppShape &&
        other.radiusButton == radiusButton &&
        other.radiusCard == radiusCard &&
        other.radiusSheet == radiusSheet &&
        other.radiusDialog == radiusDialog &&
        other.radiusField == radiusField &&
        other.radiusBadge == radiusBadge &&
        other.buttonHeight == buttonHeight &&
        other.fieldHeight == fieldHeight &&
        other.screenPadding == screenPadding;
  }

  @override
  int get hashCode => Object.hashAll([
    radiusButton,
    radiusCard,
    radiusSheet,
    radiusDialog,
    radiusField,
    radiusBadge,
    buttonHeight,
    fieldHeight,
    screenPadding,
  ]);
}
