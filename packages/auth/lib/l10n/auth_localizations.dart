import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'auth_localizations_ar.dart';
import 'auth_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AuthLocalizations
/// returned by `AuthLocalizations.of(context)`.
///
/// Applications need to include `AuthLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/auth_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AuthLocalizations.localizationsDelegates,
///   supportedLocales: AuthLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AuthLocalizations.supportedLocales
/// property.
abstract class AuthLocalizations {
  AuthLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AuthLocalizations of(BuildContext context) {
    return Localizations.of<AuthLocalizations>(context, AuthLocalizations)!;
  }

  static const LocalizationsDelegate<AuthLocalizations> delegate =
      _AuthLocalizationsDelegate();

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

  /// Login screen title and the submit button on the login form
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// Button label while the login request is in flight
  ///
  /// In ar, this message translates to:
  /// **'جاري تسجيل الدخول...'**
  String get loggingIn;

  /// Snackbar shown after a successful login
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الدخول بنجاح'**
  String get loginSuccess;

  /// Register submit button label
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// Snackbar shown after a successful registration
  ///
  /// In ar, this message translates to:
  /// **'تم التسجيل بنجاح'**
  String get registerSuccess;

  /// Subtitle above the personal-details step of registration
  ///
  /// In ar, this message translates to:
  /// **'أدخل معلوماتك الشخصية لإكمال التسجيل'**
  String get registerFormDescription;

  /// Title of the personal-details step of registration
  ///
  /// In ar, this message translates to:
  /// **'أكمل بياناتك'**
  String get completeYourInfo;

  /// Leading text before the register link; keeps its trailing space
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get noAccount;

  /// Leading text before the login link; keeps its trailing space
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get alreadyHaveAccount;

  /// First name field label
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get firstName;

  /// First name field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك الأول'**
  String get enterFirstName;

  /// Last name field label
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأخير'**
  String get lastName;

  /// Last name field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك الأخير'**
  String get enterLastName;

  /// Email field label
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// Email field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني'**
  String get enterEmail;

  /// Phone number field label
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// Phone number field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم هاتفك'**
  String get enterPhoneNumber;

  /// Password field label
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// Password field hint on the register form
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get enterPassword;

  /// Password field hint on the login form
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الخاصة بك'**
  String get enterYourPassword;

  /// Confirm password field label
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// Confirm password field hint
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور'**
  String get reenterPassword;

  /// Link on the login form that starts the password reset flow
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// Title of the reset password flow
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين كلمة المرور'**
  String get resetPassword;

  /// Subtitle on the email step of the reset password flow
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني وسنرسل لك رمز تحقق لإعادة تعيين كلمة المرور'**
  String get forgotPasswordDescription;

  /// Leading text before the back-to-login link; keeps its trailing space
  ///
  /// In ar, this message translates to:
  /// **'تذكرت كلمة المرور؟ '**
  String get rememberedPassword;

  /// Title of the new password step
  ///
  /// In ar, this message translates to:
  /// **'كلمة مرور جديدة'**
  String get newPasswordTitle;

  /// Subtitle of the new password step
  ///
  /// In ar, this message translates to:
  /// **'اختر كلمة مرور جديدة لحسابك'**
  String get chooseNewPassword;

  /// New password field label
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPasswordLabel;

  /// New password field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الجديدة'**
  String get enterNewPassword;

  /// Confirm new password field hint
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور الجديدة'**
  String get reenterNewPassword;

  /// Snackbar shown after the password was reset
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير كلمة المرور بنجاح'**
  String get passwordChangedSuccess;

  /// Title of the OTP step
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get verificationCode;

  /// Subtitle of the OTP step, naming the address the code went to
  ///
  /// In ar, this message translates to:
  /// **'لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني\n{email}'**
  String otpSentToEmail(String email);

  /// Snackbar confirming the verification code was sent
  ///
  /// In ar, this message translates to:
  /// **'تم ارسال الرمز الى الايميل بنجاح'**
  String get otpSentSuccess;

  /// Button that requests a verification code
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرمز'**
  String get sendCode;

  /// Short submit label on the OTP step
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get send;

  /// Action that requests a fresh verification code
  ///
  /// In ar, this message translates to:
  /// **'طلب رمز جديد'**
  String get requestNewCode;

  /// Warning in the cancel dialog: cancelling voids the current code
  ///
  /// In ar, this message translates to:
  /// **'ستحتاج إلى طلب رمز جديد'**
  String get willNeedNewCode;

  /// Generic confirm action inside the auth flows
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// Advances to the next step of a multi-step auth flow
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueAction;

  /// Confirm label of the dialog that abandons the auth flow
  ///
  /// In ar, this message translates to:
  /// **'إلغاء العملية'**
  String get cancelProcess;

  /// Title of the dialog that abandons the auth flow
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من الإلغاء؟'**
  String get confirmCancel;

  /// Shown when the reset token has expired
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية الرمز. يرجى طلب رمز جديد للمتابعة.'**
  String get otpExpired;
}

class _AuthLocalizationsDelegate
    extends LocalizationsDelegate<AuthLocalizations> {
  const _AuthLocalizationsDelegate();

  @override
  Future<AuthLocalizations> load(Locale locale) {
    return SynchronousFuture<AuthLocalizations>(
      lookupAuthLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AuthLocalizationsDelegate old) => false;
}

AuthLocalizations lookupAuthLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AuthLocalizationsAr();
    case 'en':
      return AuthLocalizationsEn();
  }

  throw FlutterError(
    'AuthLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
