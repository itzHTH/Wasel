import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppSoonBadge extends StatelessWidget {
  const AppSoonBadge({super.key, this.label = 'قريبًا'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: AppColor.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Text(label, style: AppTextStyles.font12Neutral600SemiBold),
    );
  }
}
