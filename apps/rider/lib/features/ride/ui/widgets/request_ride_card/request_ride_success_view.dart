import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestRideSuccessView extends StatelessWidget {
  const RequestRideSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimens.icon48,
          height: AppDimens.icon48,
          decoration: const BoxDecoration(
            color: AppColor.alertSuccess100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: AppColor.alertSuccess500,
            size: AppDimens.icon24,
          ),
        ),
        SizedBox(height: AppDimens.space12),
        Text('تم إرسال الطلب', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space8),
        Text(
          'جاري البحث عن سائق...',
          style: AppTextStyles.font14Secondary500Medium,
        ),
      ],
    );
  }
}
