// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'payments_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class PaymentsLocalizationsAr extends PaymentsLocalizations {
  PaymentsLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get paymentMethodCash => 'نقدي';

  @override
  String get paymentMethodCard => 'بطاقة';

  @override
  String get paymentMethodWallet => 'المحفظة';

  @override
  String get paymentMethodUnknown => 'غير محدد';

  @override
  String get addCardBeforeConfirming => 'أضف بطاقة قبل تأكيد الطلب';

  @override
  String get walletBalanceTooLow => 'رصيد المحفظة لا يكفي لهذه الرحلة';

  @override
  String get cardVerificationFailed => 'تعذّر التحقق من البطاقة';
}
