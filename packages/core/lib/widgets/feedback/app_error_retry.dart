import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_shimmer_sheen.dart';

class AppErrorRetry extends StatelessWidget {
  const AppErrorRetry({
    super.key,
    required this.message,
    required this.onRetry,
    this.isRetrying = false,
    this.maxLines = 3,
  });

  final String message;
  final VoidCallback onRetry;

  /// Shows the attempt in progress.
  final bool isRetrying;

  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          maxLines: maxLines,
          overflow: maxLines == null ? null : TextOverflow.ellipsis,
          style: context.styles.bodyDanger(),
        ),
        SizedBox(height: AppDimens.space8),
        AppShimmerSheen(
          enabled: isRetrying,
          borderRadius: BorderRadius.circular(AppDimens.radius8),
          highlight: context.colors.primary500,
          child: TextButton.icon(
            onPressed: isRetrying ? null : onRetry,
            icon: Icon(
              Icons.refresh_rounded,
              size: AppDimens.icon18,
              color: context.colors.primary500,
            ),
            label: Text(
              isRetrying ? context.coreL10n.retrying : context.coreL10n.retry,
              style: context.styles.bodyBrand(),
            ),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
          ),
        ),
      ],
    );
  }
}
