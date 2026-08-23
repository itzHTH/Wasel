// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CoreLocalizationsEn extends CoreLocalizations {
  CoreLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get languageSheetDescription => 'Choose the app language.';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceSheetDescription =>
      'Choose the app appearance, or let it follow your device settings.';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get retrying => 'Retrying…';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get soon => 'Soon';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get chooseImageSource => 'Choose image source';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get changeProfilePicture => 'Change profile picture';

  @override
  String stepOfSteps(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get otpNotReceived => 'Didn\'t get the code? ';

  @override
  String get otpResend => 'Resend';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get genericError => 'Something went wrong';

  @override
  String get errorNoContent => 'No content';

  @override
  String get errorBadRequest => 'Bad request, please try again';

  @override
  String get errorForbidden => 'You don\'t have permission for this';

  @override
  String get errorUnauthorized => 'Your session expired, please log in again';

  @override
  String get errorNotFound => 'We couldn’t find what you asked for';

  @override
  String get errorServer => 'Server error, please try again later';

  @override
  String get errorTimeout => 'The request timed out, please try again';

  @override
  String get errorCache => 'Stored data error';

  @override
  String get errorNoInternet => 'Please check your internet connection';

  @override
  String get mediaPermissionDenied =>
      'Please allow camera or photo access in your app settings.';

  @override
  String get currencyIqd => 'IQD';

  @override
  String get errorRoleNotAllowed =>
      'This account is not allowed to sign in to this app';

  @override
  String get errorRouteUnavailable => 'We can\'t draw the route';

  @override
  String get errorUnsupportedPaymentMethod => 'Unsupported payment method';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordWeak =>
      'Must contain an uppercase letter, a lowercase letter, a number and a symbol (!@#)';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneLength => 'Phone number must be 11 digits';

  @override
  String get yearRequired => 'Year is required';

  @override
  String get yearFourDigits => 'Enter a 4-digit year';

  @override
  String get thisField => 'This field';

  @override
  String get nameLabel => 'Name';

  @override
  String fieldRequired(String field) {
    return '$field is required';
  }

  @override
  String fieldTooShort(String field) {
    return '$field must be at least 2 characters';
  }

  @override
  String yearRange(String min, String max) {
    return 'Enter a valid year ($min–$max)';
  }
}
