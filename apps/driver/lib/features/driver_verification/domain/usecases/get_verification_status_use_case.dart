import 'package:dio/dio.dart';
import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:driver/features/driver_verification/domain/repo/base_verify_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class GetVerificationStatusUseCase
    extends CancellableUseCase<ApiResults<VerificationStatus>, void> {
  final BaseVerifyRepo _repo;

  GetVerificationStatusUseCase(this._repo);

  @override
  Future<ApiResults<VerificationStatus>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _repo.getVerificationStatus();
  }
}
