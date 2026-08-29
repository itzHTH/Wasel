import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class EnsureForegroundUnrestrictedUseCase extends BaseUseCase<bool, void> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  EnsureForegroundUnrestrictedUseCase(this._baseDriverForegroundRepo);

  @override
  Future<bool> call(void params) =>
      _baseDriverForegroundRepo.ensureUnrestricted();
}
