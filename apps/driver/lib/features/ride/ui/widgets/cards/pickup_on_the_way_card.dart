import 'package:driver/core/widgets/app_primary_button.dart';
import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/static_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/cards/card_stage_header.dart';
import 'package:driver/features/ride/ui/widgets/expandable_ride_card.dart';
import 'package:driver/features/ride/ui/widgets/cards/fare_hero.dart';
import 'package:driver/features/ride/ui/widgets/cards/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/cards/rider_info_row.dart';
import 'package:driver/features/ride/ui/widgets/cards/trip_points_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class PickupOnTheWayCard extends ConsumerWidget {
  const PickupOnTheWayCard({
    super.key,
    required this.pickupLabel,
    required this.dropoffLabel,
    required this.fare,
    required this.paymentMethod,
    required this.onArrived,
    required this.onCancel,
    this.etaMinutes,
  });

  final String pickupLabel;
  final String dropoffLabel;
  final num fare;
  final PaymentMethod paymentMethod;
  final VoidCallback onArrived;
  final VoidCallback onCancel;
  final int? etaMinutes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(staticRiderProfileProvider);
    final isBusy = ref.watch(rideActionControllerProvider).isLoading;
    final etaMinutes = this.etaMinutes;

    return ExpandableRideCard(
      summary: CardStageHeader(
        icon: Icons.directions_car_rounded,
        title: 'بالطريق لنقطة الانطلاق',
        subtitle: etaMinutes != null ? 'توصل خلال $etaMinutes دقائق' : null,
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TripPointsList(
            pickupLabel: pickupLabel,
            dropoffLabel: dropoffLabel,
          ),
          SizedBox(height: AppDimens.space24),
          RiderInfoRow(profile: profile),
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
            label: 'وصلت',
            onPressed: onArrived,
            isLoading: isBusy,
          ),
          SizedBox(height: AppDimens.space12),
          AppSecondaryButton(
            label: 'إلغاء الرحلة',
            onPressed: isBusy ? null : onCancel,
          ),
        ],
      ),
    );
  }
}
