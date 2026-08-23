import 'package:wasal/l10n/rider_localizations.dart';
import 'package:wasel_location/wasel_location.dart';

enum PickingStage { pickup, dropoff, done }

class RideDraftState {
  final PickingStage stage;
  final LatLng? pickup;
  final String? pickupLabel;
  final LatLng? dropoff;
  final String? dropoffLabel;

  const RideDraftState({
    this.stage = PickingStage.pickup,
    this.pickup,
    this.pickupLabel,
    this.dropoff,
    this.dropoffLabel,
  });

  RideDraftState withPickupLabel(String label) => RideDraftState(
    stage: stage,
    pickup: pickup,
    pickupLabel: label,
    dropoff: dropoff,
    dropoffLabel: dropoffLabel,
  );

  RideDraftState withDropoffLabel(String label) => RideDraftState(
    stage: stage,
    pickup: pickup,
    pickupLabel: pickupLabel,
    dropoff: dropoff,
    dropoffLabel: label,
  );

  bool get showBackButton => stage != PickingStage.pickup;

  bool get showMovingPin => stage != PickingStage.done;

  bool get isStarterPoint => stage == PickingStage.pickup;

  bool get showRequestPriceButton => stage == PickingStage.done;
}

/// Copy hangs off the stage alone, so the card can watch just that rather
/// than the whole draft — which also changes when a geocoded label arrives.
extension PickingStageCopy on PickingStage {
  String cardTitle(RiderLocalizations l10n) => switch (this) {
    PickingStage.pickup => l10n.setPickup,
    PickingStage.dropoff => l10n.whereToGo,
    PickingStage.done => l10n.checkDetails,
  };

  String confirmButtonLabel(RiderLocalizations l10n) => switch (this) {
    PickingStage.pickup => l10n.confirmPickup,
    PickingStage.dropoff => l10n.confirmDestination,
    PickingStage.done => l10n.edit,
  };
}
