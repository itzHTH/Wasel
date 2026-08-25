import 'package:dio/dio.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class CancelRideUseCase
    extends CancellableUseCase<ApiResults<CancelRide>, String> {
  final BaseRideRepo _repo;

  CancelRideUseCase(this._repo);

  @override
  Future<ApiResults<CancelRide>> execute(
    String params,
    CancelToken cancelToken,
  ) {
    return _repo.cancelRide(params, cancelToken: cancelToken);
  }
}
