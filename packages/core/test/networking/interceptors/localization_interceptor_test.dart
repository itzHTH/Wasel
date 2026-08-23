import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/networking/interceptors/localization_interceptor.dart';

/// Captures the options the interceptor passes along.
class _CaptureHandler extends RequestInterceptorHandler {
  RequestOptions? captured;

  @override
  void next(RequestOptions requestOptions) => captured = requestOptions;
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AppLocalizationController.currentLocale = const Locale('ar');
  });

  RequestOptions send() {
    final handler = _CaptureHandler();
    const LocalizationInterceptor().onRequest(
      RequestOptions(path: '/x'),
      handler,
    );
    return handler.captured!;
  }

  test('sends the active language code, not the whole locale', () {
    expect(send().headers['Accept-Language'], 'ar');
  });

  test('follows a locale change on the next request', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(appLocalizationControllerProvider.notifier)
        .setLocale(const Locale('en'));

    expect(send().headers['Accept-Language'], 'en');
  });

  test('the mirror tracks the controller so no wiring step can be missed', () {
    final container = ProviderContainer(
      overrides: [initialLocaleProvider.overrideWithValue(const Locale('en'))],
    );
    addTearDown(container.dispose);

    container.read(appLocalizationControllerProvider);

    expect(AppLocalizationController.currentLocale, const Locale('en'));
  });
}
