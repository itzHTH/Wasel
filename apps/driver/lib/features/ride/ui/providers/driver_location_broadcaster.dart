import 'dart:async';

import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/use_case/update_driver_location_use_case.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_location_broadcaster.g.dart';

class LocationUnavailableException implements Exception {
  const LocationUnavailableException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class DriverLocationBroadcaster extends _$DriverLocationBroadcaster {
  static const _settings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  static const _heartbeat = Duration(seconds: 10);

  StreamSubscription<Position>? _positions;
  Timer? _ticker;
  Position? _lastPosition;
  ProviderSubscription<UpdateDriverLocationUseCase>? _useCase;
  int _session = 0;

  @override
  void build() {
    ref.onDispose(_stop);

    final isOnline = ref.watch(
      rideControllerProvider.select((s) => s.stage != DriverStage.offline),
    );

    _stop();
    if (!isOnline) return;

    unawaited(_start(_session));
  }

  Future<void> _start(int session) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _fail(session, 'خدمة الموقع مطفّية، شغّلها حتى نگدر نبعث موقعك');
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _fail(session, 'ما نگدر نبعث موقعك بدون إذن الموقع');
      return;
    }

    if (session != _session || !ref.mounted) return;

    _useCase = ref.listen(updateDriverLocationUseCaseProvider, (_, _) {});
    _positions = Geolocator.getPositionStream(
      locationSettings: _settings,
    ).listen(_onPosition);
    _ticker = Timer.periodic(_heartbeat, (_) => unawaited(_broadcast()));
  }

  void _onPosition(Position position) {
    _lastPosition = position;
    unawaited(_broadcast());
  }

  Future<void> _broadcast() async {
    final position = _lastPosition;
    final useCase = _useCase;
    if (position == null || useCase == null) return;

    debugPrint('[BROADCAST] ${position.latitude}, ${position.longitude}');

    try {
      await useCase.read().call(
        UpdateLocationArg(
          lat: position.latitude,
          lng: position.longitude,
          rideId: null,
        ),
      );
    } catch (e) {
      debugPrint('[BROADCAST] update failed: $e');
    }
  }

  void _fail(int session, String message) {
    if (session != _session || !ref.mounted) return;

    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(
          LocationUnavailableException(message),
          StackTrace.current,
        );
  }

  void _stop() {
    final positions = _positions;
    final useCase = _useCase;
    _positions = null;
    _useCase = null;
    _ticker?.cancel();
    _ticker = null;
    _lastPosition = null;
    _session++;

    if (positions == null) {
      useCase?.close();
      return;
    }
    unawaited(positions.cancel().whenComplete(() => useCase?.close()));
  }
}
