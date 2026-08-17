import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';
import 'package:wasel_core/widgets/app_stat_strip.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';

class DriverProfileInfo extends StatelessWidget {
  const DriverProfileInfo({super.key, required this.profile});

  final DriverProfile? profile;

  @override
  Widget build(BuildContext context) {
    final profile = this.profile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.space16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppProfileAvatar(
                photoUrl: profile?.profilePictureUrl,
                size: 64.r,
              ),
              SizedBox(width: AppDimens.space16),
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
                    ],
                  ],
                ),
              ),
              SizedBox(width: AppDimens.space12),
              ExcludeSemantics(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppDimens.icon18,
                  color: AppColor.neutral400,
                ),
              ),
            ],
          ),
        ),
        if (profile != null) ...[
          const Divider(height: 1, thickness: 1, color: AppColor.neutral200),
          AppStatStrip(
            stats: [
              AppStat(
                icon: Icons.account_balance_wallet_rounded,
                iconColor: AppColor.primary500,
                label: 'الرصيد',
                value: formatAmount(profile.balance),
                valueTextDirection: TextDirection.ltr,
              ),
              AppStat(
                icon: Icons.star_rounded,
                iconColor: AppColor.alertWarning500,
                label: 'التقييم',
                value:
                    '${profile.averageRating.toStringAsFixed(1)} '
                    '(${profile.totalReviews})',
                valueTextDirection: TextDirection.ltr,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
