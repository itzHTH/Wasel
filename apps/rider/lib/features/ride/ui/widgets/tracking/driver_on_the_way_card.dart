import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_info_row.dart';
import 'package:wasel_core/wasel_core.dart';

/// Shown once a captain has accepted and is heading to the pickup point. Surfaces
/// the driver identity and an ETA, and lets the rider cancel via [onCancel].
class DriverOnTheWayCard extends StatelessWidget {
  const DriverOnTheWayCard({
    super.key,
    required this.driverName,
    required this.onCancel,
    this.plateNumber,
    this.etaMinutes,
    this.rating,
  });

  final String driverName;
  final String? plateNumber;
  final int? etaMinutes;
  final double? rating;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            etaMinutes != null
                ? 'الكابتن يوصل خلال $etaMinutes دقائق'
                : 'الكابتن بالطريق إلك',
            style: AppTextStyles.font20Secondary900Bold,
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
