import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/core/consts/app_rider_consts.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_point_markers_provider.dart';

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

  /// Shifts the map's own UI (Google logo, controls) — used to keep the
  /// logo visible above overlays like the bottom card.
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
    // The map watches only the derived markers set — it rebuilds when a
    // point is confirmed/removed, never on other draft-state changes.
    final markers = ref.watch(ridePointMarkersProvider);
    return GoogleMap(
      mapId: AppRiderConsts.mapStyleID,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      cameraTargetBounds: CameraTargetBounds(iraqBounds),
      minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
      padding: widget.mapPadding,
      markers: markers,
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
