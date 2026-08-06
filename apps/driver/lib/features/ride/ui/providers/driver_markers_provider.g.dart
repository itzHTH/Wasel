// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_markers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverMarkers)
final driverMarkersProvider = DriverMarkersProvider._();

final class DriverMarkersProvider
    extends $FunctionalProvider<Set<Marker>, Set<Marker>, Set<Marker>>
    with $Provider<Set<Marker>> {
  DriverMarkersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverMarkersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverMarkersHash();

  @$internal
  @override
  $ProviderElement<Set<Marker>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Set<Marker> create(Ref ref) {
    return driverMarkers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<Marker> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<Marker>>(value),
    );
  }
}

String _$driverMarkersHash() => r'a450e0efe46b33139fa1b55379437a671109c9ac';
