import 'package:driver/features/ride/data/repos/ride_repo.dart';
import 'package:driver/features/ride/data/repos/route_repo.dart';
import 'package:driver/features/ride/domain/use_case/accept_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/arrive_at_start_point_use_case.dart';
import 'package:driver/features/ride/domain/use_case/complete_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/driver_cancel_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/get_driver_balance_use_case.dart';
import 'package:driver/features/ride/domain/use_case/get_route_use_case.dart';
import 'package:driver/features/ride/domain/use_case/start_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/update_driver_location_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_use_case_providers.g.dart';

@riverpod
WatchRideEventUseCase watchRideEventUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return WatchRideEventUseCase(repo);
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
GetRouteUseCase getRouteUseCase(Ref ref) {
  final repo = ref.watch(routeRepoProvider);
  return GetRouteUseCase(repo);
}

@riverpod
GetDriverBalanceUseCase getDriverBalanceUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return GetDriverBalanceUseCase(repo);
}
