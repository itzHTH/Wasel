// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_camera_target_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Determines the initial camera position for the map upon app launch.
//
//? - Checks the OS location cache first (via [lastKnownLocationProvider]).
//
//? - Falls back seamlessly to the default service area (e.g., Baghdad center)
//?   if the cache is empty or permission is denied.
//
//? - Never fails: guarantees the map always opens on a valid [LatLng] target
//?   without displaying error states to the user.
//
//? - Kept alive (`keepAlive: true`) to match its dependency and prevent
//?  loading flickers on map remounts.

@ProviderFor(initialCameraTarget)
final initialCameraTargetProvider = InitialCameraTargetProvider._();

/// Determines the initial camera position for the map upon app launch.
//
//? - Checks the OS location cache first (via [lastKnownLocationProvider]).
//
//? - Falls back seamlessly to the default service area (e.g., Baghdad center)
//?   if the cache is empty or permission is denied.
//
//? - Never fails: guarantees the map always opens on a valid [LatLng] target
//?   without displaying error states to the user.
//
//? - Kept alive (`keepAlive: true`) to match its dependency and prevent
//?  loading flickers on map remounts.

final class InitialCameraTargetProvider
    extends $FunctionalProvider<AsyncValue<LatLng>, LatLng, FutureOr<LatLng>>
    with $FutureModifier<LatLng>, $FutureProvider<LatLng> {
  /// Determines the initial camera position for the map upon app launch.
  //
  //? - Checks the OS location cache first (via [lastKnownLocationProvider]).
  //
  //? - Falls back seamlessly to the default service area (e.g., Baghdad center)
  //?   if the cache is empty or permission is denied.
  //
  //? - Never fails: guarantees the map always opens on a valid [LatLng] target
  //?   without displaying error states to the user.
  //
  //? - Kept alive (`keepAlive: true`) to match its dependency and prevent
  //?  loading flickers on map remounts.
  InitialCameraTargetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialCameraTargetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialCameraTargetHash();

  @$internal
  @override
  $FutureProviderElement<LatLng> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LatLng> create(Ref ref) {
    return initialCameraTarget(ref);
  }
}

String _$initialCameraTargetHash() =>
    r'1f4073a9ad30d1a88b5cf38172f80232404b9771';
