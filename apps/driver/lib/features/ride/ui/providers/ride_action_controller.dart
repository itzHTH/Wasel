import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_action_controller.g.dart';

@riverpod
class RideActionController extends _$RideActionController {
  @override
  FutureOr<void> build() => null;

  void reportFailure(Object error, StackTrace st) =>
      state = AsyncError(error, st);
}
