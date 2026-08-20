import 'package:flutter/material.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_error_state.dart';
import 'package:wasel_core/widgets/app_group_card.dart';
import 'package:wasel_core/widgets/app_info_row.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_stat_cards.dart';
import 'package:wasel_core/widgets/app_surface_card.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_avatar_section.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(riderProfileControllerProvider);

    final isRefreshing = profile.isLoading;

    void refresh() =>
        ref.read(riderProfileControllerProvider.notifier).refresh();

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
            : _RiderProfileDetailsBody(profile: profile),
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
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
              ProfileEditAvatarSection(
                photoUrl: profile.profilePictureUrl,
                onMessage: (message) => _showMessage(context, message),
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                fullName.isNotEmpty ? fullName : 'مستخدم وَصَل',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.font20Secondary900Bold,
              ),
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
          ],
        ),
      ],
    );
  }
}
