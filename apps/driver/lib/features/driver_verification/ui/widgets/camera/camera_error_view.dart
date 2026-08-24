import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

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
              style: context.styles.bodyLarge(
                weight: FontWeight.w600,
                color: context.colors.onScrim,
              ),
            ),
            SizedBox(height: AppDimens.space24),
            TextButton(
              onPressed: onBack,
              child: Text(
                context.coreL10n.back,
                style: context.styles.body(
                  weight: FontWeight.w600,
                  color: context.colors.primary500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
