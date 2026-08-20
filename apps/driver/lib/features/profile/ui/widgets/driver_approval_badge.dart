import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_profile/domain/entities/driver_approval_status.dart';

/// The driver's account standing, as a coloured pill.
class DriverApprovalBadge extends StatelessWidget {
  const DriverApprovalBadge({super.key, required this.status});

  final DriverApprovalStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, icon, foreground, background) = switch (status) {
      DriverApprovalStatus.approved => (
        'موثّق',
        Icons.check_circle_rounded,
        context.colors.alertSuccess500,
        context.colors.alertSuccess100,
      ),
      DriverApprovalStatus.pending => (
        'قيد الانتظار',
        Icons.schedule_rounded,
        context.colors.alertWarning500,
        context.colors.alertWarning100,
      ),
      DriverApprovalStatus.underReview => (
        'قيد المراجعة',
        Icons.hourglass_top_rounded,
        context.colors.alertInfo500,
        context.colors.alertInfo100,
      ),
      DriverApprovalStatus.rejected => (
        'مرفوض',
        Icons.cancel_rounded,
        context.colors.alertError500,
        context.colors.alertError100,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
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
            style: context.styles.font14Secondary900SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
