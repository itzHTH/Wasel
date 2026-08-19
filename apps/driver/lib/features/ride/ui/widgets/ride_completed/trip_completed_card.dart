import 'package:driver/core/widgets/app_primary_button.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:driver/features/ride/ui/widgets/ride_completed/completed_check_badge.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_chip.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:flutter/material.dart';
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
          const Center(child: CompletedCheckBadge()),
          SizedBox(height: AppDimens.space16),
          Center(
            child: Text(
              'خلصت الرحلة',
              style: AppTextStyles.font20Secondary900Bold,
            ),
          ),
          SizedBox(height: AppDimens.space4),
          Center(
            child: Text(
              'اجمع الأجرة من الراكب',
              style: AppTextStyles.font14Neutral400Regular,
            ),
          ),
          SizedBox(height: AppDimens.space24),
          Center(
            child: FareHero(amount: fare, color: AppColor.alertSuccess500),
          ),
          SizedBox(height: AppDimens.space12),
          Center(child: PaymentMethodChip(method: paymentMethod)),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(label: 'رجوع للطلبات', onPressed: onDismiss),
        ],
      ),
    );
  }
}
