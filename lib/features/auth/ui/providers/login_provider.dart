import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/networking/dio_factory.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/data/repo/auth_repo.dart';
import 'package:wasal/features/auth/data/services/auth_api_service.dart';
import 'package:wasal/features/auth/domain/usecases/login_use_case.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading();
    final useCase = LoginUseCase(
      AuthRepo(AuthApiService(DioFactory.instance.dio)),
    );
    final result = await useCase.execute(request, CancelToken());
    result.when(
      failure: (error) => state = AsyncValue.error(
        error.apiErrorModel.message ?? "حصل خطأ ما",
        StackTrace.current,
      ),
      success: (response) => state = AsyncValue.data(response),
    );
  }

  @override
  FutureOr<LoginResponse?> build() {
    return null;
  }
}
