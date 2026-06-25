import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class GuidanceText extends StatelessWidget {
  final String message;

  const GuidanceText({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space12,
      ),
      decoration: BoxDecoration(
        color: AppColor.secondary900.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.font16Neutral0SemiBold,
      ),
    );
  }
}
