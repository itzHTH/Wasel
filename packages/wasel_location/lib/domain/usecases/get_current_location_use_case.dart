import 'package:wasel_core/usecase/base_use_case.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

/// Acquires one fresh high-accuracy fix, throwing `LocationException` when it
/// cannot.
///
/// Separate from [WatchDeviceLocationUseCase] because the cost profile is
/// different: this powers one-shot actions such as "centre on me", where the
/// caller wants an answer or an error, not a subscription it has to remember to
/// close.
class GetCurrentLocationUseCase extends BaseUseCase<DeviceFix, Duration?> {
  GetCurrentLocationUseCase(this._deviceLocationRepo);

  final BaseDeviceLocationRepo _deviceLocationRepo;

  @override
  Future<DeviceFix> call(Duration? params) =>
      _deviceLocationRepo.getCurrentLocation(timeout: params);
}
