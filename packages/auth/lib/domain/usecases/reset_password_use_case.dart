import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/reset_password/set_new_password/request/reset_password_request.dart';
import 'package:wasel_auth/domain/entities/reset_password.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class ResetPasswordUseCase
    extends
        CancellableUseCase<ApiResults<ResetPassword>, ResetPasswordRequest> {
  final BaseAuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  @override
  Future<ApiResults<ResetPassword>> execute(
    ResetPasswordRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.resetPassword(params, cancelToken: cancelToken);
  }
}
