import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/features/driver_verification/data/services/verify_api_service.dart';
import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/domain/entities/submit_driver_profile.dart';
import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:driver/features/driver_verification/domain/repo/base_verify_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/helpers/app_image_compressor.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

part 'verify_repo.g.dart';

class VerifyRepo implements BaseVerifyRepo {
  final VerifyApiService _apiService;

  VerifyRepo(this._apiService);
  @override
  Future<ApiResults<VerificationStatus>> getVerificationStatus() async {
    try {
      final result = await _apiService.getVerificationStatus();

      return ApiResults.success(result.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<SubmitDriverProfile>> submitProfile(
    DriverProfileSubmission submission, {
    void Function(double)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      // Compress before upload to keep the multipart body under the server's
      // request-size limit (avoids 413 Request Entity Too Large).
      final licenseFront = await AppImageCompressor.compress(
        File(submission.licenseFront.path),
      );
      final licenseBack = await AppImageCompressor.compress(
        File(submission.licenseBack.path),
      );
      final selfie = await AppImageCompressor.compress(
        File(submission.selfie.path),
      );
      final vehicleImage = await AppImageCompressor.compress(
        File(submission.vehicleImage.path),
      );

      final response = await _apiService.submitDriverProfile(
        licenseFront: licenseFront,
        licenseBack: licenseBack,
        selfie: selfie,
        vehicleImage: vehicleImage,
        vehicleModel: submission.vehicleModel,
        vehicleYear: submission.vehicleYear,
        vinNumber: submission.vinNumber,
        cancelToken: cancelToken,

        onSendProgress: (sent, total) {
          if (total > 0) onProgress?.call(sent / total);
        },

        options: Options(
          sendTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
VerifyRepo verifyRepo(Ref ref) {
  final verifyApiService = ref.watch(verifyApiServiceProvider);
  return VerifyRepo(verifyApiService);
}
