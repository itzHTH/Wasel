import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  String get cardTitle => switch (stage) {
    PickingStage.pickup => 'حدّد نقطة الانطلاق',
    PickingStage.dropoff => 'وين تريد تروح؟',
    PickingStage.done => 'تأكدلي من التفاصيل',
  };

  String get confirmButtonLabel => switch (stage) {
    PickingStage.pickup => 'تأكيد الانطلاق',
    PickingStage.dropoff => 'تأكيد الوجهة',
    PickingStage.done => 'تعديل',
  };

  bool get showBackButton => stage != PickingStage.pickup;

  bool get showMovingPin => stage != PickingStage.done;

  bool get isStarterPoint => stage == PickingStage.pickup;

  bool get showRequestPriceButton => stage == PickingStage.done;
}
