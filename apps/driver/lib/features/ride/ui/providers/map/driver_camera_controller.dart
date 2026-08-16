import 'dart:async';
import 'dart:math' as math;

import 'package:driver/core/helpers/geo_point_map_x.dart';
import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_heading_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/presentation/providers/map/map_controller_provider.dart';
import 'package:wasel_location/presentation/providers/map/map_ready_provider.dart';

part 'driver_camera_controller.g.dart';

@riverpod
class DriverCameraController extends _$DriverCameraController {
  static const _zoom = 17.0;
  static const _selfMoveWindow = Duration(milliseconds: 300);
  static const _resumeDelay = Duration(seconds: 3);

  /// Breathing room around a framed trip, in pixels.
  static const _framePadding = 110.0;

  /// Fallback zoom for a trip whose endpoints landed on the same spot.
  static const _frameZoom = 14.0;

  ProviderSubscription<AsyncValue<Position>>? _positions;
  Timer? _resume;
  DateTime? _selfMoveUntil;
  bool _paused = false;

  /// The camera opens on the last-known fix, so the first live position is a
  /// small correction — a hard move avoids gliding over that gap. It survives
  /// stage changes; only going offline retires the camera entirely.
  bool _placed = false;

  @override
  void build() {
    ref.onDispose(_stop);

    final stage = ref.watch(rideControllerProvider.select((s) => s.stage));

    _stop();

    if (stage == DriverStage.offline) {
      _placed = false;
      return;
    }

    // An open offer owns the camera: it pulls back to show the whole trip so
    // the driver can weigh it. Trailing the car would fight that animation, so
    // the follow stands down until the offer is answered.
    if (stage == DriverStage.offerReceived) {
      unawaited(_frameOffer());
      return;
    }

    _positions = ref.listen(deviceLocationProvider, (_, next) {
      if (next case AsyncData(:final value)) unawaited(_follow(value));
    });
  }

  /// Returns whether the driver moved the camera. A false means this was the
  /// camera's own animation, which callers must not treat as a gesture.
  bool onMoveStarted() {
    if (_isSelfMove()) return false;

    _resume?.cancel();
    _resume = null;
    _paused = true;
    return true;
  }

  void onIdle() {
    if (!_paused) return;

    _resume?.cancel();
    _resume = Timer(_resumeDelay, () => _paused = false);
  }

  Future<void> _frameOffer() async {
    final ride = ref.read(rideControllerProvider).ride;
    if (ride == null) return;

    final route = await _routePoints();
    if (!_offerIsOpen()) return;

    final controller = await _readyController();
    if (controller == null || !_offerIsOpen()) return;

    _selfMoveUntil = DateTime.now().add(_selfMoveWindow);
    _placed = true;

    await controller.animateCamera(
      _frameOf(
        route ?? [ride.position.toLatLng(), ride.dropPosition.toLatLng()],
      ),
    );
  }

  Future<List<LatLng>?> _routePoints() async {
    try {
      final polylines = await ref.read(driverRoutePolylinesProvider.future);
      if (polylines.isEmpty) return null;

      final points = polylines.first.points;
      return points.isEmpty ? null : points;
    } catch (_) {
      return null;
    }
  }

  Future<void> _follow(Position position) async {
    if (_paused || !ref.mounted) return;

    final controller = await ref.read(mapControllerHolderProvider.future);
    if (_paused || !ref.mounted) return;

    _selfMoveUntil = DateTime.now().add(_selfMoveWindow);
    final update = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: _zoom,
        bearing: ref.read(driverHeadingProvider),
      ),
    );

    if (_placed) {
      await controller.animateCamera(update);
      return;
    }

    _placed = true;
    await controller.moveCamera(update);
  }

  /// The controller lands at `onMapCreated`, which is before the map surface
  /// has been measured — `newLatLngBounds` throws on a map with no size. Waiting
  /// for the first settled frame is what makes the bounds animation safe.
  Future<GoogleMapController?> _readyController() async {
    final controller = await ref.read(mapControllerHolderProvider.future);
    if (!ref.mounted) return null;
    if (ref.read(mapReadyProvider)) return controller;

    final ready = Completer<void>();
    final readiness = ref.listen(mapReadyProvider, (_, next) {
      if (next && !ready.isCompleted) ready.complete();
    });

    try {
      await ready.future;
    } finally {
      readiness.close();
    }

    return ref.mounted ? controller : null;
  }

  CameraUpdate _frameOf(List<LatLng> points) {
    final bounds = _boundsOf(points);

    return bounds == null
        ? CameraUpdate.newLatLngZoom(points.first, _frameZoom)
        : CameraUpdate.newLatLngBounds(bounds, _framePadding);
  }

  /// Null when every point sits on one spot: that box has no area, and Google
  /// Maps cannot resolve a zoom to fit it.
  LatLngBounds? _boundsOf(List<LatLng> points) {
    var south = points.first.latitude;
    var north = south;
    var west = points.first.longitude;
    var east = west;

    for (final point in points.skip(1)) {
      south = math.min(south, point.latitude);
      north = math.max(north, point.latitude);
      west = math.min(west, point.longitude);
      east = math.max(east, point.longitude);
    }

    if (south == north && west == east) return null;

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  /// The offer can be answered or time out while the route is in flight, and a
  /// stale frame would yank the camera off whatever came next.
  bool _offerIsOpen() =>
      ref.mounted &&
      ref.read(rideControllerProvider).stage == DriverStage.offerReceived;

  bool _isSelfMove() {
    final until = _selfMoveUntil;
    return until != null && DateTime.now().isBefore(until);
  }

  void _stop() {
    _positions?.close();
    _positions = null;
    _resume?.cancel();
    _resume = null;
    _selfMoveUntil = null;
    _paused = false;
  }
}
