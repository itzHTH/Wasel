import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/profile/ui/widgets/driver_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_surface_card.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

class DriverProfileSummary extends ConsumerWidget {
  const DriverProfileSummary({super.key});

  static double get _placeholderHeight => 148.h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);

    return profile.when(
      skipLoadingOnRefresh: false,
      loading: () => AppSurfaceCard(
        borderRadius: AppDimens.radius24,
        child: SizedBox(
          height: _placeholderHeight,
          child: const Center(child: AppInlineLoading()),
        ),
      ),
      error: (error, _) => AppSurfaceCard(
        borderRadius: AppDimens.radius24,
        padding: EdgeInsets.all(AppDimens.space16),
        child: SizedBox(
          height: _placeholderHeight,
          child: Center(
            child: AppErrorRetry(
              message: errorMessageOf(error),
              onRetry: () =>
                  ref.read(driverProfileControllerProvider.notifier).refresh(),
            ),
          ),
        ),
      ),
      data: (profile) => AppSurfaceCard(
        borderRadius: AppDimens.radius24,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        onTap: () => context.pushNamed(AppRoutes.profileDetails),
        child: DriverProfileInfo(profile: profile),
      ),
    );
  }
}
