import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';

part 'logout.g.dart';

@riverpod
class Logout extends _$Logout {
  @override
  Future<bool> build() async {
    return false; // Initial state is false, indicating not logged out
  }

  /// Always reports the device as signed out: the repo drops the local session
  /// even when revoking the refresh token server-side fails.
  Future<bool> execute() async {
    state = const AsyncValue.loading();
    final logoutUseCase = ref.read(logoutUseCaseProvider);
    ref.onDispose(logoutUseCase.cancel);

    final result = await logoutUseCase.call(null);

    result.when(
      success: (data) => state = AsyncValue.data(data.success),
      failure: (error) => state = AsyncValue.error(
        error.apiErrorModel.message ?? "حصل خطأ ما",
        StackTrace.current,
      ),
    );

    return true;
  }
}
