import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasel_auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasel_auth/domain/entities/complete_registration.dart';
import 'package:wasel_auth/domain/entities/initiate_registeration.dart';
import 'package:wasel_auth/domain/entities/verify_otp.dart';
import 'package:wasel_auth/domain/usecases/complete_registration_use_case.dart';
import 'package:wasel_auth/domain/usecases/initiate_registeration_use_case.dart';
import 'package:wasel_auth/domain/usecases/verify_otp_use_case.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  Future<InitiateRegisteration?> initiateRegistration(String email) async {
    state = const AsyncValue<InitiateRegisteration>.loading();

    final result = await ref
        .read(initiateRegistrationUseCaseProvider)
        .call(InitiateRegisterationRequest(email: email.toLowerCase()));

    if (!ref.mounted) return null;

    return result.when(
      failure: (error) {
        if (!error.isCancelled) {
          state = AsyncValue<InitiateRegisteration>.error(
            error.apiErrorModel.message ?? "حصل خطأ ما",
            StackTrace.current,
          );
        }
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

    final result = await _verifyOtp.call(
      VerifyOtpRequest(sessionToken: sessionToken, otpCode: otp),
    );

    if (!ref.mounted) return null;

    return result.when(
      failure: (error) {
        if (!error.isCancelled) {
          state = AsyncValue<VerifyOtp>.error(
            error.apiErrorModel.message ?? "حصل خطأ ما",
            StackTrace.current,
          );
        }
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

    final result = await _complete.call(
          CompleteRegistrationRequest(
            registerToken: registrationToken,
            firstName: firstName,
            lastName: lastName,
            password: password,
            phoneNumber: phone,
          ),
        );

    if (!ref.mounted) return null;

    return result.when(
      failure: (error) {
        if (!error.isCancelled) {
          state = AsyncValue<CompleteRegistration>.error(
            error.apiErrorModel.message ?? "حصل خطأ ما",
            StackTrace.current,
          );
        }
        return null;
      },

      success: (response) {
        ref.invalidate(riderProfileControllerProvider);
        state = AsyncValue<CompleteRegistration>.data(response);
        return response;
      },
    );
  }

  late final InitiateRegisterationUseCase _initiate;
  late final VerifyOtpUseCase _verifyOtp;
  late final CompleteRegistrationUseCase _complete;

  @override
  FutureOr<void> build() {
    // Held so cancel-on-dispose targets the instances that run the requests.
    _initiate = ref.read(initiateRegistrationUseCaseProvider);
    _verifyOtp = ref.read(verifyOtpUseCaseProvider);
    _complete = ref.read(completeRegistrationUseCaseProvider);

    ref.onDispose(_initiate.cancel);
    ref.onDispose(_verifyOtp.cancel);
    ref.onDispose(_complete.cancel);
    return null;
  }
}
