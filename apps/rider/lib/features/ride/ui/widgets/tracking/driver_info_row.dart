import 'package:flutter/material.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverInfoRow extends StatelessWidget {
  const DriverInfoRow({super.key, required this.driver});

  final DriverProfile driver;

  @override
  Widget build(BuildContext context) {
    final vehicle = driver.vehicleLabel;
    final plate = driver.plateNumber;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DriverAvatar(photoUrl: driver.photoUrl),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driver.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font20Secondary900Bold,
              ),
              if (vehicle != null) ...[
                SizedBox(height: AppDimens.space4),
                Text(
                  vehicle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Secondary500Medium,
                ),
              ],
            ],
          ),
        ),
        if (plate != null && plate.isNotEmpty) ...[
          SizedBox(width: AppDimens.space8),
          _PlateChip(plateNumber: plate),
        ],
      ],
    );
  }
}

class _DriverAvatar extends StatelessWidget {
  const _DriverAvatar({this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final placeholder = Icon(
      Icons.person_rounded,
      color: AppColor.neutral400,
      size: AppDimens.icon24,
    );

    return Container(
      width: AppDimens.icon48,
      height: AppDimens.icon48,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColor.neutral100,
        shape: BoxShape.circle,
      ),
      child: photoUrl == null || photoUrl!.isEmpty
          ? placeholder
          : Image.network(
              photoUrl!,
              fit: BoxFit.cover,

              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }
}

class _PlateChip extends StatelessWidget {
  const _PlateChip({required this.plateNumber});

  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space8,
      ),
      decoration: BoxDecoration(
        color: AppColor.secondary900,
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      child: Text(
        plateNumber,
        textDirection: TextDirection.ltr,
        style: AppTextStyles.font16Neutral0SemiBold,
      ),
    );
  }
}
