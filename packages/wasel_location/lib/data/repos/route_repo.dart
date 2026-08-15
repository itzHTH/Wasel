import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_location/data/repos/location_domain_failure.dart';
import 'package:wasel_location/data/services/route_remote_service.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/route_request.dart';
import 'package:wasel_location/domain/repos/base_route_repo.dart';

class RouteRepo implements BaseRouteRepo {
  RouteRepo(this._routeRemoteService);

  final RouteRemoteService _routeRemoteService;

  static const String _noRouteMessage = 'ما نگدر نرسم الطريق';

  /// Fewer than two points cannot draw a line.
  static const int _minimumRoutePoints = 2;

  @override
  Future<ApiResults<List<GeoPoint>>> getRoute(RouteRequest request) async {
    try {
      final points = await _routeRemoteService.fetchRoute(
        request.origin,
        request.destination,
      );

      return points.length <
              _minimumRoutePoints // if the point is less 2, then got error
          ? domainFailure<List<GeoPoint>>(_noRouteMessage)
          : ApiResults.success(points);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}
