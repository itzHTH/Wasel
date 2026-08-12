import 'package:wasel_core/usecase/stream_base_use_case.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

/// Streams the device's position.
///
/// Takes no parameters — the tracking settings (accuracy, distance filter) are
/// a data-layer tuning concern, not something a caller should be able to vary
/// per subscription. Both apps want the same profile, and letting each listener
/// pick its own would silently open a second OS stream.
class WatchDeviceLocationUseCase extends StreamBaseUseCase<DeviceFix, void> {
  WatchDeviceLocationUseCase(this._deviceLocationRepo);

  final BaseDeviceLocationRepo _deviceLocationRepo;

  @override
  Stream<DeviceFix> call(void params) => _deviceLocationRepo.watchLocation();
}
