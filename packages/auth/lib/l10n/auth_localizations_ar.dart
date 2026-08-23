// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AuthLocalizationsAr extends AuthLocalizations {
  AuthLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loggingIn => 'جاري تسجيل الدخول...';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get registerSuccess => 'تم التسجيل بنجاح';

  @override
  String get registerFormDescription => 'أدخل معلوماتك الشخصية لإكمال التسجيل';

  @override
  String get completeYourInfo => 'أكمل بياناتك';

  @override
  String get noAccount => 'ليس لديك حساب؟ ';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get enterFirstName => 'أدخل اسمك الأول';

  @override
  String get lastName => 'الاسم الأخير';

  @override
  String get enterLastName => 'أدخل اسمك الأخير';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhoneNumber => 'أدخل رقم هاتفك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get reenterPassword => 'أعد إدخال كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get forgotPasswordDescription =>
      'أدخل بريدك الإلكتروني وسنرسل لك رمز تحقق لإعادة تعيين كلمة المرور';

  @override
  String get rememberedPassword => 'تذكرت كلمة المرور؟ ';

  @override
  String get newPasswordTitle => 'كلمة مرور جديدة';

  @override
  String get chooseNewPassword => 'اختر كلمة مرور جديدة لحسابك';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get reenterNewPassword => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get passwordChangedSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get verificationCode => 'رمز التحقق';

  @override
  String otpSentToEmail(String email) {
    return 'لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني\n$email';
  }

  @override
  String get otpSentSuccess => 'تم ارسال الرمز الى الايميل بنجاح';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get send => 'إرسال';

  @override
  String get requestNewCode => 'طلب رمز جديد';

  @override
  String get willNeedNewCode => 'ستحتاج إلى طلب رمز جديد';

  @override
  String get confirm => 'تأكيد';

  @override
  String get continueAction => 'متابعة';

  @override
  String get cancelProcess => 'إلغاء العملية';

  @override
  String get confirmCancel => 'هل أنت متأكد من الإلغاء؟';

  @override
  String get otpExpired => 'انتهت صلاحية الرمز. يرجى طلب رمز جديد للمتابعة.';
}
