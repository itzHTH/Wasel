import 'package:driver/core/widgets/app_secondary_button.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class OfflineCard extends StatelessWidget {
  const OfflineCard({
    super.key,
    required this.onGoOnline,
    required this.onCancel,
    this.isConnecting = false,
  });

  final VoidCallback onGoOnline;

  /// Aborts an attempt that is still in flight.
  final VoidCallback onCancel;

  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _OfflineBadge(isConnecting: isConnecting),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConnecting ? 'دا نتصل بالخادم' : 'إنت غير متصل',
                      style: AppTextStyles.font20Secondary900Bold,
                    ),
                    Text(
                      isConnecting
                          ? 'ثانية وحدة، دا نكمل الاتصال'
                          : 'ما راح توصلك طلبات وإنت غير متصل',
                      style: AppTextStyles.font14Neutral400Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(
            label: 'ابدأ استلام الرحلات',

            onPressed: isConnecting ? null : onGoOnline,
            isLoading: isConnecting,
          ),
          if (isConnecting) ...[
            SizedBox(height: AppDimens.space12),
            AppSecondaryButton(label: 'إلغاء', onPressed: onCancel),
          ],
        ],
      ),
    );
  }
}

class _OfflineBadge extends StatelessWidget {
  const _OfflineBadge({required this.isConnecting});

  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space8),
      decoration: BoxDecoration(
        color: isConnecting ? AppColor.primary100 : AppColor.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Icon(
        Icons.power_settings_new_rounded,
        size: AppDimens.icon20,
        color: isConnecting ? AppColor.primary500 : AppColor.neutral400,
      ),
    );
  }
}
