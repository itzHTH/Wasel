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

  /// Reduces Google's component list to a `street، locality` label.
  ///
  /// Two things make this less obvious than it looks:
  ///
  /// 1. Google returns the *same* component repeatedly, once per language it
  ///    knows, so a naive first-match picks whichever language happened to come
  ///    first. The app is Arabic, so an Arabic spelling always wins over one
  ///    already held — but a non-Arabic value is still kept rather than dropped,
  ///    since a Latin street name beats no street name at all.
  /// 2. `sublocality` is accepted alongside `locality` because dense parts of
  ///    Baghdad are returned only at the sublocality level; requiring `locality`
  ///    would leave those points with a street and no area.
  ///
  /// Visible for testing: this is pure, and it is where the interesting
  /// behaviour lives, so tests target it directly rather than through Dio.
  String labelFrom(GoogleGeocodingResponse response) {
    String? street;
    var streetIsAr = false;
    String? locality;
    var localityIsAr = false;

    for (final result in response.results) {
      for (final component in result.addressComponents) {
        // A component with no text cannot improve the label, and letting one
        // through would actively hurt: both copies being replaced here assign
        // `longText` unconditionally once a slot is empty, so a null-texted
        // Arabic component could overwrite a perfectly good Latin street with
        // null and mark the slot as "already Arabic", locking the real value out.
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
