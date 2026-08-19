import 'package:flutter/material.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_rides/presentation/providers/history/ride_history_state.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_load_more_sentinel.dart';

/// Tail of the history list: the paging trigger, its progress, its failure and
/// its end marker — whichever one the current state calls for.
class RideHistoryFooter extends StatelessWidget {
  const RideHistoryFooter({
    super.key,
    required this.historyState,
    required this.onLoadMore,
  });

  final RideHistoryState historyState;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final loadMoreError = historyState.loadMoreError;

    if (loadMoreError != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.space16),
        child: AppErrorRetry(
          message: errorMessageOf(loadMoreError),
          onRetry: onLoadMore,
        ),
      );
    }

    if (historyState.hasMore) {
      return RideHistoryLoadMoreSentinel(
        key: ValueKey(historyState.nextPage),
        onReached: onLoadMore,
        child: const _LoadingMoreRow(),
      );
    }

    if (historyState.isEmpty) return const SizedBox.shrink();

    return const _EndOfListRow();
  }
}

class _LoadingMoreRow extends StatelessWidget {
  const _LoadingMoreRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space24),
      child: const Center(child: AppInlineLoading()),
    );
  }
}

class _EndOfListRow extends StatelessWidget {
  const _EndOfListRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space24),
      child: Row(
        children: [
          const Expanded(
            child: Divider(height: 1, thickness: 1, color: AppColor.neutral200),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.space12),
            child: Text(
              'لا مزيد من الرحلات',
              style: AppTextStyles.font12Neutral400Regular,
            ),
          ),
          const Expanded(
            child: Divider(height: 1, thickness: 1, color: AppColor.neutral200),
          ),
        ],
      ),
    );
  }
}
