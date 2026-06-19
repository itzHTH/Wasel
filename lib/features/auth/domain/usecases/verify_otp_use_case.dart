import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/response/verify_otp_respons.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class VerifyOtpUseCase
    extends
        CancellableUseCase<ApiResults<VerifyOtpResponse>, VerifyOtpRequest> {
  final BaseAuthRepo authRepo;

  VerifyOtpUseCase(this.authRepo);

  @override
  Future<ApiResults<VerifyOtpResponse>> execute(
    VerifyOtpRequest params,
    CancelToken cancelToken,
  ) {
    return authRepo.verifyOtp(params, cancelToken: cancelToken);
  }
}
