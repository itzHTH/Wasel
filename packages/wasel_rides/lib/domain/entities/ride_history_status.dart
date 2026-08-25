enum RideHistoryStatus {
  completed,
  cancelled,
  unknown;

  /// Requests send `Accept-Language`, so the server answers this field in the
  /// active language and its Arabic wording is prose, not a stable code —
  /// "ملغية" and "ملغاة" are both cancelled. Every spelling seen from the API
  /// is accepted, matching how `PaymentMethod.fromApi` handles its own
  /// vocabulary.
  static RideHistoryStatus fromApi(String? raw) =>
      switch (raw?.trim().toLowerCase()) {
        'completed' || 'مكتملة' || 'مكتمل' => completed,
        'cancelled' || 'canceled' || 'ملغية' || 'ملغاة' || 'ملغي' => cancelled,
        _ => unknown,
      };
}
