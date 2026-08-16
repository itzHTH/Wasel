import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/auth/ui/providers/logout/logout.dart';
import 'package:wasal/features/profile/ui/widgets/rider_profile_summary.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_menu_tile.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';

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
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: AppDimens.space24),
        children: [
          const RiderProfileSummary(),
          SizedBox(height: AppDimens.space8),
          const AppMenuTile(
            icon: Icons.person_outline_rounded,
            label: 'الملف الشخصي',
          ),
          const AppMenuTile(icon: Icons.settings_outlined, label: 'الإعدادات'),
          const AppMenuTile(icon: Icons.brightness_6_outlined, label: 'المظهر'),
          const Divider(height: 1),
          AppMenuTile(
            icon: Icons.logout_rounded,
            label: 'تسجيل الخروج',
            isDestructive: true,
            onTap: isLoggingOut ? null : () => _logout(context, ref),
            trailing: isLoggingOut
                ? AppInlineLoading(size: AppDimens.icon20)
                : null,
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final isLoggedOut = await ref.read(logoutProvider.notifier).execute();

    if (!context.mounted) return;

    if (!isLoggedOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تسجيل الخروج. حاول مرة أخرى.')),
      );
      return;
    }

    ref.invalidate(riderProfileControllerProvider);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.auth,
      (route) => false,
    );
  }
}
