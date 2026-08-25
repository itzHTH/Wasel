import 'package:dio/dio.dart';
import 'package:driver/core/const/driver_api_consts.dart';
import 'package:driver/features/driver_earnings/data/models/driver_balance/driver_balance_response.dart';
import 'package:driver/features/driver_earnings/data/models/driver_earnings/driver_earnings_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'driver_earnings_api_service.g.dart';

@RestApi()
abstract class DriverEarningsApiService {
  factory DriverEarningsApiService(Dio dio, {String? baseUrl}) =>
      _DriverEarningsApiService(dio, baseUrl: baseUrl);

  @GET(DriverApiConsts.getDriverEarnings)
  Future<DriverEarningsResponse> getDriverEarnings({
    @Query("startDate") DateTime? startDate,
    @Query("endDate") DateTime? endDate,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(DriverApiConsts.getDriverWalletBalance)
  Future<DriverBalanceResponse> getDriverWalletBalance({
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
DriverEarningsApiService driverEarningsApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return DriverEarningsApiService(dio);
}
