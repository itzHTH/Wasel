import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/api_rider_endpoints.dart';
import 'package:wasal/features/ride/data/models/estimate_ride_price/response/estimate_ride_price_response.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/request_ride_response.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_api_service.g.dart';

@RestApi()
abstract class RideApiService {
  factory RideApiService(Dio dio, {String? baseUrl}) =>
      _RideApiService(dio, baseUrl: baseUrl);

  @GET(ApiRiderEndpoints.estimateRidePrice)
  Future<EstimateRidePriceResponse> estimateRidePrice(
    @Queries() GeoPointRequestBody geoPointRequest, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(ApiRiderEndpoints.requestRide)
  Future<RequestRideResponse> requestRide(
    @Body() GeoPointRequestBody geoPointRequest, {
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
RideApiService rideApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return RideApiService(dio);
}
