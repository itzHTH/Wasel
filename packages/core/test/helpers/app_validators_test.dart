import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';

void main() {
  setUp(() => AppLocalizationController.currentLocale = const Locale('ar'));
  tearDown(() => AppLocalizationController.currentLocale = const Locale('ar'));

  group('messages follow the active language', () {
    test('an empty email reads in Arabic', () {
      expect(AppValidators.email(''), 'البريد الإلكتروني مطلوب');
    });

    test('an empty email reads in English', () {
      AppLocalizationController.currentLocale = const Locale('en');

      expect(AppValidators.email(''), 'Email is required');
    });

    test('a named field is not stitched into a foreign-language template', () {
      // The regression this guards: a localized label inside an English
      // sentence, e.g. "المدينة is required".
      expect(AppValidators.name('', fieldName: 'المدينة'), 'المدينة مطلوب');
    });
  });

  group('rules still hold', () {
    test('accepts a well-formed email', () {
      expect(AppValidators.email('a@b.co'), isNull);
    });

    test('rejects a malformed email', () {
      expect(AppValidators.email('ab@'), isNotNull);
    });

    test('requires 11 digits for a phone number', () {
      expect(AppValidators.phone('07712345678'), isNull);
      expect(AppValidators.phone('077123'), isNotNull);
    });

    test('confirmPassword compares against the original', () {
      expect(AppValidators.confirmPassword('abc', 'abc'), isNull);
      expect(AppValidators.confirmPassword('abc', 'xyz'), isNotNull);
    });

    test('year accepts the current range and rejects outside it', () {
      expect(AppValidators.year('${DateTime.now().year}'), isNull);
      expect(AppValidators.year('1900'), isNotNull);
      expect(AppValidators.year('20'), isNotNull);
    });

    test('name needs at least two characters', () {
      expect(AppValidators.name('ab'), isNull);
      expect(AppValidators.name('a'), isNotNull);
    });
  });
}
