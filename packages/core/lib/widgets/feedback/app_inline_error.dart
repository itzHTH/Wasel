import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// Persistent error shown next to the field that caused it.
class AppInlineError extends StatelessWidget {
  final String? message;
  final TextAlign textAlign;

  const AppInlineError({
    super.key,
    required this.message,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final text = message;
    if (text == null || text.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: AppDimens.space8),
      child: Semantics(
        liveRegion: true,
        child: Row(
          mainAxisAlignment: textAlign == TextAlign.center
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: AppDimens.icon18,
              color: context.colors.alertError500,
            ),
            SizedBox(width: AppDimens.space8),
            Flexible(
              child: Text(
                text,
                style: context.styles.bodyDanger(),
                textAlign: textAlign,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
