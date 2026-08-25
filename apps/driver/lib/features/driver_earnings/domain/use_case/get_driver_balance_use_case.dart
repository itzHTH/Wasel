import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_balance.dart';
import 'package:driver/features/driver_earnings/domain/repo/base_driver_earnings_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';

class GetDriverBalanceUseCase
    extends CancellableUseCase<ApiResults<DriverBalance>, void> {
  GetDriverBalanceUseCase(this._earningsRepo);

  final BaseDriverEarningsRepo _earningsRepo;

  @override
  Future<ApiResults<DriverBalance>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _earningsRepo.getDriverWalletBalance(cancelToken: cancelToken);
  }
}
