import 'package:driver/features/ride/data/models/route_request/route_request_arg.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/route_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class GetRouteUseCase
    extends BaseUseCase<ApiResults<List<GeoPoint>>, RouteRequestArg> {
  final BaseRouteRepo _baseRouteRepo;

  GetRouteUseCase(this._baseRouteRepo);

  @override
  Future<ApiResults<List<GeoPoint>>> call(RouteRequestArg params) {
    return _baseRouteRepo.getRoute(params);
  }
}
