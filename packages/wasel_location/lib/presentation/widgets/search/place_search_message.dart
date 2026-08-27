import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The shared shape of every non-result state: a tinted icon, a title, and a
/// line of guidance. Keeping prompt, no-match and error on one layout stops the
/// panel from jumping as the rider types.
///
/// Sits near the top rather than centred: a block floating in the middle of a
/// tall panel reads as a failure even when it is only an invitation to type.
class PlaceSearchMessage extends StatelessWidget {
  const PlaceSearchMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.tone,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;

  /// Colours the icon. Defaults to the brand tint; error states pass the alert
  /// tone so failure reads differently from emptiness at a glance.
  final Color? tone;

  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final accent = tone ?? context.colors.primary500;
    final action = this.action;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimens.space32,
        AppDimens.space24,
        AppDimens.space32,
        AppDimens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(AppDimens.space12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: AppDimens.icon20, color: accent),
          ),
          SizedBox(height: AppDimens.space12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.styles.body(weight: FontWeight.w600),
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.styles.captionMuted(),
          ),
          if (action != null) ...[
            SizedBox(height: AppDimens.space16),
            action,
          ],
        ],
      ),
    );
  }
}
