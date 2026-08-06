import 'package:driver/features/ride/ui/widgets/cards/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCompletedCard extends StatelessWidget {
  const RideCompletedCard({
    super.key,
    required this.priceText,
    required this.onDismiss,
  });

  final String priceText;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      primaryLabel: 'تم',
      onPrimary: onDismiss,
      children: [
        Text('انتهت الرحلة', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space8),
        Text('الأجرة', style: AppTextStyles.font14Neutral400Regular),
        SizedBox(height: AppDimens.space4),
        Text(priceText, style: AppTextStyles.font32Secondary900Bold),
      ],
    );
  }
}
