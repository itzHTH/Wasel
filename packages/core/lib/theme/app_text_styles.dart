import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';

@immutable
class AppTextStyles {
  const AppTextStyles(this._appColors);

  final AppColorsExtension _appColors;

  // Base helper — all styles go through here so fontFamily is never missing
  TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) => GoogleFonts.ibmPlexSansArabic(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  TextStyle get font48Neutral0Bold => _base(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    color: _appColors.onScrim,
  );

  TextStyle get font32Secondary900Bold => _base(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: _appColors.secondary900,
  );

  TextStyle get font24Secondary900Bold => _base(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: _appColors.secondary900,
  );

  TextStyle get font20Secondary900Bold => _base(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: _appColors.secondary900,
  );

  TextStyle get font16Secondary500Regular => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: _appColors.secondary500,
  );

  TextStyle get font16Secondary900Bold => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: _appColors.secondary900,
  );

  TextStyle get font16Neutral0SemiBold => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.onPrimary,
  );

  TextStyle get font16OnScrimSemiBold => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.onScrim,
  );

  TextStyle get font14Secondary900SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.secondary900,
  );

  TextStyle get font14Secondary500Medium => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: _appColors.secondary500,
  );

  TextStyle get font14Neutral400Regular => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: _appColors.neutral400,
  );

  TextStyle get font14Neutral400Medium => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: _appColors.neutral400,
  );

  TextStyle get font12Neutral400Regular => _base(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: _appColors.neutral400,
  );

  TextStyle get font12Neutral600SemiBold => _base(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.neutral600,
  );

  TextStyle get font14Primary500SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.primary500,
  );

  TextStyle get font14alertError500SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: _appColors.alertError500,
  );
}
