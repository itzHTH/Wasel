// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_point_markers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ridePointMarkers)
final ridePointMarkersProvider = RidePointMarkersProvider._();

final class RidePointMarkersProvider
    extends $FunctionalProvider<Set<Marker>, Set<Marker>, Set<Marker>>
    with $Provider<Set<Marker>> {
  RidePointMarkersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ridePointMarkersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ridePointMarkersHash();

  @$internal
  @override
  $ProviderElement<Set<Marker>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Set<Marker> create(Ref ref) {
    return ridePointMarkers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<Marker> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<Marker>>(value),
    );
  }
}

String _$ridePointMarkersHash() => r'4a353d9c6e4412910a4ffcace2782e2ca6c2b52f';
