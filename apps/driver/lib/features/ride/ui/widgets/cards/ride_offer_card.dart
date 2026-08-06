import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideOfferCard extends StatelessWidget {
  const RideOfferCard({
    super.key,
    required this.pickupText,
    required this.dropoffText,
    required this.priceText,
    required this.paymentText,
    required this.onAccept,
    required this.onReject,
  });

  final String pickupText;
  final String dropoffText;
  final String priceText;
  final String paymentText;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.elementBackground,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(AppDimens.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(priceText, style: AppTextStyles.font24Secondary900Bold),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.space12,
                      vertical: AppDimens.space4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary100,
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                    child: Text(
                      paymentText,
                      style: AppTextStyles.font14Primary500SemiBold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space24),
              _OfferPoint(
                color: AppColor.primary500,
                label: 'نقطة الانطلاق',
                value: pickupText,
              ),
              SizedBox(height: AppDimens.space16),
              _OfferPoint(
                color: AppColor.alertSuccess500,
                label: 'نقطة الوصول',
                value: dropoffText,
              ),
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'قبول الطلب',
                    style: AppTextStyles.font16Neutral0SemiBold,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space12),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.neutral200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'رفض',
                    style: AppTextStyles.font14Secondary500Medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferPoint extends StatelessWidget {
  const _OfferPoint({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppDimens.space4),
          child: Icon(Icons.circle, size: AppDimens.icon18, color: color),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.font12Neutral400Regular),
              Text(value, style: AppTextStyles.font14Secondary900SemiBold),
            ],
          ),
        ),
      ],
    );
  }
}
