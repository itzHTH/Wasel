import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

class GetDriverProfileUseCase
    extends CancellableUseCase<ApiResults<DriverProfile>, void> {
  final BaseProfileRepo _profileRepo;

  GetDriverProfileUseCase(this._profileRepo);

  @override
  Future<ApiResults<DriverProfile>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _profileRepo.getDriverProfile(cancelToken: cancelToken);
  }
}
