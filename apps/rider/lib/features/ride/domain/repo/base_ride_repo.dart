import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/request/request_ride_body.dart';
import 'package:wasal/features/ride/data/models/review_ride/request/review_ride_body.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/entities/review_ride.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseRideRepo {
  Future<ApiResults<RidePrice>> estimateRidePrice(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<RequestRide>> requestRide(
    RequestRideBody requestRideBody, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<CancelRide>> cancelRide(
    String rideId, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<ReviewRide>> reviewRide(
    String rideId,
    ReviewRideBody reviewRideBody, {
    CancelToken? cancelToken,
  });

  Stream<RideEvent> watchRide(String rideId);

  Future<bool> reconnectToRide(String rideId);
}
