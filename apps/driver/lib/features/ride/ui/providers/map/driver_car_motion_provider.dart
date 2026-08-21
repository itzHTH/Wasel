import 'dart:async';

import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_car_motion_provider.g.dart';

/// The animated position and heading of the driver's own car.
@riverpod
VehicleMotion driverCarMotion(Ref ref) {
  final motion = VehicleMotion();
  ref.onDispose(motion.dispose);

  unawaited(_seedFromCache(ref, motion));

  final isOnline = ref.watch(
    rideControllerProvider.select((s) => s.stage != DriverStage.offline),
  );
  if (!isOnline) return motion;

  ref.listen(deviceLocationProvider, (_, next) {
    if (next case AsyncData(:final value)) {
      motion.moveTo(
        value.point,
        heading: value.isHeadingUsable ? value.heading : null,
      );
    }
  }, fireImmediately: true);

  return motion;
}

/// Puts the car on the cached fix so the marker never pops in — offline that is
/// all there is, and online it covers the seconds the GPS takes to warm up.
///
/// Read rather than watched: watching rebuilds this provider the moment the
/// cache resolves, which would throw away the animator and any glide with it.
/// A live fix that has already landed wins, so the car is never yanked back to
/// a stale position. No heading either — only the live stream reports one.
Future<void> _seedFromCache(Ref ref, VehicleMotion motion) async {
  try {
    final resting = await ref.read(lastKnownLocationProvider.future);
    if (resting != null && !motion.hasFix) motion.snapTo(resting, heading: 0);
  } catch (_) {
    // No cached fix is not a failure; the live stream is the real source.
  }
}
