import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
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

  @override
  FutureOr<void> build() {
    return null;
  }
}
