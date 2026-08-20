import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

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
              color: context.colors.onScrim,
            ),
            SizedBox(height: AppDimens.space16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.styles.font16OnScrimSemiBold,
            ),
            SizedBox(height: AppDimens.space24),
            TextButton(
              onPressed: onBack,
              child: Text(
                'رجوع',
                style: context.styles.font14Primary500SemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
