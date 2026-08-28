import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class DriverDisconnectedBanner extends ConsumerWidget {
  const DriverDisconnectedBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDisconnected = ref.watch(
      rideControllerProvider.select((s) => s.isDriverDisconnected),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      child: !isDisconnected
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.screenHPadding,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.neutral0,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.space16,
                    vertical: AppDimens.space8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_off_rounded,
                        size: AppDimens.icon20,
                        color: context.colors.alertWarning500,
                      ),
                      SizedBox(width: AppDimens.space8),
                      Flexible(
                        child: Text(
                          context.l10n.driverConnectionLost,
                          style: context.styles.bodySecondary(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
