import 'dart:async';

import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/use_case/update_driver_location_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_connection_use_case.dart';
import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case_providers.dart';
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
  static const _fixFailureLimit = 3;
  static const _fixTimeout = Duration(seconds: 15);

  ProviderSubscription<AsyncValue<Position>>? _positions;
  Timer? _ticker;
  Position? _lastPosition;
  ProviderSubscription<UpdateDriverLocationUseCase>? _useCase;
  ProviderSubscription<WatchRideConnectionUseCase>? _connectionUseCase;
  StreamSubscription<RideConnectionStatus>? _connection;
  Future<Position?>? _acquisition;
  bool _sending = false;
  bool _connected = false;
  bool _everConnected = false;
  int _failures = 0;
  int _fixFailures = 0;
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
    _watchConnection();

    // Armed before the first send so a slow cold fix cannot hold the heartbeat
    // back — the first tick is a full interval away either way.
    _ticker = Timer.periodic(_heartbeat, (_) => unawaited(_broadcast()));

    await _broadcast();
  }

  void _watchConnection() {
    _connectionUseCase = ref.listen(
      watchRideConnectionUseCaseProvider,
      (_, _) {},
    );
    _connection = _connectionUseCase!
        .read()
        .call(null)
        .listen(
          _onConnection,
          // The repo forwards transport errors on this stream. They say nothing the
          // driver can act on and the heartbeat carries on regardless, so they are
          // absorbed here rather than escaping to the zone handler.
          onError: (Object _, StackTrace _) {},
        );
  }

  void _onConnection(RideConnectionStatus status) {
    final connected = status == RideConnectionStatus.connected;
    // The first connect is already covered by the send in [_start]; only a
    // re-established hub needs a fresh push of its own.
    final reconnected = connected && !_connected && _everConnected;

    _connected = connected;
    _everConnected |= connected;

    if (reconnected) unawaited(_broadcast());
  }

  void _onPosition(Position position) {
    _lastPosition = position;
    unawaited(_broadcast());
  }

  Future<void> _broadcast() async {
    final useCase = _useCase;
    // A heartbeat that overlaps an in-flight send would queue behind it and
    // flush a burst of stale fixes; the next tick carries fresher data anyway.
    if (useCase == null || _sending || !ref.mounted) return;

    final session = _session;
    var position = _lastPosition;

    if (position == null) {
      final acquired = await _acquirePosition(session);
      if (session != _session || !ref.mounted) return;
      position = _lastPosition ?? acquired;
    }

    if (position == null) return;

    _lastPosition = position;
    _sending = true;

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
    } finally {
      _sending = false;
    }
  }

  Future<Position?> _acquirePosition(int session) {
    // Only clear the slot if it is still ours: an acquisition left over from a
    // previous session would otherwise null out the current one and let a
    // second high-accuracy fix start alongside it.
    return _acquisition ??= _coldFix(session).whenComplete(() {
      if (session == _session) _acquisition = null;
    });
  }

  Future<Position?> _coldFix(int session) async {
    try {
      final position =
          await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: _fixTimeout,
            ),
          );

      if (session == _session) _fixFailures = 0;
      return position;
    } catch (_) {
      _onFixFailed(session);
      return null;
    }
  }

  /// Counted here rather than in [_broadcast] so concurrent callers sharing one
  /// in-flight acquisition record a single failure between them.
  void _onFixFailed(int session) {
    if (session != _session) return;

    _fixFailures++;
    if (_fixFailures != _fixFailureLimit) return;

    _fail(session, 'ما نگدر نحدد موقعك، تأكد من إشارة الـ GPS');
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
    unawaited(_connection?.cancel());
    _connection = null;
    _connectionUseCase?.close();
    _connectionUseCase = null;
    _ticker?.cancel();
    _ticker = null;
    _lastPosition = null;
    _acquisition = null;
    _connected = false;
    _everConnected = false;
    _failures = 0;
    _fixFailures = 0;
    _session++;
  }
}
