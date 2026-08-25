import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/networking/interceptors/auth_interceptor.dart';
import 'package:wasel_core/networking/dio/secret_paths.dart';
import 'package:wasel_core/networking/interceptors/localization_interceptor.dart';
import '../api_constants.dart';

part 'dio_factory.g.dart';

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

  /// A standalone client with its own AuthInterceptor state. Tests use this
  /// so a forced logout in one case cannot leak into the next.
  static Dio create() => (DioFactory._().._init()).dio;

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
      // Asks the API to answer in the language the user is reading.
      const LocalizationInterceptor(),
      // Injects the access token and handles 401 → refresh → retry.
      AuthInterceptor(),
      // Logs requests, responses, and errors in a readable format
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        enabled: AppConstants.isDebug,
        filter: (options, _) => !ApiSecretPaths.carries(options.path),
      ),
    ]);
  }
}

@riverpod
Dio dioFactory(Ref ref) {
  return DioFactory.instance.dio;
}
