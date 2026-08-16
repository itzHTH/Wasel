import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/consts/app_rider_consts.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_point_markers_provider.dart';
import 'package:wasal/features/ride/ui/providers/route/route_polylines_provider.dart';
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
    return AppMap(
      mapId: AppRiderConsts.mapStyleID,
      markers: ref.watch(ridePointMarkersProvider),
      polylines: ref.watch(routePolylinesProvider),
      circles: ref.watch(searchRadiusCirclesProvider),
      padding: mapPadding,
      onCameraMove: onCameraMove,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraIdle: onCameraIdle,
    );
  }
}
