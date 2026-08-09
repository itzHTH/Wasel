import 'package:dio/dio.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseGeocodingRepo {
  /// Human readable label for [point] — street and locality, in Arabic when
  /// Google has it.
  Future<ApiResults<String>> labelFor(GeoPoint point, {CancelToken? cancelToken});
}
