import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wasel_core/networking/base_response.dart';
import 'package:wasel_profile/core/const/profile_api_const.dart';
import 'package:wasel_profile/data/models/driver_profile/response/driver_profile_response.dart';
import 'package:wasel_profile/data/models/rider_profile/response/rider_profile_response.dart';
import 'package:wasel_profile/data/models/update_driver_profile/request/update_driver_profile_body.dart';
import 'package:wasel_profile/data/models/update_rider_profile/request/update_rider_profile_body.dart';
import 'package:wasel_profile/data/models/update_rider_photo/response/update_rider_photo_response.dart';

part 'profile_api_service.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String? baseUrl}) =>
      _ProfileApiService(dio, baseUrl: baseUrl);

  @GET(ProfileApiConst.riderProfile)
  Future<RiderProfileResponse> getRiderProfile({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(ProfileApiConst.driverProfile)
  Future<DriverProfileResponse> getDriverProfile({
    @CancelRequest() CancelToken? cancelToken,
  });

  @PUT(ProfileApiConst.riderProfile)
  Future<BaseResponse> updateRiderProfile({
    @Body() required UpdateRiderProfileBody body,
    @CancelRequest() CancelToken? cancelToken,
  });

  /// Answers `{"succeeded":true,"data":null}` — see [updateRiderProfile].
  @PUT(ProfileApiConst.driverProfile)
  Future<BaseResponse> updateDriverProfile({
    @Body() required UpdateDriverProfileBody body,
    @CancelRequest() CancelToken? cancelToken,
  });

  @PUT(ProfileApiConst.updateRiderPhoto)
  @MultiPart()
  Future<UpdateRiderPhotoResponse> updateRiderPhoto({
    @Part(name: 'photo') required File photo,
    @SendProgress() ProgressCallback? onSendProgress,
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
  });
}
