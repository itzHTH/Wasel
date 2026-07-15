import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasel_core/wasel_core.dart';

/// Shown when the captain has reached the pickup point. Deliberately the most
/// prominent card in the flow — a tinted banner tells the rider to get in.
class DriverArrivedCard extends StatelessWidget {
  const DriverArrivedCard({
    super.key,
    required this.driverName,
    required this.onCancel,
    this.plateNumber,
    this.rating,
  });

  final String driverName;
  final String? plateNumber;
  final double? rating;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.space16,
              horizontal: AppDimens.space16,
            ),
            decoration: BoxDecoration(
              color: AppColor.primary100,
              borderRadius: BorderRadius.circular(AppDimens.radius16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.directions_car_rounded,
                  color: AppColor.primary500,
                  size: AppDimens.icon24,
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Text(
                    'الكابتن وصل — طلع له',
                    style: AppTextStyles.font20Secondary900Bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space16),
          DriverInfoRow(
            driverName: driverName,
            plateNumber: plateNumber,
            rating: rating,
          ),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(label: 'إلغاء الطلب', onPressed: onCancel),
        ],
      ),
    );
  }
}
