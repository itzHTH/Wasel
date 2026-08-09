import 'package:dio/dio.dart';
import 'package:driver/features/ride/data/models/geocoding/google_geocoding_response.dart';
import 'package:driver/features/ride/data/services/geocoding_api_service.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/geocoding_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'geocoding_repo.g.dart';

class GeocodingRepo implements BaseGeocodingRepo {
  GeocodingRepo(this._geocodingApiService);

  final GeocodingApiService _geocodingApiService;

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

      final label = _labelFrom(response);
      if (label.isEmpty) {
        return ApiResults.failure(
          ErrorHandler.handle(Exception('لا يوجد اسم لهذا الموقع حاليا')),
        );
      }

      return ApiResults.success(label);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  /// Google returns the same component in several languages; prefer the Arabic
  /// spelling when it is there, otherwise keep the first one we saw.
  String _labelFrom(GoogleGeocodingResponse response) {
    String? street;
    var streetIsAr = false;
    String? locality;
    var localityIsAr = false;

    for (final result in response.results) {
      for (final component in result.addressComponents) {
        final isAr = component.languageCode == 'ar';

        if (component.types.contains('route') &&
            (street == null || (!streetIsAr && isAr))) {
          street = component.longText;
          streetIsAr = isAr;
        }

        final isLocalityType =
            component.types.contains('locality') ||
            component.types.contains('sublocality');
        if (isLocalityType && (locality == null || (!localityIsAr && isAr))) {
          locality = component.longText;
          localityIsAr = isAr;
        }
      }
    }

    return [street, locality].whereType<String>().join('، ');
  }
}

@riverpod
BaseGeocodingRepo geocodingRepo(Ref ref) =>
    GeocodingRepo(ref.watch(geocodingApiServiceProvider));
