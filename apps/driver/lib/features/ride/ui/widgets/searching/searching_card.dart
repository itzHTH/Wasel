import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/ui/providers/earnings/driver_earnings_provider.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:driver/features/ride/ui/widgets/searching/searching_radar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class SearchingCard extends ConsumerWidget {
  const SearchingCard({super.key, required this.onGoOffline});

  final VoidCallback onGoOffline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const _TodayPanel(),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(label: 'إيقاف الاستلام', onPressed: onGoOffline),
        ],
      ),
    );
  }
}

class _TodayPanel extends ConsumerWidget {
  const _TodayPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earnings = ref.watch(driverEarningsControllerProvider);

    // Null covers both the first load and a failed one: the panel keeps its
    // shape and shows dashes, so a missing figure is never read as a zero.
    final data = earnings.value;

    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: AppColor.neutral50,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        border: Border.all(color: AppColor.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('أرباح اليوم', style: AppTextStyles.font12Neutral400Regular),
              SizedBox(width: AppDimens.space8),
              if (earnings.isLoading)
                const _PanelSpinner()
              else if (earnings.hasError)
                _RetryButton(
                  onPressed: () => ref
                      .read(driverEarningsControllerProvider.notifier)
                      .refresh(),
                ),
            ],
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            data == null
                ? '—'
                : RideFormatters.fareWithCurrency(
                    data.totalEarnings.toString(),
                  ),
            style: data == null
                ? AppTextStyles.font24Secondary900Bold.copyWith(
                    color: AppColor.neutral400,
                  )
                : AppTextStyles.font24Secondary900Bold,
          ),
          Divider(color: AppColor.neutral200, height: AppDimens.space24),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _Metric(
                    icon: Icons.local_taxi_outlined,
                    label: 'رحلات اليوم',
                    value: data?.completedRides.toString(),
                  ),
                ),
                VerticalDivider(
                  color: AppColor.neutral200,
                  width: AppDimens.space16,
                ),
                Expanded(
                  child: _Metric(
                    icon: Icons.schedule_outlined,
                    label: "مدة الاتصال اليوم",
                    value: data == null
                        ? null
                        : RideFormatters.onlineDuration(data.onlineMinutes),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;

  /// Null while there is no figure to show — greyed out to a dash so it is not
  /// mistaken for a real one.
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: AppDimens.icon18, color: AppColor.neutral400),
            SizedBox(width: AppDimens.space4),
            Text(label, style: AppTextStyles.font12Neutral400Regular),
          ],
        ),
        SizedBox(height: AppDimens.space4),
        Text(
          value ?? '—',
          style: value == null
              ? AppTextStyles.font14Neutral400Medium
              : AppTextStyles.font14Secondary900SemiBold,
        ),
      ],
    );
  }
}

/// Sized to sit on the label's baseline without pushing the row taller.
class _PanelSpinner extends StatelessWidget {
  const _PanelSpinner();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.icon18,
      height: AppDimens.icon18,
      child: CircularProgressIndicator(
        strokeWidth: AppDimens.space4 / 2,
        color: AppColor.neutral400,
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space8,
          vertical: AppDimens.space4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              size: AppDimens.icon18,
              color: AppColor.primary500,
            ),
            SizedBox(width: AppDimens.space4),
            Text(
              'إعادة المحاولة',
              style: AppTextStyles.font12Neutral400Regular.copyWith(
                color: AppColor.primary500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
