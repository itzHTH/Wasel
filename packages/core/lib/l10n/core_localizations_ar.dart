// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class CoreLocalizationsAr extends CoreLocalizations {
  CoreLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get language => 'اللغة';

  @override
  String get languageSheetDescription => 'اختر لغة التطبيق.';

  @override
  String get appearance => 'المظهر';

  @override
  String get appearanceSheetDescription =>
      'اختر مظهر التطبيق أو اتركه يتبع إعدادات جهازك.';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';

  @override
  String get cancel => 'إلغاء';

  @override
  String get back => 'رجوع';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get retrying => 'جارٍ إعادة المحاولة…';

  @override
  String get notSpecified => 'غير محدد';

  @override
  String get soon => 'قريبًا';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get chooseImageSource => 'اختر مصدر الصورة';

  @override
  String get takePhoto => 'التقط صورة';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get changeProfilePicture => 'تغيير الصورة الشخصية';

  @override
  String stepOfSteps(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get otpNotReceived => 'لم تستلم الرمز؟ ';

  @override
  String get otpResend => 'أعد الإرسال';

  @override
  String get confirm => 'تأكيد';

  @override
  String get done => 'تم';

  @override
  String get genericError => 'حصل خطأ ما';

  @override
  String get errorNoContent => 'لا توجد بيانات';

  @override
  String get errorBadRequest => 'طلب غير صالح، حاول مرة أخرى';

  @override
  String get errorForbidden => 'ليس لديك صلاحية لهذا الإجراء';

  @override
  String get errorUnauthorized => 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً';

  @override
  String get errorNotFound => 'لم نعثر على المطلوب';

  @override
  String get errorServer => 'خطأ في الخادم، حاول لاحقاً';

  @override
  String get errorTimeout => 'انتهت مهلة الاتصال، حاول مرة أخرى';

  @override
  String get errorCache => 'خطأ في البيانات المحفوظة';

  @override
  String get errorNoInternet => 'تحقق من اتصالك بالإنترنت';

  @override
  String get mediaPermissionDenied =>
      'يرجى السماح بالوصول للكاميرا أو الصور من إعدادات التطبيق.';

  @override
  String get currencyIqd => 'د.ع';

  @override
  String get errorRoleNotAllowed =>
      'هذا الحساب غير مصرح له بالدخول لهذا التطبيق';

  @override
  String get errorRouteUnavailable => 'ما نگدر نرسم الطريق';

  @override
  String get errorUnsupportedPaymentMethod => 'طريقة دفع غير مدعومة';

  @override
  String get errorForegroundServiceUnavailable =>
      'تعذّر تشغيل خدمة العمل بالخلفية، حاول مرة أخرى';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordTooShort => 'كلمة المرور يجب أن لا تقل عن 6 أحرف';

  @override
  String get passwordWeak =>
      'يجب أن تحتوي على حرف كبير وصغير ورقم ورمز (‎!@#‎)';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneLength => 'رقم الهاتف يجب أن يتكون من 11 رقماً';

  @override
  String get yearRequired => 'سنة الصنع مطلوبة';

  @override
  String get yearFourDigits => 'أدخل سنة من 4 أرقام';

  @override
  String get thisField => 'هذا الحقل';

  @override
  String get nameLabel => 'الاسم';

  @override
  String fieldRequired(String field) {
    return '$field مطلوب';
  }

  @override
  String fieldTooShort(String field) {
    return '$field يجب أن لا يقل عن حرفين';
  }

  @override
  String yearRange(String min, String max) {
    return 'أدخل سنة صحيحة ($min–$max)';
  }

  @override
  String get errorHeading => 'خطأ';

  @override
  String get errorTitle => 'حدث خطأ ما';

  @override
  String get errorBody =>
      'احنا نعتذر منك كلش ! \nصارت مشاكل بالتطبيق\nوحالياَ تم تبليغ المطورين لحل المشاكل باسرع وقت\nشكراَ لصبرك يا بطلنا العزيز';

  @override
  String get exitApp => 'الخروج من التطبيق';
}
