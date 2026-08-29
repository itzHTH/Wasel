import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:driver/features/ride/data/models/change_payment/change_payment_arg.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/use_case/reconnect_to_ride_use_case.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/offer_countdown.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_hub_session.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/usecases/get_active_ride_use_case.dart';
import 'package:wasel_rides/presentation/providers/rides_di_providers.dart';

part 'ride_controller.g.dart';

enum CompletionOutcome { completed, rejected, failed }

class RideConnectionException implements Exception {
  const RideConnectionException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
class RideController extends _$RideController {
  static const offerSeconds = 30;

  static const connectTimeout = Duration(seconds: 15);

  late final RideHubSession _hub;
  late final OfferCountdown _countdown;

  int _recovery = 0;

  late GetActiveRideUseCase _getActiveRide;
  late ReconnectToRideUseCase _reconnect;

  @override
  DriverRideState build() {
    _getActiveRide = ref.watch(getActiveRideUseCaseProvider);
    _reconnect = ref.watch(reconnectToRideUseCaseProvider);

    _hub = RideHubSession(ref);
    _countdown = OfferCountdown(
      onTick: _onCountdownTick,
      onExpire: _clearOffer,
    );

    ref.onDispose(_getActiveRide.cancel);
    ref.onDispose(_countdown.stop);
    ref.onDispose(_hub.close);

    unawaited(Future.microtask(() => _recover(opening: true)));

    return const DriverRideState(isRecovering: true);
  }

  Future<void> _recover({required bool opening}) async {
    final recovery = ++_recovery;

    state = state.copyWith(isRecovering: true);

    final result = await _getActiveRide.call(null);

    if (!ref.mounted || recovery != _recovery) return;

    result.when(
      failure: (error) {
        if (error.isCancelled) return;
        state = state.copyWith(isRecovering: false);
      },
      success: (ride) => _applySnapshot(ride, isRecovering: false),
    );

    if (!ref.mounted || recovery != _recovery) return;

    // On a cold start an active ride means the driver was mid-shift. On a
    // resume, only a committed ride re-opens: a driver who went offline on
    // purpose must not be dragged back online, but a trip whose hub died has
    // no other route back — no card exposes `goOnline` past DriverStage.online.
    final reopen = opening
        ? state.activeRide != null
        : _hasCommittedRide(state.stage);

    if (reopen &&
        state.connection != DriverConnectionState.connecting &&
        !_hub.isOpen) {
      await goOnline();
    }
  }

  Future<void> refreshFromBackend() => _recover(opening: false);

  void _applySnapshot(ActiveRide? ride, {required bool isRecovering}) {
    final stage = ride?.status?.driverStage;

    if (ride == null || stage == null) {
      if (state.stage == DriverStage.completed || _hasLiveOffer) {
        state = state.copyWith(isRecovering: isRecovering);
        return;
      }

      state = state.copyWith(
        stage: _idleStage,
        ride: null,
        activeRide: null,
        secondsLeft: 0,
        isRecovering: isRecovering,
      );
      return;
    }

    _countdown.stop();
    state = state.copyWith(
      stage: stage,
      activeRide: ride,
      secondsLeft: 0,
      isRecovering: isRecovering,
    );
  }

  Future<void> goOnline() async {
    if (state.connection == DriverConnectionState.connecting) return;

    _countdown.stop();
    state = state.copyWith(connection: DriverConnectionState.connecting);

    await _hub.open(
      timeout: connectTimeout,
      onTimeout: (generation) => _dropConnection(
        generation,
        RideConnectionException(_l10n.noServerResponse),
        StackTrace.current,
      ),
      onStatus: _onConnectionStatus,
      onEvent: _onEvent,
      onError: _dropConnection,
      onDone: (generation) => _dropConnection(
        generation,
        RideConnectionException(_l10n.serverDisconnected),
        StackTrace.current,
      ),
    );
  }

  void goOffline() {
    _countdown.stop();
    unawaited(_hub.close());
    state = const DriverRideState();
  }

  void cancelConnecting() {
    if (state.connection != DriverConnectionState.connecting) return;
    goOffline();
  }

  void _onConnectionStatus(int generation, RideConnectionStatus status) {
    debugPrint('🔌 hub → $status (stage=${state.stage})');
    if (generation != _hub.generation || !ref.mounted) return;

    final pending = state.connection == DriverConnectionState.connecting;

    switch (status) {
      case RideConnectionStatus.connecting:
        return;

      case RideConnectionStatus.connected:
        _hub.stopTimeout();
        state = (pending && !_hasCommittedRide(state.stage))
            ? state.copyWith(
                stage: DriverStage.online,
                connection: DriverConnectionState.idle,
              )
            : state.copyWith(connection: DriverConnectionState.idle);

        unawaited(_rejoin());

      case RideConnectionStatus.reconnecting:
        if (pending) return;
        state = state.copyWith(connection: DriverConnectionState.reconnecting);

      case RideConnectionStatus.disconnected:
        if (pending || state.stage == DriverStage.offline) return;
        _dropConnection(
          generation,
          RideConnectionException(_l10n.serverDisconnected),
          StackTrace.current,
        );
    }
  }

  void _dropConnection(int generation, Object error, StackTrace stackTrace) {
    if (generation != _hub.generation) return;

    _countdown.stop();
    unawaited(_hub.close());
    if (!ref.mounted) return;

    state = _hasCommittedRide(state.stage)
        ? state.copyWith(connection: DriverConnectionState.dropped)
        : const DriverRideState();

    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(error, stackTrace);
  }

  Future<void> _rejoin() async {
    final rideId = state.rideId;
    if (rideId == null) return;

    await _reconnect.call(rideId);
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
        _countdown.start(offerSeconds);

      case HideRideRequest(:final rideId):
        if (state.stage != DriverStage.offerReceived) return;
        if (rideId != state.ride?.rideId) return;
        _clearOffer();

      case RideCancelled():
        _clearOffer();

      case ProfileReviewed():
        return;

      case RideStatusSync(:final ride):
        _applySnapshot(ride, isRecovering: false);
    }
  }

  void _onCountdownTick(int secondsLeft) {
    if (!ref.mounted) return;

    if (state.stage != DriverStage.offerReceived) {
      _countdown.stop();
      return;
    }

    state = state.copyWith(secondsLeft: secondsLeft);
  }

  void _clearOffer() {
    _countdown.stop();
    if (!ref.mounted) return;

    final next = _idleStage;
    state = state.copyWith(
      stage: next,
      connection: next == DriverStage.offline
          ? DriverConnectionState.idle
          : state.connection,
      ride: null,
      activeRide: null,
      secondsLeft: 0,
    );
  }

  Future<void> acceptOffer() async {
    final secondsLeft = state.secondsLeft;
    _countdown.stop();

    final succeeded = await _perform(
      (rideId) => ref.read(acceptRideUseCaseProvider).call(rideId),
      DriverStage.heading,
    );

    if (succeeded || !ref.mounted) return;
    if (state.stage != DriverStage.offerReceived) return;

    state = state.copyWith(secondsLeft: secondsLeft);
    _countdown.start(secondsLeft);
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
    final rideId = state.rideId;
    if (rideId == null) return CompletionOutcome.failed;

    ErrorHandler? failure;

    final succeeded = await ref.read(rideActionControllerProvider.notifier).run(
      () async {
        final result = await ref.read(completeRideUseCaseProvider).call(rideId);
        result.when(success: (_) {}, failure: (error) => failure = error);
        return result;
      },
    );

    if (!ref.mounted) return CompletionOutcome.failed;

    if (succeeded) {
      state = state.copyWith(stage: DriverStage.completed);
      return CompletionOutcome.completed;
    }

    return failure?.statusCode == 400
        ? CompletionOutcome.rejected
        : CompletionOutcome.failed;
  }

  Future<bool> switchToCashAndComplete() async {
    final rideId = state.rideId;
    if (rideId == null) return false;

    final switched = await ref
        .read(rideActionControllerProvider.notifier)
        .run(
          () => ref
              .read(changePaymentMethodUseCaseProvider)
              .call(
                ChangePaymentArg(rideId: rideId, method: PaymentMethod.cash),
              ),
        );

    if (!switched || !ref.mounted) return false;

    final cash = '${PaymentMethod.cash.code}';
    state = state.copyWith(
      ride: state.ride?.copyWith(paymentMethod: cash),
      activeRide: state.activeRide?.withPaymentMethod(cash),
    );

    return await completeRide() == CompletionOutcome.completed;
  }

  Future<void> cancelRide() async {
    if (state.stage == DriverStage.inProgress) return;

    await _perform(
      (rideId) => ref.read(driverCancelRideUseCaseProvider).call(rideId),
      _idleStage,
      clearRide: true,
    );
  }

  void dismissCompleted() => _clearOffer();

  Future<bool> _perform(
    Future<ApiResults<void>> Function(String rideId) action,
    DriverStage next, {
    bool clearRide = false,
  }) async {
    final rideId = state.rideId;
    if (rideId == null) return false;

    final succeeded = await ref
        .read(rideActionControllerProvider.notifier)
        .run(() => action(rideId));

    if (!succeeded || !ref.mounted) return false;

    state = clearRide
        ? state.copyWith(stage: next, ride: null, activeRide: null)
        : state.copyWith(stage: next);

    return true;
  }

  static bool _hasCommittedRide(DriverStage stage) => switch (stage) {
    DriverStage.heading ||
    DriverStage.arrived ||
    DriverStage.inProgress ||
    DriverStage.completed => true,
    DriverStage.offline ||
    DriverStage.online ||
    DriverStage.offerReceived => false,
  };

  DriverStage get _idleStage =>
      _hub.isOpen ? DriverStage.online : DriverStage.offline;

  bool get _hasLiveOffer =>
      state.stage == DriverStage.offerReceived && state.secondsLeft > 0;
}

DriverLocalizations get _l10n =>
    lookupDriverLocalizations(AppLocalizationController.currentLocale);
