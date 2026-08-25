import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_contact_actions.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverOnTheWayCard extends ConsumerWidget {
  const DriverOnTheWayCard({
    super.key,
    required this.driver,
    required this.onCancel,
    this.onCall,
    this.onMessage,
    this.etaMinutes,
    this.pickupLabel,
    this.dropoffLabel,
    this.price,
    this.isCancelling = false,
  });

  final DriverProfile driver;
  final VoidCallback onCancel;

  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  final int? etaMinutes;
  final String? pickupLabel;
  final String? dropoffLabel;
  final RidePrice? price;
  final bool isCancelling;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = onCall;
    final message = onMessage;

    return ExpandableRideCard(
      isMapMoving: ref.watch(isCameraMovingProvider),
      summary: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RideStageHeader(
            stage: RideStageVisual.accepted,
            title: etaMinutes != null
                ? context.l10n.captainEtaMinutes(etaMinutes.toString())
                : context.l10n.captainOnWay,
          ),
          SizedBox(height: AppDimens.space16),
          DriverInfoRow(driver: driver),
        ],
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (call != null && message != null) ...[
            DriverContactActions(onCall: call, onMessage: message),
            SizedBox(height: AppDimens.space16),
          ],
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: dropoffLabel,
            price: price,
          ),
        ],
      ),
      footer: AppSecondaryButton(
        label: context.l10n.cancelRequest,
        onPressed: onCancel,
        isLoading: isCancelling,
      ),
    );
  }
}
