import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/data/services/driver_earnings_api_service.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_balance.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/domain/repo/base_driver_earnings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'driver_earnings_repo.g.dart';

class DriverEarningsRepo implements BaseDriverEarningsRepo {
  DriverEarningsRepo(this._earningsApiService);

  final DriverEarningsApiService _earningsApiService;

  @override
  Future<ApiResults<DriverEarnings>> getDriverEarnings(
    EarningsPeriod period, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _earningsApiService.getDriverEarnings(
        startDate: period.start,
        endDate: period.end,
        cancelToken: cancelToken,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<DriverBalance>> getDriverWalletBalance({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _earningsApiService.getDriverWalletBalance(
        cancelToken: cancelToken,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
BaseDriverEarningsRepo driverEarningsRepo(Ref ref) {
  final apiService = ref.watch(driverEarningsApiServiceProvider);
  return DriverEarningsRepo(apiService);
}
