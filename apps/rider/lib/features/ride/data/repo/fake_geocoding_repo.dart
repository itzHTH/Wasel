import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/repo/base_geocoding_repo.dart';

class FakeGeocodingRepo implements BaseGeocodingRepo {
  @override
  Future<String> labelFor(GeoPoint point) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return 'شارع أبو نؤاس، بغداد';
  }
}
