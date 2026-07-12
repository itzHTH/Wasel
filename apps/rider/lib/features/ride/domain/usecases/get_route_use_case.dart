import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/repo/base_route_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class GetRouteUseCase
    extends BaseUseCase<ApiResults<List<GeoPoint>>, GeoPointRequestBody> {
  final BaseRouteRepo _repo;

  GetRouteUseCase(this._repo);

  @override
  Future<ApiResults<List<GeoPoint>>> call(GeoPointRequestBody params) {
    return _repo.getRoute(params);
  }
}
