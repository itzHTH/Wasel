import 'package:flutter/material.dart';
import 'package:wasel_rides/l10n/rides_l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_error_state.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_rides/presentation/providers/history/ride_history_controller.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_empty_state.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_list.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_card.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_placeholders.dart';

class RideHistoryScreen extends ConsumerWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(rideHistoryControllerProvider);
    final controller = ref.read(rideHistoryControllerProvider.notifier);

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      appBar: AppBar(
        title: Text(context.ridesL10n.rideHistoryTitle),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: history.when(
          loading: () => AppSkeleton(
            key: const ValueKey('skeleton'),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                AppDimens.space16,
                AppDimens.space8,
                AppDimens.space16,
                AppDimens.space32,
              ),
              itemCount: rideHistoryPlaceholders.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: AppDimens.space12),
                child: RideHistoryCard(entry: rideHistoryPlaceholders[index]),
              ),
            ),
          ),
          error: (error, _) => AppErrorState(
            key: const ValueKey('error'),
            message: errorMessageOf(error),
            onRetry: controller.refresh,
            isRetrying: history.isLoading,
          ),
          data: (historyState) => historyState.isEmpty
              ? RideHistoryEmptyState(
                  key: const ValueKey('empty'),
                  onRefresh: controller.refresh,
                )
              : RideHistoryList(
                  key: const ValueKey('list'),
                  historyState: historyState,
                ),
        ),
      ),
    );
  }
}
