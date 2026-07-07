import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RideActionButtons extends ConsumerWidget {
  const RideActionButtons({
    super.key,
    required this.onConfirm,
    required this.onRequestPrice,
  });

  final VoidCallback onConfirm;
  final VoidCallback onRequestPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(
      rideDraftProvider.select((s) => s.confirmButtonLabel),
    );
    final showRequestPrice = ref.watch(
      rideDraftProvider.select((s) => s.showRequestPriceButton),
    );
    final isCameraMoving = ref.watch(isCameraMovingProvider);

    final confirmButton = SizedBox(
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isCameraMoving ? null : onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary500,
          disabledBackgroundColor: AppColor.primary300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Text(label, style: AppTextStyles.font16Neutral0SemiBold),
      ),
    );

    if (!showRequestPrice) return confirmButton;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppDimens.buttonHeight,
            child: ElevatedButton(
              onPressed: onRequestPrice,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary500,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
              child: Text('تأكيد', style: AppTextStyles.font16Neutral0SemiBold),
            ),
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: SizedBox(
            height: AppDimens.buttonHeight,
            child: OutlinedButton(
              onPressed: onConfirm,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColor.primary500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
              child: Text(label, style: AppTextStyles.font14Primary500SemiBold),
            ),
          ),
        ),
      ],
    );
  }
}
