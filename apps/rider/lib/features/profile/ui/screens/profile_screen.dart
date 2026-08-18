import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/auth/ui/providers/logout/logout.dart';
import 'package:wasal/features/profile/ui/widgets/rider_profile_summary.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_dialog.dart';
import 'package:wasel_core/widgets/app_group_card.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_menu_tile.dart';
import 'package:wasel_core/widgets/app_soon_badge.dart';
import 'package:wasel_core/widgets/app_surface_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggingOut = ref.watch(logoutProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColor.screenBackground,
      appBar: AppBar(
        title: const Text('حسابي'),
        backgroundColor: AppColor.screenBackground,
        surfaceTintColor: AppColor.screenBackground,
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
                label: 'الملف الشخصي',
                onTap: () => context.pushNamed(AppRoutes.profileDetails),
              ),
              const AppMenuTile(
                icon: Icons.settings_outlined,
                label: 'الإعدادات',
                isMuted: true,
                trailing: AppSoonBadge(),
              ),
              const AppMenuTile(
                icon: Icons.brightness_6_outlined,
                label: 'المظهر',
                isMuted: true,
                trailing: AppSoonBadge(),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          AppSurfaceCard(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            backgroundColor: AppColor.alertError100,
            child: AppMenuTile(
              icon: Icons.logout_rounded,
              label: 'تسجيل الخروج',
              isDestructive: true,
              onTap: isLoggingOut ? null : () => _logout(context, ref),
              trailing: isLoggingOut
                  ? AppInlineLoading(
                      size: AppDimens.icon20,
                      color: AppColor.alertError700,
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
      title: 'تسجيل الخروج',
      message: 'هل أنت متأكد من تسجيل الخروج من حسابك؟',
      confirmLabel: 'تسجيل الخروج',
      cancelLabel: 'إلغاء',
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
