import 'package:dio/dio.dart';
import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/domain/entities/submit_driver_profile.dart';
import 'package:driver/features/driver_verification/domain/repo/base_verify_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class SubmitDriverProfileUseCase
    extends
        CancellableUseCase<
          ApiResults<SubmitDriverProfile>,
          SubmitDriverProfileParams
        > {
  final BaseVerifyRepo _repo;

  SubmitDriverProfileUseCase(this._repo);

  @override
  Future<ApiResults<SubmitDriverProfile>> execute(
    SubmitDriverProfileParams params,
    CancelToken cancelToken,
  ) {
    return _repo.submitProfile(
      params.submission,
      onProgress: params.onProgress,
      cancelToken: cancelToken,
    );
  }
}

class SubmitDriverProfileParams {
  final DriverProfileSubmission submission;
  final void Function(double progress)? onProgress;

  const SubmitDriverProfileParams(this.submission, {this.onProgress});
}
