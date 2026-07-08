import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseRideRepo {
  Future<ApiResults<RidePrice>> estimateRidePrice(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<RequestRide>> requestRide(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  });
}
