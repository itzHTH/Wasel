import 'dart:ui' show Offset;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_location/wasel_location.dart';

part 'ride_point_markers_provider.g.dart';

const _pinSize = 48.0;

@riverpod
Set<Marker> ridePointMarkers(Ref ref) {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));

  final requestSent = ref.watch(
    requestRideControllerProvider.select((s) => s.value != null),
  );
  final driverPosition = requestSent
      ? ref.watch(rideControllerProvider.select((s) => s.driverPosition))
      : null;

  final pickupIcon = ref
      .watch(mapMarkerIconProvider(AppIcons.pinStart, logicalSize: _pinSize))
      .value;
  final dropoffIcon = ref
      .watch(
        mapMarkerIconProvider(AppIcons.pinDestination, logicalSize: _pinSize),
      )
      .value;
  final driverIcon = ref.watch(mapMarkerIconProvider(AppIcons.car)).value;

  return {
    if (pickup != null)
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickup,
        icon:
            pickupIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    if (dropoff != null)
      Marker(
        markerId: const MarkerId('dropoff'),
        position: dropoff,
        icon:
            dropoffIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    if (driverPosition != null)
      Marker(
        markerId: const MarkerId('driver'),
        position: LatLng(driverPosition.latitude, driverPosition.longitude),
        icon:
            driverIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),

        anchor: const Offset(0.5, 0.5),
        flat: true,
      ),
  };
}
