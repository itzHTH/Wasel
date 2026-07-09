import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestConfirmButton extends ConsumerWidget {
  const RequestConfirmButton({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () => ref
                  .read(requestRideControllerProvider.notifier)
                  .requetsRide(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary500,
          disabledBackgroundColor: AppColor.primary500,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: AppDimens.icon24,
                width: AppDimens.icon24,
                child: const CircularProgressIndicator(
                  color: AppColor.neutral0,
                  strokeWidth: 2,
                ),
              )
            : Text('تأكيد الطلب', style: AppTextStyles.font16Neutral0SemiBold),
      ),
    );
  }
}
