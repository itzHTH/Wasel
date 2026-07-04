import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'ride_draft_provider.g.dart';

@riverpod
class RideDraft extends _$RideDraft {
  @override
  RideDraftState build() => const RideDraftState();

  void confirmCurrentPoint(LatLng center) {
    switch (state.stage) {
      case PickingStage.pickup:
        state = state.copyWith(stage: PickingStage.dropoff, pickup: center);
        _storeLabelFor(center, isPickup: true);
      case PickingStage.dropoff:
        state = state.copyWith(stage: PickingStage.done, dropoff: center);
        _storeLabelFor(center, isPickup: false);
      case PickingStage.done:
        // At done the confirm slot means "تعديل": step back to re-pick the
        // dropoff, keeping the widget free of stage branching.
        goBackOneStep();
    }
  }

  Future<void> _storeLabelFor(LatLng point, {required bool isPickup}) async {
    final useCase = ref.read(getPointLabelUseCaseProvider);
    try {
      final label = await useCase(
        GeoPoint(latitude: point.latitude, longitude: point.longitude),
      );
      if (!ref.mounted) return;
      // Drop stale results: the point may have been cleared or replaced
      // by back navigation while the label was being resolved.
      if (isPickup && state.pickup == point) {
        state = state.copyWith(pickupLabel: label);
      } else if (!isPickup && state.dropoff == point) {
        state = state.copyWith(dropoffLabel: label);
      }
    } catch (_) {
      // Label stays null — the card keeps showing raw coordinates.
    }
  }

  void goBackOneStep() {
    switch (state.stage) {
      case PickingStage.pickup:
        break;
      case PickingStage.dropoff:
        state = state.copyWith(
          stage: PickingStage.pickup,
          pickup: null,
          pickupLabel: null,
        );
      case PickingStage.done:
        state = state.copyWith(
          stage: PickingStage.dropoff,
          dropoff: null,
          dropoffLabel: null,
        );
    }
  }

  void reset() => state = const RideDraftState();
}
