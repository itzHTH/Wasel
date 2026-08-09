import 'package:driver/core/widgets/app_primary_button.dart';
import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/rider_profile/static_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:driver/features/ride/ui/widgets/incoming_offer/offer_countdown_ring.dart';
import 'package:driver/features/ride/ui/widgets/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:driver/features/ride/ui/widgets/rider_info_row.dart';
import 'package:driver/features/ride/ui/widgets/trip_points_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class IncomingOfferCard extends ConsumerWidget {
  const IncomingOfferCard({
    super.key,
    required this.fare,
    required this.paymentMethod,
    required this.pickupPoint,
    required this.dropoffPoint,
    required this.total,
    required this.remaining,
    required this.onAccept,
    required this.onDismiss,
  });

  final num fare;
  final PaymentMethod paymentMethod;
  final GeoPoint pickupPoint;
  final GeoPoint dropoffPoint;
  final Duration total;
  final Duration remaining;
  final VoidCallback onAccept;
  final VoidCallback onDismiss;

  /// Share of the screen the scrollable middle may take before it scrolls,
  /// so a long note from the rider can never push the buttons off-screen.
  static const _maxDetailsFraction = 0.34;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(staticRiderProfileProvider);
    final isBusy = ref.watch(rideActionControllerProvider).isLoading;
    final maxDetailsHeight =
        MediaQuery.sizeOf(context).height * _maxDetailsFraction;

    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'وصلك طلب جديد',
                      style: AppTextStyles.font14Neutral400Regular,
                    ),
                    SizedBox(height: AppDimens.space4),
                    FareHero(amount: fare),
                  ],
                ),
              ),
              OfferCountdownRing(total: total, remaining: remaining),
            ],
          ),
          SizedBox(height: AppDimens.space12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: PaymentMethodChip(method: paymentMethod),
          ),
          SizedBox(height: AppDimens.space24),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxDetailsHeight),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TripPointsList(
                    pickupPoint: pickupPoint,
                    dropoffPoint: dropoffPoint,
                  ),
                  SizedBox(height: AppDimens.space24),
                  RiderInfoRow(profile: profile),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(
            label: 'قبول الطلب',
            onPressed: onAccept,
            isLoading: isBusy,
          ),
          SizedBox(height: AppDimens.space12),
          AppSecondaryButton(
            label: 'تجاهل',
            onPressed: isBusy ? null : onDismiss,
          ),
        ],
      ),
    );
  }
}

