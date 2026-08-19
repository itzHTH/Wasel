import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_rides/domain/entities/ride_history_status.dart';

class RideHistoryStatusChip extends StatelessWidget {
  const RideHistoryStatusChip({super.key, required this.status});

  final RideHistoryStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, icon, foreground, background) = switch (status) {
      RideHistoryStatus.completed => (
        'مكتملة',
        Icons.check_circle_rounded,
        AppColor.alertSuccess500,
        AppColor.alertSuccess100,
      ),
      RideHistoryStatus.cancelled => (
        'ملغاة',
        Icons.cancel_rounded,
        AppColor.alertError500,
        AppColor.alertError100,
      ),
      RideHistoryStatus.unknown => (
        'غير معروفة',
        Icons.help_outline_rounded,
        AppColor.neutral600,
        AppColor.neutral100,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space8,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimens.icon18, color: foreground),
          SizedBox(width: AppDimens.space4),
          Text(
            label,
            style: AppTextStyles.font12Neutral600SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
