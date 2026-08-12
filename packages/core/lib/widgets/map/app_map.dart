import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_core/widgets/map/map_controller_provider.dart';
import 'package:wasel_core/widgets/map/map_ready_provider.dart';

/// Camera defaults shared by every Wasel map — one service area (Iraq) for all
/// apps, so the rider and the driver always open on the same view.
class AppMapDefaults {
  const AppMapDefaults._();

  static const LatLng initialTarget = LatLng(33.3152, 44.3661);

  static const double initialZoom = 14.5;

  static const MinMaxZoomPreference zoomRange = MinMaxZoomPreference(10, 20);

  static final LatLngBounds serviceBounds = LatLngBounds(
    southwest: const LatLng(29.0, 38.8),
    northeast: const LatLng(37.4, 48.6),
  );
}

class AppMap extends ConsumerStatefulWidget {
  const AppMap({
    super.key,
    required this.mapId,
    this.markers = const {},
    this.polylines = const {},
    this.circles = const {},
    this.myLocationEnabled = false,
    this.padding = EdgeInsets.zero,
    this.initialTarget = AppMapDefaults.initialTarget,
    this.initialZoom = AppMapDefaults.initialZoom,
    this.onCameraMove,
    this.onCameraMoveStarted,
    this.onCameraIdle,
  });

  /// Cloud-styled map id of the host app.
  final String mapId;

  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final Set<Circle> circles;

  final bool myLocationEnabled;

  /// Keeps the visible camera clear of the cards stacked over the map.
  final EdgeInsets padding;

  final LatLng initialTarget;
  final double initialZoom;

  final ValueChanged<CameraPosition>? onCameraMove;
  final VoidCallback? onCameraMoveStarted;
  final VoidCallback? onCameraIdle;

  @override
  ConsumerState<AppMap> createState() => _AppMapState();
}

class _AppMapState extends ConsumerState<AppMap> {
  /// Some devices never report an idle camera for the first frame, so ready is
  /// forced shortly after creation instead of leaving the overlay stuck.
  static const _readyFallbackDelay = Duration(milliseconds: 1500);

  Timer? _readyFallback;

  @override
  void dispose() {
    _readyFallback?.cancel();
    super.dispose();
  }

  void _markReady() {
    _readyFallback?.cancel();
    if (!mounted) return;
    ref.read(mapReadyProvider.notifier).markReady();
  }

  void _onMapCreated(GoogleMapController controller) {
    ref.read(mapControllerHolderProvider.notifier).attach(controller);
    _readyFallback = Timer(_readyFallbackDelay, _markReady);
  }

  void _onCameraIdle() {
    _markReady();
    widget.onCameraIdle?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapId: widget.mapId,
      myLocationEnabled: widget.myLocationEnabled,
      buildingsEnabled: false,
      myLocationButtonEnabled: false,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
      zoomControlsEnabled: false,
      cameraTargetBounds: CameraTargetBounds(AppMapDefaults.serviceBounds),
      minMaxZoomPreference: AppMapDefaults.zoomRange,
      padding: widget.padding,
      markers: widget.markers,
      polylines: widget.polylines,
      circles: widget.circles,
      onMapCreated: _onMapCreated,
      onCameraMove: widget.onCameraMove,
      onCameraMoveStarted: widget.onCameraMoveStarted,
      onCameraIdle: _onCameraIdle,
      initialCameraPosition: CameraPosition(
        zoom: widget.initialZoom,
        target: widget.initialTarget,
      ),
    );
  }
}
