enum RideHistoryStatus {
  completed,
  cancelled,
  unknown;

  /// Requests now send `Accept-Language`, so a server that localizes this
  /// field can answer in Arabic. Both spellings are accepted, matching how
  /// `PaymentMethod.fromApi` already handles its own vocabulary.
  static RideHistoryStatus fromApi(String? raw) =>
      switch (raw?.trim().toLowerCase()) {
        'completed' || 'مكتملة' => completed,
        'cancelled' || 'canceled' || 'ملغاة' => cancelled,
        _ => unknown,
      };
}
