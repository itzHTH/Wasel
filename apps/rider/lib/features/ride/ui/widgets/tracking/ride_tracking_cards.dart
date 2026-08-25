import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/ui/providers/cancel_ride/cancel_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/review_ride/review_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/selected_payment_method_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ui/screens/ride_completed_screen.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_arrived_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_on_the_way_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_cancelled_dialog.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_in_progress_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/searching_for_driver_card.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_payments/presentation/providers/tokenize/tokenize_card_provider.dart';
import 'package:wasel_payments/presentation/providers/wallet/rider_wallet_balance_provider.dart';

class RideTrackingCards extends ConsumerWidget {
  const RideTrackingCards({super.key});

  void _reset(WidgetRef ref) {
    ref.invalidate(rideControllerProvider);
    ref.invalidate(requestRideControllerProvider);

    ref.invalidate(cancelRideControllerProvider);

    ref.invalidate(ridePriceEstimateProvider);
    ref.invalidate(selectedPaymentMethodProvider);
    ref.invalidate(tokenizeCardControllerProvider);
    ref.invalidate(riderWalletBalanceControllerProvider);
    ref.read(rideDraftProvider.notifier).reset();
  }

  void _cancelRide(WidgetRef ref) {
    ref.read(cancelRideControllerProvider.notifier).cancelRide();
  }

  void _openCompleted(BuildContext context, WidgetRef ref) {
    final draft = ref.read(rideDraftProvider);
    final price = ref.read(ridePriceEstimateProvider).value;
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (routeContext) => Consumer(
              builder: (consumerContext, routeRef, _) {
                final review = routeRef.watch(reviewRideControllerProvider);

                routeRef.listen(reviewRideControllerProvider, (previous, next) {
                  if (next.hasError) {
                    ScaffoldMessenger.of(consumerContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          next.error?.toString() ??
                              context.coreL10n.genericError,
                        ),
                      ),
                    );
                    return;
                  }
                  if (next.value?.isReviewed == true) _close(routeContext);
                });

                return RideCompletedScreen(
                  fare: price == null
                      ? '—'
                      : RideFormatters.fare(
                          context.l10n,
                          price.estimatedPrice,
                          currency: price.currency,
                        ),
                  pickupLabel: draft.pickupLabel ?? '',
                  dropoffLabel: draft.dropoffLabel ?? '',
                  isSubmitting: review.isLoading,
                  onDone: (rating, comment) {
                    if (rating == 0) {
                      _close(routeContext);
                      return;
                    }
                    routeRef
                        .read(reviewRideControllerProvider.notifier)
                        .submit(rating: rating, comment: comment);
                  },
                );
              },
            ),
          ),
        )
        .then((_) {
          if (context.mounted) _reset(ref);
        });
  }

  void _close(BuildContext routeContext) => Navigator.of(routeContext).pop();

  void _showCancelled(BuildContext context, WidgetRef ref) {
    final reason =
        ref.read(rideControllerProvider.select((s) => s.error)) ??
        context.l10n.captainDeclined;
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
      if (next.value?.isCancelled == true) {
        _reset(ref);
        return;
      }
      // Without this the card keeps its searching radar spinning and the rider
      // is left tapping a button that looks broken.
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error?.toString() ?? context.coreL10n.genericError,
            ),
          ),
        );
      }
    });

    final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
    final isCancelling = ref.watch(
      cancelRideControllerProvider.select((s) => s.isLoading),
    );
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
        isCancelling: isCancelling,
      ),
      RideStage.arrived => DriverArrivedCard(
        driver: captain,
        onCancel: () => _cancelRide(ref),
        onCall: contact('tel'),
        onMessage: contact('sms'),
        pickupLabel: labels.$1,
        dropoffLabel: labels.$2,
        price: price,
        isCancelling: isCancelling,
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
        isCancelling: isCancelling,
      ),
    };

    return RideCardTransition(
      child: KeyedSubtree(key: ValueKey(stage), child: card),
    );
  }
}
