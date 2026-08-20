import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AppMenuTile extends StatelessWidget {
  const AppMenuTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
    this.isMuted = false,
  });

  static double get leadingExtent =>
      AppDimens.space16 + AppDimens.icon40 + AppDimens.space12;

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    final trailing = this.trailing;

    final foreground = isDestructive
        ? context.colors.alertError700
        : isMuted
        ? context.colors.neutral600
        : context.colors.primary500;
    final badgeBackground = isDestructive
        ? context.colors.elementBackground
        : isMuted
        ? context.colors.neutral100
        : context.colors.primary100;
    final labelStyle = isDestructive
        ? context.styles.font14alertError500SemiBold.copyWith(
            color: context.colors.alertError700,
          )
        : context.styles.font14Secondary900SemiBold;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.space16,
            vertical: AppDimens.space12,
          ),
          child: Row(
            children: [
              Container(
                width: AppDimens.icon40,
                height: AppDimens.icon40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: badgeBackground,
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                ),
                child: Icon(icon, size: AppDimens.icon20, color: foreground),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: AppDimens.space12),
                trailing,
              ] else if (onTap != null) ...[
                SizedBox(width: AppDimens.space12),
                ExcludeSemantics(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: AppDimens.icon18,
                    color: context.colors.neutral400,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
