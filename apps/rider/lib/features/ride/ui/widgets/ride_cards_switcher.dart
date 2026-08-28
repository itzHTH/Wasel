import 'package:wasel_core/wasel_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_draft_card.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_card.dart';
import 'package:wasal/features/ride/ui/widgets/ride_recovery_error_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_tracking_cards.dart';

class RideCardsSwitcher extends ConsumerStatefulWidget {
  const RideCardsSwitcher({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  ConsumerState<RideCardsSwitcher> createState() => _RideCardsSwitcherState();
}

class _RideCardsSwitcherState extends ConsumerState<RideCardsSwitcher> {
  bool _showPrice = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(rideControllerProvider.select((s) => s.hasActiveRide), (
      previous,
      next,
    ) {
      if (next && _showPrice) setState(() => _showPrice = false);
    });

    final recoveryError = ref.watch(
      rideControllerProvider.select((s) => s.recoveryError),
    );
    if (recoveryError != null) {
      return RideCardTransition(
        child: RideRecoveryErrorCard(
          key: const ValueKey('recoveryError'),
          message: recoveryError,
        ),
      );
    }

    final isRecovering = ref.watch(
      rideControllerProvider.select((s) => s.isRecovering),
    );
    if (isRecovering) {
      return const RideCardTransition(
        child: SizedBox.shrink(key: ValueKey('recovering')),
      );
    }

    final hasActiveRide = ref.watch(
      rideControllerProvider.select((s) => s.hasActiveRide),
    );

    final Widget card = hasActiveRide
        ? const RideTrackingCards(key: ValueKey('tracking'))
        : _showPrice
        ? RidePriceCard(
            key: const ValueKey('price'),
            onClose: () => setState(() => _showPrice = false),
          )
        : RideDraftCard(
            key: const ValueKey('draft'),
            onConfirm: widget.onConfirm,
            onRequestPrice: () => setState(() => _showPrice = true),
          );

    return RideCardTransition(child: card);
  }
}
