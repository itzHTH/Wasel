import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasel_core/wasel_core.dart';

/// Shown while the ride is underway toward the destination. No cancel action —
/// the trip has already started.
class RideInProgressCard extends StatelessWidget {
  const RideInProgressCard({
    super.key,
    required this.destinationLabel,
    this.etaMinutes,
  });

  final String destinationLabel;
  final int? etaMinutes;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('رحلة موفقة', style: AppTextStyles.font20Secondary900Bold),
          SizedBox(height: AppDimens.space16),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: AppColor.primary500,
                size: AppDimens.icon24,
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Text(
                  destinationLabel,
                  style: AppTextStyles.font14Secondary900SemiBold,
                ),
              ),
            ],
          ),
          if (etaMinutes != null) ...[
            SizedBox(height: AppDimens.space8),
            Text(
              'الوصول خلال $etaMinutes دقائق تقريباً',
              style: AppTextStyles.font14Secondary500Medium,
            ),
          ],
        ],
      ),
    );
  }
}
