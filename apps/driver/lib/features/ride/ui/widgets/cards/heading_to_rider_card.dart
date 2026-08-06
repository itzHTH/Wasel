import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class HeadingToRiderCard extends StatelessWidget {
  const HeadingToRiderCard({
    super.key,
    required this.pickupText,
    required this.onArrived,
    required this.onCancel,
  });

  final String pickupText;
  final VoidCallback onArrived;
  final VoidCallback onCancel;

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
                ],
              ),
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onArrived,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'وصلت',
                    style: AppTextStyles.font16Neutral0SemiBold,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space12),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.neutral200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'إلغاء الرحلة',
                    style: AppTextStyles.font14alertError500SemiBold,
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
