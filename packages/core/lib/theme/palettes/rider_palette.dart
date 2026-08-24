import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';

/// Wasel Rider — "Velocity Teal".
class RiderPalette {
  RiderPalette._();

  static const AppColorsExtension light = AppColorsExtension.light(
    primary700: Color(0xFF05606F),
    primary500: Color(0xFF097A8F),
    primary300: Color(0xFF9FD9E4),
    primary100: Color(0xFFE6F6F9),
    primaryVivid: Color(0xFF00C2E0),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryVivid: Color(0xFF04212A),
    accent500: Color(0xFF6D4AFF),
    accent100: Color(0xFFEFEBFF),
    onAccent: Color(0xFFFFFFFF),
    secondary900: Color(0xFF0E1729),
    secondary500: Color(0xFF4A5A6B),
    secondary300: Color(0xFF60707C),
    neutral0: Color(0xFFFFFFFF),
    neutral50: Color(0xFFFAFCFD),
    neutral100: Color(0xFFF0F4F6),
    neutral200: Color(0xFFDCE5EA),
    borderStrong: Color(0xFF798E9D),
    neutral400: Color(0xFF5F7180),
    neutral600: Color(0xFF45535F),
    screenBackground: Color(0xFFF5F8FA),
    elementBackground: Color(0xFFFFFFFF),
    splashBackground: Color(0xFF0E1729),
  );

  static const AppColorsExtension dark = AppColorsExtension.dark(
    primary700: Color(0xFF17B0CE),
    primary500: Color(0xFF3FD3EE),
    primary300: Color(0xFF2C5A66),
    primary100: Color(0xFF0E2B33),
    primaryVivid: Color(0xFF5FE2FA),
    onPrimary: Color(0xFF04212A),
    onPrimaryVivid: Color(0xFF04212A),
    accent500: Color(0xFFB9A6FF),
    accent100: Color(0xFF241C40),
    onAccent: Color(0xFF17093D),
    secondary900: Color(0xFFE8EEF2),
    secondary500: Color(0xFFA9BCC7),
    secondary300: Color(0xFF8FA5B2),
    neutral0: Color(0xFF151F25),
    neutral50: Color(0xFF1A252C),
    neutral100: Color(0xFF1F2C33),
    neutral200: Color(0xFF2B3A43),
    borderStrong: Color(0xFF526C78),
    neutral400: Color(0xFF90A5B1),
    neutral600: Color(0xFFB9C9D2),
    screenBackground: Color(0xFF0D1418),
    elementBackground: Color(0xFF151F25),
    splashBackground: Color(0xFF0E1729),
  );
}
