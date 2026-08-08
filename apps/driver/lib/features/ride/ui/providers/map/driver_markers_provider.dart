import 'dart:ui' show Offset;

import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_heading_provider.dart';
import 'package:driver/features/ride/ui/providers/map/map_marker_icon_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'driver_markers_provider.g.dart';

@riverpod
Set<Marker> driverMarkers(Ref ref) {
  final isOnline = ref.watch(
    rideControllerProvider.select((s) => s.stage != DriverStage.offline),
  );
  if (!isOnline) return const {};

  final position = ref.watch(deviceLocationProvider).value;
  if (position == null) return const {};

  final icon = ref.watch(mapMarkerIconProvider(AppDriverConsts.carIcon)).value;

  return {
    Marker(
      markerId: const MarkerId('driver'),
      position: LatLng(position.latitude, position.longitude),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      rotation: ref.watch(driverHeadingProvider),
      anchor: const Offset(0.5, 0.5),
      flat: true,
    ),
  };
}
