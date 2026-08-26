import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// What a message means. The variant drives an icon as well as a colour, so
/// the meaning survives for anyone who cannot separate the hues.
enum AppSnackBarVariant { info, success, warning, error }

/// Transient messages for the Wasel apps.
class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) => _show(
    context,
    message,
    AppSnackBarVariant.info,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void showSuccess(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) => _show(
    context,
    message,
    AppSnackBarVariant.success,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void showWarning(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) => _show(
    context,
    message,
    AppSnackBarVariant.warning,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void showError(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) => _show(
    context,
    message,
    AppSnackBarVariant.error,
    actionLabel: actionLabel,
    onAction: onAction,
  );

  static void _show(
    BuildContext context,
    String message,
    AppSnackBarVariant variant, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context)
      // clearSnackBars drops the backlog but hides the visible one through its
      // full exit animation, so the stale message stays readable for another
      // ~250ms before the new one starts entering. removeCurrentSnackBar takes
      // it away on the spot and lets the replacement enter immediately.
      ..clearSnackBars()
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: AppSnackBarContent(
            message: message,
            variant: variant,
            actionLabel: actionLabel,
            onAction: onAction,
          ),
          // The content paints its own surface, so the Material one gets out
          // of the way entirely.
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(AppDimens.space16),
          duration: _durationFor(variant, hasAction: actionLabel != null),
          dismissDirection: DismissDirection.horizontal,
        ),
      );
  }

  /// Inside the 3–5s band for a message that only needs reading. An actionable
  /// one runs longer because the user has to reach the button before it goes.
  static Duration _durationFor(
    AppSnackBarVariant variant, {
    required bool hasAction,
  }) {
    if (hasAction) return const Duration(seconds: 6);
    return variant == AppSnackBarVariant.error
        ? const Duration(seconds: 5)
        : const Duration(seconds: 4);
  }
}

/// The message surface itself. Public so it can be pumped in tests without a
/// ScaffoldMessenger.
class AppSnackBarContent extends StatelessWidget {
  const AppSnackBarContent({
    super.key,
    required this.message,
    this.variant = AppSnackBarVariant.info,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final AppSnackBarVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = _accentOf(colors, variant);
    final label = actionLabel;

    return Semantics(
      container: true,
      liveRegion: true,
      label: message,
      child: ExcludeSemantics(
        child: Container(
          decoration: BoxDecoration(
            color: colors.elementBackground,
            borderRadius: BorderRadius.circular(context.shape.radiusCard),
            // Full-strength, not a tint: on a dark screen the surface alone is
            // too close to the background to read as a separate object, and
            // the edge doubles as the variant's identity.
            border: Border.all(color: accent, width: _borderWidth.w),
            boxShadow: [
              BoxShadow(
                color: colors.scrim.withValues(alpha: 0.28),
                blurRadius: 24.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: _accentBarWidth.w + AppDimens.space12,
                  end: AppDimens.space12,
                  top: AppDimens.space12,
                  bottom: AppDimens.space12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _VariantBadge(variant: variant, accent: accent),
                    SizedBox(width: AppDimens.space12),
                    Expanded(
                      child: Padding(
                        // Optically centres one line against the badge while
                        // letting more lines grow downward.
                        padding: EdgeInsets.only(top: AppDimens.space4),
                        child: Text(message, style: context.styles.body()),
                      ),
                    ),
                    if (label != null) ...[
                      SizedBox(width: AppDimens.space8),
                      _SnackAction(
                        label: label,
                        accent: accent,
                        onPressed: onAction,
                      ),
                    ],
                  ],
                ),
              ),
              // Positioned rather than a stretched row child: the row has no
              // bounded height here, and directional start keeps the bar on
              // the right in Arabic.
              PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                width: _accentBarWidth.w,
                child: ColoredBox(color: accent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VariantBadge extends StatelessWidget {
  const _VariantBadge({required this.variant, required this.accent});

  final AppSnackBarVariant variant;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space4),
      decoration: BoxDecoration(
        color: _badgeOf(context.colors, variant),
        shape: BoxShape.circle,
      ),
      child: Icon(_iconOf(variant), size: AppDimens.icon20, color: accent),
    );
  }
}

class _SnackAction extends StatelessWidget {
  const _SnackAction({
    required this.label,
    required this.accent,
    required this.onPressed,
  });

  final String label;
  final Color accent;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // Reachable by thumb, which a bare TextButton is not guaranteed to be.
      constraints: BoxConstraints(
        minWidth: _minTouch.w,
        minHeight: _minTouch.h,
      ),
      child: TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onPressed?.call();
        },
        style: TextButton.styleFrom(
          foregroundColor: accent,
          padding: EdgeInsets.symmetric(horizontal: AppDimens.space8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radius8),
          ),
        ),
        child: Text(
          label,
          style: context.styles.label(color: accent, weight: FontWeight.w700),
        ),
      ),
    );
  }
}

IconData _iconOf(AppSnackBarVariant variant) => switch (variant) {
  AppSnackBarVariant.info => Icons.info_rounded,
  AppSnackBarVariant.success => Icons.check_circle_rounded,
  AppSnackBarVariant.warning => Icons.warning_rounded,
  AppSnackBarVariant.error => Icons.error_rounded,
};

Color _accentOf(AppColorsExtension colors, AppSnackBarVariant variant) =>
    switch (variant) {
      AppSnackBarVariant.info => colors.alertInfo500,
      AppSnackBarVariant.success => colors.alertSuccess500,
      AppSnackBarVariant.warning => colors.alertWarning500,
      AppSnackBarVariant.error => colors.alertError500,
    };

Color _badgeOf(AppColorsExtension colors, AppSnackBarVariant variant) =>
    switch (variant) {
      AppSnackBarVariant.info => colors.alertInfo100,
      AppSnackBarVariant.success => colors.alertSuccess100,
      AppSnackBarVariant.warning => colors.alertWarning100,
      AppSnackBarVariant.error => colors.alertError100,
    };

const _accentBarWidth = 4.0;

const _borderWidth = 1.5;

/// The platform floor for a tap target.
const _minTouch = 44.0;
