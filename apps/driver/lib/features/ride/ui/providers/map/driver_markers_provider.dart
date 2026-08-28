import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_markers_provider.g.dart';

const _pinSize = 48.0;

/// The markers that sit still. The car is animated between fixes, so it is
/// drawn from [driverCarMotionProvider] instead of rebuilt through here.
@riverpod
Set<Marker> driverMarkers(Ref ref) {
  final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
  final ride = ref.watch(rideControllerProvider.select((s) => s.currentRide));
  if (ride == null) return const {};

  final (bool pickup, bool dropoff) = switch (stage) {
    DriverStage.offerReceived || DriverStage.inProgress => (true, true),
    DriverStage.heading || DriverStage.arrived => (true, false),
    _ => (false, false),
  };

  return {
    if (pickup) _pin(ref, 'pickup', ride.position, AppDriverConsts.pickupIcon),
    if (dropoff)
      _pin(ref, 'dropoff', ride.dropPosition, AppDriverConsts.dropoffIcon),
  };
}

Marker _pin(Ref ref, String id, GeoPoint point, String asset) {
  final icon = ref
      .watch(mapMarkerIconProvider(asset, logicalSize: _pinSize))
      .value;

  return Marker(
    markerId: MarkerId(id),
    position: point.toLatLng(),
    icon: icon ?? BitmapDescriptor.defaultMarker,
  );
}
