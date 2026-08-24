import 'package:dio/dio.dart';
import 'package:driver/features/ride/domain/entities/driver_balance.dart';
import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class GetDriverBalanceUseCase
    extends CancellableUseCase<ApiResults<DriverBalance>, void> {
  GetDriverBalanceUseCase(this._rideRepo);

  final BaseRideRepo _rideRepo;
  @override
  Future<ApiResults<DriverBalance>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _rideRepo.getDriverWalletBalance();
  }
}
