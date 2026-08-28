import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_car_motion_provider.g.dart';

/// The animated position and heading of the driver's car on the rider's map.
@riverpod
VehicleMotion driverCarMotion(Ref ref) {
  final motion = VehicleMotion();
  ref.onDispose(motion.dispose);

  final hasActiveRide = ref.watch(
    rideControllerProvider.select((s) => s.hasActiveRide),
  );
  if (!hasActiveRide) return motion;

  // A null means the hub is no longer reporting a car. Ignoring it would leave
  // the marker parked at the last position it ever sent.
  ref.listen(rideControllerProvider.select((s) => s.driverPosition), (_, next) {
    if (next == null) {
      motion.clear();
    } else {
      motion.moveTo(next);
    }
  }, fireImmediately: true);

  return motion;
}
