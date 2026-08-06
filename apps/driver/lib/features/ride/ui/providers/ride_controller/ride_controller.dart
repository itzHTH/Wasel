import 'dart:async';

import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'ride_controller.g.dart';

class RideConnectionException implements Exception {
  const RideConnectionException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class RideController extends _$RideController {
  static const _offerSeconds = 30;

  StreamSubscription<DriverRideEvent>? _events;
  ProviderSubscription<WatchRideEventUseCase>? _useCase;
  Timer? _countdown;
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
    state = const DriverRideState();
  }

  Future<void> acceptOffer() {
    _stopCountdown();
    return _perform(
      (rideId) => ref.read(acceptRideUseCaseProvider).call(rideId),
      DriverStage.heading,
    );
  }

  void rejectOffer() => _clearOffer();

  Future<void> markArrived() => _perform(
    (rideId) => ref.read(arriveAtStartPointUseCaseProvider).call(rideId),
    DriverStage.arrived,
  );

  Future<void> startRide() => _perform(
    (rideId) => ref.read(startRideUseCaseProvider).call(rideId),
    DriverStage.inProgress,
  );

  Future<void> completeRide() => _perform(
    (rideId) => ref.read(completeRideUseCaseProvider).call(rideId),
    DriverStage.completed,
  );

  Future<void> cancelRide() => _perform(
    (rideId) => ref.read(driverCancelRideUseCaseProvider).call(rideId),
    DriverStage.online,
    clearRide: true,
  );

  void dismissCompleted() => _clearOffer();

  Future<void> _perform(
    Future<ApiResults<void>> Function(String rideId) action,
    DriverStage next, {
    bool clearRide = false,
  }) async {
    final rideId = state.ride?.rideId;
    if (rideId == null) return;

    final succeeded = await ref
        .read(rideActionControllerProvider.notifier)
        .run(() => action(rideId));

    if (!succeeded || !ref.mounted) return;

    state = clearRide
        ? state.copyWith(stage: next, ride: null)
        : state.copyWith(stage: next);
  }

  void _onEvent(DriverRideEvent event) {
    if (!ref.mounted) return;

    switch (event) {
      case final ReceiveRideRequest offer:
        state = state.copyWith(
          stage: DriverStage.offerReceived,
          ride: offer,
          secondsLeft: _offerSeconds,
        );
        _startCountdown();
      case HideRideRequest():
        if (state.stage != DriverStage.offerReceived) return;
        _clearOffer();
      case RideCancelled():
        _clearOffer();
      case ProfileReviewed():
        return;
    }
  }

  void _clearOffer() {
    _stopCountdown();
    if (!ref.mounted) return;
    state = state.copyWith(
      stage: DriverStage.online,
      ride: null,
      secondsLeft: 0,
    );
  }

  void _startCountdown() {
    _stopCountdown();
    _countdown = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (!ref.mounted) return;

    final remaining = state.secondsLeft - 1;
    if (remaining <= 0) {
      _clearOffer();
      return;
    }

    state = state.copyWith(secondsLeft: remaining);
  }

  void _stopCountdown() {
    _countdown?.cancel();
    _countdown = null;
  }

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
    _stopCountdown();

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
