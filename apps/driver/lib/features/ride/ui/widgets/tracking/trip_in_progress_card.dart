import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/rider_profile/current_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/tracking/card_stage_header.dart';
import 'package:driver/features/ride/ui/widgets/expandable_ride_card.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/rider_info_row.dart';
import 'package:driver/features/ride/ui/widgets/trip_points_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class TripInProgressCard extends ConsumerWidget {
  const TripInProgressCard({
    super.key,
    required this.dropoffPoint,
    required this.fare,
    required this.paymentMethod,
    required this.onComplete,
    this.etaMinutes,
  });

  final GeoPoint dropoffPoint;
  final num fare;
  final PaymentMethod paymentMethod;
  final VoidCallback onComplete;
  final int? etaMinutes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentRiderProfileProvider);
    final isBusy = ref.watch(rideActionControllerProvider).isLoading;
    final etaMinutes = this.etaMinutes;

    return ExpandableRideCard(
      summary: CardStageHeader(
        icon: Icons.navigation_rounded,
        title: 'الرحلة جارية',
        subtitle: etaMinutes != null ? 'توصل خلال $etaMinutes دقائق' : null,
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FareHero(amount: fare),
              PaymentMethodChip(method: paymentMethod),
            ],
          ),
          if (profile != null) ...[
            SizedBox(height: AppDimens.space24),
            RiderInfoRow(profile: profile),
          ],
          SizedBox(height: AppDimens.space24),
          TripPointsList(dropoffPoint: dropoffPoint),
        ],
      ),
      footer: AppPrimaryButton(
        label: 'إنهاء الرحلة',
        onPressed: onComplete,
        isLoading: isBusy,
      ),
    );
  }
}
