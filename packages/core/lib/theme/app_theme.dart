import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(AppBrand brand) =>
      build(brand: brand, brightness: Brightness.light);

  static ThemeData dark(AppBrand brand) =>
      build(brand: brand, brightness: Brightness.dark);

  /// Builds the full theme for a brand in one brightness.
  static ThemeData build({
    required AppBrand brand,
    required Brightness brightness,
  }) {
    final appColors = brand.paletteFor(brightness);
    final isDark = brightness == Brightness.dark;

    final textTheme =
        GoogleFonts.ibmPlexSansArabicTextTheme(
          ThemeData(brightness: brightness).textTheme,
        ).apply(
          bodyColor: appColors.secondary900,
          displayColor: appColors.secondary900,
        );

    OutlineInputBorder fieldBorder(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: _schemeOf(appColors, brightness),
      scaffoldBackgroundColor: appColors.screenBackground,
      canvasColor: appColors.elementBackground,
      dividerColor: appColors.neutral200,
      textTheme: textTheme,
      extensions: [appColors],

      appBarTheme: AppBarTheme(
        backgroundColor: appColors.screenBackground,
        surfaceTintColor: appColors.screenBackground,
        foregroundColor: appColors.secondary900,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: appColors.secondary900),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: appColors.secondary900,
        ),
      ),

      iconTheme: IconThemeData(color: appColors.secondary500),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.primary500,
          foregroundColor: appColors.onPrimary,
          disabledBackgroundColor: appColors.primary300,
          disabledForegroundColor: appColors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: appColors.primary500),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: appColors.primary500,
          side: BorderSide(color: appColors.neutral200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.elementBackground,
        hintStyle: textTheme.bodyMedium?.copyWith(color: appColors.neutral400),
        labelStyle: textTheme.bodyMedium?.copyWith(color: appColors.neutral600),
        border: fieldBorder(appColors.neutral200),
        enabledBorder: fieldBorder(appColors.neutral200),
        focusedBorder: fieldBorder(appColors.primary500, width: 1.5),
        errorBorder: fieldBorder(appColors.alertError500, width: 1.5),
        focusedErrorBorder: fieldBorder(appColors.alertError500, width: 1.5),
        disabledBorder: fieldBorder(appColors.neutral100),
      ),

      cardTheme: CardThemeData(
        color: appColors.elementBackground,
        surfaceTintColor: appColors.elementBackground,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius16),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: appColors.elementBackground,
        surfaceTintColor: appColors.elementBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius24),
        ),
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: appColors.secondary900,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: appColors.neutral600,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.elementBackground,
        surfaceTintColor: appColors.elementBackground,
        modalBackgroundColor: appColors.elementBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimens.radius24),
          ),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: appColors.neutral200,
        thickness: 1,
        space: 1,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: appColors.secondary900,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: appColors.neutral0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: appColors.neutral100,
        side: BorderSide(color: appColors.neutral200),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: appColors.secondary500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: appColors.primary500,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.elementBackground,
        selectedItemColor: appColors.primary500,
        unselectedItemColor: appColors.neutral400,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      splashColor: appColors.primary500.withValues(alpha: isDark ? 0.16 : 0.08),
      highlightColor: appColors.primary500.withValues(
        alpha: isDark ? 0.10 : 0.05,
      ),
    );
  }

  static ColorScheme _schemeOf(AppColorsExtension c, Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: c.primary500,
      onPrimary: c.onPrimary,
      primaryContainer: c.primary100,
      onPrimaryContainer: c.primary700,
      secondary: c.accent500,
      onSecondary: c.onAccent,
      secondaryContainer: c.accent100,
      onSecondaryContainer: c.accent500,
      tertiary: c.secondary500,
      onTertiary: c.neutral0,
      surface: c.elementBackground,
      onSurface: c.secondary900,
      surfaceContainerLowest: c.elementBackground,
      surfaceContainerLow: c.neutral50,
      surfaceContainer: c.neutral100,
      surfaceContainerHigh: c.neutral100,
      surfaceContainerHighest: c.neutral200,
      onSurfaceVariant: c.neutral600,
      surfaceTint: c.primary500,
      error: c.alertError500,
      onError: c.neutral0,
      errorContainer: c.alertError100,
      onErrorContainer: c.alertError700,
      outline: c.neutral200,
      outlineVariant: c.neutral100,
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: c.secondary900,
      onInverseSurface: c.neutral0,
      inversePrimary: c.primary300,
    );
  }
}
