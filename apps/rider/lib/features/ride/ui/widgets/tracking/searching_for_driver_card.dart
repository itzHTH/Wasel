import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class SearchingForDriverCard extends StatelessWidget {
  const SearchingForDriverCard({
    super.key,
    required this.onCancel,
    this.pickupLabel,
    this.dropoffLabel,
    this.price,
    this.isCancelling = false,
  });

  final VoidCallback onCancel;
  final bool isCancelling;
  final String? pickupLabel;
  final String? dropoffLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RideStageHeader(
            stage: RideStageVisual.searching,
            title: context.l10n.searchingForCaptain,
            subtitle: context.l10n.stayOnline,
          ),
          SizedBox(height: AppDimens.space16),
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: dropoffLabel,
            price: price,
          ),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(
            label: context.l10n.cancelRequest,
            onPressed: onCancel,
            isLoading: isCancelling,
          ),
        ],
      ),
    );
  }
}
