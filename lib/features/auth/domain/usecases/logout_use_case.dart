import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/logout/request/logout_request.dart';
import 'package:wasal/features/auth/data/models/logout/response/logout_response.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class LogoutUseCase
    extends CancellableUseCase<ApiResults<LogoutResponse>, LogoutRequest> {
  final BaseAuthRepo _authRepo;

  LogoutUseCase(this._authRepo);

  @override
  Future<ApiResults<LogoutResponse>> execute(
    LogoutRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.logout(params.refreshToken, cancelToken: cancelToken);
  }
}
