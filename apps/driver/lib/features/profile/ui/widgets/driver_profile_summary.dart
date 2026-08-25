import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/profile/ui/widgets/driver_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_error_retry.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

class DriverProfileSummary extends ConsumerWidget {
  const DriverProfileSummary({super.key});

  static double get _placeholderHeight => 178.h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);

    return profile.when(
      skipLoadingOnRefresh: false,
      loading: () => AppSurfaceCard(
        borderRadius: context.shape.radiusSheet,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: AppSkeleton(
          child: DriverProfileInfo(profile: placeholderDriverProfile),
        ),
      ),
      error: (error, _) => AppSurfaceCard(
        borderRadius: context.shape.radiusSheet,
        padding: EdgeInsets.all(AppDimens.space16),
        child: ConstrainedBox(
          // A minimum, not a fixed height: the message has to be able to grow
          // the card at large text scales rather than overflow it.
          constraints: BoxConstraints(minHeight: _placeholderHeight),
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
        borderRadius: context.shape.radiusSheet,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        onTap: () => context.pushNamed(AppRoutes.profileDetails),
        child: DriverProfileInfo(profile: profile),
      ),
    );
  }
}
