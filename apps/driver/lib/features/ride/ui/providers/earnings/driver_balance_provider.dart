import 'package:dio/dio.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';

part 'driver_balance_provider.g.dart';

@riverpod
class DriverBalanceController extends _$DriverBalanceController {
  @override
  Future<double> build() => _fetch();

  /// Re-reads the balance. Rebuilding rather than assigning state keeps the
  /// figure already on screen while the request is in flight.
  void refresh() => ref.invalidateSelf();

  Future<double> _fetch() async {
    final useCase = ref.read(getDriverBalanceUseCaseProvider);
    final result = await useCase.execute(null, CancelToken());

    return result.when(
      success: (data) => data.balance,
      failure: (error) => throw Exception(errorMessageOf(error)),
    );
  }
}
