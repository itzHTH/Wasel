import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/usecase/cancellable_use_case.dart';
import 'package:wasal/features/auth/data/models/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

class InitiateRegisterationUseCase
    extends
        CancellableUseCase<
          ApiResults<InitiateRegisterationResponse>,
          InitiateRegisterationRequest
        > {
  final BaseAuthRepo _authRepo;

  InitiateRegisterationUseCase(this._authRepo);

  @override
  Future<ApiResults<InitiateRegisterationResponse>> execute(
    InitiateRegisterationRequest params,
    CancelToken cancelToken,
  ) {
    return _authRepo.initiateRegistration(params, cancelToken: cancelToken);
  }
}
