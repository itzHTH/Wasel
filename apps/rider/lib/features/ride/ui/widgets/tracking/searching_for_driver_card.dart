import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class SearchingForDriverCard extends StatelessWidget {
  const SearchingForDriverCard({
    super.key,
    required this.onCancel,
    this.pickupLabel,
    this.dropoffLabel,
    this.price,
  });

  final VoidCallback onCancel;
  final String? pickupLabel;
  final String? dropoffLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: AppDimens.icon24,
                height: AppDimens.icon24,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColor.primary500,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نبحث عن كابتن قريب...',
                      style: AppTextStyles.font20Secondary900Bold,
                    ),
                    SizedBox(height: AppDimens.space4),
                    Text(
                      'خليك على الخط، راح نلگه لك كابتن بأسرع وقت',
                      style: AppTextStyles.font14Secondary500Medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: dropoffLabel,
            price: price,
          ),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(label: 'إلغاء الطلب', onPressed: onCancel),
        ],
      ),
    );
  }
}
