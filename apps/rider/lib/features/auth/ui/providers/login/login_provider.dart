import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/data/models/login/request/login_request.dart';
import 'package:wasel_auth/domain/entities/login.dart' as entity;
import 'package:wasel_auth/providers/auth_use_case_providers.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(loginUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      LoginRequest(email: email, password: password),
    );

    result.when(
      failure: (error) => state = AsyncValue.error(
        error.apiErrorModel.message ?? "حصل خطأ ما",
        StackTrace.current,
      ),
      success: (response) => state = AsyncValue.data(response),
    );
  }

  @override
  FutureOr<entity.Login?> build() {
    return null;
  }
}
