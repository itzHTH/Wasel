import 'package:driver/features/ride/domain/entities/driver_earnings.dart';
import 'package:driver/features/ride/domain/entities/earnings_period.dart';
import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class GetDriverEarningsUseCase
    extends BaseUseCase<ApiResults<DriverEarnings>, EarningsPeriod> {
  final BaseRideRepo rideRepo;

  GetDriverEarningsUseCase(this.rideRepo);

  @override
  Future<ApiResults<DriverEarnings>> call(EarningsPeriod period) {
    return rideRepo.getDriverEarnings(period);
  }
}
