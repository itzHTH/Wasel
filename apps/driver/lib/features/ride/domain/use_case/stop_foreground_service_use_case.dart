import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class StopForegroundServiceUseCase extends BaseUseCase<ApiResults<void>, void> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  StopForegroundServiceUseCase(this._baseDriverForegroundRepo);

  @override
  Future<ApiResults<void>> call(void params) =>
      _baseDriverForegroundRepo.stopService();
}
