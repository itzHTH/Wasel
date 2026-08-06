import 'dart:async';

import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_controller.g.dart';

class RideConnectionException implements Exception {
  const RideConnectionException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class RideController extends _$RideController {
  StreamSubscription<DriverRideEvent>? _events;
  ProviderSubscription<WatchRideEventUseCase>? _useCase;
  int _session = 0;

  @override
  DriverRideState build() {
    ref.onDispose(_cancelEvents);
    return const DriverRideState();
  }

  void goOnline() {
    _cancelEvents();

    final session = _session;
    _useCase = ref.listen(watchRideEventUseCaseProvider, (_, _) {});
    _events = _useCase!
        .read()
        .call(null)
        .listen(
          _onEvent,
          onError: (Object error, StackTrace stackTrace) =>
              _dropConnection(session, error, stackTrace),
          onDone: () => _dropConnection(
            session,
            const RideConnectionException('انقطع الاتصال بالخادم'),
            StackTrace.current,
          ),
        );

    state = state.copyWith(stage: DriverStage.online);
  }

  void goOffline() {
    _cancelEvents();
    state = state.copyWith(stage: DriverStage.offline);
  }

  void _onEvent(DriverRideEvent event) {}

  void _dropConnection(int session, Object error, StackTrace stackTrace) {
    if (session != _session) return;

    _cancelEvents();
    if (!ref.mounted) return;

    state = const DriverRideState();
    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(error, stackTrace);
  }

  void _cancelEvents() {
    final events = _events;
    final useCase = _useCase;
    _events = null;
    _useCase = null;
    _session++;

    if (events == null) {
      useCase?.close();
      return;
    }
    unawaited(events.cancel().whenComplete(() => useCase?.close()));
  }
}
