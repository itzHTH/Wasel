import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Full-screen error state for the camera capture flow, with a back action.
class CameraErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onBack;

  const CameraErrorView({
    super.key,
    required this.message,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.screenHPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_photography_outlined,
              size: AppDimens.icon36,
              color: AppColor.neutral0,
            ),
            SizedBox(height: AppDimens.space16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Neutral0SemiBold,
            ),
            SizedBox(height: AppDimens.space24),
            TextButton(
              onPressed: onBack,
              child: Text(
                'رجوع',
                style: AppTextStyles.font14Primary500SemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
