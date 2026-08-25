import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/driver_earnings_di_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'driver_balance_provider.g.dart';

/// A failed read is the user's to retry; the default policy would fire ten
/// more requests through the auth-refresh interceptor.
Duration? _noRetry(int retryCount, Object error) => null;

@Riverpod(retry: _noRetry)
class DriverBalanceController extends _$DriverBalanceController {
  @override
  Future<double> build() async {
    final useCase = ref.watch(getDriverBalanceUseCaseProvider);

    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    final result = await useCase.execute(null, cancelToken);

    return result.when(
      success: (data) => data.balance,
      failure: (error) => throw error,
    );
  }

  void refresh() => ref.invalidateSelf();
}
