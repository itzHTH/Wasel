import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/screens/ride_search_screen.dart';
import 'package:wasel_location/wasel_location.dart';

/// Opens place search for one endpoint and takes the map to whatever the rider
/// picked.
Future<void> openRideSearch(
  BuildContext context,
  WidgetRef ref, {
  required SearchFieldType initialField,
}) async {
  final draft = ref.read(rideDraftProvider);
  final pinned = draft.pickup;

  final selection = await showRideSearch(
    context,
    initialField: initialField,
    pickupLabel: draft.pickupLabel,
    hasPickup: pinned != null,
    pickupIsResolving: pinned != null && draft.pickupLabel == null,
    proximity: pinned == null
        ? null
        : GeoPoint(latitude: pinned.latitude, longitude: pinned.longitude),
  );
  // The session provider is pinned alive by keepAlive `pointLabelProvider`, so
  // it outlives this screen. Without this an abandoned search keeps billing
  // later, unrelated searches under a token Google has already written off.
  ref.read(placeSearchSessionProvider).close();

  if (selection == null) return;

  final pick = selection.finalPick;
  ref
      .read(rideDraftProvider.notifier)
      .noteSearchedPlace(pick.point, pick.name, selection.finalField);

  unawaited(ref.read(mapControllerHolderProvider.notifier).focusOn(pick.point));
}

/// Pushes the search screen.
Future<PlaceSearchSelection?> showRideSearch(
  BuildContext context, {
  SearchFieldType initialField = SearchFieldType.dropoff,
  String? pickupLabel,
  GeoPoint? proximity,
  bool hasPickup = false,
  bool pickupIsResolving = false,
}) {
  return Navigator.of(context).push<PlaceSearchSelection>(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (_, _, _) => RideSearchScreen(
        initialField: initialField,
        pickupLabel: pickupLabel,
        proximity: proximity,
        hasPickup: hasPickup,
        pickupIsResolving: pickupIsResolving,
      ),
      transitionsBuilder: (_, animation, _, child) {
        final eased = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: eased,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(eased),
            child: child,
          ),
        );
      },
    ),
  );
}
