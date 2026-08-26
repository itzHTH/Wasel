import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/ui/providers/driver_earnings_provider.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_placeholders.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
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
          RideStageHeader(
            stage: RideStageVisual.searching,
            title: context.l10n.searchingForRequests,
            subtitle: context.l10n.stayInBusyArea,
          ),
          SizedBox(height: AppDimens.space24),
          const _TodayPanel(),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(
            label: context.l10n.stopAcceptingRides,
            onPressed: onGoOffline,
          ),
        ],
      ),
    );
  }
}

class _TodayPanel extends ConsumerWidget {
  const _TodayPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const range = EarningsRange.today;
    final earnings = ref.watch(driverEarningsControllerProvider(range));

    final data = earnings.value;

    // Only the first load skeletons. A failure still shows dashes, so a
    // missing figure is never read as a zero.
    final isLoading = earnings.isLoading && data == null;
    final shown = isLoading ? placeholderEarnings : data;

    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: context.colors.neutral50,
        borderRadius: BorderRadius.circular(context.shape.radiusCard),
        border: Border.all(color: context.colors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  context.l10n.todayEarnings,
                  style: context.styles.captionMuted(),
                ),
              ),
              SizedBox(width: AppDimens.space8),
              if (earnings.hasError)
                _RetryButton(
                  // A retry in flight still reports hasError, so without this
                  // the button invites taps that cancel their own request.
                  isRetrying: earnings.isLoading,
                  onPressed: () => ref
                      .read(driverEarningsControllerProvider(range).notifier)
                      .refresh(),
                ),
            ],
          ),
          SizedBox(height: AppDimens.space4),
          AppSkeleton(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shown == null
                      ? '—'
                      : RideFormatters.fare(
                          context.l10n,
                          shown.totalEarnings.toString(),
                        ),
                  style: shown == null
                      ? context.styles.headline().copyWith(
                          color: context.colors.neutral400,
                        )
                      : context.styles.headline(),
                ),
                Divider(
                  color: context.colors.neutral200,
                  height: AppDimens.space24,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          icon: Icons.local_taxi_outlined,
                          label: context.l10n.todayRides,
                          value: shown?.completedRides.toString(),
                        ),
                      ),
                      VerticalDivider(
                        color: context.colors.neutral200,
                        width: AppDimens.space16,
                      ),
                      Expanded(
                        child: _Metric(
                          icon: Icons.schedule_outlined,
                          label: context.l10n.todayOnlineTime,
                          value: shown == null
                              ? null
                              : RideFormatters.onlineDuration(
                                  context.l10n,
                                  shown.onlineMinutes,
                                ),
                        ),
                      ),
                    ],
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
            Icon(
              icon,
              size: AppDimens.icon18,
              color: context.colors.neutral400,
            ),
            SizedBox(width: AppDimens.space4),
            // The captain ramp has no 12sp tier, so this label needs room to
            // wrap rather than a fixed width to overflow out of.
            Expanded(child: Text(label, style: context.styles.captionMuted())),
          ],
        ),
        SizedBox(height: AppDimens.space4),
        Text(
          value ?? '—',
          style: value == null
              ? context.styles.bodyMuted(weight: FontWeight.w500)
              : context.styles.body(weight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed, this.isRetrying = false});

  final VoidCallback onPressed;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    final color = isRetrying
        ? context.colors.neutral400
        : context.colors.primary500;

    return InkWell(
      onTap: isRetrying ? null : onPressed,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space8,
          vertical: AppDimens.space4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh, size: AppDimens.icon18, color: color),
            SizedBox(width: AppDimens.space4),
            Flexible(
              child: Text(
                isRetrying ? context.coreL10n.retrying : context.coreL10n.retry,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.caption(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
