import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';
import 'package:wasel_core/widgets/app_stat_cards.dart';
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
          padding: EdgeInsets.fromLTRB(
            AppDimens.space16,
            AppDimens.space16,
            AppDimens.space16,
            AppDimens.space12,
          ),
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
                      style: context.styles.font20Secondary900Bold,
                    ),
                    if (profile != null) ...[
                      SizedBox(height: AppDimens.space4),
                      Text(
                        profile.phoneNumber,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.styles.font14Secondary500Medium,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (profile != null)
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimens.space16,
              0,
              AppDimens.space16,
              AppDimens.space16,
            ),
            child: AppStatCards(
              stats: [
                AppStat(
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: context.colors.primary500,
                  background: context.colors.primary100,
                  label: 'الرصيد',
                  value: formatAmount(profile.balance),
                  valueTextDirection: TextDirection.ltr,
                ),
                AppStat(
                  icon: Icons.star_rounded,
                  iconColor: context.colors.primary500,
                  background: context.colors.neutral100,
                  label: 'التقييم',
                  value:
                      '${profile.averageRating.toStringAsFixed(1)} '
                      '(${profile.totalReviews})',
                  valueTextDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
