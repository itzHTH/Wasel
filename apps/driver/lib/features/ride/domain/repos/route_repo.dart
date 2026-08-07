import 'package:driver/features/ride/data/models/route_request/route_request_arg.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:wasel_core/networking/api_results.dart';

abstract class BaseRouteRepo {
  Future<ApiResults<List<GeoPoint>>> getRoute(RouteRequestArg routeRequestArg);
}
