import 'package:wasel_core/usecase/base_use_case.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

class IsLocationServiceEnabledUseCase extends BaseUseCase<bool, void> {
  IsLocationServiceEnabledUseCase(this._deviceLocationRepo);

  final BaseDeviceLocationRepo _deviceLocationRepo;

  @override
  Future<bool> call(void params) =>
      _deviceLocationRepo.isLocationServiceEnabled();
}
