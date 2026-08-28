import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/repos/base_active_ride_repo.dart';

class GetActiveRideUseCase
    extends CancellableUseCase<ApiResults<ActiveRide?>, void> {
  final BaseActiveRideRepo _activeRideRepo;

  GetActiveRideUseCase(this._activeRideRepo);

  @override
  Future<ApiResults<ActiveRide?>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _activeRideRepo.getActiveRide(cancelToken: cancelToken);
  }
}
