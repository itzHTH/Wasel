import 'package:wasel_core/l10n/core_l10n_extension.dart';

/// Form validation, in the language the user is reading.
///
/// The messages resolve from the active locale rather than a BuildContext, so
/// these stay usable as bare `validator:` tear-offs at every call site.
class AppValidators {
  AppValidators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) return coreL10nNow.emailRequired;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(value) ? null : coreL10nNow.emailInvalid;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return coreL10nNow.passwordRequired;
    if (value.length < 6) return coreL10nNow.passwordTooShort;

    final regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    return regex.hasMatch(value) ? null : coreL10nNow.passwordWeak;
  }

  static String? confirmPassword(String? currentValue, String? originValue) {
    if (currentValue == null || currentValue.isEmpty) {
      return coreL10nNow.confirmPasswordRequired;
    }

    return currentValue == originValue ? null : coreL10nNow.passwordsDoNotMatch;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return coreL10nNow.fieldRequired(fieldName ?? coreL10nNow.thisField);
    }
    return null;
  }

  /// Iraqi format: 11 digits, e.g. 07xxxxxxxxx.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return coreL10nNow.phoneRequired;

    return RegExp(r'^[0-9]{11}$').hasMatch(value)
        ? null
        : coreL10nNow.phoneLength;
  }

  static String? year(String? value) {
    if (value == null || value.isEmpty) return coreL10nNow.yearRequired;
    if (!RegExp(r'^\d{4}$').hasMatch(value)) return coreL10nNow.yearFourDigits;

    const minYear = 1950;
    final maxYear = DateTime.now().year + 1;
    final year = int.parse(value);

    if (year < minYear || year > maxYear) {
      return coreL10nNow.yearRange('$minYear', '$maxYear');
    }
    return null;
  }

  static String? name(String? value, {String? fieldName}) {
    final label = fieldName ?? coreL10nNow.nameLabel;

    if (value == null || value.isEmpty) return coreL10nNow.fieldRequired(label);
    if (value.length < 2) return coreL10nNow.fieldTooShort(label);

    return null;
  }
}
