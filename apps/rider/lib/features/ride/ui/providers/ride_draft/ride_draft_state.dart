import 'dart:ui' show Color;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_core/theme/app_color.dart';

part 'ride_draft_state.freezed.dart';

enum PickingStage { pickup, dropoff, done }

@freezed
abstract class RideDraftState with _$RideDraftState {
  const factory RideDraftState({
    @Default(PickingStage.pickup) PickingStage stage,
    LatLng? pickup,
    String? pickupLabel,
    LatLng? dropoff,
    String? dropoffLabel,
  }) = _RideDraftState;

  const RideDraftState._();

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

  /// Tint applied to the moving pin. Null keeps the SVG's natural brand
  /// colors (pickup); dropoff gets a solid dark pin to signal the stage.
  Color? get pinTint => switch (stage) {
    PickingStage.pickup => null,
    PickingStage.dropoff => AppColor.secondary500,
    PickingStage.done => null,
  };

  String get summaryText {
    final lines = [
      if (pickup != null) 'الانطلاق: ${pickupLabel ?? _format(pickup!)}',
      if (dropoff != null) 'الوجهة: ${dropoffLabel ?? _format(dropoff!)}',
    ];
    return lines.join('\n');
  }

  static String _format(LatLng point) =>
      '${point.latitude.toStringAsFixed(5)}، ${point.longitude.toStringAsFixed(5)}';
}
