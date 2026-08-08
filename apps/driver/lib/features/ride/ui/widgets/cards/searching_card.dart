import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/ui/providers/driver_earnings_overview_provider.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:driver/features/ride/ui/widgets/searching_radar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class SearchingCard extends ConsumerWidget {
  const SearchingCard({super.key, required this.onGoOffline});

  final VoidCallback onGoOffline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earnings = ref.watch(driverEarningsOverviewProvider);

    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const SearchingRadar(),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'دا ندوّر على طلبات',
                      style: AppTextStyles.font20Secondary900Bold,
                    ),
                    Text(
                      'خليك بمكان زحمة حتى توصلك طلبات أكثر',
                      style: AppTextStyles.font14Neutral400Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space24),
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'رحلات اليوم',
                  value: '${earnings.completedTrips}',
                  isPlaceholder: earnings.isPlaceholder,
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'أرباح اليوم',
                  value: RideFormatters.fare(
                    earnings.todayTotal.toString(),
                    currency: earnings.currency,
                  ),
                  isPlaceholder: earnings.isPlaceholder,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(label: 'إيقاف الاستلام', onPressed: onGoOffline),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.isPlaceholder,
  });

  final String label;
  final String value;

  /// Greys the figure out while it comes from placeholder data, so it is not
  /// read as a real total.
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font12Neutral400Regular),
        SizedBox(height: AppDimens.space4),
        Text(
          value,
          style: isPlaceholder
              ? AppTextStyles.font14Neutral400Medium
              : AppTextStyles.font14Secondary900SemiBold,
        ),
      ],
    );
  }
}
