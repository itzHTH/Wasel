import 'package:wasel_rides/domain/entities/ride_history_status.dart';

class RideHistoryEntry {
  final String? id;
  final DateTime requestedAt;
  final double price;
  final RideHistoryStatus status;

  const RideHistoryEntry({
    this.id,
    required this.requestedAt,
    required this.price,
    required this.status,
  });
}
