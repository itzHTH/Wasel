import 'package:wasel_core/usecase/stream_base_use_case.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

class WatchDeviceLocationUseCase extends StreamBaseUseCase<DeviceFix, void> {
  WatchDeviceLocationUseCase(this._deviceLocationRepo);

  final BaseDeviceLocationRepo _deviceLocationRepo;

  @override
  Stream<DeviceFix> call(void params) => _deviceLocationRepo.watchLocation();
}
