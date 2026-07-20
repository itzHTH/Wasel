import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/cancel_ride/cancel_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ui/screens/ride_completed_screen.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_arrived_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_on_the_way_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_cancelled_dialog.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_in_progress_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/searching_for_driver_card.dart';

/// Binds [rideControllerProvider] to the pure tracking cards: watches the live
/// [RideStage] and renders the matching card, and drives the two terminal
/// side effects — completion pushes [RideCompletedScreen], cancellation shows
/// [showRideCancelledDialog]. This is the only stateful glue; the cards stay pure.
class RideTrackingCards extends ConsumerWidget {
  const RideTrackingCards({super.key});

  /// Clears the ride so the UI returns to the pickup/dropoff draft.
  void _reset(WidgetRef ref) {
    ref.invalidate(rideControllerProvider);
    ref.invalidate(requestRideControllerProvider);
    ref.read(rideDraftProvider.notifier).reset();
  }

  void _cancelRide(WidgetRef ref) {
    ref.read(cancelRideControllerProvider.notifier).cancelRide();
    final cancelRide = ref.watch(cancelRideControllerProvider);
    if (cancelRide.value?.isCancelled != null ||
        cancelRide.value?.isCancelled != false) {
      _reset(ref);
    }
  }

  void _openCompleted(BuildContext context, WidgetRef ref) {
    final draft = ref.read(rideDraftProvider);
    final fare =
        ref.read(ridePriceEstimateProvider).value?.estimatedPrice ?? '—';
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RideCompletedScreen(
          fare: fare,
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
    // Fire terminal side effects once, on transition into the stage.
    ref.listen(rideControllerProvider.select((s) => s.stage), (prev, next) {
      if (prev == next) return;
      if (next == RideStage.completed) {
        _openCompleted(context, ref);
      } else if (next == RideStage.cancelled) {
        _showCancelled(context, ref);
      }
    });

    final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
    final driverName = ref.watch(
      rideControllerProvider.select((s) => s.driver?.name),
    );

    final Widget card = switch (stage) {
      RideStage.accepted => DriverOnTheWayCard(
        driverName: driverName ?? '',
        onCancel: () => _cancelRide(ref),
      ),
      RideStage.arrived => DriverArrivedCard(
        driverName: driverName ?? '',
        onCancel: () => _cancelRide(ref),
      ),
      RideStage.inProgress || RideStage.completed => RideInProgressCard(
        destinationLabel:
            ref.watch(rideDraftProvider.select((s) => s.dropoffLabel)) ?? '',
      ),
      // The dialog overlays the map; no bottom card underneath it.
      RideStage.cancelled => const SizedBox.shrink(),
      RideStage.idel || RideStage.searching => SearchingForDriverCard(
        onCancel: () => _cancelRide(ref),
      ),
    };

    return card;
  }
}
