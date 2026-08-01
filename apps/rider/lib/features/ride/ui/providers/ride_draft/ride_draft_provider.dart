import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/location/point_label_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';

part 'ride_draft_provider.g.dart';

@Riverpod(keepAlive: true)
class RideDraft extends _$RideDraft {
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
        goBackOneStep();
    }
  }

  void goBackOneStep() {
    switch (state.stage) {
      case PickingStage.pickup:
        break;

      case PickingStage.dropoff:
        state = const RideDraftState();

      case PickingStage.done:
        state = RideDraftState(
          stage: PickingStage.dropoff,
          pickup: state.pickup,
          pickupLabel: state.pickupLabel,
        );
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
    // A failed or nameless lookup must still leave a usable label behind: the
    // tracking and completion screens read these and have no fallback of their
    // own, so a null here renders as a blank origin/destination.
    final label = await _resolveLabel(point);

    if (!ref.mounted) return;
    if (isPickup && state.pickup == point) {
      state = state.withPickupLabel(label);
    } else if (!isPickup && state.dropoff == point) {
      state = state.withDropoffLabel(label);
    }
  }

  Future<String> _resolveLabel(LatLng point) async {
    final fallback = RideFormatters.coordinates(
      point.latitude,
      point.longitude,
    );

    try {
      final label = await ref.read(
        pointLabelProvider(
          GeoPoint(latitude: point.latitude, longitude: point.longitude),
        ).future,
      );
      return label.isEmpty ? fallback : label;
    } catch (_) {
      return fallback;
    }
  }
}
