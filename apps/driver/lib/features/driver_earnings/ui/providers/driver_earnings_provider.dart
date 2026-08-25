import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/driver_earnings_di_providers.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'driver_earnings_provider.g.dart';

/// A failed read is the user's to retry from the error state.
Duration? _noRetry(int retryCount, Object error) => null;

@Riverpod(retry: _noRetry)
class DriverEarningsController extends _$DriverEarningsController {
  @override
  Future<DriverEarnings> build(EarningsRange range) async {
    final useCase = ref.watch(getDriverEarningsUseCaseProvider);

    // A token per range: the use case instance is shared across every key, so
    // cancelling its own token would abort whichever range asked last.
    final cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    final result = await useCase.execute(
      EarningsPeriod.forRange(range),
      cancelToken,
    );

    return result.when(
      success: (earnings) => earnings,
      failure: (error) => throw error,
    );
  }

  void refresh() => ref.invalidateSelf();
}
