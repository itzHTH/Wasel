import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_editable_avatar.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';
import 'package:wasel_core/widgets/app_group_card.dart';
import 'package:wasel_core/widgets/app_info_row.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_surface_card.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(riderProfileControllerProvider);

    void refresh() =>
        ref.read(riderProfileControllerProvider.notifier).refresh();

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
            : _RiderProfileDetailsBody(profile: profile),
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

class _RiderProfileDetailsBody extends StatelessWidget {
  const _RiderProfileDetailsBody({required this.profile});

  final RiderProfile profile;

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
              AppEditableAvatar(
                photoUrl: profile.profilePictureUrl,
                size: 96.r,
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                fullName.isNotEmpty ? fullName : 'مستخدم وَصَل',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font20Secondary900Bold,
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
              icon: Icons.account_balance_wallet_outlined,
              label: 'الرصيد',
              value: formatAmount(profile.balance),
              valueTextDirection: TextDirection.ltr,
            ),
          ],
        ),
      ],
    );
  }
}
