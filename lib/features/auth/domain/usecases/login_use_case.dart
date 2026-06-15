import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class LoginUseCase
    extends CancellableUseCase<ApiResults<LoginResponse>, LoginRequest> {
  final BaseAuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<ApiResults<LoginResponse>> execute(
    LoginRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.login(params, cancelToken: cancelToken);
  }
}
