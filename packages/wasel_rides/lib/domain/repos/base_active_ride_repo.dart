import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';

abstract class BaseActiveRideRepo {
  Future<ApiResults<ActiveRide?>> getActiveRide({CancelToken? cancelToken});
}
