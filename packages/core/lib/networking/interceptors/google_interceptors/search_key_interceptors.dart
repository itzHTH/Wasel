import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// The one key behind both Places and Geocoding. Restrict it to those two APIs
/// in the Cloud console: `.env` ships as a bundled asset and is readable from
/// a shipped build.
const String searchApiKeyName = 'SEARCH_API_KEY';

/// Places API (New) authenticates by header.
class PlacesKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Goog-Api-Key'] = dotenv.get(searchApiKeyName);
    handler.next(options);
  }
}

/// The Geocoding API authenticates by query parameter instead.
class GeocodingKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['key'] = dotenv.get(searchApiKeyName);
    handler.next(options);
  }
}
