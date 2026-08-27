import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/interceptors/google_interceptors/search_key_interceptors.dart';

part 'google_search_dio_factory.g.dart';

/// Transport for Google Places and Geocoding. Deliberately no AuthInterceptor:
/// our bearer token must never reach a third-party host.
abstract final class GoogleSearchDioFactory {
  static Dio? _places;
  static Dio? _geocoding;

  static Dio get places =>
      _places ??= _build(ApiConstants.placesBaseUrl, PlacesKeyInterceptor());

  static Dio get geocoding =>
      _geocoding ??=
          _build(ApiConstants.geocodingBaseUrl, GeocodingKeyInterceptor());

  static Dio _build(String baseUrl, Interceptor keyInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      // Logger first, so Geocoding's `key` query parameter is printed before
      // the interceptor below attaches it — the URL reaches the log unkeyed.
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        enabled: AppConstants.isDebug,
      ),
      keyInterceptor,
    ]);

    return dio;
  }
}

@riverpod
Dio placesDio(Ref ref) => GoogleSearchDioFactory.places;

@riverpod
Dio geocodingDio(Ref ref) => GoogleSearchDioFactory.geocoding;
