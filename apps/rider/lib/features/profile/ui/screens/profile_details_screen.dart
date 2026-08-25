import 'package:flutter/material.dart';
import 'package:wasel_core/widgets/feedback/app_snack_bar.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_profile/wasel_profile.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_error_state.dart';
import 'package:wasel_core/widgets/cards/app_group_card.dart';
import 'package:wasel_core/widgets/cards/app_info_row.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_core/widgets/cards/app_stat_cards.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
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
          child: _RiderProfileDetailsBody(profile: placeholderRiderProfile),
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
            : _RiderProfileDetailsBody(profile: profile),
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  AppSnackBar.show(context, message);
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
          borderRadius: context.shape.radiusSheet,
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
                fullName.isNotEmpty ? fullName : context.l10n.defaultUserName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.title(),
              ),
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
          ],
        ),
      ],
    );
  }
}
