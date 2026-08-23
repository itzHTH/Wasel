enum PaymentMethod {
  cash(1),
  card(2),
  wallet(3),
  unknown(null);

  const PaymentMethod(this.code);

  /// The value the API expects for this method, or null when it has none.
  final int? code;

  static PaymentMethod fromApi(String? value) {
    return switch (value?.trim().toLowerCase()) {
      '1' || 'cash' || 'نقدي' => cash,
      '2' || 'card' || 'بطاقة' => card,
      '3' || 'wallet' || 'المحفظة' => wallet,
      _ => unknown,
    };
  }
}
