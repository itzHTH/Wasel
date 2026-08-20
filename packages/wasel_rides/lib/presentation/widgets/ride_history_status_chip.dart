import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
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
        context.colors.alertSuccess500,
        context.colors.alertSuccess100,
      ),
      RideHistoryStatus.cancelled => (
        'ملغاة',
        Icons.cancel_rounded,
        context.colors.alertError500,
        context.colors.alertError100,
      ),
      RideHistoryStatus.unknown => (
        'غير معروفة',
        Icons.help_outline_rounded,
        context.colors.neutral600,
        context.colors.neutral100,
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
            style: context.styles.font12Neutral600SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
