import 'package:wasel_core/usecase/base_use_case.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

class GetCurrentLocationUseCase extends BaseUseCase<DeviceFix, Duration?> {
  GetCurrentLocationUseCase(this._deviceLocationRepo);

  final BaseDeviceLocationRepo _deviceLocationRepo;

  @override
  Future<DeviceFix> call(Duration? params) =>
      _deviceLocationRepo.getCurrentLocation(timeout: params);
}
