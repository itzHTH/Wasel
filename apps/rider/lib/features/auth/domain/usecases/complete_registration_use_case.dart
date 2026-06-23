import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/domain/entities/complete_registration.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class CompleteRegistrationUseCase
    extends
        CancellableUseCase<
          ApiResults<CompleteRegistration>,
          CompleteRegistrationRequest
        > {
  final BaseAuthRepo _authRepo;
  CompleteRegistrationUseCase(this._authRepo);

  @override
  Future<ApiResults<CompleteRegistration>> execute(
    CompleteRegistrationRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.completeRegistration(params, cancelToken: cancelToken);
  }
}
