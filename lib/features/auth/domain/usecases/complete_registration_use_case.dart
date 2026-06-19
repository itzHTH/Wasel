import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class CompleteRegistrationUseCase
    extends
        CancellableUseCase<
          ApiResults<CompleteRegistrationResponse>,
          CompleteRegistrationRequest
        > {
  final BaseAuthRepo _authRepo;
  CompleteRegistrationUseCase(this._authRepo);

  @override
  Future<ApiResults<CompleteRegistrationResponse>> execute(
    CompleteRegistrationRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.completeRegistration(params, cancelToken: cancelToken);
  }
}
