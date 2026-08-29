import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class EnsureForegroundReadyUseCase
    extends BaseUseCase<ForegroundStatus, void> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  EnsureForegroundReadyUseCase(this._baseDriverForegroundRepo);

  @override
  Future<ForegroundStatus> call(void params) =>
      _baseDriverForegroundRepo.ensureReady();
}
