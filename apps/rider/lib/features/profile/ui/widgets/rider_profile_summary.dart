import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/profile/ui/widgets/rider_profile_info.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_error_retry.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';

class RiderProfileSummary extends ConsumerWidget {
  const RiderProfileSummary({super.key});

  static double get _placeholderHeight => 178.h;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(riderProfileControllerProvider);

    return profile.when(
      skipLoadingOnRefresh: false,
      loading: () => AppSurfaceCard(
        borderRadius: context.shape.radiusSheet,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: AppSkeleton(
          child: RiderProfileInfo(profile: placeholderRiderProfile),
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
                  ref.read(riderProfileControllerProvider.notifier).refresh(),
            ),
          ),
        ),
      ),
      data: (profile) => AppSurfaceCard(
        borderRadius: context.shape.radiusSheet,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        onTap: () => context.pushNamed(AppRoutes.profileDetails),
        child: RiderProfileInfo(profile: profile),
      ),
    );
  }
}
