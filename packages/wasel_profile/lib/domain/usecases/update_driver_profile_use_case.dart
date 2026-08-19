import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

class UpdateDriverProfileParams {
  final String phoneNumber;

  const UpdateDriverProfileParams({required this.phoneNumber});
}

class UpdateDriverProfileUseCase
    extends
        CancellableUseCase<
          ApiResults<void>,
          UpdateDriverProfileParams
        > {
  final BaseProfileRepo _profileRepo;

  UpdateDriverProfileUseCase(this._profileRepo);

  @override
  Future<ApiResults<void>> execute(
    UpdateDriverProfileParams params,
    CancelToken cancelToken,
  ) {
    return _profileRepo.updateDriverProfile(
      phoneNumber: params.phoneNumber,
      cancelToken: cancelToken,
    );
  }
}
