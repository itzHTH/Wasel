import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class GetRidePriceUseCase
    extends CancellableUseCase<ApiResults<RidePrice>, GeoPointRequestBody> {
  final BaseRideRepo _rideRepo;

  GetRidePriceUseCase(this._rideRepo);

  @override
  Future<ApiResults<RidePrice>> execute(
    GeoPointRequestBody params,
    CancelToken cancelToken,
  ) {
    return _rideRepo.estimateRidePrice(params, cancelToken: cancelToken);
  }
}
