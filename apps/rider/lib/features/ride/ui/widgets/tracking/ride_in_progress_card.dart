import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class RideInProgressCard extends ConsumerWidget {
  const RideInProgressCard({
    super.key,
    required this.destinationLabel,
    this.driver,
    this.etaMinutes,
    this.pickupLabel,
    this.price,
  });

  final String destinationLabel;
  final DriverProfile? driver;
  final int? etaMinutes;
  final String? pickupLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final captain = driver;

    return ExpandableRideCard(
      isMapMoving: ref.watch(isCameraMovingProvider),
      summary: RideStageHeader(
        stage: RideStageVisual.inTrip,
        title: context.l10n.haveAGoodTrip,
        subtitle: etaMinutes != null
            ? context.l10n.arrivalEtaMinutes(etaMinutes.toString())
            : null,
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (captain != null) ...[
            DriverInfoRow(driver: captain),
            SizedBox(height: AppDimens.space16),
          ],
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: destinationLabel,
            price: price,
          ),
        ],
      ),
    );
  }
}
