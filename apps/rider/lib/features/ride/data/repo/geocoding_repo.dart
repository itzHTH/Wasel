import 'package:wasal/features/ride/data/services/geocodng_api_service.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/repo/base_geocoding_repo.dart';

class GeocodingRepo implements BaseGeocodingRepo {
  final GeocodngApiService _apiServiceProvider;

  GeocodingRepo(this._apiServiceProvider);

  @override
  Future<String> labelFor(GeoPoint point) async {
    final res = await _apiServiceProvider.getLocationName(
      point.latitude.toString(),
      point.longitude.toString(),
    );
    if (res.results.isEmpty) {
      throw Exception('لا يوجد اسم لهذا الموقع حاليا');
    }

    String? street;
    var streetIsAr = false;
    String? locality;
    var localityIsAr = false;
    // String? governorate;
    // var governorateIsAr = false;

    for (final result in res.results) {
      for (final c in result.addressComponents) {
        final isAr = c.languageCode == 'ar';

        if (c.types.contains('route') &&
            (street == null || (!streetIsAr && isAr))) {
          street = c.longText;
          streetIsAr = isAr;
        }

        final isLocalityType =
            c.types.contains('locality') || c.types.contains('sublocality');
        if (isLocalityType && (locality == null || (!localityIsAr && isAr))) {
          locality = c.longText;
          localityIsAr = isAr;
        }

        // final isGovernorateType = c.types.contains(
        //   'administrative_area_level_1',
        // );
        // if (isGovernorateType &&
        //     (governorate == null || (!governorateIsAr && isAr))) {
        //   governorate = c.longText;
        //   governorateIsAr = isAr;
        // }
      }
    }

    final label = [
      street,
      locality,
      // governorate,
    ].whereType<String>().join('، ');
    return label;
  }
}
