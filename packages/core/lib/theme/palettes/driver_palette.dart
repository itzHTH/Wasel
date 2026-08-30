import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';

/// Wasel Captain — "Signal Amber". Amber fills always carry ink, never white.
class DriverPalette {
  DriverPalette._();

  static const AppColorsExtension light = AppColorsExtension.light(
    primary700: Color(0xFF7E4404),
    primary500: Color(0xFFA65C06),
    primary300: Color(0xFFE8C99A),
    primary100: Color(0xFFFDF3E3),
    primaryVivid: Color(0xFFF5A314),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryVivid: Color(0xFF1A1206),
    accent500: Color(0xFF0A7183),
    accent100: Color(0xFFE4F3F6),
    onAccent: Color(0xFFFFFFFF),
    secondary900: Color(0xFF12161A),
    secondary500: Color(0xFF4C565E),
    secondary300: Color(0xFF636E75),
    neutral0: Color(0xFFFFFFFF),
    neutral50: Color(0xFFFAFBFB),
    neutral100: Color(0xFFF0F2F3),
    neutral200: Color(0xFFDFE3E5),
    borderStrong: Color(0xFF828D93),
    neutral400: Color(0xFF5A646B),
    neutral600: Color(0xFF464F55),
    screenBackground: Color(0xFFF4F6F7),
    elementBackground: Color(0xFFFFFFFF),
    splashBackground: Color(0xFFF4F6F7),
  );

  static const AppColorsExtension dark = AppColorsExtension.dark(
    primary700: Color(0xFFD98E0C),
    primary500: Color(0xFFFFB020),
    primary300: Color(0xFF6B5320),
    primary100: Color(0xFF2A1F0B),
    primaryVivid: Color(0xFFFFC24D),
    onPrimary: Color(0xFF1A1206),
    onPrimaryVivid: Color(0xFF1A1206),
    accent500: Color(0xFF4FC3DD),
    accent100: Color(0xFF102A31),
    onAccent: Color(0xFF04212A),
    secondary900: Color(0xFFE9EDEF),
    secondary500: Color(0xFFA8B2B8),
    secondary300: Color(0xFF8C979D),
    neutral0: Color(0xFF181C1F),
    neutral50: Color(0xFF1D2225),
    neutral100: Color(0xFF23282C),
    neutral200: Color(0xFF2A3136),
    borderStrong: Color(0xFF657077),
    neutral400: Color(0xFF98A3A9),
    neutral600: Color(0xFFBFC8CD),
    screenBackground: Color(0xFF0E1113),
    elementBackground: Color(0xFF181C1F),
    splashBackground: Color(0xFF12161A),
  );
}
