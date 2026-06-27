import 'package:dio/dio.dart';
import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/domain/entities/submit_driver_profile.dart';
import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseVerifyRepo {
  Future<ApiResults<VerificationStatus>> getVerificationStatus();
  Future<ApiResults<SubmitDriverProfile>> submitProfile(
    DriverProfileSubmission submission, {
    void Function(double)? onProgress,
    CancelToken? cancelToken,
  });
}
