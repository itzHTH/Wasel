import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_core/networking/errors/api_error_model.dart';
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
    test('returns the default message when the payload is empty', () {
      final error = _handlerFor(ApiErrorModel(message: ''));

      expect(errorMessageOf(error), defaultErrorMessage);
    });

    test('returns the custom fallback when the payload is empty', () {
      final error = _handlerFor(ApiErrorModel(message: ''));

      expect(errorMessageOf(error, fallback: 'تعذّر الحفظ'), 'تعذّر الحفظ');
    });

    test('prefers the errors map over the fallback', () {
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

    test('returns the fallback for a non-ErrorHandler object', () {
      expect(errorMessageOf(Exception('boom')), defaultErrorMessage);
    });
  });
}
