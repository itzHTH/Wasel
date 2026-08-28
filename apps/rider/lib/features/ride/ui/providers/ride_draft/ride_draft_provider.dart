import 'package:wasel_core/wasel_core.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasel_location/wasel_location.dart';
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

    // A pin the rider never moved off the place they searched for keeps that
    // name; re-geocoding it would trade 'مول المنصور' for a street address.
    final searched = _takeSearched(center);

    switch (state.stage) {
      case PickingStage.pickup:
        state = RideDraftState(
          stage: PickingStage.dropoff,
          pickup: center,
          pickupLabel: searched,
        );
        if (searched == null) _storeLabelFor(center, isPickup: true);

      case PickingStage.dropoff:
        state = RideDraftState(
          stage: PickingStage.done,
          pickup: state.pickup,
          pickupLabel: state.pickupLabel,
          dropoff: center,
          dropoffLabel: searched,
        );
        if (searched == null) _storeLabelFor(center, isPickup: false);

      case PickingStage.done:
        goBackOneStep();
    }
  }

  LatLng? _searchedPoint;
  String? _searchedName;
  SearchFieldType? _searchedField;

  /// Remembers what the rider named in search, without pinning any of it.
  ///
  /// [field] is which endpoint they answered, and the stage follows it. The pin
  /// only ever fills the endpoint the card is asking for, so a destination
  /// picked while the card asks for an origin would otherwise be pinned as the
  /// origin — and vice versa.
  void noteSearchedPlace(GeoPoint point, String label, SearchFieldType field) {
    _searchedPoint = LatLng(point.latitude, point.longitude);
    _searchedName = label;
    _searchedField = field;

    final wanted = field.isPickup
        ? PickingStage.pickup
        // Only reachable once an origin exists; without one there is nothing
        // for a destination to be measured from.
        : (state.pickup == null ? state.stage : PickingStage.dropoff);

    if (wanted != state.stage) {
      state = RideDraftState(
        stage: wanted,
        pickup: state.pickup,
        pickupLabel: state.pickupLabel,
        dropoff: state.dropoff,
        dropoffLabel: state.dropoffLabel,
      );
    }
  }

  /// Consumed whole on every confirm, matched or not: a name left behind here
  /// would be claimed by whichever later pin happened to land on it.
  ///
  //! Compared with a tolerance, never `==`. The centre comes back from the
  //! platform camera after a Mercator round trip, so it is near-identical to
  //! what was requested but not bit-identical — an exact match would silently
  //! never hold, and every searched name would be re-geocoded away.
  String? _takeSearched(LatLng center) {
    final point = _searchedPoint;
    final name = _searchedName;
    final field = _searchedField;
    _clearSearched();

    if (point == null) return null;
    if (field?.isPickup != (state.stage == PickingStage.pickup)) return null;

    return _isSamePlace(point, center) ? name : null;
  }

  /// Roughly a metre: finer than the rider can aim, coarser than any rounding
  /// the camera introduces.
  static const _sameLatLngTolerance = 1e-5;

  static bool _isSamePlace(LatLng a, LatLng b) =>
      (a.latitude - b.latitude).abs() < _sameLatLngTolerance &&
      (a.longitude - b.longitude).abs() < _sameLatLngTolerance;

  void _clearSearched() {
    _searchedPoint = null;
    _searchedName = null;
    _searchedField = null;
  }

  void hydrateFrom(LatLng pickup, LatLng dropoff) {
    _clearSearched();

    state = RideDraftState(
      stage: PickingStage.done,
      pickup: pickup,
      dropoff: dropoff,
    );

    _storeLabelFor(pickup, isPickup: true);
    _storeLabelFor(dropoff, isPickup: false);
  }

  void goBackOneStep() {
    _clearSearched();

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

  void reset() {
    _clearSearched();
    state = const RideDraftState();
  }

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
      lookupRiderLocalizations(ref.read(appLocalizationControllerProvider)),
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
