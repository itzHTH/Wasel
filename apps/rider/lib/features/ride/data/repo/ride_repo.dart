import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/estimate_ride_price/response/estimate_ride_price_response.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/request_ride_response.dart';
import 'package:wasal/features/ride/data/services/ride_api_service.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_repo.g.dart';

class RideRepo extends BaseRideRepo {
  final RideApiService _rideApiService;

  RideRepo(this._rideApiService);

  @override
  Future<ApiResults<RidePrice>> estimateRidePrice(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  }) async {
    try {
      final EstimateRidePriceResponse response = await _rideApiService
          .estimateRidePrice(geoPointRequest, cancelToken: cancelToken);

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<RequestRide>> requestRide(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  }) async {
    try {
      final RequestRideResponse response = await _rideApiService.requestRide(
        geoPointRequest,
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
BaseRideRepo rideRepo(Ref ref) {
  final rideApiService = ref.watch(rideApiServiceProvider);
  return RideRepo(rideApiService);
}
