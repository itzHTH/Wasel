import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class ArrivedCard extends StatelessWidget {
  const ArrivedCard({super.key, required this.onStart, required this.onCancel});

  final VoidCallback onStart;
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
              Text(
                'بانتظار الراكب',
                style: AppTextStyles.font20Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space8),
              Text(
                'وصلت لنقطة الانطلاق',
                style: AppTextStyles.font14Neutral400Regular,
              ),
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    'بدء الرحلة',
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
