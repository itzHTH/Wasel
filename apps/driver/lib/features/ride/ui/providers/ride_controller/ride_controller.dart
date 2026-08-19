import 'dart:async';

import 'package:driver/features/ride/data/models/change_payment/change_payment_arg.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_connection_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';

part 'ride_controller.g.dart';

/// Only [rejected] means the backend refused the trip on its merits, which is
/// the single case where offering a switch to cash makes sense.
enum CompletionOutcome { completed, rejected, failed }

class RideConnectionException implements Exception {
  const RideConnectionException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class RideController extends _$RideController {
  /// How long a driver has to answer an offer. Public so the countdown ring
  /// can size its arc against the same window the timer counts down.
  static const offerSeconds = 30;

  /// How long the hub gets to confirm the handshake before the attempt is
  /// abandoned. Sits above the 8s a single invoke waits inside the SignalR
  /// client so a slow — but live — connection is not cut short.
  static const connectTimeout = Duration(seconds: 15);

  StreamSubscription<DriverRideEvent>? _events;
  StreamSubscription<RideConnectionStatus>? _connection;
  ProviderSubscription<WatchRideEventUseCase>? _useCase;
  ProviderSubscription<WatchRideConnectionUseCase>? _connectionUseCase;
  Timer? _countdown;
  Timer? _connectTimer;

  /// A release that has not finished yet, kept so the next attempt can wait it
  /// out instead of racing it for the shared hub.
  Future<void>? _teardown;
  int _session = 0;

  @override
  DriverRideState build() {
    ref.onDispose(_cancelEvents);
    return const DriverRideState();
  }

  Future<void> goOnline() async {
    // A second tap while the handshake is in flight is a double tap, not a new
    // intent; restarting here would drop the connection already being opened.
    if (state.connection == DriverConnectionState.connecting) return;

    final teardown = _cancelEvents();

    final session = _session;

    state = state.copyWith(connection: DriverConnectionState.connecting);

    // Armed before the teardown is awaited so the window covers both halves; a
    // teardown that never lands is just as stuck as a hub that never answers.
    _connectTimer = Timer(
      connectTimeout,
      () => _dropConnection(
        session,
        const RideConnectionException('ما وصل رد من الخادم، حاول مرة ثانية'),
        StackTrace.current,
      ),
    );

    // The previous session releases the hub asynchronously and ends by
    // disconnecting it. Opening before that lands lets the old disconnect tear
    // down the socket this attempt just opened, since both share one client.
    await teardown;
    if (session != _session || !ref.mounted) return;

    // Subscribed before the event stream so the transition to `connected` is
    // observed even if the handshake resolves within the same microtask.
    _connectionUseCase = ref.listen(
      watchRideConnectionUseCaseProvider,
      (_, _) {},
    );
    _connection = _connectionUseCase!
        .read()
        .call(null)
        .listen(
          (status) => _onConnectionStatus(session, status),
          onError: (Object error, StackTrace stackTrace) =>
              _dropConnection(session, error, stackTrace),
        );

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
  }

  void goOffline() {
    _cancelEvents();
    state = const DriverRideState();
  }

  void cancelConnecting() {
    if (state.connection != DriverConnectionState.connecting) return;
    goOffline();
  }

  /// Takes the offer, holding the window open until the backend agrees.
  ///
  /// The countdown is paused rather than left running: a tick landing mid-call
  /// would expire the offer and clear the very ride the accept is committing
  /// to. If the call does not commit, the driver gets the rest of their window
  /// back instead of a card frozen at the second they tapped.
  Future<void> acceptOffer() async {
    final secondsLeft = state.secondsLeft;
    _stopCountdown();

    final succeeded = await _perform(
      (rideId) => ref.read(acceptRideUseCaseProvider).call(rideId),
      DriverStage.heading,
    );

    if (succeeded || !ref.mounted) return;
    if (state.stage != DriverStage.offerReceived) return;

    state = state.copyWith(secondsLeft: secondsLeft);
    _startCountdown();
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

  Future<CompletionOutcome> completeRide() async {
    final rideId = state.ride?.rideId;
    if (rideId == null) return CompletionOutcome.failed;

    ErrorHandler? failure;

    final succeeded = await ref
        .read(rideActionControllerProvider.notifier)
        .run(() async {
          final result = await ref
              .read(completeRideUseCaseProvider)
              .call(rideId);
          result.when(success: (_) {}, failure: (error) => failure = error);
          return result;
        });

    if (!ref.mounted) return CompletionOutcome.failed;

    if (succeeded) {
      state = state.copyWith(stage: DriverStage.completed);
      return CompletionOutcome.completed;
    }

    // A timeout or a dropped connection carries no status code, so it can
    // never be mistaken for the backend refusing the payment.
    return failure?.statusCode == 400
        ? CompletionOutcome.rejected
        : CompletionOutcome.failed;
  }

  /// The local method follows only once the server has taken the switch.
  Future<bool> switchToCashAndComplete() async {
    final rideId = state.ride?.rideId;
    if (rideId == null) return false;

    final switched = await ref
        .read(rideActionControllerProvider.notifier)
        .run(
          () => ref
              .read(changePaymentMethodUseCaseProvider)
              .call(
                ChangePaymentArg(
                  rideId: rideId,
                  method: PaymentMethod.cash,
                ),
              ),
        );

    if (!switched || !ref.mounted) return false;

    state = state.copyWith(
      ride: state.ride?.copyWith(
        paymentMethod: '${PaymentMethod.cash.code}',
      ),
    );

    return await completeRide() == CompletionOutcome.completed;
  }

  /// Cancelling is only possible before the ride starts. Once it is under way
  /// the backend refuses the call from either side, so the request is not
  /// worth making — no card offers the action past this point either.
  Future<void> cancelRide() async {
    if (state.stage == DriverStage.inProgress) return;

    await _perform(
      (rideId) => ref.read(driverCancelRideUseCaseProvider).call(rideId),
      _idleStage,
      clearRide: true,
    );
  }

  void dismissCompleted() => _clearOffer();

  /// Runs [action] against the ride on screen, reporting whether it committed
  /// so a caller can undo whatever it staged for the round trip.
  Future<bool> _perform(
    Future<ApiResults<void>> Function(String rideId) action,
    DriverStage next, {
    bool clearRide = false,
  }) async {
    final rideId = state.ride?.rideId;
    if (rideId == null) return false;

    final succeeded = await ref
        .read(rideActionControllerProvider.notifier)
        .run(() => action(rideId));

    if (!succeeded || !ref.mounted) return false;

    state = clearRide
        ? state.copyWith(stage: next, ride: null)
        : state.copyWith(stage: next);

    return true;
  }

  /// The hub's own view of the socket, which is what the UI follows.
  ///
  /// While [DriverConnectionState.connecting] this only reacts to `connected` —
  /// a failed handshake reports `disconnected` too, but that path belongs to
  /// the event stream's error and the timeout, which carry the right message.
  void _onConnectionStatus(int session, RideConnectionStatus status) {
    if (session != _session || !ref.mounted) return;

    final pending = state.connection == DriverConnectionState.connecting;

    switch (status) {
      case RideConnectionStatus.connecting:
        return;

      case RideConnectionStatus.connected:
        _stopConnectTimer();
        // Promoting the stage is only right for the opening handshake; an
        // automatic reconnect mid-ride reports `connected` as well and must
        // leave the driver on whatever stage the ride had reached.
        state = pending
            ? state.copyWith(
                stage: DriverStage.online,
                connection: DriverConnectionState.idle,
              )
            : state.copyWith(connection: DriverConnectionState.idle);

      case RideConnectionStatus.reconnecting:
        if (pending) return;
        state = state.copyWith(connection: DriverConnectionState.reconnecting);

      case RideConnectionStatus.disconnected:
        // SignalR only reports this once automatic reconnection has given up,
        // so there is nothing left to wait for.
        if (pending || state.stage == DriverStage.offline) return;
        _dropConnection(
          session,
          const RideConnectionException('انقطع الاتصال بالخادم'),
          StackTrace.current,
        );
    }
  }

  void _onEvent(DriverRideEvent event) {
    if (!ref.mounted) return;

    switch (event) {
      case final ReceiveRideRequest offer:
        state = state.copyWith(
          stage: DriverStage.offerReceived,
          ride: offer,
          secondsLeft: offerSeconds,
        );
        _startCountdown();
      // The hub broadcasts a hide to every driver it offered the ride to, so
      // one can arrive for a ride this driver is not looking at. Clearing on
      // that would pull a live offer out from under them.
      case HideRideRequest(:final rideId):
        if (state.stage != DriverStage.offerReceived) return;
        if (rideId != state.ride?.rideId) return;
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

    final next = _idleStage;
    state = state.copyWith(
      stage: next,
      // Dismissing the last card of a dropped ride is the point the driver
      // finally goes offline, so the dead-link marker retires with it.
      connection: next == DriverStage.offline
          ? DriverConnectionState.idle
          : state.connection,
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

    // Only an offer on screen has a window to run down. Anything else means a
    // ticker outlived what it was counting, and it must not clear a live ride.
    if (state.stage != DriverStage.offerReceived) {
      _stopCountdown();
      return;
    }

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

  void _stopConnectTimer() {
    _connectTimer?.cancel();
    _connectTimer = null;
  }

  void _dropConnection(int session, Object error, StackTrace stackTrace) {
    if (session != _session) return;

    _cancelEvents();
    if (!ref.mounted) return;

    // An accepted ride is driven over REST, not the hub — arrive, start and
    // complete all still reach the backend — so losing the socket must not take
    // the trip with it. The stage stays put and only the link is marked dead.
    state = _hasCommittedRide(state.stage)
        ? state.copyWith(connection: DriverConnectionState.dropped)
        : const DriverRideState();

    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(error, stackTrace);
  }

  /// Whether the driver has taken on a ride they can still finish offline.
  static bool _hasCommittedRide(DriverStage stage) => switch (stage) {
    DriverStage.heading ||
    DriverStage.arrived ||
    DriverStage.inProgress ||
    DriverStage.completed => true,
    DriverStage.offline ||
    DriverStage.online ||
    DriverStage.offerReceived => false,
  };

  /// Where the driver lands once a ride ends: back to searching only while the
  /// hub subscription is live, otherwise offline — there is nothing listening.
  DriverStage get _idleStage =>
      _events == null ? DriverStage.offline : DriverStage.online;

  /// Releases the current session. The returned future completes once the hub
  /// has actually been disconnected — cancelling the event subscription runs
  /// the repo's release, which awaits that — so a caller reopening the
  /// connection can wait for the old one to be gone first.
  Future<void> _cancelEvents() {
    _stopCountdown();
    _stopConnectTimer();

    final events = _events;
    final useCase = _useCase;
    final connection = _connection;
    final connectionUseCase = _connectionUseCase;
    final previous = _teardown;
    _events = null;
    _useCase = null;
    _connection = null;
    _connectionUseCase = null;
    _session++;

    final teardown = _releaseAll(
      previous,
      _release(connection, connectionUseCase),
      _release(events, useCase),
    );
    _teardown = teardown;
    unawaited(
      teardown.whenComplete(() {
        if (identical(_teardown, teardown)) _teardown = null;
      }),
    );
    return teardown;
  }

  /// [previous] is a teardown from an earlier session that has not landed yet.
  /// It ends by disconnecting the same shared hub, so a caller waiting on this
  /// one has to wait on that as well — `goOffline` discards its future, and
  /// without this an immediate `goOnline` would sail straight past it.
  Future<void> _releaseAll(
    Future<void>? previous,
    Future<void> connection,
    Future<void> events,
  ) async {
    // Both releases are already in flight — they start when _cancelEvents
    // builds them — so awaiting in turn still lets them run side by side.
    await previous;
    await connection;
    await events;
  }

  /// Drops the provider only once its stream is gone: closing the subscription
  /// first would tear the hub down from under a listener still attached to it.
  Future<void> _release(
    StreamSubscription<Object?>? stream,
    ProviderSubscription<Object?>? useCase,
  ) async {
    try {
      await stream?.cancel();
    } catch (_) {
      // A release that fails still ends the session, and `goOnline` waits on
      // this future before reopening: letting the error through would leave the
      // driver stuck on a spinner until the connect timeout, over a hub that is
      // already gone.
    }
    useCase?.close();
  }
}
