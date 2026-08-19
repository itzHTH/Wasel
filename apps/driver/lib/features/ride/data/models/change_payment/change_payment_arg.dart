import 'package:wasel_payments/domain/entities/payment_method.dart';

class ChangePaymentArg {
  final String rideId;
  final PaymentMethod method;

  ChangePaymentArg({required this.rideId, required this.method});
}
