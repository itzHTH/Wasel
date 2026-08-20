import 'package:flutter/material.dart';

/// The full Wasel colour token set for one brand in one brightness.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary700,
    required this.primary500,
    required this.primary300,
    required this.primary100,
    required this.onPrimary,
    required this.accent500,
    required this.accent100,
    required this.onAccent,
    required this.secondary900,
    required this.secondary500,
    required this.secondary300,
    required this.neutral0,
    required this.neutral50,
    required this.neutral100,
    required this.neutral200,
    required this.neutral400,
    required this.neutral600,
    required this.screenBackground,
    required this.elementBackground,
    required this.alertInfo100,
    required this.alertInfo500,
    required this.alertSuccess100,
    required this.alertSuccess500,
    required this.alertWarning100,
    required this.alertWarning500,
    required this.alertError100,
    required this.alertError500,
    required this.alertError700,
    required this.statusOnline,
    required this.statusOffline,
    required this.scrim,
    required this.onScrim,
    required this.splashBackground,
  });

  // Brand
  final Color primary700;
  final Color primary500;
  final Color primary300;
  final Color primary100;

  /// Label/icon colour on top of a primary500 fill.
  final Color onPrimary;

  final Color accent500;
  final Color accent100;

  /// Label/icon colour on top of an accent500 fill.
  final Color onAccent;

  // Text
  final Color secondary900;
  final Color secondary500;
  final Color secondary300;

  // Surfaces & neutrals
  final Color neutral0;
  final Color neutral50;
  final Color neutral100;
  final Color neutral200;
  final Color neutral400;
  final Color neutral600;
  final Color screenBackground;
  final Color elementBackground;

  // Alerts
  final Color alertInfo100;
  final Color alertInfo500;
  final Color alertSuccess100;
  final Color alertSuccess500;
  final Color alertWarning100;
  final Color alertWarning500;
  final Color alertError100;
  final Color alertError500;
  final Color alertError700;

  // Availability
  final Color statusOnline;
  final Color statusOffline;

  // Media overlays
  final Color scrim;
  final Color onScrim;

  /// Launch-screen backdrop.
  final Color splashBackground;

  // ── Map markers ───────────────────────────────────────────────────────────
  // Also fixed: a marker is read against its own white pin body and the map
  // beneath it, neither of which follows the app surface.

  @override
  AppColorsExtension copyWith({
    Color? primary700,
    Color? primary500,
    Color? primary300,
    Color? primary100,
    Color? onPrimary,
    Color? accent500,
    Color? accent100,
    Color? onAccent,
    Color? secondary900,
    Color? secondary500,
    Color? secondary300,
    Color? neutral0,
    Color? neutral50,
    Color? neutral100,
    Color? neutral200,
    Color? neutral400,
    Color? neutral600,
    Color? screenBackground,
    Color? elementBackground,
    Color? alertInfo100,
    Color? alertInfo500,
    Color? alertSuccess100,
    Color? alertSuccess500,
    Color? alertWarning100,
    Color? alertWarning500,
    Color? alertError100,
    Color? alertError500,
    Color? alertError700,
    Color? statusOnline,
    Color? statusOffline,
    Color? scrim,
    Color? onScrim,
    Color? splashBackground,
  }) {
    return AppColorsExtension(
      primary700: primary700 ?? this.primary700,
      primary500: primary500 ?? this.primary500,
      primary300: primary300 ?? this.primary300,
      primary100: primary100 ?? this.primary100,
      onPrimary: onPrimary ?? this.onPrimary,
      accent500: accent500 ?? this.accent500,
      accent100: accent100 ?? this.accent100,
      onAccent: onAccent ?? this.onAccent,
      secondary900: secondary900 ?? this.secondary900,
      secondary500: secondary500 ?? this.secondary500,
      secondary300: secondary300 ?? this.secondary300,
      neutral0: neutral0 ?? this.neutral0,
      neutral50: neutral50 ?? this.neutral50,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral400: neutral400 ?? this.neutral400,
      neutral600: neutral600 ?? this.neutral600,
      screenBackground: screenBackground ?? this.screenBackground,
      elementBackground: elementBackground ?? this.elementBackground,
      alertInfo100: alertInfo100 ?? this.alertInfo100,
      alertInfo500: alertInfo500 ?? this.alertInfo500,
      alertSuccess100: alertSuccess100 ?? this.alertSuccess100,
      alertSuccess500: alertSuccess500 ?? this.alertSuccess500,
      alertWarning100: alertWarning100 ?? this.alertWarning100,
      alertWarning500: alertWarning500 ?? this.alertWarning500,
      alertError100: alertError100 ?? this.alertError100,
      alertError500: alertError500 ?? this.alertError500,
      alertError700: alertError700 ?? this.alertError700,
      statusOnline: statusOnline ?? this.statusOnline,
      statusOffline: statusOffline ?? this.statusOffline,
      scrim: scrim ?? this.scrim,
      onScrim: onScrim ?? this.onScrim,
      splashBackground: splashBackground ?? this.splashBackground,
    );
  }

  @override
  AppColorsExtension lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary700: Color.lerp(primary700, other.primary700, t)!,
      primary500: Color.lerp(primary500, other.primary500, t)!,
      primary300: Color.lerp(primary300, other.primary300, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      accent500: Color.lerp(accent500, other.accent500, t)!,
      accent100: Color.lerp(accent100, other.accent100, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      secondary900: Color.lerp(secondary900, other.secondary900, t)!,
      secondary500: Color.lerp(secondary500, other.secondary500, t)!,
      secondary300: Color.lerp(secondary300, other.secondary300, t)!,
      neutral0: Color.lerp(neutral0, other.neutral0, t)!,
      neutral50: Color.lerp(neutral50, other.neutral50, t)!,
      neutral100: Color.lerp(neutral100, other.neutral100, t)!,
      neutral200: Color.lerp(neutral200, other.neutral200, t)!,
      neutral400: Color.lerp(neutral400, other.neutral400, t)!,
      neutral600: Color.lerp(neutral600, other.neutral600, t)!,
      screenBackground: Color.lerp(
        screenBackground,
        other.screenBackground,
        t,
      )!,
      elementBackground: Color.lerp(
        elementBackground,
        other.elementBackground,
        t,
      )!,
      alertInfo100: Color.lerp(alertInfo100, other.alertInfo100, t)!,
      alertInfo500: Color.lerp(alertInfo500, other.alertInfo500, t)!,
      alertSuccess100: Color.lerp(alertSuccess100, other.alertSuccess100, t)!,
      alertSuccess500: Color.lerp(alertSuccess500, other.alertSuccess500, t)!,
      alertWarning100: Color.lerp(alertWarning100, other.alertWarning100, t)!,
      alertWarning500: Color.lerp(alertWarning500, other.alertWarning500, t)!,
      alertError100: Color.lerp(alertError100, other.alertError100, t)!,
      alertError500: Color.lerp(alertError500, other.alertError500, t)!,
      alertError700: Color.lerp(alertError700, other.alertError700, t)!,
      statusOnline: Color.lerp(statusOnline, other.statusOnline, t)!,
      statusOffline: Color.lerp(statusOffline, other.statusOffline, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      onScrim: Color.lerp(onScrim, other.onScrim, t)!,
      splashBackground: Color.lerp(
        splashBackground,
        other.splashBackground,
        t,
      )!,
    );
  }

  /// Value equality matters: without it a non-const palette (from [copyWith]
  /// or [lerp]) would make every rebuilt `ThemeData` unequal, restarting the
  /// `AnimatedTheme` cross-fade on every frame.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppColorsExtension &&
        other.primary700 == primary700 &&
        other.primary500 == primary500 &&
        other.primary300 == primary300 &&
        other.primary100 == primary100 &&
        other.onPrimary == onPrimary &&
        other.accent500 == accent500 &&
        other.accent100 == accent100 &&
        other.onAccent == onAccent &&
        other.secondary900 == secondary900 &&
        other.secondary500 == secondary500 &&
        other.secondary300 == secondary300 &&
        other.neutral0 == neutral0 &&
        other.neutral50 == neutral50 &&
        other.neutral100 == neutral100 &&
        other.neutral200 == neutral200 &&
        other.neutral400 == neutral400 &&
        other.neutral600 == neutral600 &&
        other.screenBackground == screenBackground &&
        other.elementBackground == elementBackground &&
        other.alertInfo100 == alertInfo100 &&
        other.alertInfo500 == alertInfo500 &&
        other.alertSuccess100 == alertSuccess100 &&
        other.alertSuccess500 == alertSuccess500 &&
        other.alertWarning100 == alertWarning100 &&
        other.alertWarning500 == alertWarning500 &&
        other.alertError100 == alertError100 &&
        other.alertError500 == alertError500 &&
        other.alertError700 == alertError700 &&
        other.statusOnline == statusOnline &&
        other.statusOffline == statusOffline &&
        other.scrim == scrim &&
        other.onScrim == onScrim &&
        other.splashBackground == splashBackground;
  }

  @override
  int get hashCode => Object.hashAll([
    primary700,
    primary500,
    primary300,
    primary100,
    onPrimary,
    accent500,
    accent100,
    onAccent,
    secondary900,
    secondary500,
    secondary300,
    neutral0,
    neutral50,
    neutral100,
    neutral200,
    neutral400,
    neutral600,
    screenBackground,
    elementBackground,
    alertInfo100,
    alertInfo500,
    alertSuccess100,
    alertSuccess500,
    alertWarning100,
    alertWarning500,
    alertError100,
    alertError500,
    alertError700,
    statusOnline,
    statusOffline,
    scrim,
    onScrim,
    splashBackground,
  ]);
}
