import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The rounded icon-and-label pill that ride status, driver approval, payment
/// method and earnings all render.
///
/// The label is flexible and clips to an ellipsis: every caller drops the pill
/// into a row or column that can be narrower than the text, and the icon has to
/// survive so the state stays readable once the words are cut.
class AppIconPill extends StatelessWidget {
  const AppIconPill({
    super.key,
    required this.icon,
    required this.label,
    required this.foreground,
    required this.background,
    this.dense = false,
    this.labelTextDirection,
  });

  final IconData icon;

  final String label;

  final Color foreground;

  final Color background;

  /// Tighter padding and a caption-sized label, for pills that sit inside a
  /// list row rather than standing on their own.
  final bool dense;

  /// Forces a direction on the label — fares read left to right even in Arabic.
  final TextDirection? labelTextDirection;

  @override
  Widget build(BuildContext context) {
    final style = dense
        ? context.styles.caption(weight: FontWeight.w600, color: foreground)
        : context.styles.body(weight: FontWeight.w600, color: foreground);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? AppDimens.space8 : AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimens.icon18, color: foreground),
          SizedBox(width: AppDimens.space4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: labelTextDirection,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
