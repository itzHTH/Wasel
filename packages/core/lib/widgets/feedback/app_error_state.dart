import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_shimmer_sheen.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.isRetrying = false,
    this.title,
    this.icon = Icons.cloud_off_rounded,
  });

  final String message;
  final VoidCallback onRetry;
  final bool isRetrying;

  /// Headline above [message], dropped when it would only repeat it.
  final String? title;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final heading = title;
    final showTitle = heading != null && heading != message;

    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space24,
        vertical: AppDimens.space32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconHalo(icon: icon),
          SizedBox(height: AppDimens.space24),
          // The copy is announced by the live region above, so the individual
          // nodes would only repeat it.
          ExcludeSemantics(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showTitle) ...[
                  Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: context.styles.title(),
                  ),
                  SizedBox(height: AppDimens.space12),
                ],
                // Deliberately unbounded lines: a long backend message wraps
                // rather than getting cut off.
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.styles.bodyMuted(),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space24),
          _RetryButton(onPressed: onRetry, isRetrying: isRetrying),
        ],
      ),
    );

    return Semantics(
      container: true,
      liveRegion: true,
      label: showTitle ? '$heading. $message' : message,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Placed inside a list or another scrollable, the height is
          // unbounded: centring and scrolling are the parent's job there, and
          // a viewport of our own would have nothing to size against.
          if (!constraints.hasBoundedHeight) return content;

          // Centred while it fits, scrollable the moment large text or a long
          // message makes it taller than the viewport.
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: content),
            ),
          );
        },
      ),
    );
  }
}

/// Soft-tinted disc behind the icon. Sized off the layout scale rather than the
/// text scale, so it never crowds out the copy it illustrates.
class _IconHalo extends StatelessWidget {
  const _IconHalo({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space24),
      decoration: BoxDecoration(
        color: context.colors.alertError100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: AppDimens.icon48,
        color: context.colors.alertError500,
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed, required this.isRetrying});

  final VoidCallback onPressed;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = isRetrying ? colors.primary700 : colors.primary500;

    return AppShimmerSheen(
      enabled: isRetrying,
      borderRadius: BorderRadius.circular(context.shape.radiusButton),
      highlight: colors.onPrimary,
      child: ElevatedButton(
        onPressed: isRetrying ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: colors.onPrimary,
          // Retrying is not a disabled look: the label has to stay readable.
          disabledBackgroundColor: background,
          disabledForegroundColor: colors.onPrimary,
          elevation: 0,
          // A minimum rather than a fixed height, so the button grows with its
          // label instead of clipping it at large text scales.
          minimumSize: Size(0, context.shape.buttonHeight),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.space24,
            vertical: AppDimens.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.shape.radiusButton),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, size: AppDimens.icon18),
            SizedBox(width: AppDimens.space8),
            Flexible(
              child: Text(
                isRetrying ? context.coreL10n.retrying : context.coreL10n.retry,
                style: context.styles.body(
                  weight: FontWeight.w600,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
