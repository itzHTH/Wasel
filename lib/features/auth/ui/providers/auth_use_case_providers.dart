import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/auth/data/repo/auth_repo.dart';
import 'package:wasal/features/auth/domain/usecases/initiate_registeration_use_case.dart';
import 'package:wasal/features/auth/domain/usecases/login_use_case.dart';

part 'auth_use_case_providers.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return LoginUseCase(authRepo);
}

@riverpod
InitiateRegisterationUseCase initiateRegistrationUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return InitiateRegisterationUseCase(authRepo);
}
