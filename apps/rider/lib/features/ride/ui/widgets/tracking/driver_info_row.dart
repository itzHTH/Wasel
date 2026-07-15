import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// Identifies the driver and vehicle so the rider can spot the car: an avatar,
/// the driver name and plate number, and an optional rating badge. Shared by the
/// "on the way" and "arrived" cards.
class DriverInfoRow extends StatelessWidget {
  const DriverInfoRow({
    super.key,
    required this.driverName,
    required this.plateNumber,
    this.rating,
  });

  final String driverName;
  final String? plateNumber;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppDimens.icon48,
          height: AppDimens.icon48,
          decoration: const BoxDecoration(
            color: AppColor.neutral100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_rounded,
            color: AppColor.neutral400,
            size: AppDimens.icon24,
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driverName, style: AppTextStyles.font20Secondary900Bold),
              if (plateNumber != null && plateNumber!.isNotEmpty) ...[
                SizedBox(height: AppDimens.space4),
                Text(
                  plateNumber!,
                  style: AppTextStyles.font14Secondary500Medium,
                ),
              ],
            ],
          ),
        ),
        if (rating != null) ...[
          SizedBox(width: AppDimens.space8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColor.alertWarning500,
                size: AppDimens.icon20,
              ),
              SizedBox(width: AppDimens.space4),
              Text(
                rating!.toStringAsFixed(1),
                style: AppTextStyles.font14Secondary900SemiBold,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
