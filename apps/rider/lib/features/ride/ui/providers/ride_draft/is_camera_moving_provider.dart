import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_camera_moving_provider.g.dart';

@riverpod
class IsCameraMoving extends _$IsCameraMoving {
  @override
  bool build() => false;

  void setMoving(bool moving) => state = moving;
}
