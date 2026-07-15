import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';

part 'ride_point_markers_provider.g.dart';

@riverpod
Set<Marker> ridePointMarkers(Ref ref) {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));

  // Only track the driver once a ride is requested, so reading the ride
  // controller here doesn't start the tracking hub before it's needed.
  final requestSent = ref.watch(
    requestRideControllerProvider.select((s) => s.value != null),
  );
  final driverPosition = requestSent
      ? ref.watch(rideControllerProvider.select((s) => s.driverPosition))
      : null;

  return {
    if (pickup != null)
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickup,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    if (dropoff != null)
      Marker(
        markerId: const MarkerId('dropoff'),
        position: dropoff,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    if (driverPosition != null)
      Marker(
        markerId: const MarkerId('driver'),
        position: LatLng(driverPosition.latitude, driverPosition.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
  };
}
