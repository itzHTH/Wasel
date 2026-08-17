import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/reset_password/verify_reset_otp/request/verify_reset_otp_request.dart';
import 'package:wasel_auth/domain/entities/verify_reset_otp.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class VerifyResetOtpUseCase
    extends
        CancellableUseCase<ApiResults<VerifyResetOtp>, VerifyResetOtpRequest> {
  final BaseAuthRepo _authRepo;

  VerifyResetOtpUseCase(this._authRepo);

  @override
  Future<ApiResults<VerifyResetOtp>> execute(
    VerifyResetOtpRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.verifyResetOtp(params, cancelToken: cancelToken);
  }
}
