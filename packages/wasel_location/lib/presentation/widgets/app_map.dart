import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_location/core/const/app_map_defaults.dart';
import 'package:wasel_location/presentation/providers/location/recenter_controller.dart';
import 'package:wasel_location/presentation/providers/map/initial_camera_target_provider.dart';
import 'package:wasel_location/presentation/providers/map/map_controller_provider.dart';
import 'package:wasel_location/presentation/providers/map/map_ready_provider.dart';

/// The one Google Map surface both apps draw on.
///
/// Layers (markers, polylines, circles) stay caller-supplied because they carry
/// ride semantics; everything that is purely *about the map or the device* is
/// resolved here from the package's own providers, so neither app has to
/// re-derive it:
///
/// - **Opening camera** — [initialCameraTargetProvider] (last known fix, else
///   the Iraq default). `GoogleMap` reads `initialCameraPosition` exactly once,
///   at creation, so the platform view is deliberately not built until the
///   target resolves; [AppMapLoadingOverlay] is what the user sees meanwhile.
/// - **Blue dot** — [RecenterController.myLocationEnabled], which only flips to
///   `true` after permission was verified in-app. Letting `GoogleMap` own this
///   would trigger its own unlocalized native permission prompt.
/// - **Controller + readiness** — published to [mapControllerHolderProvider]
///   and [mapReadyProvider] so cameras, recentre and overlays can be driven
///   from providers instead of widget callbacks.
class AppMap extends ConsumerStatefulWidget {
  const AppMap({
    super.key,
    required this.mapId,
    this.markers = const {},
    this.polylines = const {},
    this.circles = const {},
    this.myLocationEnabled,
    this.padding = EdgeInsets.zero,
    this.initialTarget,
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

  /// Overrides the blue dot.
  final bool? myLocationEnabled;

  /// Keeps the visible camera clear of the cards stacked over the map.
  final EdgeInsets padding;

  /// Overrides the opening camera.
  final LatLng? initialTarget;

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
    final target =
        widget.initialTarget ?? ref.watch(initialCameraTargetProvider).value;

    if (target == null) return const SizedBox.shrink();

    final bool myLocationEnabled =
        widget.myLocationEnabled ??
        ref.watch(
          recenterControllerProvider.select((s) => s.myLocationEnabled),
        );

    return GoogleMap(
      mapId: widget.mapId,
      myLocationEnabled: myLocationEnabled,
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
        target: target,
      ),
    );
  }
}
