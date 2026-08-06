import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/navigation_handoff_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/cards/arrived_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/heading_to_rider_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/in_ride_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_completed_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_offer_card.dart';
import 'package:driver/features/ride/ui/widgets/navigation_chooser_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

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
    final secondsLeft = ref.watch(
      rideControllerProvider.select((state) => state.secondsLeft),
    );
    final controller = ref.read(rideControllerProvider.notifier);

    return switch ((stage, ride)) {
      (DriverStage.offerReceived, final ReceiveRideRequest offer) =>
        RideOfferCard(
          pickupText: _coordinates(offer.position),
          dropoffText: _coordinates(offer.dropPosition),
          priceText: _price(offer.calculatedPrice),
          paymentText: offer.paymentMethod,
          secondsLeft: secondsLeft,
          onAccept: controller.acceptOffer,
          onReject: controller.rejectOffer,
        ),
      (DriverStage.heading, final ReceiveRideRequest offer) =>
        HeadingToRiderCard(
          pickupText: _coordinates(offer.position),
          onArrived: controller.markArrived,
          onCancel: controller.cancelRide,
          onNavigate: () => _navigateTo(context, ref, offer.position),
        ),
      (DriverStage.arrived, _) => ArrivedCard(
        onStart: controller.startRide,
        onCancel: controller.cancelRide,
      ),
      (DriverStage.inProgress, final ReceiveRideRequest offer) => InRideCard(
        dropoffText: _coordinates(offer.dropPosition),
        onComplete: controller.completeRide,
        onNavigate: () => _navigateTo(context, ref, offer.dropPosition),
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

Future<void> _navigateTo(
  BuildContext context,
  WidgetRef ref,
  GeoPoint point,
) async {
  final apps = await ref.read(navigationHandoffProvider.future);
  if (!context.mounted) return;

  final choice = await showModalBottomSheet<NavigationApp>(
    context: context,
    backgroundColor: AppColor.elementBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (sheetContext) => NavigationChooserSheet(
      apps: apps,
      onSelect: (app) => Navigator.of(sheetContext).pop(app),
    ),
  );

  if (choice == null) return;

  await ref
      .read(navigationHandoffProvider.notifier)
      .open(choice, point.latitude, point.longitude);
}

String _coordinates(GeoPoint point) =>
    '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';

String _price(double value) => '${value.toStringAsFixed(0)} د.ع';
