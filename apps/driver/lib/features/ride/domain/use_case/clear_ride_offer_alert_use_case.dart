import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class ClearRideOfferAlertUseCase extends BaseUseCase<ApiResults<void>, void> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  ClearRideOfferAlertUseCase(this._baseDriverForegroundRepo);

  @override
  Future<ApiResults<void>> call(void params) =>
      _baseDriverForegroundRepo.clearOfferAlert();
}
