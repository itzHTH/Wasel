import 'package:driver/features/ride/data/repos/driver_foreground_repo.dart';
import 'package:driver/features/ride/data/repos/ride_repo.dart';
import 'package:driver/features/ride/domain/use_case/accept_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/arrive_at_start_point_use_case.dart';
import 'package:driver/features/ride/domain/use_case/change_payment_method_use_case.dart';
import 'package:driver/features/ride/domain/use_case/complete_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/driver_cancel_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/ensure_foreground_ready_use_case.dart';
import 'package:driver/features/ride/domain/use_case/ensure_foreground_unrestricted_use_case.dart';
import 'package:driver/features/ride/domain/use_case/is_foreground_service_running_use_case.dart';
import 'package:driver/features/ride/domain/use_case/reconnect_to_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/start_foreground_service_use_case.dart';
import 'package:driver/features/ride/domain/use_case/start_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/stop_foreground_service_use_case.dart';
import 'package:driver/features/ride/domain/use_case/update_driver_location_use_case.dart';
import 'package:driver/features/ride/domain/use_case/update_foreground_notification_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_connection_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_di_providers.g.dart';

@riverpod
WatchRideEventUseCase watchRideEventUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return WatchRideEventUseCase(repo);
}

@riverpod
WatchRideConnectionUseCase watchRideConnectionUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return WatchRideConnectionUseCase(repo);
}

@riverpod
UpdateDriverLocationUseCase updateDriverLocationUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return UpdateDriverLocationUseCase(repo);
}

@riverpod
AcceptRideUseCase acceptRideUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return AcceptRideUseCase(repo);
}

@riverpod
ArriveAtStartPointUseCase arriveAtStartPointUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return ArriveAtStartPointUseCase(repo);
}

@riverpod
StartRideUseCase startRideUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return StartRideUseCase(repo);
}

@riverpod
ChangePaymentMethodUseCase changePaymentMethodUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return ChangePaymentMethodUseCase(repo);
}

@riverpod
CompleteRideUseCase completeRideUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return CompleteRideUseCase(repo);
}

@riverpod
DriverCancelRideUseCase driverCancelRideUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return DriverCancelRideUseCase(repo);
}

@riverpod
ReconnectToRideUseCase reconnectToRideUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return ReconnectToRideUseCase(repo);
}

@riverpod
EnsureForegroundReadyUseCase ensureForegroundReadyUseCase(Ref ref) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return EnsureForegroundReadyUseCase(repo);
}

@riverpod
EnsureForegroundUnrestrictedUseCase ensureForegroundUnrestrictedUseCase(
  Ref ref,
) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return EnsureForegroundUnrestrictedUseCase(repo);
}

@riverpod
StartForegroundServiceUseCase startForegroundServiceUseCase(Ref ref) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return StartForegroundServiceUseCase(repo);
}

@riverpod
UpdateForegroundNotificationUseCase updateForegroundNotificationUseCase(
  Ref ref,
) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return UpdateForegroundNotificationUseCase(repo);
}

@riverpod
StopForegroundServiceUseCase stopForegroundServiceUseCase(Ref ref) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return StopForegroundServiceUseCase(repo);
}

@riverpod
IsForegroundServiceRunningUseCase isForegroundServiceRunningUseCase(Ref ref) {
  final repo = ref.watch(driverForegroundRepoProvider);
  return IsForegroundServiceRunningUseCase(repo);
}
