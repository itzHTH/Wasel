import 'dart:async';

import 'package:driver/features/ride/data/models/foreground/ride_alert_arg.dart';
import 'package:driver/features/ride/domain/use_case/alert_ride_offer_use_case.dart';
import 'package:driver/features/ride/domain/use_case/clear_ride_offer_alert_use_case.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_offer_alert.g.dart';

@riverpod
class RideOfferAlert extends _$RideOfferAlert {
  late AlertRideOfferUseCase _alert;
  late ClearRideOfferAlertUseCase _clear;

  @override
  void build() {
    _alert = ref.watch(alertRideOfferUseCaseProvider);
    _clear = ref.watch(clearRideOfferAlertUseCaseProvider);

    final dispose = observeAppReturn(_dismiss);
    if (dispose != null) ref.onDispose(dispose);

    ref.onDispose(_dismiss);

    ref.listen(
      rideControllerProvider.select(_offerIdOf),
      (previous, next) {
        if (next == previous) return;

        final foregrounded = isAppForegrounded;
        debugPrint('🔔 offer=$next foregrounded=$foregrounded');

        if (next == null) {
          _dismiss();
          return;
        }

        // The card is already on screen and counting down; a full-screen
        // intent over it would take the driver away from the accept button.
        if (foregrounded) return;

        unawaited(_raise());
      },
      fireImmediately: true,
    );
  }

  Future<void> _raise() async {
    final result = await _alert.call(_argFor());

    result.when(
      success: (_) => debugPrint('🔔 offer alert posted'),
      failure: (error) {
        debugPrint('🔔 offer alert FAILED → ${errorMessageOf(error)}');
        if (!ref.mounted) return;
        ref
            .read(rideActionControllerProvider.notifier)
            .reportFailure(errorMessageOf(error), StackTrace.current);
      },
    );
  }

  void _dismiss() => unawaited(_clear.call(null));

  RideAlertArg _argFor() {
    final l10n = lookupDriverLocalizations(
      AppLocalizationController.currentLocale,
    );

    return RideAlertArg(
      channelName: l10n.offerChannelName,
      channelDescription: l10n.offerChannelDescription,
      title: l10n.offerAlertTitle,
      body: l10n.offerAlertBody,
    );
  }
}

String? _offerIdOf(DriverRideState state) =>
    state.stage == DriverStage.offerReceived ? state.ride?.rideId : null;
