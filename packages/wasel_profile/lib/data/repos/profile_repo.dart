import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wasel_core/helpers/app_image_compressor.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_profile/data/services/profile_api_service.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

typedef ImageCompressor = Future<File> Function(File source);

class ProfileRepo implements BaseProfileRepo {
  final ProfileApiService _profileApiService;
  final ImageCompressor _compressImage;

  ProfileRepo(this._profileApiService, {ImageCompressor? compressImage})
    : _compressImage = compressImage ?? AppImageCompressor.compress;

  @override
  Future<ApiResults<RiderProfile>> getRiderProfile({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _profileApiService.getRiderProfile(
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<DriverProfile>> getDriverProfile({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _profileApiService.getDriverProfile(
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<String?>> updateRiderPhoto(
    File photo, {
    void Function(double)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final compressed = await _compressImage(photo);

      final response = await _profileApiService.updateRiderPhoto(
        photo: compressed,
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
