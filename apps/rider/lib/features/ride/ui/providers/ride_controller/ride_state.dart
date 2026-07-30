import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';

part 'ride_state.freezed.dart';

enum RideStage {
  idel,
  searching,
  accepted,
  arrived,
  inProgress,
  completed,
  cancelled,
}

@freezed
abstract class RideState with _$RideState {
  const factory RideState({
    @Default(RideStage.idel) RideStage stage,
    DriverProfile? driver,
    GeoPoint? driverPosition,
    @Default(false) bool isLoading,
    String? error,
  }) = _RideState;
}
