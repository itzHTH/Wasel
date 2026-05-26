import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasal/core/const/app_constants.dart';
import 'api_constants.dart';

class DioFactory {
  // Private constructor to prevent external instantiation
  DioFactory._();

  // Single static instance
  static DioFactory? _instance;

  // The Dio client instance
  late final Dio dio;

  /// Returns the singleton instance of [DioFactory].
  static DioFactory get instance {
    _instance ??= DioFactory._().._init();
    return _instance!;
  }

  void _init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.addAll([
      // Logs requests, responses, and errors in a readable format
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        enabled: AppConstants.isDebug,
      ),
    ]);
  }
}
