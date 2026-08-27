import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';

/// A single search result: the place name, the area that disambiguates it,
/// and a pin badge.
///
/// The name is the headline because two places often share an area; the
/// address is muted so a long list scans by name alone.
class PlaceSuggestionTile extends StatelessWidget {
  const PlaceSuggestionTile({
    super.key,
    required this.suggestion,
    required this.onTap,
    this.isResolving = false,
  });

  final PlaceSuggestion suggestion;
  final ValueChanged<PlaceSuggestion> onTap;

  /// This row was tapped and its coordinates are on their way. Shimmers in
  /// place, so a slow lookup reads as progress on the row the rider chose.
  final bool isResolving;

  @override
  Widget build(BuildContext context) {
    final address = suggestion.addressParts.join(
      context.locationL10n.addressSeparator,
    );

    return AppSkeleton(
      enabled: isResolving,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isResolving ? null : () => onTap(suggestion),
          borderRadius: BorderRadius.circular(context.shape.radiusCard),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
              vertical: AppDimens.space12,
            ),
            child: Row(
              children: [
                const _PinBadge(),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        suggestion.name,
                        style: context.styles.body(weight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (address.isNotEmpty) ...[
                        SizedBox(height: AppDimens.space4),
                        Text(
                          address,
                          style: context.styles.captionMuted(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinBadge extends StatelessWidget {
  const _PinBadge();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: AppDimens.icon40,
      height: AppDimens.icon40,
      decoration: BoxDecoration(
        color: colors.primary100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Icon(
        Icons.location_on_rounded,
        size: AppDimens.icon20,
        color: colors.primary500,
      ),
    );
  }
}
