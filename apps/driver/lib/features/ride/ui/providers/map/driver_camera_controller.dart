import 'dart:async';

import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_heading_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'driver_camera_controller.g.dart';

@riverpod
class DriverCameraController extends _$DriverCameraController {
  static const _zoom = 17.0;
  static const _selfMoveWindow = Duration(milliseconds: 300);
  static const _resumeDelay = Duration(seconds: 3);

  ProviderSubscription<AsyncValue<Position>>? _positions;
  Timer? _resume;
  DateTime? _selfMoveUntil;
  bool _paused = false;

  @override
  void build() {
    ref.onDispose(_stop);

    final isOnline = ref.watch(
      rideControllerProvider.select((s) => s.stage != DriverStage.offline),
    );

    _stop();
    if (!isOnline) return;

    _positions = ref.listen(deviceLocationProvider, (_, next) {
      if (next case AsyncData(:final value)) unawaited(_follow(value));
    });
  }

  /// Returns whether the driver moved the camera. A false means this was the
  /// follow-camera's own animation, which callers must not treat as a gesture.
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

  Future<void> _follow(Position position) async {
    if (_paused || !ref.mounted) return;

    final controller = await ref.read(mapControllerHolderProvider.future);
    if (_paused || !ref.mounted) return;

    _selfMoveUntil = DateTime.now().add(_selfMoveWindow);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: _zoom,
          bearing: ref.read(driverHeadingProvider),
        ),
      ),
    );
  }

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
