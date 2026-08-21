import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_point_markers_provider.dart';
import 'package:wasal/features/ride/ui/providers/route/route_polylines_provider.dart';
import 'package:wasal/features/ride/ui/providers/tracking/driver_car_motion_provider.dart';
import 'package:wasal/features/ride/ui/providers/tracking/search_radius_circles_provider.dart';
import 'package:wasel_location/wasel_location.dart';

/// Feeds the shared [AppMap] with the rider ride layers (pickup/dropoff pins,
/// the active route, and the driver search radius).
class RideMap extends ConsumerWidget {
  const RideMap({
    super.key,
    this.onCameraMove,
    this.onCameraMoveStarted,
    this.onCameraIdle,
    this.mapPadding = EdgeInsets.zero,
  });

  final ValueChanged<CameraPosition>? onCameraMove;
  final VoidCallback? onCameraMoveStarted;
  final VoidCallback? onCameraIdle;

  final EdgeInsets mapPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(ridePointMarkersProvider);
    final polylines = ref.watch(routePolylinesProvider);
    final circles = ref.watch(searchRadiusCirclesProvider);
    final motion = ref.watch(driverCarMotionProvider);
    final carIcon = ref.watch(mapMarkerIconProvider(AppIcons.car)).value;

    return AnimatedBuilder(
      animation: motion,
      builder: (context, _) => AppMap(
        markers: {
          ...pins,
          if (motion.hasFix) motion.value.toMarker(icon: carIcon),
        },
        polylines: polylines,
        circles: circles,
        padding: mapPadding,
        onCameraMove: onCameraMove,
        onCameraMoveStarted: onCameraMoveStarted,
        onCameraIdle: onCameraIdle,
      ),
    );
  }
}
