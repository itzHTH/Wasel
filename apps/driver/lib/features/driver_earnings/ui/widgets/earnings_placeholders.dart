import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';

/// Stand-in figures the skeleton lays out while real earnings load. Shared so
/// the dashboard and the searching panel shimmer the same shape.
const placeholderEarnings = DriverEarnings(
  completedRides: 12,
  totalEarnings: 125000,
  onlineMinutes: 315,
  canCashOut: true,
);
