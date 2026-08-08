/// What the driver has earned so far today.
///
/// The backend exposes no earnings endpoint yet, so the app serves a
/// placeholder instance and [isPlaceholder] dims the chip that renders it.
/// When the endpoint lands this entity gains a data layer behind it and the
/// contract stays.
class DriverEarningsOverview {
  const DriverEarningsOverview({
    required this.todayTotal,
    this.currency = 'IQD',
    this.completedTrips = 0,
    this.isPlaceholder = false,
  });

  final num todayTotal;
  final String currency;
  final int completedTrips;
  final bool isPlaceholder;

  @override
  bool operator ==(Object other) =>
      other is DriverEarningsOverview &&
      other.todayTotal == todayTotal &&
      other.currency == currency &&
      other.completedTrips == completedTrips &&
      other.isPlaceholder == isPlaceholder;

  @override
  int get hashCode =>
      Object.hash(todayTotal, currency, completedTrips, isPlaceholder);
}
