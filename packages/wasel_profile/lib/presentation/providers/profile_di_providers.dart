import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/dio/dio_factory.dart';
import 'package:wasel_profile/data/repos/profile_repo.dart';
import 'package:wasel_profile/data/services/profile_api_service.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';
import 'package:wasel_profile/domain/usecases/get_driver_profile_use_case.dart';
import 'package:wasel_profile/domain/usecases/get_rider_profile_use_case.dart';
import 'package:wasel_profile/domain/usecases/update_rider_photo_use_case.dart';

part 'profile_di_providers.g.dart';

@riverpod
ProfileApiService profileApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return ProfileApiService(dio);
}

@riverpod
BaseProfileRepo profileRepo(Ref ref) {
  final profileApiService = ref.watch(profileApiServiceProvider);
  return ProfileRepo(profileApiService);
}

@riverpod
GetRiderProfileUseCase getRiderProfileUseCase(Ref ref) {
  final profileRepo = ref.watch(profileRepoProvider);
  return GetRiderProfileUseCase(profileRepo);
}

@riverpod
GetDriverProfileUseCase getDriverProfileUseCase(Ref ref) {
  final profileRepo = ref.watch(profileRepoProvider);
  return GetDriverProfileUseCase(profileRepo);
}

@riverpod
UpdateRiderPhotoUseCase updateRiderPhotoUseCase(Ref ref) {
  final profileRepo = ref.watch(profileRepoProvider);
  return UpdateRiderPhotoUseCase(profileRepo);
}
