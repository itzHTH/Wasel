import 'package:driver/core/widgets/app_primary_button.dart';
import 'package:driver/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class OfflineCard extends StatelessWidget {
  const OfflineCard({super.key, required this.onGoOnline});

  final VoidCallback onGoOnline;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const _OfflineBadge(),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إنت غير متصل',
                      style: AppTextStyles.font20Secondary900Bold,
                    ),
                    Text(
                      'ما راح توصلك طلبات وإنت غير متصل',
                      style: AppTextStyles.font14Neutral400Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(label: 'ابدأ استلام الرحلات', onPressed: onGoOnline),
        ],
      ),
    );
  }
}

class _OfflineBadge extends StatelessWidget {
  const _OfflineBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColor.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Icon(
        Icons.power_settings_new_rounded,
        size: AppDimens.icon20,
        color: AppColor.neutral400,
      ),
    );
  }
}
