/// How the rider pays for the trip.
///
/// The hub delivers this as a free-form string (`data['paymentmethod']`), so
/// [fromApi] accepts both the numeric codes the rider app sends when
/// requesting a ride and the spelled-out names, and degrades to [unknown]
/// rather than throwing on anything unrecognised.
enum PaymentMethod {
  cash('نقدي'),
  card('بطاقة'),
  wallet('المحفظة'),
  unknown('غير محدد');

  const PaymentMethod(this.label);

  final String label;

  static PaymentMethod fromApi(String? value) {
    return switch (value?.trim().toLowerCase()) {
      '1' || 'cash' || 'نقدي' => cash,
      '2' || 'card' || 'بطاقة' => card,
      '3' || 'wallet' || 'المحفظة' => wallet,
      _ => unknown,
    };
  }
}
