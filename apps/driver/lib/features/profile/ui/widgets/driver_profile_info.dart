import 'package:driver/features/profile/ui/widgets/driver_rating_chip.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';

class DriverProfileInfo extends StatelessWidget {
  const DriverProfileInfo({super.key, required this.profile});

  final DriverProfile? profile;

  @override
  Widget build(BuildContext context) {
    final profile = this.profile;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppProfileAvatar(photoUrl: profile?.profilePictureUrl),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profile?.fullName.isNotEmpty == true
                    ? profile!.fullName
                    : 'سائق وَصَل',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font20Secondary900Bold,
              ),
              if (profile != null) ...[
                SizedBox(height: AppDimens.space4),
                Text(
                  profile.phoneNumber,
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Secondary500Medium,
                ),
                SizedBox(height: AppDimens.space8),
                DriverRatingChip(
                  averageRating: profile.averageRating,
                  totalReviews: profile.totalReviews,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
