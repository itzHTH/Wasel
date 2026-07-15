import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_draft_card.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_card.dart';
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
    // Once the ride request is sent, hand off to the live ride-tracking cards.
    final requestSent = ref.watch(
      requestRideControllerProvider.select((s) => s.value != null),
    );
    if (requestSent) {
      return const RideTrackingCards();
    }

    if (_showPrice) {
      return RidePriceCard(
        onClose: () => setState(() => _showPrice = false),
      );
    }
    return RideDraftCard(
      onConfirm: widget.onConfirm,
      onRequestPrice: () => setState(() => _showPrice = true),
    );
  }
}
