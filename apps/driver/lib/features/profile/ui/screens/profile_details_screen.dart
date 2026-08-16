import 'package:driver/features/profile/ui/widgets/driver_approval_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';
import 'package:wasel_core/widgets/app_info_card.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);

    void refresh() =>
        ref.read(driverProfileControllerProvider.notifier).refresh();

    return Scaffold(
      backgroundColor: AppColor.screenBackground,
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: AppColor.screenBackground,
        surfaceTintColor: AppColor.screenBackground,
      ),
      body: profile.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: AppInlineLoading()),
        error: (error, _) =>
            _ErrorState(message: errorMessageOf(error), onRetry: refresh),
        data: (profile) => profile == null
            ? _ErrorState(
                message: 'تعذّر تحميل بيانات الملف الشخصي',
                onRetry: refresh,
              )
            : _DriverProfileDetailsBody(profile: profile),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space24),
        child: AppErrorRetry(message: message, onRetry: onRetry),
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
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space24,
        vertical: AppDimens.space24,
      ),
      children: [
        Center(
          child: AppProfileAvatar(
            photoUrl: profile.profilePictureUrl,
            size: 96.r,
          ),
        ),
        SizedBox(height: AppDimens.space16),
        Text(
          fullName.isNotEmpty ? fullName : 'سائق وَصَل',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font20Secondary900Bold,
        ),
        SizedBox(height: AppDimens.space8),
        Center(child: DriverApprovalBadge(status: profile.approvalStatus)),
        SizedBox(height: AppDimens.space24),
        AppInfoCard(
          icon: Icons.person_outline_rounded,
          label: 'الاسم الأول',
          value: profile.firstName,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.badge_outlined,
          label: 'اسم العائلة',
          value: profile.lastName,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.phone_outlined,
          label: 'رقم الهاتف',
          value: profile.phoneNumber,
          valueTextDirection: TextDirection.ltr,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.mail_outline_rounded,
          label: 'البريد الإلكتروني',
          value: profile.email,
          valueTextDirection: TextDirection.ltr,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.location_city_outlined,
          label: 'المدينة',
          value: profile.city,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.location_on_outlined,
          label: 'العنوان',
          value: profile.address,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.star_outline_rounded,
          label: 'التقييم',
          value:
              '${profile.averageRating.toStringAsFixed(1)} '
              '(${profile.totalReviews} تقييم)',
          valueTextDirection: TextDirection.ltr,
        ),
        SizedBox(height: AppDimens.space12),
        AppInfoCard(
          icon: Icons.account_balance_wallet_outlined,
          label: 'الرصيد',
          value: formatAmount(profile.balance),
          valueTextDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
