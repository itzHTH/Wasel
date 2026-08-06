import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/cards/arrived_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/heading_to_rider_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/in_ride_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_completed_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverCardsSwitcher extends ConsumerWidget {
  const DriverCardsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(
      rideControllerProvider.select((state) => state.stage),
    );
    final ride = ref.watch(
      rideControllerProvider.select((state) => state.ride),
    );
    final controller = ref.read(rideControllerProvider.notifier);

    return switch ((stage, ride)) {
      (DriverStage.offerReceived, final ReceiveRideRequest offer) =>
        RideOfferCard(
          pickupText: _coordinates(offer.position),
          dropoffText: _coordinates(offer.dropPosition),
          priceText: _price(offer.calculatedPrice),
          paymentText: offer.paymentMethod,
          onAccept: controller.acceptOffer,
          onReject: controller.rejectOffer,
        ),
      (DriverStage.heading, final ReceiveRideRequest offer) =>
        HeadingToRiderCard(
          pickupText: _coordinates(offer.position),
          onArrived: controller.markArrived,
          onCancel: controller.cancelRide,
        ),
      (DriverStage.arrived, _) => ArrivedCard(
        onStart: controller.startRide,
        onCancel: controller.cancelRide,
      ),
      (DriverStage.inProgress, final ReceiveRideRequest offer) => InRideCard(
        dropoffText: _coordinates(offer.dropPosition),
        onComplete: controller.completeRide,
      ),
      (DriverStage.completed, final ReceiveRideRequest offer) =>
        RideCompletedCard(
          priceText: _price(offer.calculatedPrice),
          onDismiss: controller.dismissCompleted,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

String _coordinates(GeoPoint point) =>
    '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';

String _price(double value) => '${value.toStringAsFixed(0)} د.ع';
