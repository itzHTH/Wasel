import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/route_request.dart';

abstract class BaseRouteRepo {
  /// The drivable path between the endpoints of [request], as the decoded
  /// polyline points that a map can render directly.
  ///
  /// Succeeds only with at least two points: a single-point "route" has no line
  /// to draw and would silently render as nothing, so it is reported as a
  /// failure the caller can act on instead.
  Future<ApiResults<List<GeoPoint>>> getRoute(RouteRequest request);
}
