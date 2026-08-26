import 'package:flutter/material.dart';
import 'package:wasel_rides/l10n/rides_l10n_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_icon_pill.dart';
import 'package:wasel_rides/domain/entities/ride_history_status.dart';

class RideHistoryStatusChip extends StatelessWidget {
  const RideHistoryStatusChip({super.key, required this.status});

  final RideHistoryStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, icon, foreground, background) = switch (status) {
      RideHistoryStatus.completed => (
        context.ridesL10n.rideStatusCompleted,
        Icons.check_circle_rounded,
        context.colors.alertSuccess500,
        context.colors.alertSuccess100,
      ),
      RideHistoryStatus.cancelled => (
        context.ridesL10n.rideStatusCancelled,
        Icons.cancel_rounded,
        context.colors.alertError500,
        context.colors.alertError100,
      ),
      RideHistoryStatus.unknown => (
        context.ridesL10n.rideStatusUnknown,
        Icons.help_outline_rounded,
        context.colors.neutral600,
        context.colors.neutral100,
      ),
    };

    return AppIconPill(
      icon: icon,
      label: label,
      foreground: foreground,
      background: background,
      dense: true,
    );
  }
}
