import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class DriverRatingChip extends StatelessWidget {
  const DriverRatingChip({
    super.key,
    required this.averageRating,
    required this.totalReviews,
  });

  final double averageRating;
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: AppColor.neutral0,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: AppDimens.icon18,
            color: AppColor.alertWarning500,
          ),
          SizedBox(width: AppDimens.space4),
          Text(
            '${averageRating.toStringAsFixed(1)} ($totalReviews)',
            textDirection: TextDirection.ltr,
            style: AppTextStyles.font14Primary500SemiBold,
          ),
        ],
      ),
    );
  }
}
