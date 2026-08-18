import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/data/models/login/request/login_request.dart';
import 'package:wasel_auth/domain/entities/login.dart' as entity;
import 'package:wasel_auth/domain/usecases/login_use_case.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final result = await ref
        .read(loginUseCaseProvider)
        .call(LoginRequest(email: email.toLowerCase(), password: password));

    if (!ref.mounted) return;

    result.when(
      failure: (error) {
        if (error.isCancelled) return;
        state = AsyncValue.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
      },
      success: (response) {
        //* Drop any profile cached for the previous account before the UI
        //* navigates to a screen that reads it.
        ref.invalidate(driverProfileControllerProvider);
        state = AsyncValue.data(response);
      },
    );
  }

  late final LoginUseCase _useCase;

  @override
  FutureOr<entity.Login?> build() {
    // Held so cancel-on-dispose targets the instance that runs the request.
    _useCase = ref.read(loginUseCaseProvider);
    ref.onDispose(_useCase.cancel);
    return null;
  }
}
