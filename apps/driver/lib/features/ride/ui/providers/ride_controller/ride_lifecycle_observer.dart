import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasel_core/lifecycle/app_return_observer.dart';

part 'ride_lifecycle_observer.g.dart';

@riverpod
void rideLifecycleObserver(Ref ref) {
  final dispose = observeAppReturn(
    () => ref.read(rideControllerProvider.notifier).refreshFromBackend(),
  );
  if (dispose != null) ref.onDispose(dispose);
}
