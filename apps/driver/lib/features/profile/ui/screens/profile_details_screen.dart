import 'package:driver/features/profile/ui/widgets/driver_approval_badge.dart';
import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_error_state.dart';
import 'package:wasel_core/widgets/app_group_card.dart';
import 'package:wasel_core/widgets/app_info_row.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';
import 'package:wasel_core/widgets/app_stat_cards.dart';
import 'package:wasel_core/widgets/app_surface_card.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

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
        title: const Text('الملف الشخصي'),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
        actions: [
          IconButton(
            tooltip: 'تعديل',
            icon: const Icon(Icons.edit_outlined),
            color: context.colors.primary500,
            onPressed: () => context.pushNamed(AppRoutes.profileEdit),
          ),
        ],
      ),
      body: profile.when(
        skipLoadingOnRefresh: true,
        loading: () => const Center(child: AppInlineLoading()),
        error: (error, _) => AppErrorState(
          message: errorMessageOf(error),
          onRetry: refresh,
          isRetrying: isRefreshing,
        ),
        data: (profile) => profile == null
            ? AppErrorState(
                message: 'تعذّر تحميل بيانات الملف الشخصي',
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
          borderRadius: AppDimens.radius24,
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
                fullName.isNotEmpty ? fullName : 'سائق وَصَل',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.font20Secondary900Bold,
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
            ],
          ),
        ),
        SizedBox(height: AppDimens.space24),
        AppGroupCard(
          children: [
            AppInfoRow(
              icon: Icons.person_outline_rounded,
              label: 'الاسم الأول',
              value: profile.firstName,
            ),
            AppInfoRow(
              icon: Icons.badge_outlined,
              label: 'اسم العائلة',
              value: profile.lastName,
            ),
            AppInfoRow(
              icon: Icons.phone_outlined,
              label: 'رقم الهاتف',
              value: profile.phoneNumber,
              valueTextDirection: TextDirection.ltr,
            ),
            AppInfoRow(
              icon: Icons.mail_outline_rounded,
              label: 'البريد الإلكتروني',
              value: profile.email,
              valueTextDirection: TextDirection.ltr,
            ),
            AppInfoRow(
              icon: Icons.location_city_outlined,
              label: 'المدينة',
              value: profile.city,
            ),
            AppInfoRow(
              icon: Icons.location_on_outlined,
              label: 'العنوان',
              value: profile.address,
            ),
          ],
        ),
      ],
    );
  }
}
