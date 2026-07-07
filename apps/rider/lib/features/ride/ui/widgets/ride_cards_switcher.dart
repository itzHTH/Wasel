import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_draft_card.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_card.dart';

class RideCardsSwitcher extends StatefulWidget {
  const RideCardsSwitcher({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  State<RideCardsSwitcher> createState() => _RideCardsSwitcherState();
}

class _RideCardsSwitcherState extends State<RideCardsSwitcher> {
  bool _showPrice = false;

  @override
  Widget build(BuildContext context) {
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
