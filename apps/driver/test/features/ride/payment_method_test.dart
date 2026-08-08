import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('numeric codes map to their method', () {
    expect(PaymentMethod.fromApi('1'), PaymentMethod.cash);
    expect(PaymentMethod.fromApi('2'), PaymentMethod.card);
    expect(PaymentMethod.fromApi('3'), PaymentMethod.wallet);
  });

  test('english names map regardless of case', () {
    expect(PaymentMethod.fromApi('Cash'), PaymentMethod.cash);
    expect(PaymentMethod.fromApi('CARD'), PaymentMethod.card);
    expect(PaymentMethod.fromApi('wallet'), PaymentMethod.wallet);
  });

  test('arabic names map to their method', () {
    expect(PaymentMethod.fromApi('نقدي'), PaymentMethod.cash);
    expect(PaymentMethod.fromApi('بطاقة'), PaymentMethod.card);
    expect(PaymentMethod.fromApi('المحفظة'), PaymentMethod.wallet);
  });

  test('surrounding whitespace is ignored', () {
    expect(PaymentMethod.fromApi('  cash '), PaymentMethod.cash);
  });

  test('an empty value falls back to unknown', () {
    expect(PaymentMethod.fromApi(''), PaymentMethod.unknown);
  });

  test('a null value falls back to unknown', () {
    expect(PaymentMethod.fromApi(null), PaymentMethod.unknown);
  });

  test('an unrecognised value falls back to unknown', () {
    expect(PaymentMethod.fromApi('crypto'), PaymentMethod.unknown);
  });
}
