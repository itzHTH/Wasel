import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasal/features/auth/ui/providers/auth_use_case_providers.dart';

part 'logout.g.dart';

@riverpod
class Logout extends _$Logout {
  @override
  Future<bool> build() async {
    return false; // Initial state is false, indicating not logged out
  }

  Future<bool> execute() async {
    state = const AsyncValue.loading();
    final logoutUseCase = ref.watch(logoutUseCaseProvider);
    ref.onDispose(logoutUseCase.cancel);
    final result = await logoutUseCase.call(null);
    return result.when(
      success: (data) {
        state = AsyncValue.data(data.success);
        return data.success;
      },
      failure: (error) {
        state = AsyncValue.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
        return false;
      },
    );
  }
}
