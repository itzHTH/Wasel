import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/ui/providers/earnings_range_provider.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class EarningsRangeSelector extends ConsumerWidget {
  const EarningsRangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(earningsRangeControllerProvider);

    return SegmentedButton<EarningsRange>(
      segments: [
        ButtonSegment(
          value: EarningsRange.today,
          label: Text(context.l10n.periodToday),
        ),
        ButtonSegment(
          value: EarningsRange.last7Days,
          label: Text(context.l10n.periodLast7Days),
        ),
        ButtonSegment(
          value: EarningsRange.last30Days,
          label: Text(context.l10n.periodLast30Days),
        ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => ref
          .read(earningsRangeControllerProvider.notifier)
          .select(selection.first),
      style: SegmentedButton.styleFrom(
        backgroundColor: context.colors.elementBackground,
        foregroundColor: context.colors.neutral600,
        selectedBackgroundColor: context.colors.primary100,
        selectedForegroundColor: context.colors.primary700,
        side: BorderSide(color: context.colors.neutral200),
        textStyle: context.styles.caption(weight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
      ),
    );
  }
}
