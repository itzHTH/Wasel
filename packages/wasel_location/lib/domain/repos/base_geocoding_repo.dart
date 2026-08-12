import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

abstract class BaseGeocodingRepo {
  /// Human readable label for [point] — street and locality, in Arabic when
  /// Google has it.
  ///
  /// [cancelToken] lets a caller abandon the lookup when the point it was asked
  /// about is no longer on screen. This matters more than it looks: the rider
  /// resolves a label for every pin drag, so without cancellation a fast drag
  /// leaves a queue of in-flight requests whose answers all arrive out of order.
  Future<ApiResults<String>> labelFor(
    GeoPoint point, {
    CancelToken? cancelToken,
  });
}
