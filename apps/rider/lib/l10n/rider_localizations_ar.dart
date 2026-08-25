// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rider_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class RiderLocalizationsAr extends RiderLocalizations {
  RiderLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get brandName => 'وَصَل';

  @override
  String get authHeaderTagline => 'احصل على تجربة رائعة مع ';

  @override
  String get loginTagline => 'اطلب تكسي في أي وقت';

  @override
  String get registerTagline => 'اطلب تكسي في أي وقت';

  @override
  String get orSignUpWith => 'أو سجل باستخدام';

  @override
  String get signUpWithGoogle => 'التسجيل باستخدام جوجل';

  @override
  String get registerWithGoogle => 'سجل باستخدام جوجل';

  @override
  String get loginWithGoogle => 'سجّل الدخول باستخدام جوجل';

  @override
  String get myAccount => 'حسابي';

  @override
  String get profileDetails => 'الملف الشخصي';

  @override
  String get rideHistory => 'سجل الرحلات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmMessage => 'هل أنت متأكد من تسجيل الخروج من حسابك؟';

  @override
  String get requestRideFailed => 'تعذّر إرسال الطلب، حاول مرة أخرى';

  @override
  String get logoutFailed => 'فشل تسجيل الخروج';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get profileLoadFailed => 'تعذّر تحميل بيانات الملف الشخصي';

  @override
  String get edit => 'تعديل';

  @override
  String get defaultUserName => 'مستخدم وَصَل';

  @override
  String get balance => 'الرصيد';

  @override
  String get currencyIqd => 'د.ع';

  @override
  String distanceKm(String value) {
    return '$value كم';
  }

  @override
  String coordinatePair(String lat, String lng) {
    return '$lat، $lng';
  }

  @override
  String get whereToGo => 'وين تريد تروح؟';

  @override
  String get setPickup => 'حدّد نقطة الانطلاق';

  @override
  String get confirmDestination => 'تأكيد الوجهة';

  @override
  String get confirmPickup => 'تأكيد الانطلاق';

  @override
  String get fromLabel => 'من';

  @override
  String get toLabel => 'إلى';

  @override
  String get pickupLabel => 'الانطلاق';

  @override
  String get destinationLabel => 'الوجهة';

  @override
  String get estimatedFare => 'الأجرة التقديرية';

  @override
  String get distanceLabel => 'المسافة';

  @override
  String get paymentMethodLabel => 'طريقة الدفع';

  @override
  String get confirmRequest => 'تأكيد الطلب';

  @override
  String get checkDetails => 'تأكدلي من التفاصيل';

  @override
  String get cancelRequest => 'إلغاء الطلب';

  @override
  String get searchingForCaptain => 'نبحث عن كابتن قريب...';

  @override
  String get stayOnline => 'خليك على الخط، راح نلگه لك كابتن بأسرع وقت';

  @override
  String get captainOnWay => 'الكابتن بالطريق إلك';

  @override
  String get captainArrived => 'الكابتن وصل — اطلع اله';

  @override
  String get findCarByPlate => 'دور على السيارة برقم اللوحة';

  @override
  String get call => 'اتصال';

  @override
  String get message => 'رسالة';

  @override
  String get rideCancelled => 'انلغت الرحلة';

  @override
  String get captainDeclined => 'اعتذر الكابتن عن الرحلة، جرب مرة ثانية';

  @override
  String get arrivedSafely => 'وصلت بالسلامة';

  @override
  String get haveAGoodTrip => 'رحلة موفقة';

  @override
  String get howWasYourRide => 'شلون كانت رحلتك؟';

  @override
  String get writeNotesOptional => 'اكتب ملاحظاتك (اختياري)';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get rideDetails => 'تفاصيل الرحلة';

  @override
  String get waselDriverName => 'سائق وصل';

  @override
  String get noRideToRate => 'ما موجودة رحلة نقيمها';

  @override
  String get noRideToCancel => 'ما موجودة رحلة نلغيها';

  @override
  String get cancelRideFailed => 'ما گدرنا نلغي الرحلة، جرّب مرة ثانية';

  @override
  String get cannotCancelInProgress => 'ما تگدر تلغي رحلة بديت بيها';

  @override
  String get cardDetails => 'بيانات البطاقة';

  @override
  String get cardNumber => 'رقم البطاقة';

  @override
  String get enterCardNumber => 'أدخل رقم البطاقة';

  @override
  String get cardNumberLength => 'رقم البطاقة 16 رقمًا';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get enterExpiryDate => 'أدخل تاريخ الانتهاء';

  @override
  String get expiryFormat => 'الصيغة MM/YY';

  @override
  String get invalidMonth => 'شهر غير صحيح';

  @override
  String get cardExpired => 'البطاقة منتهية';

  @override
  String get enterCvv => 'أدخل الرمز';

  @override
  String get cvvLength => 'من 3 إلى 4 أرقام';

  @override
  String get saveCard => 'حفظ البطاقة';

  @override
  String captainEtaMinutes(String minutes) {
    return 'الكابتن يوصل خلال $minutes دقائق';
  }

  @override
  String arrivalEtaMinutes(String minutes) {
    return 'الوصول خلال $minutes دقائق تقريباً';
  }
}
