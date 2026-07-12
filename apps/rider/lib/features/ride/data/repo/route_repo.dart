import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/services/route_remote_service.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/repo/base_route_repo.dart';
import 'package:wasel_core/wasel_core.dart';

part 'route_repo.g.dart';

class RouteRepo implements BaseRouteRepo {
  RouteRepo(this._service);

  final RouteRemoteService _service;

  @override
  Future<ApiResults<List<GeoPoint>>> getRoute(
    GeoPointRequestBody geoPoints,
  ) async {
    try {
      final origin = GeoPoint(
        latitude: double.parse(geoPoints.pickupLat),
        longitude: double.parse(geoPoints.pickupLng),
      );
      final destination = GeoPoint(
        latitude: double.parse(geoPoints.dropoffLat),
        longitude: double.parse(geoPoints.dropoffLng),
      );

      final points = await _service.fetchRoute(origin, destination);
      if (points.isEmpty) {
        return ApiResults.failure(ErrorHandler.handle(Exception('No route')));
      }
      return ApiResults.success(points);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
BaseRouteRepo routeRepo(Ref ref) =>
    RouteRepo(ref.watch(routeRemoteServiceProvider));
