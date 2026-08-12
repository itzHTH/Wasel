import 'package:dio/dio.dart';
import 'package:driver/core/const/driver_api_consts.dart';
import 'package:driver/features/ride/data/models/driver_balance/driver_balance_response.dart';
import 'package:driver/features/ride/data/models/driver_earnings/driver_earnings_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_api_service.g.dart';

@RestApi()
abstract class RideApiService {
  factory RideApiService(Dio dio, {String? baseUrl}) =>
      _RideApiService(dio, baseUrl: baseUrl);

  @POST(DriverApiConsts.acceptRide)
  Future<void> acceptRide(
    @Path("id") String rideId, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(DriverApiConsts.arriveAtStartPoint)
  Future<void> arriveAtDestination(
    @Path("id") String rideId, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(DriverApiConsts.startRide)
  Future<void> startRide(
    @Path("id") String rideId, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(DriverApiConsts.completeRide)
  Future<void> completeRide(
    @Path("id") String rideId, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(DriverApiConsts.driverCancelRide)
  Future<void> driverCancelRide(
    @Path("id") String rideId, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(DriverApiConsts.getDriverWalletBalance)
  Future<DriverBalanceResponse> getDriverWalletBalance({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(DriverApiConsts.getDriverEarnings)
  Future<DriverEarningsResponse> getDriverEarnings({
    @Query("startDate") DateTime? startDate,
    @Query("endDate") DateTime? endDate,
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
RideApiService rideApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return RideApiService(dio);
}
