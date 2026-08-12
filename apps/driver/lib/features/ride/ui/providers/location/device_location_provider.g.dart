// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceLocation)
final deviceLocationProvider = DeviceLocationProvider._();

final class DeviceLocationProvider
    extends
        $FunctionalProvider<AsyncValue<Position>, Position, Stream<Position>>
    with $FutureModifier<Position>, $StreamProvider<Position> {
  DeviceLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationHash();

  @$internal
  @override
  $StreamProviderElement<Position> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Position> create(Ref ref) {
    return deviceLocation(ref);
  }
}

String _$deviceLocationHash() => r'847c9229a476f6bc41d51fa61d028f6b1dae20aa';

/// The OS cached fix — a cache read rather than a GPS acquisition, so it
/// settles immediately and holds no position stream open. Null when the cache
/// is empty or the permission was refused.

@ProviderFor(lastKnownLocation)
final lastKnownLocationProvider = LastKnownLocationProvider._();

/// The OS cached fix — a cache read rather than a GPS acquisition, so it
/// settles immediately and holds no position stream open. Null when the cache
/// is empty or the permission was refused.

final class LastKnownLocationProvider
    extends $FunctionalProvider<AsyncValue<LatLng?>, LatLng?, FutureOr<LatLng?>>
    with $FutureModifier<LatLng?>, $FutureProvider<LatLng?> {
  /// The OS cached fix — a cache read rather than a GPS acquisition, so it
  /// settles immediately and holds no position stream open. Null when the cache
  /// is empty or the permission was refused.
  LastKnownLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastKnownLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastKnownLocationHash();

  @$internal
  @override
  $FutureProviderElement<LatLng?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LatLng?> create(Ref ref) {
    return lastKnownLocation(ref);
  }
}

String _$lastKnownLocationHash() => r'e2f2fa4723f73974c6125f86f1fdb1fc6834608e';
