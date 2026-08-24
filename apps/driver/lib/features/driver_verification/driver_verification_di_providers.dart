import 'package:driver/features/driver_verification/data/repo/verify_repo.dart';
import 'package:driver/features/driver_verification/domain/usecases/get_verification_status_use_case.dart';
import 'package:driver/features/driver_verification/domain/usecases/submit_driver_profile_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_verification_di_providers.g.dart';

@riverpod
GetVerificationStatusUseCase getVerificationStatusUseCase(Ref ref) {
  final repo = ref.watch(verifyRepoProvider);
  return GetVerificationStatusUseCase(repo);
}

@riverpod
SubmitDriverProfileUseCase submitDriverProfileUseCase(Ref ref) {
  final repo = ref.watch(verifyRepoProvider);
  return SubmitDriverProfileUseCase(repo);
}
