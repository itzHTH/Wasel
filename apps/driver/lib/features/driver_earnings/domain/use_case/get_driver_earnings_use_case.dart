import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/domain/repo/base_driver_earnings_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';

class GetDriverEarningsUseCase
    extends CancellableUseCase<ApiResults<DriverEarnings>, EarningsPeriod> {
  GetDriverEarningsUseCase(this._earningsRepo);

  final BaseDriverEarningsRepo _earningsRepo;

  @override
  Future<ApiResults<DriverEarnings>> execute(
    EarningsPeriod params,
    CancelToken cancelToken,
  ) {
    return _earningsRepo.getDriverEarnings(params, cancelToken: cancelToken);
  }
}
