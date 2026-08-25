import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_chip.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/wasel_core.dart';

class TripCompletedCard extends StatelessWidget {
  const TripCompletedCard({
    super.key,
    required this.fare,
    required this.paymentMethod,
    required this.onDismiss,
  });

  final num fare;
  final PaymentMethod paymentMethod;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: RideStageBadge(
              stage: RideStageVisual.completed,
              size: AppDimens.icon48,
            ),
          ),
          SizedBox(height: AppDimens.space16),
          Center(
            child: Text(
              context.l10n.rideFinished,
              style: context.styles.title(),
            ),
          ),
          SizedBox(height: AppDimens.space4),
          Center(
            child: Text(
              context.l10n.collectFareFromRider,
              style: context.styles.bodyMuted(),
            ),
          ),
          SizedBox(height: AppDimens.space24),
          Center(
            child: FareHero(
              amount: fare,
              color: context.colors.alertSuccess500,
            ),
          ),
          SizedBox(height: AppDimens.space12),
          Center(child: PaymentMethodChip(method: paymentMethod)),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(
            label: context.l10n.backToRequests,
            onPressed: onDismiss,
          ),
        ],
      ),
    );
  }
}
