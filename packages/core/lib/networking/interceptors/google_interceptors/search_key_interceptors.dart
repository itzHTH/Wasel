import 'package:dio/dio.dart';
import 'package:wasel_core/config/app_env.dart';

/// Places API (New) authenticates by header.
class PlacesKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Goog-Api-Key'] = AppEnv.searchApiKey;
    handler.next(options);
  }
}

/// The Geocoding API authenticates by query parameter instead.
class GeocodingKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['key'] = AppEnv.searchApiKey;
    handler.next(options);
  }
}
