import 'package:driver/features/ride/domain/entities/driver_earnings_overview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_earnings_overview_provider.g.dart';

/// Placeholder earnings until `DriverEarnings` exists on the backend.
///
/// Kept as the real provider name so wiring it up later is a body swap: the
/// return type becomes the result of a use case and every consumer stays put.
const _placeholder = DriverEarningsOverview(
  todayTotal: 0,
  completedTrips: 0,
  isPlaceholder: true,
);

@riverpod
DriverEarningsOverview driverEarningsOverview(Ref ref) => _placeholder;
