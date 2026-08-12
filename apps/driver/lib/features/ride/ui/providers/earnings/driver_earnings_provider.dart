import 'package:driver/features/ride/domain/entities/driver_earnings.dart';
import 'package:driver/features/ride/domain/entities/earnings_period.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'driver_earnings_provider.g.dart';

@riverpod
class DriverEarningsController extends _$DriverEarningsController {
  @override
  Future<DriverEarnings?> build() async {
    final isOnline = ref.watch(
      rideControllerProvider.select(
        (state) => state.stage != DriverStage.offline,
      ),
    );

    ref.listen(rideControllerProvider.select((state) => state.stage), (
      previous,
      next,
    ) {
      if (next == DriverStage.completed) refresh();
    });

    if (!isOnline) return null;
    return _fetch();
  }

  /// Re-reads the totals. Rebuilding rather than assigning state keeps the
  /// figures already on screen while the request is in flight, so the card
  /// shows progress without blanking out mid-refresh.
  void refresh() => ref.invalidateSelf();

  Future<DriverEarnings> _fetch() async {
    final useCase = ref.read(getDriverEarningsUseCaseProvider);
    final result = await useCase.call(EarningsPeriod.today());

    return result.when(
      success: (earnings) => earnings,
      failure: (error) =>
          throw Exception(error.apiErrorModel.message ?? 'حصل خطأ ما'),
    );
  }
}
