import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';

abstract class BaseProfileRepo {
  Future<ApiResults<RiderProfile>> getRiderProfile({CancelToken? cancelToken});

  Future<ApiResults<DriverProfile>> getDriverProfile({
    CancelToken? cancelToken,
  });

  Future<ApiResults<String?>> updateRiderPhoto(
    File photo, {
    void Function(double)? onProgress,
    CancelToken? cancelToken,
  });
}
