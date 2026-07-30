import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/repo/geocoding_repo.dart';
import 'package:wasal/features/ride/data/repo/ride_repo.dart';
import 'package:wasal/features/ride/data/repo/route_repo.dart';
import 'package:wasal/features/ride/data/services/geocodng_api_service.dart';
import 'package:wasal/features/ride/domain/repo/base_geocoding_repo.dart';
import 'package:wasal/features/ride/domain/usecases/cancel_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/get_point_label_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/get_ride_price_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/get_route_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/request_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/watch_ride_use_case.dart';

part 'ride_use_case_providers.g.dart';

@riverpod
BaseGeocodingRepo geocodingRepo(Ref ref) {
  final geocodingApiService = ref.watch(geocodingApiServiceProvider);
  return GeocodingRepo(geocodingApiService);
}

@riverpod
GetPointLabelUseCase getPointLabelUseCase(Ref ref) {
  final geocodingRepo = ref.watch(geocodingRepoProvider);
  return GetPointLabelUseCase(geocodingRepo);
}

@riverpod
GetRidePriceUseCase getRidePriceUseCase(Ref ref) {
  final rideRepo = ref.watch(rideRepoProvider);
  return GetRidePriceUseCase(rideRepo);
}

@riverpod
GetRouteUseCase getRouteUseCase(Ref ref) {
  final routeRepo = ref.watch(routeRepoProvider);
  return GetRouteUseCase(routeRepo);
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
