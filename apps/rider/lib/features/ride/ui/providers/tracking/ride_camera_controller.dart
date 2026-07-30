import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/map/map_controller_provider.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';

part 'ride_camera_controller.g.dart';

@riverpod
class RideCameraController extends _$RideCameraController {
  static const _boundsPadding = 96.0;

  static const _soloZoom = 12.0;

  bool _framed = false;

  bool _searchFramed = false;

  @override
  void build() {
    final rideId = ref.watch(
      requestRideControllerProvider.select((s) => s.value?.id),
    );
    _framed = false;
    _searchFramed = false;

    if (rideId == null) return;

    ref.listen(rideControllerProvider.select((s) => s.stage), (previous, next) {
      if (next != RideStage.searching || _searchFramed) return;
      _searchFramed = true;
      _frameOnPickup(_soloZoom);
    }, fireImmediately: true);

    ref.listen(rideControllerProvider.select((s) => s.driverPosition), (
      previous,
      next,
    ) {
      if (next == null || _framed) return;
      _framed = true;
      _frameOn(next);
    });
  }

  Future<void> _frameOnPickup(double zoome) async {
    final controller = await ref.read(mapControllerHolderProvider.future);
    if (!ref.mounted) return;

    final pickup = ref.read(rideDraftProvider).pickup;
    if (pickup == null) return;

    await controller.animateCamera(CameraUpdate.newLatLngZoom(pickup, zoome));
  }

  Future<void> _frameOn(GeoPoint driverPosition) async {
    final controller = await ref.read(mapControllerHolderProvider.future);
    if (!ref.mounted) return;

    final driver = LatLng(driverPosition.latitude, driverPosition.longitude);
    final pickup = ref.read(rideDraftProvider).pickup;

    final update = pickup == null
        ? CameraUpdate.newLatLngZoom(driver, _soloZoom)
        : CameraUpdate.newLatLngBounds(
            _boundsOf(driver, pickup),
            _boundsPadding,
          );

    await controller.animateCamera(update);
  }

  LatLngBounds _boundsOf(LatLng a, LatLng b) => LatLngBounds(
    southwest: LatLng(
      math.min(a.latitude, b.latitude),
      math.min(a.longitude, b.longitude),
    ),
    northeast: LatLng(
      math.max(a.latitude, b.latitude),
      math.max(a.longitude, b.longitude),
    ),
  );
}
