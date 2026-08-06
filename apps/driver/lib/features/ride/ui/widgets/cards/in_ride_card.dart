import 'package:driver/features/ride/ui/widgets/cards/navigate_button.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class InRideCard extends StatelessWidget {
  const InRideCard({
    super.key,
    required this.dropoffText,
    required this.onComplete,
    required this.onNavigate,
  });

  final String dropoffText;
  final VoidCallback onComplete;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      primaryLabel: 'إنهاء الرحلة',
      onPrimary: onComplete,
      children: [
        Text('الرحلة جارية', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppDimens.space4),
              child: Icon(
                Icons.circle,
                size: AppDimens.icon18,
                color: AppColor.alertSuccess500,
              ),
            ),
            SizedBox(width: AppDimens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نقطة الوصول',
                    style: AppTextStyles.font12Neutral400Regular,
                  ),
                  Text(
                    dropoffText,
                    style: AppTextStyles.font14Secondary900SemiBold,
                  ),
                ],
              ),
            ),
            SizedBox(width: AppDimens.space12),
            NavigateButton(onPressed: onNavigate),
          ],
        ),
      ],
    );
  }
}
