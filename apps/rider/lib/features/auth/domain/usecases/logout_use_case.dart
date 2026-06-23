import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/domain/entities/logout.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class LogoutUseCase
    extends CancellableUseCase<ApiResults<Logout>, void> {
  final BaseAuthRepo _authRepo;

  LogoutUseCase(this._authRepo);

  @override
  Future<ApiResults<Logout>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _authRepo.logout(cancelToken: cancelToken);
  }
}
