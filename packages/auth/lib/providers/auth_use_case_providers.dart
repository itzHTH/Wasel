import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_auth/data/repo/auth_repo.dart';
import 'package:wasel_auth/domain/usecases/complete_registration_use_case.dart';
import 'package:wasel_auth/domain/usecases/initiate_registeration_use_case.dart';
import 'package:wasel_auth/domain/usecases/forgot_password_use_case.dart';
import 'package:wasel_auth/domain/usecases/login_use_case.dart';
import 'package:wasel_auth/domain/usecases/logout_use_case.dart';
import 'package:wasel_auth/domain/usecases/reset_password_use_case.dart';
import 'package:wasel_auth/domain/usecases/verify_otp_use_case.dart';
import 'package:wasel_auth/domain/usecases/verify_reset_otp_use_case.dart';

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

@riverpod
VerifyOtpUseCase verifyOtpUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return VerifyOtpUseCase(authRepo);
}

@riverpod
CompleteRegistrationUseCase completeRegistrationUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return CompleteRegistrationUseCase(authRepo);
}

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return LogoutUseCase(authRepo);
}

@riverpod
ForgotPasswordUseCase forgotPasswordUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return ForgotPasswordUseCase(authRepo);
}

@riverpod
VerifyResetOtpUseCase verifyResetOtpUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return VerifyResetOtpUseCase(authRepo);
}

@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final authRepo = ref.watch(authRepoProvider);
  return ResetPasswordUseCase(authRepo);
}
