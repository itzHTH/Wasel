import 'dart:ui' show Offset;

import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/core/helpers/geo_point_map_x.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_heading_provider.dart';
import 'package:driver/features/ride/ui/providers/map/map_marker_icon_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'driver_markers_provider.g.dart';

const _pinSize = 48.0;

@riverpod
Set<Marker> driverMarkers(Ref ref) => {..._car(ref), ..._tripPins(ref)};

Set<Marker> _car(Ref ref) {
  final isOnline = ref.watch(
    rideControllerProvider.select((s) => s.stage != DriverStage.offline),
  );

  // Online follows the live fix. Offline rests on the cached one so the car is
  // on the map from app open without holding a position stream — and without a
  // heading, which only the stream reports.
  final position = isOnline
      ? ref.watch(deviceLocationProvider).value?.toLatLng()
      : ref.watch(lastKnownLocationProvider).value;

  if (position == null) return const {};

  final icon = ref.watch(mapMarkerIconProvider(AppDriverConsts.carIcon)).value;

  return {
    Marker(
      markerId: const MarkerId('driver'),
      position: position,
      icon: icon ?? BitmapDescriptor.defaultMarker,
      rotation: isOnline ? ref.watch(driverHeadingProvider) : 0,
      anchor: const Offset(0.5, 0.5),
      flat: true,
    ),
  };
}

Set<Marker> _tripPins(Ref ref) {
  final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
  final ride = ref.watch(rideControllerProvider.select((s) => s.ride));
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

extension on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}
