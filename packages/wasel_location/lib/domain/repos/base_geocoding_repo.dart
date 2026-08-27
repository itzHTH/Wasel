import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';

abstract class BaseGeocodingRepo {
  /// The address parts, most specific first, with blanks dropped. Empty when
  /// the point has no name. Joining them is a presentation concern: the
  /// separator differs by language.
  Future<ApiResults<List<String>>> labelFor(
    GeoPoint point, {
    required String languageCode,
    CancelToken? cancelToken,
  });

  /// Places matching query, best match first. An empty list means the search
  /// matched nothing, which is not a failure.
  Future<ApiResults<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    required String languageCode,
    GeoPoint? proximity,
    CancelToken? cancelToken,
  });

  /// Resolves the coordinates of the suggestion the rider picked.
  Future<ApiResults<GeoPoint>> retrievePlace(
    String placeId, {
    required String languageCode,
    CancelToken? cancelToken,
  });
}
