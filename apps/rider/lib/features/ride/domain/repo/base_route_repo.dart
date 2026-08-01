import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseRouteRepo {
  Future<ApiResults<List<GeoPoint>>> getRoute(
    GeoPointRequestBody geoPointRequest,
  );
}
