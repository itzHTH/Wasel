import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestRideUseCase
    extends CancellableUseCase<ApiResults<RequestRide>, GeoPointRequestBody> {
  final BaseRideRepo _baseRideRepo;

  RequestRideUseCase(this._baseRideRepo);
  @override
  Future<ApiResults<RequestRide>> execute(
    GeoPointRequestBody params,
    CancelToken cancelToken,
  ) {
    return _baseRideRepo.requestRide(params, cancelToken: cancelToken);
  }
}
