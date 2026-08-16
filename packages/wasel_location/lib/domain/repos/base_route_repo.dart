import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/route_request.dart';

abstract class BaseRouteRepo {
  Future<ApiResults<List<GeoPoint>>> getRoute(RouteRequest request);
}
