import 'package:dio/dio.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';

class LocalizationInterceptor extends Interceptor {
  const LocalizationInterceptor();

  static const String _acceptLanguageHeader = 'Accept-Language';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_acceptLanguageHeader] =
        AppLocalizationController.currentLocale.languageCode;

    handler.next(options);
  }
}
