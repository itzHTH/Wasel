import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasel_core/wasel_core.dart';

/// Shown right after a ride is requested, while the backend looks for a nearby
/// captain. Pure: the parent owns cancellation via [onCancel].
class SearchingForDriverCard extends StatelessWidget {
  const SearchingForDriverCard({super.key, required this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: SizedBox(
              width: AppDimens.icon36,
              height: AppDimens.icon36,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColor.primary500,
              ),
            ),
          ),
          SizedBox(height: AppDimens.space16),
          Text(
            'نبحث عن كابتن قريب...',
            textAlign: TextAlign.center,
            style: AppTextStyles.font20Secondary900Bold,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'خليك على الخط، راح نلگه لك كابتن بأسرع وقت',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Secondary500Medium,
          ),
          SizedBox(height: AppDimens.space24),
          AppSecondaryButton(label: 'إلغاء الطلب', onPressed: onCancel),
        ],
      ),
    );
  }
}
