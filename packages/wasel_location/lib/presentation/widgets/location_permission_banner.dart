import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart'
    show openAppSettings;
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_location/presentation/providers/location/location_access_provider.dart';

/// A persistent nudge shown while the app cannot read the device location.
class LocationPermissionBanner extends ConsumerWidget {
  const LocationPermissionBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(locationAccessControllerProvider);

    // Nothing to show while the first read is still in flight
    final blocked = access.hasValue && !access.requireValue.isGranted;
    if (!blocked) return const SizedBox.shrink();

    final needsSettings = access.requireValue.needsSettings;

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
                onPressed: () => needsSettings
                    ? openAppSettings()
                    : ref
                          .read(locationAccessControllerProvider.notifier)
                          .request(context),
                child: Text(
                  needsSettings ? 'الإعدادات' : 'تمكين',
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
