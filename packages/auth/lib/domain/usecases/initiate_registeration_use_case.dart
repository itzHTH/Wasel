import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasel_auth/domain/entities/initiate_registeration.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

class InitiateRegisterationUseCase
    extends
        CancellableUseCase<
          ApiResults<InitiateRegisteration>,
          InitiateRegisterationRequest
        > {
  final BaseAuthRepo _authRepo;

  InitiateRegisterationUseCase(this._authRepo);

  @override
  Future<ApiResults<InitiateRegisteration>> execute(
    InitiateRegisterationRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.initiateRegistration(params, cancelToken: cancelToken);
  }
}
