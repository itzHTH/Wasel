enum PaymentMethod {
  cash('نقدي', 1),
  card('بطاقة', 2),
  wallet('المحفظة', 3),
  unknown('غير محدد', null);

  const PaymentMethod(this.label, this.code);

  final String label;

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
