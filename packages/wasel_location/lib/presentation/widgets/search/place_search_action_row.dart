import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// A shortcut offered above the results — "use my current location" and the
/// like.
///
/// Given a tinted card of its own rather than the suggestion rows' flat
/// treatment: it is the one row here that is an action rather than a match,
/// and it is the answer most riders want for a pickup.
class PlaceSearchActionRow extends StatelessWidget {
  const PlaceSearchActionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isBusy = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(context.shape.radiusCard);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space8,
        vertical: AppDimens.space8,
      ),
      child: Material(
        color: colors.primary500.withValues(alpha: 0.08),
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isBusy ? null : onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: colors.primary500.withValues(alpha: 0.22),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space12,
                vertical: AppDimens.space12,
              ),
              child: Row(
                children: [
                  _ActionBadge(icon: icon, isBusy: isBusy),
                  SizedBox(width: AppDimens.space12),
                  Expanded(
                    child: Text(
                      label,
                      style: context.styles
                          .body(weight: FontWeight.w700)
                          .copyWith(color: colors.primary500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_left_rounded,
                    size: AppDimens.icon20,
                    color: colors.primary500.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionBadge extends StatelessWidget {
  const _ActionBadge({required this.icon, required this.isBusy});

  final IconData icon;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: AppDimens.icon40,
      height: AppDimens.icon40,
      decoration: BoxDecoration(
        color: colors.primary500,
        shape: BoxShape.circle,
      ),
      child: isBusy
          ? Padding(
              padding: EdgeInsets.all(AppDimens.space12),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primary100,
              ),
            )
          : Icon(
              icon,
              size: AppDimens.icon20,
              color: colors.primary100,
            ),
    );
  }
}
