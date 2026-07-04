import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';

part 'ride_point_markers_provider.g.dart';

/// Markers for the confirmed points only. The map watches this provider —
/// never the whole draft state — so it rebuilds only when a point is
/// added or removed.
@riverpod
Set<Marker> ridePointMarkers(Ref ref) {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));
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
  };
}
