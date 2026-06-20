import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/domain/entities/complete_registration.dart';
import 'package:wasal/features/auth/domain/entities/initiate_registeration.dart';
import 'package:wasal/features/auth/domain/entities/verify_otp.dart';
import 'package:wasal/features/auth/ui/providers/auth_use_case_providers.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  Future<InitiateRegisteration?> initiateRegistration(
    String email,
  ) async {
    state = const AsyncValue<InitiateRegisteration>.loading();

    final useCase = ref.read(initiateRegistrationUseCaseProvider);

    final result = await useCase.execute(
      InitiateRegisterationRequest(email: email),
      CancelToken(),
    );

    return result.when(
      failure: (error) {
        state = AsyncValue<InitiateRegisteration>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<InitiateRegisteration>.data(response);
        return response;
      },
    );
  }

  Future<VerifyOtp?> verifyOtp({
    required String sessionToken,
    required String otp,
  }) async {
    state = const AsyncValue<VerifyOtp>.loading();

    final useCase = ref.read(verifyOtpUseCaseProvider);

    final result = await useCase.execute(
      VerifyOtpRequest(sessionToken: sessionToken, otpCode: otp),
      CancelToken(),
    );

    return result.when(
      failure: (error) {
        state = AsyncValue<VerifyOtp>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<VerifyOtp>.data(response);
        return response;
      },
    );
  }

  Future<CompleteRegistration?> completeRegistration({
    required String registrationToken,
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
  }) async {
    state = const AsyncValue<CompleteRegistration>.loading();

    final useCase = ref.read(completeRegistrationUseCaseProvider);

    final result = await useCase.execute(
      CompleteRegistrationRequest(
        registerToken: registrationToken,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phoneNumber: phone,
      ),
      CancelToken(),
    );

    return result.when(
      failure: (error) {
        state = AsyncValue<CompleteRegistration>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<CompleteRegistration>.data(response);
        return response;
      },
    );
  }

  @override
  FutureOr<void> build() {
    return null;
  }
}
