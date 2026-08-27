import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasal/features/ride/ui/ride_search_flow.dart';
import 'package:wasal/features/ride/ui/screens/ride_search_screen.dart';
import 'package:wasal/features/ride/ui/widgets/ride_search/ride_search_header.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';

/// The tap target that opens [RideSearchScreen], offered alongside the map pin
/// rather than replacing it: typing is faster for a place the rider can name,
/// dragging is better for one they can only point at.
///
/// Mirrors the search header's own layout — marker, then text in a bordered
/// well — because the two are Hero counterparts and the flight between them
/// should read as one element growing, not two swapping.
///
/// Hidden once both endpoints are set and the card becomes a summary.
class RideSearchBar extends ConsumerWidget {
  const RideSearchBar({super.key});

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    PickingStage stage,
  ) => openRideSearch(
    context,
    ref,
    initialField: stage.isPickupStage
        ? SearchFieldType.pickup
        : SearchFieldType.dropoff,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(rideDraftProvider.select((s) => s.stage));
    if (stage == PickingStage.done) return const SizedBox.shrink();

    final colors = context.colors;
    final isPickup = stage.isPickupStage;

    return Padding(
      padding: EdgeInsets.only(top: AppDimens.space12),
      child: Hero(
        tag: RideSearchHeader.heroTag,
        child: Material(
          color: colors.screenBackground,
          borderRadius: BorderRadius.circular(context.shape.radiusCard),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _open(context, ref, stage),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.shape.radiusCard),
                  border: Border.all(color: colors.neutral100),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.space12,
                    vertical: AppDimens.space16,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: PlaceSearchField.markerGutter,
                        child: Center(
                          child: EndpointMarker(isPickup: isPickup),
                        ),
                      ),
                      SizedBox(width: AppDimens.space8),
                      Expanded(
                        child: Text(
                          // Not the stage title: the card already carries it
                          // directly above, and repeating it says nothing.
                          context.locationL10n.searchPlaceHint,
                          style: context.styles.bodyMuted(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.search_rounded,
                        size: AppDimens.icon20,
                        color: colors.neutral400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
