enum RideHistoryStatus {
  completed,
  cancelled,
  unknown;

  static RideHistoryStatus fromApi(String? raw) =>
      switch (raw?.trim().toLowerCase()) {
        'completed' => completed,
        'cancelled' || 'canceled' => cancelled,
        _ => unknown,
      };
}
