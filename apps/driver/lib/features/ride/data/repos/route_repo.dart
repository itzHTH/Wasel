import 'package:driver/features/ride/data/models/route_request/route_request_arg.dart';
import 'package:driver/features/ride/data/services/route_remote_service.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/route_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'route_repo.g.dart';

class RouteRepo implements BaseRouteRepo {
  RouteRepo(this._routeRemoteService);

  final RouteRemoteService _routeRemoteService;

  @override
  Future<ApiResults<List<GeoPoint>>> getRoute(
    RouteRequestArg routeRequestArg,
  ) async {
    try {
      final points = await _routeRemoteService.fetchRoute(
        routeRequestArg.origin,
        routeRequestArg.destination,
      );

      if (points.length < 2) {
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
