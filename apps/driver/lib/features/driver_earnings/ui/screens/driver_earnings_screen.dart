import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/ui/providers/driver_earnings_provider.dart';
import 'package:driver/features/driver_earnings/ui/providers/earnings_range_provider.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_dashboard.dart';
import 'package:driver/features/driver_earnings/ui/widgets/earnings_range_selector.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

/// Stand-in figures the skeleton lays out.
const _placeholderEarnings = DriverEarnings(
  completedRides: 12,
  totalEarnings: 125000,
  onlineMinutes: 315,
  canCashOut: true,
);

class DriverEarningsScreen extends ConsumerWidget {
  const DriverEarningsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(earningsRangeControllerProvider);
    final earnings = ref.watch(driverEarningsControllerProvider(range));

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      appBar: AppBar(
        title: Text(context.l10n.earnings),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
      ),
      body: RefreshIndicator(
        color: context.colors.primary500,
        backgroundColor: context.colors.elementBackground,
        onRefresh: () => _refresh(ref, range),
        child: ListView(
          // Short content is not draggable under ClampingScrollPhysics, which
          // would leave the refresh gesture dead on Android.
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            AppDimens.space16,
            AppDimens.space16,
            AppDimens.space16,
            AppDimens.space32,
          ),
          children: [
            // Outside the switcher, so the range stays tappable while the
            // current one loads.
            const EarningsRangeSelector(),
            SizedBox(height: AppDimens.space24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: earnings.when(
                loading: () => const AppSkeleton(
                  key: ValueKey('skeleton'),
                  child: EarningsDashboard(earnings: _placeholderEarnings),
                ),
                error: (error, _) => AppErrorState(
                  key: const ValueKey('error'),
                  message: errorMessageOf(error),
                  onRetry: () => ref
                      .read(driverEarningsControllerProvider(range).notifier)
                      .refresh(),
                  isRetrying: earnings.isLoading,
                ),
                data: (data) => EarningsDashboard(
                  key: const ValueKey('dashboard'),
                  earnings: data,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Awaits the rebuilt future so the spinner stays up until the read settles.
  Future<void> _refresh(WidgetRef ref, EarningsRange range) async {
    ref.invalidate(driverEarningsControllerProvider(range));
    try {
      await ref.read(driverEarningsControllerProvider(range).future);
    } catch (_) {
      // The error state reports it; the spinner just needs to stop.
    }
  }
}
