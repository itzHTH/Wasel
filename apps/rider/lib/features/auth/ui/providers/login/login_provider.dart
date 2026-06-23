import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/domain/entities/login.dart' as entity;
import 'package:wasal/features/auth/ui/providers/auth_use_case_providers.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(loginUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(request);

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
