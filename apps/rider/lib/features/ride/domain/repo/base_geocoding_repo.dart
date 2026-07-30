import 'package:wasal/features/ride/domain/entities/geo_point.dart';

abstract class BaseGeocodingRepo {
  Future<String> labelFor(GeoPoint point);
}
