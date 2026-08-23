import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

abstract class BaseGeocodingRepo {
  /// The address parts, most specific first, with blanks dropped. Empty when
  /// the point has no name. Joining them is a presentation concern: the
  /// separator differs by language.
  Future<ApiResults<List<String>>> labelFor(
    GeoPoint point, {
    required String languageCode,
    CancelToken? cancelToken,
  });
}
