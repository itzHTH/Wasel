import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/data/models/geocoding/reverse_geocoding_response.dart';
import 'package:wasel_location/data/models/places/autocomplete/request/autocomplete_body.dart';
import 'package:wasel_location/data/models/places/autocomplete/response/autocomplete_response.dart';
import 'package:wasel_location/data/models/places/details/response/place_details_response.dart';
import 'package:wasel_location/data/models/places/nearby/request/nearby_search_body.dart';
import 'package:wasel_location/data/models/places/nearby/response/nearby_search_response.dart';
import 'package:wasel_location/data/services/geocoding_api_service.dart';
import 'package:wasel_location/data/services/places_api_service.dart';
import 'package:wasel_location/data/session/place_search_session.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

/// How far around the rider autocomplete prefers results, in metres.
const _biasRadius = 30000.0;

class GoogleGeocodingRepo implements BaseGeocodingRepo {
  GoogleGeocodingRepo(this._places, this._geocoding, this._session);

  final PlacesApiService _places;
  final GeocodingApiService _geocoding;
  final PlaceSearchSession _session;

  /// Names a dropped pin, preferring a landmark over a postal address.
  @override
  Future<ApiResults<List<String>>> labelFor(
    GeoPoint point, {
    required String languageCode,
    CancelToken? cancelToken,
  }) async {
    try {
      final poi = await _nearestPoi(
        point,
        languageCode: languageCode,
        cancelToken: cancelToken,
      );
      if (poi.isNotEmpty) return ApiResults.success(poi);

      final response = await _geocoding.reverseGeocode(
        latlng: '${point.latitude},${point.longitude}',
        language: languageCode,
        cancelToken: cancelToken,
      );

      // A point Google cannot name is an empty label, not a failure: callers
      // fall back to coordinates, which at least tell two points apart.
      return ApiResults.success(response.toLabelParts());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  /// Empty when there is no POI worth naming, or when the lookup itself failed
  /// — an unreachable Places call must still let geocoding answer.
  Future<List<String>> _nearestPoi(
    GeoPoint point, {
    required String languageCode,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _places.searchNearby(
        body: NearbySearchBody(
          languageCode: languageCode,
          maxResultCount: 1,
          rankPreference: LocationApiConst.nearbyRankPreference,
          locationRestriction: NearbyLocationRestriction(
            circle: AutocompleteCircle(
              center: GoogleLatLng(
                latitude: point.latitude,
                longitude: point.longitude,
              ),
              radius: LocationApiConst.nearbyRadiusMeters,
            ),
          ),
        ),
        cancelToken: cancelToken,
      );

      final place = response.places.firstOrNull;
      return place == null ? const [] : place.toLabelParts();
    } on DioException catch (e) {
      // A cancelled lookup is the caller going away, not a missing POI.
      if (CancelToken.isCancel(e)) rethrow;
      return const [];
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<ApiResults<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    required String languageCode,
    GeoPoint? proximity,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _places.autocomplete(
        body: AutocompleteBody(
          input: query,
          sessionToken: _session.token,
          languageCode: languageCode,
          includedRegionCodes: const [LocationApiConst.geocodingCountryCode],
          locationBias: proximity == null ? null : _biasAround(proximity),
        ),
        cancelToken: cancelToken,
      );

      final suggestions = response.suggestions
          .map((suggestion) => suggestion.placePrediction?.toEntity())
          .whereType<PlaceSuggestion>()
          .toList();

      return ApiResults.success(suggestions);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<GeoPoint>> retrievePlace(
    String placeId, {
    required String languageCode,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _places.placeDetails(
        placeId,
        sessionToken: _session.token,
        languageCode: languageCode,
        cancelToken: cancelToken,
      );

      // Closed only on a reply Google billed; a failed call leaves the session
      // open so the retry stays inside it.
      _session.close();

      final point = response.toPoint();
      if (point == null) {
        return ApiResults.failure(
          ErrorHandler.handle(
            DioException(
              requestOptions: RequestOptions(path: placeId),
              type: DioExceptionType.badResponse,
              error: 'Place $placeId carries no location',
            ),
          ),
        );
      }

      return ApiResults.success(point);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  AutocompleteLocationBias _biasAround(GeoPoint point) =>
      AutocompleteLocationBias(
        circle: AutocompleteCircle(
          center: GoogleLatLng(
            latitude: point.latitude,
            longitude: point.longitude,
          ),
          radius: _biasRadius,
        ),
      );
}
