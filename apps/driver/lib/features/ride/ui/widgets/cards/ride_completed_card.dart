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
              Text('انتهت الرحلة', style: AppTextStyles.font20Secondary900Bold),
              SizedBox(height: AppDimens.space8),
              Text('الأجرة', style: AppTextStyles.font14Neutral400Regular),
              SizedBox(height: AppDimens.space4),
              Text(priceText, style: AppTextStyles.font32Secondary900Bold),
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onDismiss,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'تم',
                    style: AppTextStyles.font16Neutral0SemiBold,
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
