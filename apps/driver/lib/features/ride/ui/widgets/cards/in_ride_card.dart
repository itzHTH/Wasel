import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class InRideCard extends StatelessWidget {
  const InRideCard({
    super.key,
    required this.dropoffText,
    required this.onComplete,
  });

  final String dropoffText;
  final VoidCallback onComplete;

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
                ],
              ),
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'إنهاء الرحلة',
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
