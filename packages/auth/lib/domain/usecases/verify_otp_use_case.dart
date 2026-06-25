import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasel_auth/domain/entities/verify_otp.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class VerifyOtpUseCase
    extends
        CancellableUseCase<ApiResults<VerifyOtp>, VerifyOtpRequest> {
  final BaseAuthRepo authRepo;

  VerifyOtpUseCase(this.authRepo);

  @override
  Future<ApiResults<VerifyOtp>> execute(
    VerifyOtpRequest params,
    CancelToken cancelToken,
  ) {
    return authRepo.verifyOtp(params, cancelToken: cancelToken);
  }
}
