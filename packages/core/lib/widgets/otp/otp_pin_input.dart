import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// Six-box OTP entry, shared by the register and reset-password flows.
class OtpPinInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;

  /// Paints the boxes in the error palette (e.g. the server rejected the code).
  final bool hasError;

  const OtpPinInput({
    super.key,
    required this.controller,
    this.onCompleted,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: AppDimens.otpBoxSize,
      height: AppDimens.otpBoxSize,
      textStyle: context.styles.font24Secondary900Bold,
      decoration: BoxDecoration(
        color: context.colors.neutral50,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
        border: Border.all(color: context.colors.neutral200),
      ),
    );

    final errorTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        color: context.colors.alertError100,
        border: Border.all(color: context.colors.alertError500, width: 1.5),
      ),
    );

    return Pinput(
      length: 6,
      controller: controller,
      keyboardType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      defaultPinTheme: defaultTheme,
      focusedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          color: context.colors.elementBackground,
          border: Border.all(color: context.colors.primary500, width: 1.5),
        ),
      ),
      submittedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          color: context.colors.primary100,
          border: Border.all(color: context.colors.primary300),
        ),
      ),
      errorPinTheme: errorTheme,
      forceErrorState: hasError,
      separatorBuilder: (_) => SizedBox(width: AppDimens.space12),
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 2.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: context.colors.primary500,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
      onCompleted: onCompleted,
    );
  }
}
