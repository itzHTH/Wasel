import 'package:driver/features/ride/ui/widgets/cards/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class ArrivedCard extends StatelessWidget {
  const ArrivedCard({super.key, required this.onStart, required this.onCancel});

  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      primaryLabel: 'بدء الرحلة',
      onPrimary: onStart,
      secondaryLabel: 'إلغاء الرحلة',
      onSecondary: onCancel,
      secondaryStyle: AppTextStyles.font14alertError500SemiBold,
      children: [
        Text('بانتظار الراكب', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space8),
        Text(
          'وصلت لنقطة الانطلاق',
          style: AppTextStyles.font14Neutral400Regular,
        ),
      ],
    );
  }
}
