import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_icon_pill.dart';
import 'package:wasel_profile/domain/entities/driver_approval_status.dart';

/// The driver's account standing, as a coloured pill.
class DriverApprovalBadge extends StatelessWidget {
  const DriverApprovalBadge({super.key, required this.status});

  final DriverApprovalStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, icon, foreground, background) = switch (status) {
      DriverApprovalStatus.approved => (
        context.l10n.approved,
        Icons.check_circle_rounded,
        context.colors.alertSuccess500,
        context.colors.alertSuccess100,
      ),
      DriverApprovalStatus.pending => (
        context.l10n.pendingStatus,
        Icons.schedule_rounded,
        context.colors.alertWarning500,
        context.colors.alertWarning100,
      ),
      DriverApprovalStatus.underReview => (
        context.l10n.underReview,
        Icons.hourglass_top_rounded,
        context.colors.alertInfo500,
        context.colors.alertInfo100,
      ),
      DriverApprovalStatus.rejected => (
        context.l10n.rejected,
        Icons.cancel_rounded,
        context.colors.alertError500,
        context.colors.alertError100,
      ),
    };

    return AppIconPill(
      icon: icon,
      label: label,
      foreground: foreground,
      background: background,
    );
  }
}
