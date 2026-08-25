import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Per-brand type ramp.
///
/// The rider ramp is expressive — a wide range read at rest, one-handed. The
/// captain ramp is compressed with a higher floor, because it is read in
/// glances, at arm's length, in a moving vehicle. Nothing there drops below 14.
@immutable
class AppTypeScale extends ThemeExtension<AppTypeScale> {
  const AppTypeScale({
    required this.displayLargeSize,
    required this.displaySize,
    required this.displayWeight,
    required this.headlineSize,
    required this.headlineWeight,
    required this.titleSize,
    required this.titleWeight,
    required this.bodyLargeSize,
    required this.bodySize,
    required this.labelSize,
    required this.labelWeight,
    required this.captionSize,
  });

  AppTypeScale.rider()
    : displayLargeSize = 48.sp,
      displaySize = 32.sp,
      displayWeight = FontWeight.w700,
      headlineSize = 24.sp,
      headlineWeight = FontWeight.w700,
      titleSize = 20.sp,
      titleWeight = FontWeight.w600,
      bodyLargeSize = 16.sp,
      bodySize = 14.sp,
      labelSize = 13.sp,
      labelWeight = FontWeight.w500,
      captionSize = 12.sp;

  AppTypeScale.driver()
    : displayLargeSize = 44.sp,
      displaySize = 28.sp,
      displayWeight = FontWeight.w600,
      headlineSize = 22.sp,
      headlineWeight = FontWeight.w600,
      titleSize = 18.sp,
      titleWeight = FontWeight.w600,
      bodyLargeSize = 16.sp,
      bodySize = 15.sp,
      labelSize = 14.sp,
      labelWeight = FontWeight.w500,
      captionSize = 14.sp;

  final double displayLargeSize;
  final double displaySize;
  final FontWeight displayWeight;
  final double headlineSize;
  final FontWeight headlineWeight;
  final double titleSize;
  final FontWeight titleWeight;
  final double bodyLargeSize;
  final double bodySize;
  final double labelSize;
  final FontWeight labelWeight;
  final double captionSize;

  @override
  AppTypeScale copyWith({
    double? displayLargeSize,
    double? displaySize,
    FontWeight? displayWeight,
    double? headlineSize,
    FontWeight? headlineWeight,
    double? titleSize,
    FontWeight? titleWeight,
    double? bodyLargeSize,
    double? bodySize,
    double? labelSize,
    FontWeight? labelWeight,
    double? captionSize,
  }) => AppTypeScale(
    displayLargeSize: displayLargeSize ?? this.displayLargeSize,
    displaySize: displaySize ?? this.displaySize,
    displayWeight: displayWeight ?? this.displayWeight,
    headlineSize: headlineSize ?? this.headlineSize,
    headlineWeight: headlineWeight ?? this.headlineWeight,
    titleSize: titleSize ?? this.titleSize,
    titleWeight: titleWeight ?? this.titleWeight,
    bodyLargeSize: bodyLargeSize ?? this.bodyLargeSize,
    bodySize: bodySize ?? this.bodySize,
    labelSize: labelSize ?? this.labelSize,
    labelWeight: labelWeight ?? this.labelWeight,
    captionSize: captionSize ?? this.captionSize,
  );

  @override
  AppTypeScale lerp(covariant ThemeExtension<AppTypeScale>? other, double t) {
    if (other is! AppTypeScale) return this;
    double d(double a, double b) => a + (b - a) * t;
    return AppTypeScale(
      displayLargeSize: d(displayLargeSize, other.displayLargeSize),
      displaySize: d(displaySize, other.displaySize),
      displayWeight: t < 0.5 ? displayWeight : other.displayWeight,
      headlineSize: d(headlineSize, other.headlineSize),
      headlineWeight: t < 0.5 ? headlineWeight : other.headlineWeight,
      titleSize: d(titleSize, other.titleSize),
      titleWeight: t < 0.5 ? titleWeight : other.titleWeight,
      bodyLargeSize: d(bodyLargeSize, other.bodyLargeSize),
      bodySize: d(bodySize, other.bodySize),
      labelSize: d(labelSize, other.labelSize),
      labelWeight: t < 0.5 ? labelWeight : other.labelWeight,
      captionSize: d(captionSize, other.captionSize),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppTypeScale &&
        other.displayLargeSize == displayLargeSize &&
        other.displaySize == displaySize &&
        other.displayWeight == displayWeight &&
        other.headlineSize == headlineSize &&
        other.headlineWeight == headlineWeight &&
        other.titleSize == titleSize &&
        other.titleWeight == titleWeight &&
        other.bodyLargeSize == bodyLargeSize &&
        other.bodySize == bodySize &&
        other.labelSize == labelSize &&
        other.labelWeight == labelWeight &&
        other.captionSize == captionSize;
  }

  @override
  int get hashCode => Object.hashAll([
    displayLargeSize,
    displaySize,
    displayWeight,
    headlineSize,
    headlineWeight,
    titleSize,
    titleWeight,
    bodyLargeSize,
    bodySize,
    labelSize,
    labelWeight,
    captionSize,
  ]);
}
