import 'package:driver/features/ride/domain/entities/rider_profile.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_rider_profile_provider.g.dart';

/// The rider of the ride the driver is currently serving, or null when there
/// is no active ride.
///
/// The offer event carries the rider's name and phone, so those two fields are
/// real. Rating and photo have no source yet, hence they stay null. A blank
/// name from the backend yields null too — an empty identity is worse than no
/// row at all.
@riverpod
RiderProfile? currentRiderProfile(Ref ref) {
  final ride = ref.watch(rideControllerProvider.select((state) => state.ride));
  if (ride == null || ride.riderName.trim().isEmpty) return null;

  final phoneNumber = ride.riderPhone.trim();

  return RiderProfile(
    name: ride.riderName,
    phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
  );
}
