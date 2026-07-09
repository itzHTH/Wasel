import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/widgets/request_ride_card/request_ride_success_view.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestRideCard extends ConsumerWidget {
  const RequestRideCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(
        AppDimens.space16,
        0,
        AppDimens.space16,
        AppDimens.space24,
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        AppDimens.screenHPadding,
        AppDimens.space24,
        AppDimens.screenHPadding,
        AppDimens.space24,
      ),
      decoration: BoxDecoration(
        color: AppColor.elementBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius24),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary900.withValues(alpha: 0.08),
            blurRadius: AppDimens.radius16,
            offset: Offset(0, AppDimens.space4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RequestRideSuccessView(),
          SizedBox(height: AppDimens.space24),
          SizedBox(
            height: AppDimens.buttonHeight,
            child: OutlinedButton(
              onPressed: () => ref.invalidate(requestRideControllerProvider),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColor.primary500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
              child: Text(
                'إلغاء الطلب',
                style: AppTextStyles.font14Primary500SemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
