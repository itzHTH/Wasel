import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/features/ride/ui/providers/earnings/driver_earnings_provider.dart';
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
    final earnings = ref.watch(driverEarningsControllerProvider);

    // Null covers both the first load and a failed one: the panel keeps its
    // shape and shows dashes, so a missing figure is never read as a zero.
    final data = earnings.value;

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
              Text(
                context.l10n.todayEarnings,
                style: context.styles.captionMuted(),
              ),
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
                : RideFormatters.fare(
                    context.l10n,
                    data.totalEarnings.toString(),
                  ),
            style: data == null
                ? context.styles.headline().copyWith(
                    color: context.colors.neutral400,
                  )
                : context.styles.headline(),
          ),
          Divider(color: context.colors.neutral200, height: AppDimens.space24),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _Metric(
                    icon: Icons.local_taxi_outlined,
                    label: context.l10n.todayRides,
                    value: data?.completedRides.toString(),
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
                    value: data == null
                        ? null
                        : RideFormatters.onlineDuration(
                            context.l10n,
                            data.onlineMinutes,
                          ),
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
        color: context.colors.neutral400,
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
              color: context.colors.primary500,
            ),
            SizedBox(width: AppDimens.space4),
            Text(
              context.coreL10n.retry,
              style: context.styles
                  .caption(color: context.colors.neutral400)
                  .copyWith(color: context.colors.primary500),
            ),
          ],
        ),
      ),
    );
  }
}
