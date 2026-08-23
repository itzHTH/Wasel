import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_location/data/models/geocoding/google_geocoding_response.dart';
import 'package:wasel_location/data/services/geocoding_api_service.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

class GeocodingRepo implements BaseGeocodingRepo {
  GeocodingRepo(this._geocodingApiService);

  final GeocodingApiService _geocodingApiService;

  @override
  Future<ApiResults<List<String>>> labelFor(
    GeoPoint point, {
    required String languageCode,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _geocodingApiService.getLocationName(
        point.latitude.toString(),
        point.longitude.toString(),
        languageCode: languageCode,
        cancelToken: cancelToken,
      );

      return ApiResults.success(labelFrom(response, languageCode));
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  // Extracts the address parts from Google's geocoding response.
  //
  //* Handling Edge Cases:
  //* 1. Prioritizes components in the requested language when both exist.
  //* 2. Accepts 'sublocality' alongside 'locality' (fixes missing areas in dense cities like Baghdad).
  //* 3. Ignores empty components to prevent overwriting valid Latin names with nulls.
  List<String> labelFrom(
    GoogleGeocodingResponse response, [
    String languageCode = LocationApiConst.geocodingFallbackLanguageCode,
  ]) {
    String? street;
    var streetIsPreferred = false;
    String? locality;
    var localityIsPreferred = false;

    for (final result in response.results) {
      for (final component in result.addressComponents) {
        // Ignore empty texts to avoid overwriting valid fallbacks.
        final text = component.longText;
        if (text == null) continue;

        final isPreferred = component.languageCode == languageCode;

        if (component.types.contains(_routeType) &&
            (street == null || (!streetIsPreferred && isPreferred))) {
          street = text;
          streetIsPreferred = isPreferred;
        }

        final isLocalityType =
            component.types.contains(_localityType) ||
            component.types.contains(_subLocalityType);
        if (isLocalityType &&
            (locality == null || (!localityIsPreferred && isPreferred))) {
          locality = text;
          localityIsPreferred = isPreferred;
        }
      }
    }

    return [street, locality].whereType<String>().toList();
  }

  static const String _routeType = 'route';
  static const String _localityType = 'locality';
  static const String _subLocalityType = 'sublocality';
}
