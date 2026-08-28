import 'dart:async';

import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_connection_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RideHubSession {
  RideHubSession(this._ref);

  final Ref _ref;

  StreamSubscription<DriverRideEvent>? _events;
  StreamSubscription<RideConnectionStatus>? _status;
  ProviderSubscription<WatchRideEventUseCase>? _eventUseCase;
  ProviderSubscription<WatchRideConnectionUseCase>? _statusUseCase;

  Timer? _timeout;

  Future<void>? _teardown;

  int _generation = 0;

  bool get isOpen => _events != null;

  int get generation => _generation;

  void stopTimeout() {
    _timeout?.cancel();
    _timeout = null;
  }

  Future<bool> open({
    required Duration timeout,
    required void Function(int generation) onTimeout,
    required void Function(int generation, RideConnectionStatus status)
    onStatus,
    required void Function(DriverRideEvent event) onEvent,
    required void Function(int generation, Object error, StackTrace stackTrace)
    onError,
    required void Function(int generation) onDone,
  }) async {
    final teardown = close();
    final generation = _generation;

    _timeout = Timer(timeout, () => onTimeout(generation));

    await teardown;
    if (generation != _generation || !_ref.mounted) return false;

    _statusUseCase = _ref.listen(watchRideConnectionUseCaseProvider, (_, _) {});
    _status = _statusUseCase!
        .read()
        .call(null)
        .listen(
          (status) => onStatus(generation, status),
          onError: (Object error, StackTrace stackTrace) =>
              onError(generation, error, stackTrace),
        );

    _eventUseCase = _ref.listen(watchRideEventUseCaseProvider, (_, _) {});
    _events = _eventUseCase!
        .read()
        .call(null)
        .listen(
          onEvent,
          onError: (Object error, StackTrace stackTrace) =>
              onError(generation, error, stackTrace),
          onDone: () => onDone(generation),
        );

    return true;
  }

  Future<void> close() {
    stopTimeout();

    final events = _events;
    final eventUseCase = _eventUseCase;
    final status = _status;
    final statusUseCase = _statusUseCase;
    final previous = _teardown;

    _events = null;
    _eventUseCase = null;
    _status = null;
    _statusUseCase = null;
    _generation++;

    final teardown = _releaseAll(
      previous,
      _release(status, statusUseCase),
      _release(events, eventUseCase),
    );

    _teardown = teardown;
    unawaited(
      teardown.whenComplete(() {
        if (identical(_teardown, teardown)) _teardown = null;
      }),
    );

    return teardown;
  }

  Future<void> _releaseAll(
    Future<void>? previous,
    Future<void> status,
    Future<void> events,
  ) async {
    await previous;
    await status;
    await events;
  }

  Future<void> _release(
    StreamSubscription<Object?>? stream,
    ProviderSubscription<Object?>? useCase,
  ) async {
    try {
      await stream?.cancel();
    } catch (_) {}
    useCase?.close();
  }
}
