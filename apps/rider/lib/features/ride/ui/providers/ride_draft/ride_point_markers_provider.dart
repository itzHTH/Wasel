import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_location/wasel_location.dart';

part 'ride_point_markers_provider.g.dart';

const _pinSize = 48.0;

/// The markers that sit still. The driver's car is animated between hub
/// updates, so it is drawn from `driverCarMotionProvider` instead.
@riverpod
Set<Marker> ridePointMarkers(Ref ref) {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));

  final pickupIcon = ref
      .watch(mapMarkerIconProvider(AppIcons.pinStart, logicalSize: _pinSize))
      .value;
  final dropoffIcon = ref
      .watch(
        mapMarkerIconProvider(AppIcons.pinDestination, logicalSize: _pinSize),
      )
      .value;

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
  };
}
