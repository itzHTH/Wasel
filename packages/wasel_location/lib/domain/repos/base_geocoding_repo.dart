import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

abstract class BaseGeocodingRepo {
  Future<ApiResults<String>> labelFor(
    GeoPoint point, {
    CancelToken? cancelToken,
  });
}
