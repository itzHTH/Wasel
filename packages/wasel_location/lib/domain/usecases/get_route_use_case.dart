import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/route_request.dart';
import 'package:wasel_location/domain/repos/base_route_repo.dart';

class GetRouteUseCase
    extends BaseUseCase<ApiResults<List<GeoPoint>>, RouteRequest> {
  GetRouteUseCase(this._routeRepo);

  final BaseRouteRepo _routeRepo;

  @override
  Future<ApiResults<List<GeoPoint>>> call(RouteRequest params) {
    return _routeRepo.getRoute(params);
  }
}
