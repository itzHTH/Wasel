import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/repo/ride_repo.dart';
import 'package:wasal/features/ride/domain/usecases/cancel_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/get_ride_price_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/request_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/watch_ride_use_case.dart';

part 'ride_use_case_providers.g.dart';

@riverpod
GetRidePriceUseCase getRidePriceUseCase(Ref ref) {
  final rideRepo = ref.watch(rideRepoProvider);
  return GetRidePriceUseCase(rideRepo);
}

@riverpod
RequestRideUseCase requestRideUseCase(Ref ref) {
  final rideRepo = ref.watch(rideRepoProvider);
  return RequestRideUseCase(rideRepo);
}

@riverpod
WatchRideUseCase watchRideUseCase(Ref ref) {
  final rideRepo = ref.watch(rideRepoProvider);
  return WatchRideUseCase(rideRepo);
}

@riverpod
CancelRideUseCase cancelRideUseCase(Ref ref) {
  final rideRepo = ref.watch(rideRepoProvider);
  return CancelRideUseCase(rideRepo);
}
