import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wasel_core/helpers/app_image_compressor.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_profile/data/models/update_driver_profile/request/update_driver_profile_body.dart';
import 'package:wasel_profile/data/models/update_rider_profile/request/update_rider_profile_body.dart';
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
  Future<ApiResults<void>> updateRiderProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    CancelToken? cancelToken,
  }) async {
    try {
      await _profileApiService.updateRiderProfile(
        body: UpdateRiderProfileBody(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
        ),
        cancelToken: cancelToken,
      );

      return const ApiResults.success(null);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<void>> updateDriverProfile({
    required String phoneNumber,
    CancelToken? cancelToken,
  }) async {
    try {
      await _profileApiService.updateDriverProfile(
        body: UpdateDriverProfileBody(phoneNumber: phoneNumber),
        cancelToken: cancelToken,
      );

      return const ApiResults.success(null);
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
