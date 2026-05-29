import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';

abstract class BaseAuthRepo {
  Future<ApiResults<LoginResponse>> login(
    LoginRequest loginRequest, {
    CancelToken? cancelToken,
  });
}
