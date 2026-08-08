// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_rider_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(staticRiderProfile)
final staticRiderProfileProvider = StaticRiderProfileProvider._();

final class StaticRiderProfileProvider
    extends $FunctionalProvider<RiderProfile, RiderProfile, RiderProfile>
    with $Provider<RiderProfile> {
  StaticRiderProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staticRiderProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staticRiderProfileHash();

  @$internal
  @override
  $ProviderElement<RiderProfile> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderProfile create(Ref ref) {
    return staticRiderProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderProfile>(value),
    );
  }
}

String _$staticRiderProfileHash() =>
    r'8e5057140d84bf45abefdc91fe47f1779eec13ae';
