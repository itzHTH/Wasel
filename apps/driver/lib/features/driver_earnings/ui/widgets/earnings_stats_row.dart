import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class EarningsStatsRow extends StatelessWidget {
  const EarningsStatsRow({
    super.key,
    required this.completedRides,
    required this.onlineMinutes,
  });

  final int completedRides;
  final num onlineMinutes;

  @override
  Widget build(BuildContext context) {
    return AppStatCards(
      stats: [
        AppStat(
          icon: Icons.local_taxi_outlined,
          iconColor: context.colors.primary500,
          background: context.colors.primary100,
          label: context.l10n.completedRidesLabel,
          value: completedRides.toString(),
          valueTextDirection: TextDirection.ltr,
        ),
        AppStat(
          icon: Icons.schedule_outlined,
          iconColor: context.colors.alertInfo500,
          background: context.colors.alertInfo100,
          label: context.l10n.onlineTimeLabel,
          value: RideFormatters.onlineDuration(context.l10n, onlineMinutes),
          valueTextDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
