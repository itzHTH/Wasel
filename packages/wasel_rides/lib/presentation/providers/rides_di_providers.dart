import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/dio/dio_factory.dart';
import 'package:wasel_rides/data/repos/active_ride_repo.dart';
import 'package:wasel_rides/data/repos/rides_history_repo.dart';
import 'package:wasel_rides/data/services/rides_api_service.dart';
import 'package:wasel_rides/domain/repos/base_active_ride_repo.dart';
import 'package:wasel_rides/domain/repos/base_rides_history_repo.dart';
import 'package:wasel_rides/domain/usecases/get_active_ride_use_case.dart';
import 'package:wasel_rides/domain/usecases/get_ride_history_use_case.dart';

part 'rides_di_providers.g.dart';

@riverpod
RidesApiService ridesApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return RidesApiService(dio);
}

@riverpod
BaseRidesHistoryRepo ridesHistoryRepo(Ref ref) {
  final ridesApiService = ref.watch(ridesApiServiceProvider);
  return RidesHistoryRepo(ridesApiService);
}

@riverpod
GetRideHistoryUseCase getRideHistoryUseCase(Ref ref) {
  final ridesHistoryRepo = ref.watch(ridesHistoryRepoProvider);
  return GetRideHistoryUseCase(ridesHistoryRepo);
}

@riverpod
BaseActiveRideRepo activeRideRepo(Ref ref) {
  final ridesApiService = ref.watch(ridesApiServiceProvider);
  return ActiveRideRepo(ridesApiService);
}

@riverpod
GetActiveRideUseCase getActiveRideUseCase(Ref ref) {
  final activeRideRepo = ref.watch(activeRideRepoProvider);
  return GetActiveRideUseCase(activeRideRepo);
}
