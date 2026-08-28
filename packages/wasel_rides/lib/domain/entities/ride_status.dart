enum RideStatus {
  pending,
  accepted,
  arrived,
  inProgress,
  completed,
  cancelled;

  static RideStatus? fromApi({String? name, int? code}) =>
      _fromName(name) ?? _fromCode(code);

  static RideStatus? _fromName(String? raw) =>
      switch (raw?.trim().toLowerCase()) {
        'pending' => pending,
        'accepted' => accepted,
        'arrived' || 'driverarrived' => arrived,
        'inprogress' || 'started' => inProgress,
        'completed' => completed,
        'cancelled' || 'canceled' => cancelled,
        _ => null,
      };

  static RideStatus? _fromCode(int? code) => switch (code) {
    1 => pending,
    2 => accepted,
    3 => arrived,
    4 => inProgress,
    5 => completed,
    6 => cancelled,
    _ => null,
  };

  bool get isTerminal => this == completed || this == cancelled;
}
