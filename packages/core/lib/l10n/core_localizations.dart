import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'core_localizations_ar.dart';
import 'core_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CoreLocalizations
/// returned by `CoreLocalizations.of(context)`.
///
/// Applications need to include `CoreLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/core_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CoreLocalizations.localizationsDelegates,
///   supportedLocales: CoreLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CoreLocalizations.supportedLocales
/// property.
abstract class CoreLocalizations {
  CoreLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CoreLocalizations of(BuildContext context) {
    return Localizations.of<CoreLocalizations>(context, CoreLocalizations)!;
  }

  static const LocalizationsDelegate<CoreLocalizations> delegate =
      _CoreLocalizationsDelegate();

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

  /// Menu tile label for the language setting
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// Subtitle inside the language bottom sheet
  ///
  /// In ar, this message translates to:
  /// **'اختر لغة التطبيق.'**
  String get languageSheetDescription;

  /// Menu tile label and title of the appearance bottom sheet
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get appearance;

  /// Subtitle inside the appearance bottom sheet
  ///
  /// In ar, this message translates to:
  /// **'اختر مظهر التطبيق أو اتركه يتبع إعدادات جهازك.'**
  String get appearanceSheetDescription;

  /// Light theme mode segment label
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get themeLight;

  /// Dark theme mode segment label
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get themeDark;

  /// System theme mode segment label; follows the device setting
  ///
  /// In ar, this message translates to:
  /// **'النظام'**
  String get themeSystem;

  /// Generic cancel action, shared across dialogs and sheets
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// Semantics label for the shared back button
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// Label of the retry button on an error state
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// Shown on the retry button while the retry is in flight
  ///
  /// In ar, this message translates to:
  /// **'جارٍ إعادة المحاولة…'**
  String get retrying;

  /// Placeholder shown when an info row has no value
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get notSpecified;

  /// Badge on menu entries that are not built yet
  ///
  /// In ar, this message translates to:
  /// **'قريبًا'**
  String get soon;

  /// Action that sends the user to the OS app settings page
  ///
  /// In ar, this message translates to:
  /// **'فتح الإعدادات'**
  String get openSettings;

  /// Title of the image source bottom sheet
  ///
  /// In ar, this message translates to:
  /// **'اختر مصدر الصورة'**
  String get chooseImageSource;

  /// Image source option that opens the camera
  ///
  /// In ar, this message translates to:
  /// **'التقط صورة'**
  String get takePhoto;

  /// Image source option that opens the photo library
  ///
  /// In ar, this message translates to:
  /// **'اختر من المعرض'**
  String get chooseFromGallery;

  /// Semantics label for the editable avatar button
  ///
  /// In ar, this message translates to:
  /// **'تغيير الصورة الشخصية'**
  String get changeProfilePicture;

  /// Progress label in the multi-step indicator
  ///
  /// In ar, this message translates to:
  /// **'الخطوة {current} من {total}'**
  String stepOfSteps(int current, int total);

  /// Leading text of the resend OTP row; keeps its trailing space before the action
  ///
  /// In ar, this message translates to:
  /// **'لم تستلم الرمز؟ '**
  String get otpNotReceived;

  /// Tappable action that resends the OTP code
  ///
  /// In ar, this message translates to:
  /// **'أعد الإرسال'**
  String get otpResend;

  /// Generic confirm action shared across flows
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// Generic completion action
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get done;

  /// Fallback shown when no specific error message is available
  ///
  /// In ar, this message translates to:
  /// **'حصل خطأ ما'**
  String get genericError;

  /// Server returned no content
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get errorNoContent;

  /// HTTP 400
  ///
  /// In ar, this message translates to:
  /// **'طلب غير صالح، حاول مرة أخرى'**
  String get errorBadRequest;

  /// HTTP 403
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك صلاحية لهذا الإجراء'**
  String get errorForbidden;

  /// HTTP 401
  ///
  /// In ar, this message translates to:
  /// **'انتهت الجلسة، يرجى تسجيل الدخول مجدداً'**
  String get errorUnauthorized;

  /// HTTP 404
  ///
  /// In ar, this message translates to:
  /// **'لم نعثر على المطلوب'**
  String get errorNotFound;

  /// HTTP 500
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم، حاول لاحقاً'**
  String get errorServer;

  /// Connect/send/receive timeout
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال، حاول مرة أخرى'**
  String get errorTimeout;

  /// Local cache failure
  ///
  /// In ar, this message translates to:
  /// **'خطأ في البيانات المحفوظة'**
  String get errorCache;

  /// No connectivity
  ///
  /// In ar, this message translates to:
  /// **'تحقق من اتصالك بالإنترنت'**
  String get errorNoInternet;

  /// Shown when picking an image is blocked by permissions
  ///
  /// In ar, this message translates to:
  /// **'يرجى السماح بالوصول للكاميرا أو الصور من إعدادات التطبيق.'**
  String get mediaPermissionDenied;

  /// Iraqi dinar symbol appended to amounts
  ///
  /// In ar, this message translates to:
  /// **'د.ع'**
  String get currencyIqd;

  /// Shown when a rider signs in to the driver app, or vice versa
  ///
  /// In ar, this message translates to:
  /// **'هذا الحساب غير مصرح له بالدخول لهذا التطبيق'**
  String get errorRoleNotAllowed;

  /// Shown when the route between two points cannot be drawn
  ///
  /// In ar, this message translates to:
  /// **'ما نگدر نرسم الطريق'**
  String get errorRouteUnavailable;

  /// Shown when a ride cannot be settled with the chosen payment method
  ///
  /// In ar, this message translates to:
  /// **'طريقة دفع غير مدعومة'**
  String get errorUnsupportedPaymentMethod;

  /// Validation: empty email
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني مطلوب'**
  String get emailRequired;

  /// Validation: malformed email
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريداً إلكترونياً صحيحاً'**
  String get emailInvalid;

  /// Validation: empty password
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get passwordRequired;

  /// Validation: short password
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور يجب أن لا تقل عن 6 أحرف'**
  String get passwordTooShort;

  /// Validation: password complexity
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي على حرف كبير وصغير ورقم ورمز (‎!@#‎)'**
  String get passwordWeak;

  /// Validation: empty confirmation
  ///
  /// In ar, this message translates to:
  /// **'يرجى تأكيد كلمة المرور'**
  String get confirmPasswordRequired;

  /// Validation: mismatched confirmation
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get passwordsDoNotMatch;

  /// Validation: empty phone
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف مطلوب'**
  String get phoneRequired;

  /// Validation: wrong phone length
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف يجب أن يتكون من 11 رقماً'**
  String get phoneLength;

  /// Validation: empty year
  ///
  /// In ar, this message translates to:
  /// **'سنة الصنع مطلوبة'**
  String get yearRequired;

  /// Validation: malformed year
  ///
  /// In ar, this message translates to:
  /// **'أدخل سنة من 4 أرقام'**
  String get yearFourDigits;

  /// Default label when a field has no name of its own
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل'**
  String get thisField;

  /// Default label for an unnamed name field
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get nameLabel;

  /// Validation: a named field is empty
  ///
  /// In ar, this message translates to:
  /// **'{field} مطلوب'**
  String fieldRequired(String field);

  /// Validation: a named field is too short
  ///
  /// In ar, this message translates to:
  /// **'{field} يجب أن لا يقل عن حرفين'**
  String fieldTooShort(String field);

  /// Validation: year out of range
  ///
  /// In ar, this message translates to:
  /// **'أدخل سنة صحيحة ({min}–{max})'**
  String yearRange(String min, String max);
}

class _CoreLocalizationsDelegate
    extends LocalizationsDelegate<CoreLocalizations> {
  const _CoreLocalizationsDelegate();

  @override
  Future<CoreLocalizations> load(Locale locale) {
    return SynchronousFuture<CoreLocalizations>(
      lookupCoreLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CoreLocalizationsDelegate old) => false;
}

CoreLocalizations lookupCoreLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return CoreLocalizationsAr();
    case 'en':
      return CoreLocalizationsEn();
  }

  throw FlutterError(
    'CoreLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
