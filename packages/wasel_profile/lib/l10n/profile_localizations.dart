import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'profile_localizations_ar.dart';
import 'profile_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ProfileLocalizations
/// returned by `ProfileLocalizations.of(context)`.
///
/// Applications need to include `ProfileLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/profile_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProfileLocalizations.localizationsDelegates,
///   supportedLocales: ProfileLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ProfileLocalizations.supportedLocales
/// property.
abstract class ProfileLocalizations {
  ProfileLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProfileLocalizations of(BuildContext context) {
    return Localizations.of<ProfileLocalizations>(
      context,
      ProfileLocalizations,
    )!;
  }

  static const LocalizationsDelegate<ProfileLocalizations> delegate =
      _ProfileLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Notice explaining that only the phone number is editable
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تعديل رقم هاتفك فقط. لتغيير بقية بياناتك تواصل مع الدعم.'**
  String get editPhoneOnlyNotice;

  /// Snackbar shown after the profile is saved
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث بياناتك بنجاح'**
  String get profileUpdated;

  /// Snackbar shown after the avatar is replaced
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الصورة بنجاح'**
  String get avatarUpdated;

  /// Title of the unsaved-changes dialog
  ///
  /// In ar, this message translates to:
  /// **'تجاهل التعديلات؟'**
  String get discardChangesTitle;

  /// Body of the unsaved-changes dialog
  ///
  /// In ar, this message translates to:
  /// **'لديك تغييرات لم يتم حفظها. هل تريد الخروج وتجاهلها؟'**
  String get discardChangesMessage;

  /// Confirm action of the unsaved-changes dialog
  ///
  /// In ar, this message translates to:
  /// **'تجاهل'**
  String get discard;

  /// Cancel action of the unsaved-changes dialog
  ///
  /// In ar, this message translates to:
  /// **'متابعة التعديل'**
  String get keepEditing;

  /// First name field label on the profile edit form
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get firstName;

  /// First name field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك الأول'**
  String get enterFirstName;

  /// Last name field label on the profile edit form
  ///
  /// In ar, this message translates to:
  /// **'اسم العائلة'**
  String get lastName;

  /// Last name field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم عائلتك'**
  String get enterLastName;

  /// Phone number field label on the profile edit form
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// Submit button on the profile edit form
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get saveChanges;

  /// Placeholder shown when a profile field is empty
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get notSpecified;

  /// Validation error when a named profile field is empty
  ///
  /// In ar, this message translates to:
  /// **'{field} مطلوب'**
  String fieldRequired(String field);

  /// Validation error when a named profile field is too short
  ///
  /// In ar, this message translates to:
  /// **'{field} يجب أن لا يقل عن حرفين'**
  String fieldTooShort(String field);

  /// Validation error when the phone field is empty
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف مطلوب'**
  String get phoneRequired;

  /// Validation error when the phone number is the wrong length
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف يجب أن يتكون من ١١ رقماً'**
  String get phoneLength;
}

class _ProfileLocalizationsDelegate
    extends LocalizationsDelegate<ProfileLocalizations> {
  const _ProfileLocalizationsDelegate();

  @override
  Future<ProfileLocalizations> load(Locale locale) {
    return SynchronousFuture<ProfileLocalizations>(
      lookupProfileLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ProfileLocalizationsDelegate old) => false;
}

ProfileLocalizations lookupProfileLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ProfileLocalizationsAr();
    case 'en':
      return ProfileLocalizationsEn();
  }

  throw FlutterError(
    'ProfileLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
