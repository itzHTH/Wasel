import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'ride_draft_provider.g.dart';

/// keepAlive: the draft must survive leaving and re-entering the screen
/// mid-flow; [reset] is the explicit way to discard it.
@Riverpod(keepAlive: true)
class RideDraft extends _$RideDraft {
  /// Ignore a second confirm arriving within this window (rapid double-tap
  /// must not advance two stages with the same point).
  static const _confirmDebounce = Duration(milliseconds: 500);
  DateTime? _lastConfirmAt;

  @override
  RideDraftState build() => const RideDraftState();

  void confirmCurrentPoint(LatLng center) {
    if (_isDoubleTap()) return;

    switch (state.stage) {
      case PickingStage.pickup:
        state = RideDraftState(stage: PickingStage.dropoff, pickup: center);
        _storeLabelFor(center, isPickup: true);

      case PickingStage.dropoff:
        state = RideDraftState(
          stage: PickingStage.done,
          pickup: state.pickup,
          pickupLabel: state.pickupLabel,
          dropoff: center,
        );
        _storeLabelFor(center, isPickup: false);

      case PickingStage.done:
        // At done the confirm slot means "تعديل": step back to re-pick the
        // dropoff, keeping the widget free of stage branching.
        goBackOneStep();
    }
  }

  void goBackOneStep() {
    switch (state.stage) {
      case PickingStage.pickup:
        break; // Nothing to go back to.

      case PickingStage.dropoff:
        state = const RideDraftState(); // Back to picking the pickup.

      case PickingStage.done:
        state = RideDraftState(
          stage: PickingStage.dropoff,
          pickup: state.pickup,
          pickupLabel: state.pickupLabel,
        ); // Dropoff cleared, pickup kept.
    }
  }

  void reset() => state = const RideDraftState();

  bool _isDoubleTap() {
    final now = DateTime.now();
    final last = _lastConfirmAt;
    _lastConfirmAt = now;
    return last != null && now.difference(last) < _confirmDebounce;
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
        state = state.withPickupLabel(label);
      } else if (!isPickup && state.dropoff == point) {
        state = state.withDropoffLabel(label);
      }
    } catch (_) {
      // Label stays null — the card keeps showing raw coordinates.
    }
  }
}
