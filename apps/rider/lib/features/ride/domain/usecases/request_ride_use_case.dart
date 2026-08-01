import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/request_ride/request/request_ride_body.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestRideUseCase
    extends CancellableUseCase<ApiResults<RequestRide>, RequestRideBody> {
  final BaseRideRepo _baseRideRepo;

  RequestRideUseCase(this._baseRideRepo);
  @override
  Future<ApiResults<RequestRide>> execute(
    RequestRideBody params,
    CancelToken cancelToken,
  ) {
    return _baseRideRepo.requestRide(params, cancelToken: cancelToken);
  }
}
