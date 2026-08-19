import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

class UpdateRiderProfileParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const UpdateRiderProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}

class UpdateRiderProfileUseCase
    extends
        CancellableUseCase<ApiResults<void>, UpdateRiderProfileParams> {
  final BaseProfileRepo _profileRepo;

  UpdateRiderProfileUseCase(this._profileRepo);

  @override
  Future<ApiResults<void>> execute(
    UpdateRiderProfileParams params,
    CancelToken cancelToken,
  ) {
    return _profileRepo.updateRiderProfile(
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
      cancelToken: cancelToken,
    );
  }
}
