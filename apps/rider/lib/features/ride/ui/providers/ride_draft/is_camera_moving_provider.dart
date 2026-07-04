import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_camera_moving_provider.g.dart';

/// Toggled by the map's onCameraMoveStarted/onCameraIdle. Watched only by
/// the confirm button so camera drags never rebuild anything else.
@riverpod
class IsCameraMoving extends _$IsCameraMoving {
  @override
  bool build() => false;

  void setMoving(bool moving) => state = moving;
}
