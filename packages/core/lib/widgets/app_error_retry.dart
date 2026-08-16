import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppErrorRetry extends StatelessWidget {
  const AppErrorRetry({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font14alertError500SemiBold,
        ),
        SizedBox(height: AppDimens.space8),
        TextButton.icon(
          onPressed: onRetry,
          icon: Icon(
            Icons.refresh_rounded,
            size: AppDimens.icon18,
            color: AppColor.primary500,
          ),
          label: Text(
            'إعادة المحاولة',
            style: AppTextStyles.font14Primary500SemiBold,
          ),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ],
    );
  }
}
