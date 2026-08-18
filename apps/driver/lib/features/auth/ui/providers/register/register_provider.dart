import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasel_auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasel_auth/domain/entities/complete_registration.dart';
import 'package:wasel_auth/domain/entities/initiate_registeration.dart';
import 'package:wasel_auth/domain/entities/verify_otp.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

part 'register_provider.g.dart';

// Reuses the shared wasel_auth use cases. Login shares `/api/v1/Auth/login`
// with the rider; the registration flow hits the driver endpoints because the
// driver app overrides `authUserTypeProvider` -> AuthUserType.driver at its
// root ProviderScope (see main_common.dart).
@riverpod
class Register extends _$Register {
  Future<InitiateRegisteration?> initiateRegistration(
    String email,
  ) async {
    state = const AsyncValue<InitiateRegisteration>.loading();

    final useCase = ref.read(initiateRegistrationUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      InitiateRegisterationRequest(email: email),
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
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      VerifyOtpRequest(sessionToken: sessionToken, otpCode: otp),
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
    required String city,
    required String address,
  }) async {
    state = const AsyncValue<CompleteRegistration>.loading();

    final useCase = ref.read(completeRegistrationUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      CompleteRegistrationRequest(
        registerToken: registrationToken,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phoneNumber: phone,
        city: city,
        address: address,
      ),
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
        ref.invalidate(driverProfileControllerProvider);
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
