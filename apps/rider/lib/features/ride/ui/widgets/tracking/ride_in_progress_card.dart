import 'package:flutter/material.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/expandable_ride_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class RideInProgressCard extends StatelessWidget {
  const RideInProgressCard({
    super.key,
    required this.destinationLabel,
    this.driver,
    this.etaMinutes,
    this.pickupLabel,
    this.price,
  });

  final String destinationLabel;
  final DriverProfile? driver;
  final int? etaMinutes;
  final String? pickupLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context) {
    final captain = driver;

    return ExpandableRideCard(
      summary: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimens.space8),
                decoration: BoxDecoration(
                  color: AppColor.primary100,
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                ),
                child: Icon(
                  Icons.navigation_rounded,
                  color: AppColor.primary500,
                  size: AppDimens.icon20,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رحلة موفقة',
                      style: AppTextStyles.font20Secondary900Bold,
                    ),
                    if (etaMinutes != null) ...[
                      SizedBox(height: AppDimens.space4),
                      Text(
                        'الوصول خلال $etaMinutes دقائق تقريباً',
                        style: AppTextStyles.font14Secondary500Medium,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (captain != null) ...[
            DriverInfoRow(driver: captain),
            SizedBox(height: AppDimens.space16),
          ],
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: destinationLabel,
            price: price,
          ),
        ],
      ),
    );
  }
}
