import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/tracking/at_pickup_card.dart';
import 'package:driver/features/ride/ui/widgets/incoming_offer/incoming_offer_card.dart';
import 'package:driver/features/ride/ui/widgets/offline/offline_card.dart';
import 'package:driver/features/ride/ui/widgets/tracking/pickup_on_the_way_card.dart';
import 'package:driver/features/ride/ui/widgets/searching/searching_card.dart';
import 'package:driver/features/ride/ui/widgets/ride_completed/trip_completed_card.dart';
import 'package:driver/features/ride/ui/widgets/tracking/trip_in_progress_card.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Picks the card for the current ride stage and cross-fades between them.
///
/// Branches still pointing at the pre-rebuild cards are migrated one stage at
/// a time; each migration also deletes the card it replaces.
class DriverRideCardsSwitcher extends ConsumerWidget {
  const DriverRideCardsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(
      rideControllerProvider.select((state) => state.stage),
    );
    final ride = ref.watch(
      rideControllerProvider.select((state) => state.ride),
    );
    final secondsLeft = ref.watch(
      rideControllerProvider.select((state) => state.secondsLeft),
    );
    final controller = ref.read(rideControllerProvider.notifier);

    final card = switch ((stage, ride)) {
      (DriverStage.offline, _) => OfflineCard(
        key: const ValueKey('offline'),
        onGoOnline: controller.goOnline,
      ),
      (DriverStage.online, _) => SearchingCard(
        key: const ValueKey('searching'),
        onGoOffline: controller.goOffline,
      ),
      (DriverStage.offerReceived, final ReceiveRideRequest offer) =>
        IncomingOfferCard(
          key: const ValueKey('offer'),
          fare: offer.calculatedPrice,
          paymentMethod: PaymentMethod.fromApi(offer.paymentMethod),
          pickupPoint: offer.position,
          dropoffPoint: offer.dropPosition,
          total: const Duration(seconds: RideController.offerSeconds),
          remaining: Duration(seconds: secondsLeft),
          onAccept: controller.acceptOffer,
          onDismiss: controller.rejectOffer,
        ),
      (DriverStage.heading, final ReceiveRideRequest offer) =>
        PickupOnTheWayCard(
          key: const ValueKey('heading'),
          pickupPoint: offer.position,
          dropoffPoint: offer.dropPosition,
          fare: offer.calculatedPrice,
          paymentMethod: PaymentMethod.fromApi(offer.paymentMethod),
          onArrived: controller.markArrived,
          onCancel: controller.cancelRide,
        ),
      (DriverStage.arrived, final ReceiveRideRequest offer) => AtPickupCard(
        key: const ValueKey('arrived'),
        dropoffPoint: offer.dropPosition,
        fare: offer.calculatedPrice,
        paymentMethod: PaymentMethod.fromApi(offer.paymentMethod),
        onStart: controller.startRide,
        onCancel: controller.cancelRide,
      ),
      (DriverStage.inProgress, final ReceiveRideRequest offer) =>
        TripInProgressCard(
          key: const ValueKey('inProgress'),
          dropoffPoint: offer.dropPosition,
          fare: offer.calculatedPrice,
          paymentMethod: PaymentMethod.fromApi(offer.paymentMethod),
          onComplete: controller.completeRide,
        ),
      (DriverStage.completed, final ReceiveRideRequest offer) =>
        TripCompletedCard(
          key: const ValueKey('completed'),
          fare: offer.calculatedPrice,
          paymentMethod: PaymentMethod.fromApi(offer.paymentMethod),
          onDismiss: controller.dismissCompleted,
        ),
      _ => const SizedBox.shrink(key: ValueKey('none')),
    };

    return RideCardTransition(child: card);
  }
}
