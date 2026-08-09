import 'package:driver/features/ride/domain/entities/rider_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'static_rider_profile_provider.g.dart';

/// Stand-in rider until the backend exposes a rider profile for a ride.
///
/// Replaced by `riderProfileProvider(rideId)` when that endpoint lands —
/// `RiderInfoRow` itself does not change.
const _placeholder = RiderProfile(
  name: 'أحمد ك.',
  rating: 4.8,
  isPlaceholder: true,
);

@riverpod
RiderProfile staticRiderProfile(Ref ref) => _placeholder;
