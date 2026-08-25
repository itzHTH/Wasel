import 'package:driver/features/ride/ui/providers/map/driver_is_camera_moving_provider.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/rider_profile/current_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/rider_info_row.dart';
import 'package:driver/features/ride/ui/widgets/trip_points_list.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class AtPickupCard extends ConsumerWidget {
  const AtPickupCard({
    super.key,
    required this.dropoffPoint,
    required this.fare,
    required this.paymentMethod,
    required this.onStart,
    required this.onCancel,
  });

  final GeoPoint dropoffPoint;
  final num fare;
  final PaymentMethod paymentMethod;
  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentRiderProfileProvider);
    final isBusy = ref.watch(rideActionControllerProvider).isLoading;

    return ExpandableRideCard(
      isMapMoving: ref.watch(driverIsCameraMovingProvider),
      summary: RideStageHeader(
        stage: RideStageVisual.arrived,
        title: context.l10n.arrivedAtPickup,
        subtitle: context.l10n.waitForRiderThenStart,
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (profile != null) ...[
            RiderInfoRow(profile: profile),
            SizedBox(height: AppDimens.space24),
          ],
          TripPointsList(dropoffPoint: dropoffPoint),
          SizedBox(height: AppDimens.space24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FareHero(amount: fare),
              PaymentMethodChip(method: paymentMethod),
            ],
          ),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPrimaryButton(
            label: context.l10n.startRide,
            onPressed: onStart,
            isLoading: isBusy,
          ),
          SizedBox(height: AppDimens.space12),
          AppSecondaryButton(
            label: context.l10n.cancelRide,
            onPressed: isBusy ? null : onCancel,
          ),
        ],
      ),
    );
  }
}
