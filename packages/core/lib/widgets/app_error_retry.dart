import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_loading.dart';

class AppErrorRetry extends StatelessWidget {
  const AppErrorRetry({
    super.key,
    required this.message,
    required this.onRetry,
    this.isRetrying = false,
  });

  final String message;
  final VoidCallback onRetry;

  /// Shows the attempt in progress.
  final bool isRetrying;

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
          style: context.styles.font14alertError500SemiBold,
        ),
        SizedBox(height: AppDimens.space8),
        TextButton.icon(
          onPressed: isRetrying ? null : onRetry,
          icon: isRetrying
              ? AppInlineLoading(size: AppDimens.icon18)
              : Icon(
                  Icons.refresh_rounded,
                  size: AppDimens.icon18,
                  color: context.colors.primary500,
                ),
          label: Text(
            isRetrying ? 'جارٍ إعادة المحاولة…' : 'إعادة المحاولة',
            style: context.styles.font14Primary500SemiBold,
          ),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ],
    );
  }
}
