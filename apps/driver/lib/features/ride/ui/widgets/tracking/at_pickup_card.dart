import 'package:driver/core/widgets/app_primary_button.dart';
import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/rider_profile/current_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/tracking/card_stage_header.dart';
import 'package:driver/features/ride/ui/widgets/expandable_ride_card.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:driver/features/ride/ui/widgets/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/rider_info_row.dart';
import 'package:driver/features/ride/ui/widgets/trip_points_list.dart';
import 'package:flutter/material.dart';
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
      summary: const CardStageHeader(
        icon: Icons.check_circle_outline_rounded,
        title: 'وصلت لنقطة الانطلاق',
        subtitle: 'انتظر الراكب يركب وبعدين ابدأ الرحلة',
        tint: AppColor.alertSuccess500,
        background: AppColor.alertSuccess100,
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
            label: 'ابدأ الرحلة',
            onPressed: onStart,
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
