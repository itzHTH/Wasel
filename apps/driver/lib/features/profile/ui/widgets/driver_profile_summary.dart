import 'package:driver/features/profile/ui/widgets/driver_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

class DriverProfileSummary extends ConsumerWidget {
  const DriverProfileSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space24,
        vertical: AppDimens.space24,
      ),
      color: AppColor.primary100,
      child: profile.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: AppInlineLoading()),
        error: (error, _) => AppErrorRetry(
          message: errorMessageOf(error),
          onRetry: () =>
              ref.read(driverProfileControllerProvider.notifier).refresh(),
        ),
        data: (profile) => DriverProfileInfo(profile: profile),
      ),
    );
  }
}
