import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/login/request/login_request.dart';
import 'package:wasel_auth/domain/entities/login.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class LoginUseCase
    extends CancellableUseCase<ApiResults<Login>, LoginRequest> {
  final BaseAuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<ApiResults<Login>> execute(
    LoginRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.login(params, cancelToken: cancelToken);
  }
}
