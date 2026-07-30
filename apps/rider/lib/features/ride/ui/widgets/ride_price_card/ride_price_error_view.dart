import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RidePriceErrorView extends ConsumerWidget {
  const RidePriceErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.font14Secondary500Medium,
        ),
        SizedBox(height: AppDimens.space16),
        SizedBox(
          height: AppDimens.buttonHeight,
          child: ElevatedButton(
            onPressed: () =>
                ref.read(ridePriceEstimateProvider.notifier).getPrice(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary500,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusPill),
              ),
            ),
            child: Text(
              'إعادة المحاولة',
              style: AppTextStyles.font16Neutral0SemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
