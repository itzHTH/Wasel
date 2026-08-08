import 'dart:async';

import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/use_case/update_driver_location_use_case.dart';
import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case.dart';
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

class LocationBroadcastException implements Exception {
  const LocationBroadcastException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class DriverLocationBroadcaster extends _$DriverLocationBroadcaster {
  static const _heartbeat = Duration(seconds: 10);
  static const _failureLimit = 3;
  static const _fixTimeout = Duration(seconds: 15);

  ProviderSubscription<AsyncValue<Position>>? _positions;
  Timer? _ticker;
  Position? _lastPosition;
  ProviderSubscription<UpdateDriverLocationUseCase>? _useCase;
  int _failures = 0;
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
    _positions = ref.listen(deviceLocationProvider, (_, next) {
      if (next case AsyncData(:final value)) _onPosition(value);
    });
    _ticker = Timer.periodic(_heartbeat, (_) => unawaited(_broadcast()));

    await _seedPosition(session);
  }

  /// The position stream only fires once the driver has moved the distance
  /// filter, so a driver who goes online and stays put never produces a first
  /// fix — leaving [_lastPosition] null and every heartbeat with nothing to
  /// send. Seed it once so dispatch sees the driver from the moment they
  /// connect.
  Future<void> _seedPosition(int session) async {
    final Position position;

    try {
      position =
          await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: _fixTimeout,
            ),
          );
    } catch (_) {
      return;
    }

    if (session != _session || !ref.mounted) return;

    // The stream may have delivered a newer fix while we were waiting.
    if (_lastPosition != null) return;

    _lastPosition = position;
    await _broadcast();
  }

  void _onPosition(Position position) {
    _lastPosition = position;
    unawaited(_broadcast());
  }

  Future<void> _broadcast() async {
    final position = _lastPosition;
    final useCase = _useCase;
    if (position == null || useCase == null || !ref.mounted) return;

    final session = _session;

    try {
      await useCase.read().call(
        UpdateLocationArg(
          lat: position.latitude,
          lng: position.longitude,
          rideId: _activeRideId(),
        ),
      );
      _failures = 0;
    } catch (_) {
      _onBroadcastFailed(session);
    }
  }

  void _onBroadcastFailed(int session) {
    if (session != _session) return;

    _failures++;
    if (_failures != _failureLimit) return;

    if (!ref.mounted) return;

    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(
          const LocationBroadcastException(
            'ماكو اتصال بالخادم، موقعك ما يوصل للتوزيع',
          ),
          StackTrace.current,
        );
  }

  String _activeRideId() {
    final ride = ref.read(rideControllerProvider);

    return switch (ride.stage) {
      DriverStage.heading ||
      DriverStage.arrived ||
      DriverStage.inProgress => ride.ride?.rideId ?? '',
      _ => '',
    };
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
    _positions?.close();
    _positions = null;
    _useCase?.close();
    _useCase = null;
    _ticker?.cancel();
    _ticker = null;
    _lastPosition = null;
    _failures = 0;
    _session++;
  }
}
