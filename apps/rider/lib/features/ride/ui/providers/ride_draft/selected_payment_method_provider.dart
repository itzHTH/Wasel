import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';

part 'selected_payment_method_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedPaymentMethod extends _$SelectedPaymentMethod {
  @override
  PaymentMethod build() => PaymentMethod.cash;

  void select(PaymentMethod method) => state = method;
}
