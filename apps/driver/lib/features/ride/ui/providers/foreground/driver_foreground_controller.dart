import 'dart:async';

import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:driver/features/ride/domain/use_case/ensure_foreground_ready_use_case.dart';
import 'package:driver/features/ride/domain/use_case/ensure_foreground_unrestricted_use_case.dart';
import 'package:driver/features/ride/domain/use_case/start_foreground_service_use_case.dart';
import 'package:driver/features/ride/domain/use_case/stop_foreground_service_use_case.dart';
import 'package:driver/features/ride/domain/use_case/update_foreground_notification_use_case.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_foreground_controller.g.dart';

enum ShiftPhase { online, onTrip, reconnecting }

@riverpod
class DriverForegroundController extends _$DriverForegroundController {
  late EnsureForegroundReadyUseCase _ensureReady;
  late EnsureForegroundUnrestrictedUseCase _ensureUnrestricted;
  late StartForegroundServiceUseCase _startService;
  late UpdateForegroundNotificationUseCase _updateNotification;
  late StopForegroundServiceUseCase _stopService;

  ProviderSubscription<ShiftPhase?>? _phase;
  int _session = 0;
  bool _started = false;

  @override
  void build() {
    _ensureReady = ref.watch(ensureForegroundReadyUseCaseProvider);
    _ensureUnrestricted = ref.watch(
      ensureForegroundUnrestrictedUseCaseProvider,
    );
    _startService = ref.watch(startForegroundServiceUseCaseProvider);
    _updateNotification = ref.watch(
      updateForegroundNotificationUseCaseProvider,
    );
    _stopService = ref.watch(stopForegroundServiceUseCaseProvider);

    ref.onDispose(_stop);

    final isOnline = ref.watch(
      rideControllerProvider.select((s) => s.stage != DriverStage.offline),
    );

    final hasLocation = ref.watch(
      locationAccessControllerProvider.select(
        (access) =>
            access is AsyncData<LocationAccess> && access.value.isGranted,
      ),
    );

    _stop();
    if (!isOnline || !hasLocation) return;

    unawaited(_start(_session));
  }

  Future<void> _start(int session) async {
    try {
      await _startShift(session);
    } catch (error) {
      if (session == _session) _fail(errorMessageOf(error));
    }
  }

  Future<void> _startShift(int session) async {
    final status = await _ensureReady.call(null);
    if (session != _session || !ref.mounted) return;

    // unsupported is iOS, where there is no foreground service to start and
    // nothing the driver could do about it.
    if (!status.isReady) {
      if (status != ForegroundStatus.unsupported) {
        _fail(_l10n.notificationsRequiredForShift);
      }
      return;
    }

    debugPrint('🟢 starting shift service');
    await _promptBatteryOnce();
    if (session != _session || !ref.mounted) return;

    final phase =
        _phaseOf(ref.read(rideControllerProvider)) ?? ShiftPhase.online;
    final result = await _startService.call(_notificationFor(phase));
    if (session != _session || !ref.mounted) return;

    if (!_report(result)) return;

    _started = true;
    _watchPhase(session);
  }

  void _watchPhase(int session) {
    _phase = ref.listen(rideControllerProvider.select(_phaseOf), (
      previous,
      next,
    ) {
      if (next == null || next == previous) return;
      unawaited(_update(session, next));
    });
  }

  Future<void> _update(int session, ShiftPhase phase) async {
    debugPrint('🟢 phase → $phase (started=$_started)');
    if (!_started) return;

    final result = await _updateNotification.call(_notificationFor(phase));
    if (session != _session) return;

    _report(result);
  }

  Future<void> _promptBatteryOnce() async {
    final prompted = await AppLocalCache.getBool(
      AppDriverConsts.batteryPromptKey,
    );
    if (prompted == true) return;

    // Recorded only once the dialog has been answered, so a driver who
    // dismissed it by accident is asked again rather than left under Doze.
    final granted = await _ensureUnrestricted.call(null);
    debugPrint('🔋 battery exemption granted=$granted');
    if (granted) {
      await AppLocalCache.setData(AppDriverConsts.batteryPromptKey, true);
    }
  }

  ForegroundNotificationArg _notificationFor(ShiftPhase phase) {
    final l10n = _l10n;

    return switch (phase) {
      ShiftPhase.online => ForegroundNotificationArg(
        channelName: l10n.shiftChannelName,
        title: l10n.shiftOnlineTitle,
        body: l10n.shiftOnlineBody,
      ),
      ShiftPhase.onTrip => ForegroundNotificationArg(
        channelName: l10n.shiftChannelName,
        title: l10n.shiftOnTripTitle,
        body: l10n.shiftOnTripBody,
      ),
      ShiftPhase.reconnecting => ForegroundNotificationArg(
        channelName: l10n.shiftChannelName,
        title: l10n.shiftReconnectingTitle,
        body: l10n.shiftReconnectingBody,
      ),
    };
  }

  bool _report(ApiResults<void> result) => result.when(
    success: (_) => true,
    failure: (error) {
      _fail(errorMessageOf(error));
      return false;
    },
  );

  void _fail(String message) {
    if (!ref.mounted) return;

    ref
        .read(rideActionControllerProvider.notifier)
        .reportFailure(message, StackTrace.current);
  }

  void _stop() {
    _phase?.close();
    _phase = null;
    _session++;

    if (!_started) return;
    _started = false;

    unawaited(_stopService.call(null));
  }
}

ShiftPhase? _phaseOf(DriverRideState state) {
  if (state.stage == DriverStage.offline) return null;

  if (state.connection == DriverConnectionState.reconnecting ||
      state.connection == DriverConnectionState.dropped) {
    return ShiftPhase.reconnecting;
  }

  return switch (state.stage) {
    DriverStage.heading ||
    DriverStage.arrived ||
    DriverStage.inProgress => ShiftPhase.onTrip,
    _ => ShiftPhase.online,
  };
}

DriverLocalizations get _l10n =>
    lookupDriverLocalizations(AppLocalizationController.currentLocale);
