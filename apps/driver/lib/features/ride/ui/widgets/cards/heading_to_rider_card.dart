import 'package:driver/features/ride/ui/widgets/cards/navigate_button.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class HeadingToRiderCard extends StatelessWidget {
  const HeadingToRiderCard({
    super.key,
    required this.pickupText,
    required this.onArrived,
    required this.onCancel,
    required this.onNavigate,
  });

  final String pickupText;
  final VoidCallback onArrived;
  final VoidCallback onCancel;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      primaryLabel: 'وصلت',
      onPrimary: onArrived,
      secondaryLabel: 'إلغاء الرحلة',
      onSecondary: onCancel,
      secondaryStyle: AppTextStyles.font14alertError500SemiBold,
      children: [
        Text('متجه للراكب', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppDimens.space4),
              child: Icon(
                Icons.circle,
                size: AppDimens.icon18,
                color: AppColor.primary500,
              ),
            ),
            SizedBox(width: AppDimens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نقطة الانطلاق',
                    style: AppTextStyles.font12Neutral400Regular,
                  ),
                  Text(
                    pickupText,
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
