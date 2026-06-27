import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver/core/const/driver_api_consts.dart';
import 'package:driver/features/driver_verification/data/models/get_verification_status/response/get_verification_status_response.dart';
import 'package:driver/features/driver_verification/data/models/submit_driver_profile/response/submit_driver_profile_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'verify_api_service.g.dart';

@RestApi()
abstract class VerifyApiService {
  factory VerifyApiService(Dio dio, {String? baseUrl}) =>
      _VerifyApiService(dio, baseUrl: baseUrl);

  @GET(DriverApiConsts.getVerificationStatus)
  Future<GetVerificationStatusResponse> getVerificationStatus({
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(DriverApiConsts.submitDriverProfile)
  @MultiPart()
  Future<SubmitDriverProfileResponse> submitDriverProfile({
    @Part(name: 'LicenseFrontImage') required File licenseFront,
    @Part(name: 'LicenseBackImage') required File licenseBack,
    @Part(name: 'SelfieImage') required File selfie,
    @Part(name: 'VehicleImage') required File vehicleImage,
    @Part(name: 'VehicleModel') required String vehicleModel,
    @Part(name: 'VehicleYear') required String vehicleYear,
    @Part(name: 'VinNumber') required String vinNumber,
    @SendProgress() ProgressCallback? onSendProgress,
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
VerifyApiService verifyApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return VerifyApiService(dio);
}
