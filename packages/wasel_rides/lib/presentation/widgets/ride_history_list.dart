import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_entrance_fade.dart';
import 'package:wasel_rides/core/formatters/ride_history_labels.dart';
import 'package:wasel_rides/presentation/providers/history/ride_history_controller.dart';
import 'package:wasel_rides/presentation/providers/history/ride_history_state.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_card.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_day_header.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_footer.dart';

class RideHistoryList extends ConsumerStatefulWidget {
  const RideHistoryList({super.key, required this.historyState});

  final RideHistoryState historyState;

  @override
  ConsumerState<RideHistoryList> createState() => _RideHistoryListState();
}

class _RideHistoryListState extends ConsumerState<RideHistoryList> {
  final Set<int> _animatedRows = <int>{};

  RideHistoryController get _controller =>
      ref.read(rideHistoryControllerProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final entries = widget.historyState.entries;

    return RefreshIndicator(
      onRefresh: _controller.refresh,
      color: context.colors.primary500,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppDimens.space16,
          AppDimens.space8,
          AppDimens.space16,
          AppDimens.space32,
        ),
        itemCount: entries.length + 1,
        itemBuilder: (context, index) {
          if (index == entries.length) {
            return RideHistoryFooter(
              historyState: widget.historyState,
              onLoadMore: _controller.loadMore,
            );
          }

          final entry = entries[index];
          final previous = index == 0 ? null : entries[index - 1];
          final startsNewDay =
              previous == null ||
              !RideHistoryLabels.isSameDay(
                previous.requestedAt,
                entry.requestedAt,
              );

          final row = Padding(
            padding: EdgeInsets.only(bottom: AppDimens.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (startsNewDay) RideHistoryDayHeader(day: entry.requestedAt),
                RideHistoryCard(entry: entry),
              ],
            ),
          );

          return AppEntranceFade(
            index: index,
            animate: _animatedRows.add(index),
            child: row,
          );
        },
      ),
    );
  }
}
