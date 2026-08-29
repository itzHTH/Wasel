import 'package:driver/features/ride/data/models/foreground/ride_alert_arg.dart';
import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class AlertRideOfferUseCase
    extends BaseUseCase<ApiResults<void>, RideAlertArg> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  AlertRideOfferUseCase(this._baseDriverForegroundRepo);

  @override
  Future<ApiResults<void>> call(RideAlertArg params) =>
      _baseDriverForegroundRepo.alertOffer(params);
}
