// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ProfileLocalizationsEn extends ProfileLocalizations {
  ProfileLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get editPhoneOnlyNotice =>
      'You can only change your phone number. Contact support to update the rest of your details.';

  @override
  String get profileUpdated => 'Your details were updated';

  @override
  String get avatarUpdated => 'Your photo was updated';

  @override
  String get discardChangesTitle => 'Discard changes?';

  @override
  String get discardChangesMessage =>
      'You have unsaved changes. Do you want to leave and discard them?';

  @override
  String get discard => 'Discard';

  @override
  String get keepEditing => 'Keep editing';

  @override
  String get firstName => 'First name';

  @override
  String get enterFirstName => 'Enter your first name';

  @override
  String get lastName => 'Family name';

  @override
  String get enterLastName => 'Enter your family name';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get notSpecified => 'Not specified';

  @override
  String fieldRequired(String field) {
    return '$field is required';
  }

  @override
  String fieldTooShort(String field) {
    return '$field must be at least 2 characters';
  }

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneLength => 'Phone number must be 11 digits';
}
