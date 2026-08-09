// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_rider_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The rider of the ride the driver is currently serving, or null when there
/// is no active ride.
///
/// The offer event carries the rider's name and phone, so those two fields are
/// real. Rating and photo have no source yet, hence they stay null. A blank
/// name from the backend yields null too — an empty identity is worse than no
/// row at all.

@ProviderFor(currentRiderProfile)
final currentRiderProfileProvider = CurrentRiderProfileProvider._();

/// The rider of the ride the driver is currently serving, or null when there
/// is no active ride.
///
/// The offer event carries the rider's name and phone, so those two fields are
/// real. Rating and photo have no source yet, hence they stay null. A blank
/// name from the backend yields null too — an empty identity is worse than no
/// row at all.

final class CurrentRiderProfileProvider
    extends $FunctionalProvider<RiderProfile?, RiderProfile?, RiderProfile?>
    with $Provider<RiderProfile?> {
  /// The rider of the ride the driver is currently serving, or null when there
  /// is no active ride.
  ///
  /// The offer event carries the rider's name and phone, so those two fields are
  /// real. Rating and photo have no source yet, hence they stay null. A blank
  /// name from the backend yields null too — an empty identity is worse than no
  /// row at all.
  CurrentRiderProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentRiderProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentRiderProfileHash();

  @$internal
  @override
  $ProviderElement<RiderProfile?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderProfile? create(Ref ref) {
    return currentRiderProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderProfile? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderProfile?>(value),
    );
  }
}

String _$currentRiderProfileHash() =>
    r'd00eda5fcbee2691597b1e95787ed229549e9117';
