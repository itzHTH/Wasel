import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/response/verify_otp_respons.dart';
import 'package:wasal/features/auth/ui/providers/auth_use_case_providers.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  Future<InitiateRegisterationResponse?> initiateRegistration(
    String email,
  ) async {
    state = const AsyncValue<InitiateRegisterationResponse>.loading();

    final useCase = ref.read(initiateRegistrationUseCaseProvider);

    final result = await useCase.execute(
      InitiateRegisterationRequest(email: email),
      CancelToken(),
    );

    return result.when(
      failure: (error) {
        state = AsyncValue<InitiateRegisterationResponse>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<InitiateRegisterationResponse>.data(response);
        return response;
      },
    );
  }

  Future<VerifyOtpResponse?> verifyOtp({
    required String sessionToken,
    required String otp,
  }) async {
    state = const AsyncValue<VerifyOtpResponse>.loading();

    final useCase = ref.read(verifyOtpUseCaseProvider);

    final result = await useCase.execute(
      VerifyOtpRequest(sessionToken: sessionToken, otpCode: otp),
      CancelToken(),
    );

    return result.when(
      failure: (error) {
        state = AsyncValue<VerifyOtpResponse>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<VerifyOtpResponse>.data(response);
        return response;
      },
    );
  }

  Future<CompleteRegistrationResponse?> completeRegistration({
    required String registrationToken,
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
  }) async {
    state = const AsyncValue<CompleteRegistrationResponse>.loading();

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
        state = AsyncValue<CompleteRegistrationResponse>.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return null;
      },

      success: (response) {
        state = AsyncValue<CompleteRegistrationResponse>.data(response);
        return response;
      },
    );
  }

  @override
  FutureOr<void> build() {
    return null;
  }
}
