import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_location/data/models/geocoding/google_geocoding_response.dart';
import 'package:wasel_location/data/repos/location_domain_failure.dart';
import 'package:wasel_location/data/services/geocoding_api_service.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

class GeocodingRepo implements BaseGeocodingRepo {
  GeocodingRepo(this._geocodingApiService);

  final GeocodingApiService _geocodingApiService;

  static const String _noLabelMessage = 'لا يوجد اسم لهذا الموقع حاليا';

  @override
  Future<ApiResults<String>> labelFor(
    GeoPoint point, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _geocodingApiService.getLocationName(
        point.latitude.toString(),
        point.longitude.toString(),
        cancelToken: cancelToken,
      );

      final label = labelFrom(response);

      return label.isEmpty
          ? domainFailure<String>(_noLabelMessage)
          : ApiResults.success(label);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  // Extracts a localized 'Street، Locality' label from Google's geocoding response.
  //
  //* Handling Edge Cases:
  //* 1. Prioritizes Arabic names over Latin ones if both exist.
  //* 2. Accepts 'sublocality' alongside 'locality' (fixes missing areas in dense cities like Baghdad).
  //* 3. Ignores empty components to prevent overwriting valid Latin names with nulls.
  String labelFrom(GoogleGeocodingResponse response) {
    String? street;
    var streetIsAr = false;
    String? locality;
    var localityIsAr = false;

    for (final result in response.results) {
      for (final component in result.addressComponents) {
        // Ignore empty texts to avoid overwriting valid fallbacks.
        final text = component.longText;
        if (text == null) continue;

        final isAr = component.languageCode == _arabicLanguageCode;

        if (component.types.contains(_routeType) &&
            (street == null || (!streetIsAr && isAr))) {
          street = text;
          streetIsAr = isAr;
        }

        final isLocalityType =
            component.types.contains(_localityType) ||
            component.types.contains(_subLocalityType);
        if (isLocalityType && (locality == null || (!localityIsAr && isAr))) {
          locality = text;
          localityIsAr = isAr;
        }
      }
    }

    return [street, locality].whereType<String>().join('، ');
  }

  static const String _arabicLanguageCode = 'ar';
  static const String _routeType = 'route';
  static const String _localityType = 'locality';
  static const String _subLocalityType = 'sublocality';
}
