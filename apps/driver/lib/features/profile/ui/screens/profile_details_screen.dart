import 'package:driver/features/profile/ui/widgets/driver_approval_badge.dart';
import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_profile/wasel_profile.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_error_state.dart';
import 'package:wasel_core/widgets/cards/app_group_card.dart';
import 'package:wasel_core/widgets/cards/app_info_row.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_core/widgets/avatar/app_profile_avatar.dart';
import 'package:wasel_core/widgets/cards/app_stat_cards.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);

    final isRefreshing = profile.isLoading;

    void refresh() =>
        ref.read(driverProfileControllerProvider.notifier).refresh();

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      appBar: AppBar(
        title: Text(context.l10n.profileDetails),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
        actions: [
          IconButton(
            tooltip: context.l10n.edit,
            icon: const Icon(Icons.edit_outlined),
            color: context.colors.primary500,
            onPressed: () => context.pushNamed(AppRoutes.profileEdit),
          ),
        ],
      ),
      body: profile.when(
        skipLoadingOnRefresh: true,
        loading: () => AppSkeleton(
          child: _DriverProfileDetailsBody(profile: placeholderDriverProfile),
        ),
        error: (error, _) => AppErrorState(
          message: errorMessageOf(error),
          onRetry: refresh,
          isRetrying: isRefreshing,
        ),
        data: (profile) => profile == null
            ? AppErrorState(
                message: context.l10n.profileLoadFailed,
                onRetry: refresh,
                isRetrying: isRefreshing,
              )
            : _DriverProfileDetailsBody(profile: profile),
      ),
    );
  }
}

class _DriverProfileDetailsBody extends StatelessWidget {
  const _DriverProfileDetailsBody({required this.profile});

  final DriverProfile profile;

  @override
  Widget build(BuildContext context) {
    final fullName = profile.fullName;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space32,
      ),
      children: [
        AppSurfaceCard(
          borderRadius: context.shape.radiusSheet,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.space16,
            vertical: AppDimens.space24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppProfileAvatar(photoUrl: profile.profilePictureUrl, size: 96.r),
              SizedBox(height: AppDimens.space16),
              Text(
                fullName.isNotEmpty ? fullName : context.l10n.waselDriverName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.title(),
              ),
              SizedBox(height: AppDimens.space8),
              DriverApprovalBadge(status: profile.approvalStatus),
              SizedBox(height: AppDimens.space16),
              AppStatCards(
                stats: [
                  AppStat(
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: context.colors.primary500,
                    background: context.colors.primary100,
                    label: context.l10n.balance,
                    value: formatAmount(profile.balance),
                    valueTextDirection: TextDirection.ltr,
                  ),
                  AppStat(
                    icon: Icons.star_rounded,
                    iconColor: context.colors.primary500,
                    background: context.colors.neutral100,
                    label: context.l10n.rating,
                    value:
                        '${profile.averageRating.toStringAsFixed(1)} '
                        '(${profile.totalReviews})',
                    valueTextDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.space24),
        AppGroupCard(
          children: [
            AppInfoRow(
              icon: Icons.person_outline_rounded,
              label: context.profileL10n.firstName,
              value: profile.firstName,
            ),
            AppInfoRow(
              icon: Icons.badge_outlined,
              label: context.profileL10n.lastName,
              value: profile.lastName,
            ),
            AppInfoRow(
              icon: Icons.phone_outlined,
              label: context.profileL10n.phoneNumber,
              value: profile.phoneNumber,
              valueTextDirection: TextDirection.ltr,
            ),
            AppInfoRow(
              icon: Icons.mail_outline_rounded,
              label: context.authL10n.email,
              value: profile.email,
              valueTextDirection: TextDirection.ltr,
            ),
            AppInfoRow(
              icon: Icons.location_city_outlined,
              label: context.l10n.city,
              value: profile.city,
            ),
            AppInfoRow(
              icon: Icons.location_on_outlined,
              label: context.l10n.address,
              value: profile.address,
            ),
          ],
        ),
      ],
    );
  }
}
