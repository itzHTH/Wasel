import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_is_camera_moving_provider.g.dart';

/// Driver-side mirror of the rider's `IsCameraMoving`.
///
/// Fed from [AppMap]'s `onCameraMoveStarted` / `onCameraIdle` on the ride
/// screen so expandable cards can collapse while the driver pans the map.
@riverpod
class DriverIsCameraMoving extends _$DriverIsCameraMoving {
  @override
  bool build() => false;

  void setMoving(bool moving) => state = moving;
}
