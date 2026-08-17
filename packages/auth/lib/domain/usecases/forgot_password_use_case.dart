import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/reset_password/forgot_password/request/forgot_password_request.dart';
import 'package:wasel_auth/domain/entities/forgot_password.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class ForgotPasswordUseCase
    extends
        CancellableUseCase<ApiResults<ForgotPassword>, ForgotPasswordRequest> {
  final BaseAuthRepo _authRepo;

  ForgotPasswordUseCase(this._authRepo);

  @override
  Future<ApiResults<ForgotPassword>> execute(
    ForgotPasswordRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.forgotPassword(params, cancelToken: cancelToken);
  }
}
