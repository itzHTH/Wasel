import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/domain/entities/ride_history_status.dart';

/// Stand-in rows the skeleton lays out while real history loads. Shared so the
/// first-load skeleton and the load-more skeleton shimmer the same shape.
final rideHistoryPlaceholders = List<RideHistoryEntry>.unmodifiable(
  List.generate(
    8,
    (index) => RideHistoryEntry(
      requestedAt: DateTime(2026, 1, 1, 12, index),
      price: 12500,
      status: RideHistoryStatus.completed,
    ),
  ),
);
