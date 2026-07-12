import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/core/consts/app_rider_consts.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_point_markers_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_location_controller.dart';
import 'package:wasal/features/ride/ui/providers/route/route_polylines_provider.dart';

class CustomMap extends ConsumerStatefulWidget {
  const CustomMap({
    super.key,
    required Completer<GoogleMapController> controller,
    this.onCameraMove,
    this.onCameraMoveStarted,
    this.onCameraIdle,
    this.mapPadding = EdgeInsets.zero,
  }) : _controller = controller;

  static const LatLng initialTarget = LatLng(33.3152, 44.3661);

  final Completer<GoogleMapController> _controller;
  final ValueChanged<CameraPosition>? onCameraMove;
  final VoidCallback? onCameraMoveStarted;
  final VoidCallback? onCameraIdle;

  final EdgeInsets mapPadding;

  @override
  ConsumerState<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends ConsumerState<CustomMap> {
  final iraqBounds = LatLngBounds(
    southwest: const LatLng(29.0, 38.8),
    northeast: const LatLng(37.4, 48.6),
  );

  @override
  Widget build(BuildContext context) {
    final markers = ref.watch(ridePointMarkersProvider);
    final polylines = ref.watch(routePolylinesProvider);
    final myLocationEnabled = ref.watch(rideLocationControllerProvider);

    return GoogleMap(
      mapId: AppRiderConsts.mapStyleID,
      myLocationEnabled: myLocationEnabled,
      buildingsEnabled: false,
      myLocationButtonEnabled: false,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
      zoomControlsEnabled: false,
      cameraTargetBounds: CameraTargetBounds(iraqBounds),
      minMaxZoomPreference: const MinMaxZoomPreference(6, 20),
      padding: widget.mapPadding,
      markers: markers,
      polylines: polylines,
      onMapCreated: (controller) {
        widget._controller.complete(controller);
      },
      onCameraMove: widget.onCameraMove,
      onCameraMoveStarted: widget.onCameraMoveStarted,
      onCameraIdle: widget.onCameraIdle,
      initialCameraPosition: const CameraPosition(
        zoom: 14.5,
        target: CustomMap.initialTarget,
      ),
    );
  }
}
