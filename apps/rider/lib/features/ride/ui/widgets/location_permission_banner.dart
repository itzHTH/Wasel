import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/location/location_permission_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class LocationPermissionBanner extends ConsumerWidget {
  const LocationPermissionBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final denied = ref.watch(
      locationPermissionProvider.select(
        (s) => s.hasValue && s.requireValue == LocationAccess.denied,
      ),
    );
    if (!denied) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimens.screenHPadding,
        right: AppDimens.screenHPadding,
        bottom: AppDimens.space8,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.neutral0,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimens.space8,
            right: AppDimens.space16,
            top: AppDimens.space4,
            bottom: AppDimens.space4,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_off_outlined,
                size: AppDimens.icon20,
                color: AppColor.alertWarning500,
              ),
              SizedBox(width: AppDimens.space8),
              Expanded(
                child: Text(
                  'شغّل الموقع حتى نلگه مكانك',
                  style: AppTextStyles.font14Secondary500Medium,
                ),
              ),
              TextButton(
                onPressed: () => ref
                    .read(locationPermissionProvider.notifier)
                    .request(context),
                child: Text(
                  'تمكين',
                  style: AppTextStyles.font14Primary500SemiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
