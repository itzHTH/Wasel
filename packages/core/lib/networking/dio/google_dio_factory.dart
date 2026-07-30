import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/interceptors/google_interceptors/google_key_interceptor.dart';

part 'google_dio_factory.g.dart';

class GoogleDioFactory {
  // Private constructor to prevent external instantiation
  GoogleDioFactory._();

  // Single static instance
  static GoogleDioFactory? _instance;

  // The Dio client instance
  late final Dio dio;

  /// Returns the singleton instance of [DioFactory].
  static GoogleDioFactory get instance {
    _instance ??= GoogleDioFactory._().._init();
    return _instance!;
  }

  void _init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.googleGeocodingBaseUrl,
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
      GoogleKeyInterceptor(),

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

@riverpod
Dio googleDioFactory(Ref ref) {
  return GoogleDioFactory.instance.dio;
}
