import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleKeyInterceptor extends Interceptor {
  static const apiKeyName = 'GoogleGeocodingApiKey';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Goog-Api-Key'] = dotenv.get(apiKeyName);
    handler.next(options);
  }
}
