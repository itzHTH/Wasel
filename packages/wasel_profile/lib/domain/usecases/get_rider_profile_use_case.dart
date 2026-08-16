import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

class GetRiderProfileUseCase
    extends CancellableUseCase<ApiResults<RiderProfile>, void> {
  final BaseProfileRepo _profileRepo;

  GetRiderProfileUseCase(this._profileRepo);

  @override
  Future<ApiResults<RiderProfile>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _profileRepo.getRiderProfile(cancelToken: cancelToken);
  }
}
