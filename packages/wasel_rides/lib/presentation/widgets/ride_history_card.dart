import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_card_details.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_card_header.dart';

/// One past ride. Tapping expands it in place — there is no detail route,
/// because the API exposes neither a ride id nor a detail endpoint yet.
class RideHistoryCard extends StatefulWidget {
  const RideHistoryCard({super.key, required this.entry});

  final RideHistoryEntry entry;

  @override
  State<RideHistoryCard> createState() => _RideHistoryCardState();
}

class _RideHistoryCardState extends State<RideHistoryCard> {
  bool _isExpanded = false;

  void _toggle() {
    HapticFeedback.selectionClick();
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      borderRadius: AppDimens.radius16,
      clipBehavior: Clip.antiAlias,
      onTap: _toggle,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space16,
          vertical: AppDimens.space12,
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RideHistoryCardHeader(
                entry: widget.entry,
                isExpanded: _isExpanded,
              ),
              if (_isExpanded) RideHistoryCardDetails(entry: widget.entry),
            ],
          ),
        ),
      ),
    );
  }
}
