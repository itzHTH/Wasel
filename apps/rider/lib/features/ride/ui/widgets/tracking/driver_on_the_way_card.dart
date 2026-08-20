import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/expandable_ride_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_contact_actions.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_trip_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverOnTheWayCard extends StatelessWidget {
  const DriverOnTheWayCard({
    super.key,
    required this.driver,
    required this.onCancel,
    this.onCall,
    this.onMessage,
    this.etaMinutes,
    this.pickupLabel,
    this.dropoffLabel,
    this.price,
  });

  final DriverProfile driver;
  final VoidCallback onCancel;

  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  final int? etaMinutes;
  final String? pickupLabel;
  final String? dropoffLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context) {
    final call = onCall;
    final message = onMessage;

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
                  color: context.colors.primary100,
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                ),
                child: Icon(
                  Icons.directions_car_rounded,
                  color: context.colors.primary500,
                  size: AppDimens.icon20,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Text(
                  etaMinutes != null
                      ? 'الكابتن يوصل خلال $etaMinutes دقائق'
                      : 'الكابتن بالطريق إلك',
                  style: context.styles.font20Secondary900Bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          DriverInfoRow(driver: driver),
        ],
      ),
      details: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (call != null && message != null) ...[
            DriverContactActions(onCall: call, onMessage: message),
            SizedBox(height: AppDimens.space16),
          ],
          RideTripSummary(
            pickupLabel: pickupLabel,
            dropoffLabel: dropoffLabel,
            price: price,
          ),
        ],
      ),
      footer: AppSecondaryButton(label: 'إلغاء الطلب', onPressed: onCancel),
    );
  }
}
