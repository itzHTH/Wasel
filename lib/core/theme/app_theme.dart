import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.screenBackground,
      textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          borderSide: const BorderSide(color: AppColor.neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          borderSide: const BorderSide(color: AppColor.neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          borderSide: const BorderSide(color: AppColor.primary500, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          borderSide: const BorderSide(
            color: AppColor.alertError500,
            width: 1.5,
          ),
        ),
      ),

      // TODO : Define Light Theme
    );
  }
}
