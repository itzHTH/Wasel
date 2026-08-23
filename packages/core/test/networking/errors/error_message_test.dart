import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_core/networking/errors/api_error_model.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_core/networking/errors/error_message.dart';

ErrorHandler _handlerFor(ApiErrorModel model) =>
    ErrorHandler.message('')..apiErrorModel = model;

void main() {
  group('displayMessage', () {
    test('returns message when it carries text', () {
      final model = ApiErrorModel(message: 'كلمة المرور غير صحيحة');

      expect(model.displayMessage, 'كلمة المرور غير صحيحة');
    });

    test('falls back to the errors map when message is blank', () {
      final model = ApiErrorModel(
        message: '',
        errors: {
          'email': ['البريد الإلكتروني مستخدم بالفعل'],
        },
      );

      expect(model.displayMessage, 'البريد الإلكتروني مستخدم بالفعل');
    });

    test('treats a whitespace-only message as blank', () {
      final model = ApiErrorModel(
        message: '   ',
        errors: {
          'password': ['كلمة المرور قصيرة جدًا'],
        },
      );

      expect(model.displayMessage, 'كلمة المرور قصيرة جدًا');
    });

    test('skips blank entries in the errors map', () {
      final model = ApiErrorModel(
        message: '',
        errors: {
          'email': ['', '  '],
          'password': ['كلمة المرور مطلوبة'],
        },
      );

      expect(model.displayMessage, 'كلمة المرور مطلوبة');
    });

    test('returns null when neither message nor errors carry text', () {
      final model = ApiErrorModel(message: '', errors: const {});

      expect(model.displayMessage, isNull);
    });
  });

  group('errorMessageOf', () {
    setUp(() => AppLocalizationController.currentLocale = const Locale('ar'));
    // Static state: restore it so a later test cannot inherit English.
    tearDown(
      () => AppLocalizationController.currentLocale = const Locale('ar'),
    );

    test('prefers what the server said over anything local', () {
      final error = _handlerFor(
        ApiErrorModel(
          message: 'الرحلة غير متاحة',
          reason: ApiErrorReason.internalServerError,
        ),
      );

      expect(
        errorMessageOf(error, fallback: 'تعذّر الحفظ'),
        'الرحلة غير متاحة',
      );
    });

    test('falls back to the errors map before anything local', () {
      final error = _handlerFor(
        ApiErrorModel(
          message: '',
          errors: {
            'ride': ['الرحلة غير متاحة'],
          },
        ),
      );

      expect(
        errorMessageOf(error, fallback: 'تعذّر الحفظ'),
        'الرحلة غير متاحة',
      );
    });

    test('maps a device-side reason to localized copy', () {
      final error = _handlerFor(
        ApiErrorModel(reason: ApiErrorReason.noInternetConnection),
      );

      expect(errorMessageOf(error), 'تحقق من اتصالك بالإنترنت');
    });

    test('follows the active language', () {
      AppLocalizationController.currentLocale = const Locale('en');
      final error = _handlerFor(
        ApiErrorModel(reason: ApiErrorReason.noInternetConnection),
      );

      expect(errorMessageOf(error), 'Please check your internet connection');
    });

    test('uses the caller fallback when there is no server text or reason', () {
      final error = _handlerFor(ApiErrorModel(message: ''));

      expect(errorMessageOf(error, fallback: 'تعذّر الحفظ'), 'تعذّر الحفظ');
    });

    test('ends at the generic apology for an unrelated object', () {
      expect(errorMessageOf(Exception('boom')), 'حصل خطأ ما');
    });

    test('a role refusal names the reason rather than apologising', () {
      final error = _handlerFor(
        ApiErrorModel(reason: ApiErrorReason.roleNotAllowed),
      );

      expect(
        errorMessageOf(error),
        'هذا الحساب غير مصرح له بالدخول لهذا التطبيق',
      );
    });

    test('an undrawable route names the reason', () {
      final error = _handlerFor(
        ApiErrorModel(reason: ApiErrorReason.routeUnavailable),
      );

      expect(errorMessageOf(error), 'ما نگدر نرسم الطريق');
    });

    test('a timeout reads as a timeout, not a generic failure', () {
      final error = _handlerFor(ApiErrorModel(reason: ApiErrorReason.timeout));

      expect(errorMessageOf(error), 'انتهت مهلة الاتصال، حاول مرة أخرى');
    });
  });
}
