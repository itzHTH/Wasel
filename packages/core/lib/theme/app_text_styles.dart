import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // Base helper — all styles go through here so fontFamily is never missing
  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) => GoogleFonts.ibmPlexSansArabic(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );

  static TextStyle get font48Neutral0Bold => _base(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.neutral0,
  );

  static TextStyle get font32Secondary900Bold => _base(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.secondary900,
  );

  static TextStyle get font24Secondary900Bold => _base(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.secondary900,
  );

  static TextStyle get font20Secondary900Bold => _base(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.secondary900,
  );

  static TextStyle get font16Secondary500Regular => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.secondary500,
  );

  static TextStyle get font16Neutral0SemiBold => _base(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.neutral0,
  );

  static TextStyle get font14Secondary900SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.secondary900,
  );

  static TextStyle get font14Secondary500Medium => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.secondary500,
  );

  static TextStyle get font14Neutral400Regular => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.neutral400,
  );

  static TextStyle get font14Neutral400Medium => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.neutral400,
  );

  // ── Caption ───────────────────────────────────────────────────────────────
  static TextStyle get font12Neutral400Regular => _base(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.neutral400,
  );

  // ── Accent ────────────────────────────────────────────────────────────────
  static TextStyle get font14Primary500SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.primary500,
  );

  static TextStyle get font14alertError500SemiBold => _base(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.alertError500,
  );
}
