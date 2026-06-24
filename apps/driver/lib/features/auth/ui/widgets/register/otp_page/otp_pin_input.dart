import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class OtpPinInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;

  const OtpPinInput({super.key, required this.controller, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: AppDimens.otpBoxSize,
      height: AppDimens.otpBoxSize,
      textStyle: AppTextStyles.font24Secondary900Bold,
      decoration: BoxDecoration(
        color: AppColor.neutral50,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
        border: Border.all(color: AppColor.neutral200),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultTheme,
      focusedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          color: AppColor.neutral0,
          border: Border.all(color: AppColor.primary500, width: 1.5),
        ),
      ),
      submittedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          color: AppColor.primary100,
          border: Border.all(color: AppColor.primary300),
        ),
      ),
      separatorBuilder: (_) => SizedBox(width: AppDimens.space12),
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 2.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: AppColor.primary500,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
      onCompleted: onCompleted,
    );
  }
}
