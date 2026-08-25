import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_cash_out_button.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_stats_row.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_total_card.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// The loading state renders this same tree behind a skeleton, so the
/// placeholder has the exact shape of the real thing.
class EarningsDashboard extends StatelessWidget {
  const EarningsDashboard({super.key, required this.earnings});

  final DriverEarnings earnings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        EarningsTotalCard(totalEarnings: earnings.totalEarnings),
        SizedBox(height: AppDimens.space16),
        EarningsStatsRow(
          completedRides: earnings.completedRides,
          onlineMinutes: earnings.onlineMinutes,
        ),
        SizedBox(height: AppDimens.space32),
        EarningsCashOutButton(canCashOut: earnings.canCashOut),
      ],
    );
  }
}
