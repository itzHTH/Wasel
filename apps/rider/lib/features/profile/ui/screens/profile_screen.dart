import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/auth/ui/providers/logout/logout.dart';
import 'package:wasal/features/profile/ui/widgets/rider_profile_summary.dart';
import 'package:wasel_core/wasel_core.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggingOut = ref.watch(logoutProvider).isLoading;

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      appBar: AppBar(
        title: Text(context.l10n.myAccount),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppDimens.space16,
          AppDimens.space16,
          AppDimens.space16,
          AppDimens.space32,
        ),
        children: [
          const RiderProfileSummary(),
          SizedBox(height: AppDimens.space24),
          AppGroupCard(
            children: [
              AppMenuTile(
                icon: Icons.person_outline_rounded,
                label: context.l10n.profileDetails,
                onTap: () => context.pushNamed(AppRoutes.profileDetails),
              ),
              AppMenuTile(
                icon: Icons.history_rounded,
                label: context.l10n.rideHistory,
                onTap: () => context.pushNamed(AppRoutes.rideHistory),
              ),
              AppMenuTile(
                icon: Icons.settings_outlined,
                label: context.l10n.settings,
                isMuted: true,
                trailing: const AppSoonBadge(),
              ),
              AppMenuTile(
                icon: Icons.brightness_6_outlined,
                label: context.coreL10n.appearance,
                onTap: () => showAppAppearanceSheet(context),
                trailing: Text(
                  appThemeModeLabel(
                    context,
                    ref.watch(themeModeControllerProvider),
                  ),
                  style: context.styles.bodyMuted(),
                ),
              ),
              AppMenuTile(
                icon: Icons.language_rounded,
                label: context.coreL10n.language,
                onTap: () => showAppLanguageSheet(context),
                trailing: Text(
                  appLocaleLabel(ref.watch(appLocalizationControllerProvider)),
                  style: context.styles.bodyMuted(),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          AppSurfaceCard(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            backgroundColor: context.colors.alertError100,
            child: AppMenuTile(
              icon: Icons.logout_rounded,
              label: context.l10n.logout,
              isDestructive: true,
              onTap: isLoggingOut ? null : () => _logout(context, ref),
              trailing: isLoggingOut
                  ? AppInlineLoading(
                      size: AppDimens.icon20,
                      color: context.colors.alertError700,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.show(
      context,
      title: context.l10n.logout,
      message: context.l10n.logoutConfirmMessage,
      confirmLabel: context.l10n.logout,
      cancelLabel: context.coreL10n.cancel,
      icon: Icons.logout_rounded,
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) return;

    await ref.read(logoutProvider.notifier).execute();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.auth,
      (route) => false,
    );
  }
}
