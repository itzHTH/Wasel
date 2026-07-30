import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/ui/providers/cancel_ride/cancel_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ui/screens/ride_completed_screen.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_transition.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_arrived_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_on_the_way_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_cancelled_dialog.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_in_progress_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/searching_for_driver_card.dart';
import 'package:wasel_core/wasel_core.dart';

class RideTrackingCards extends ConsumerWidget {
  const RideTrackingCards({super.key});

  void _reset(WidgetRef ref) {
    ref.invalidate(rideControllerProvider);
    ref.invalidate(requestRideControllerProvider);

    ref.invalidate(cancelRideControllerProvider);

    ref.invalidate(ridePriceEstimateProvider);
    ref.read(rideDraftProvider.notifier).reset();
  }

  void _cancelRide(WidgetRef ref) {
    ref.read(cancelRideControllerProvider.notifier).cancelRide();
  }

  void _openCompleted(BuildContext context, WidgetRef ref) {
    final draft = ref.read(rideDraftProvider);
    final price = ref.read(ridePriceEstimateProvider).value;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RideCompletedScreen(
          fare: price == null
              ? '—'
              : RideFormatters.fare(
                  price.estimatedPrice,
                  currency: price.currency,
                ),
          pickupLabel: draft.pickupLabel ?? '',
          dropoffLabel: draft.dropoffLabel ?? '',
          onRatingChanged: (_) {},
          onDone: () {
            Navigator.of(context).pop();
            _reset(ref);
          },
        ),
      ),
    );
  }

  void _showCancelled(BuildContext context, WidgetRef ref) {
    final reason =
        ref.read(rideControllerProvider.select((s) => s.error)) ??
        'اعتذر الكابتن عن الرحلة، جرب مرة ثانية';
    showRideCancelledDialog(
      context,
      reason: reason,
      onDismiss: () => _reset(ref),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(rideControllerProvider.select((s) => s.stage), (prev, next) {
      if (prev == next) return;
      if (next == RideStage.completed) {
        _openCompleted(context, ref);
      } else if (next == RideStage.cancelled) {
        _showCancelled(context, ref);
      }
    });

    ref.listen(cancelRideControllerProvider, (previous, next) {
      if (next.value?.isCancelled == true) _reset(ref);
    });

    final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
    final driver = ref.watch(rideControllerProvider.select((s) => s.driver));
    final labels = ref.watch(
      rideDraftProvider.select((s) => (s.pickupLabel, s.dropoffLabel)),
    );
    final price = ref.watch(ridePriceEstimateProvider).value;

    final captain = driver ?? DriverProfile(id: '', name: '');

    final phone = driver?.canBeContacted == true ? driver!.phoneNumber! : null;
    VoidCallback? contact(String scheme) =>
        phone == null ? null : () => AppUrlLauncher.launch('$scheme:$phone');

    final Widget card = switch (stage) {
      RideStage.accepted => DriverOnTheWayCard(
        driver: captain,
        onCancel: () => _cancelRide(ref),
        onCall: contact('tel'),
        onMessage: contact('sms'),
        pickupLabel: labels.$1,
        dropoffLabel: labels.$2,
        price: price,
      ),
      RideStage.arrived => DriverArrivedCard(
        driver: captain,
        onCancel: () => _cancelRide(ref),
        onCall: contact('tel'),
        onMessage: contact('sms'),
        pickupLabel: labels.$1,
        dropoffLabel: labels.$2,
        price: price,
      ),
      RideStage.inProgress || RideStage.completed => RideInProgressCard(
        destinationLabel: labels.$2 ?? '',
        driver: driver,
        pickupLabel: labels.$1,
        price: price,
      ),

      RideStage.cancelled => const SizedBox.shrink(),
      RideStage.idel || RideStage.searching => SearchingForDriverCard(
        onCancel: () => _cancelRide(ref),
        pickupLabel: labels.$1,
        dropoffLabel: labels.$2,
        price: price,
      ),
    };

    return RideCardTransition(
      child: KeyedSubtree(key: ValueKey(stage), child: card),
    );
  }
}
