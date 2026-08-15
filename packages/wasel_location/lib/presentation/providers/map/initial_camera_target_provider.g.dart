// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_camera_target_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** decides where a map should open its camera, before any live
/// fix exists.
///
/// **Data flow:** [lastKnownLocationProvider] → the cached coordinate if there
/// is one, otherwise `AppMapDefaults.initialTarget` (the service-area centre).
/// Exposes `AsyncValue<LatLng>` to whichever screen is constructing an `AppMap`.
///
/// **Why `FutureProvider`:** the answer depends on an awaited cache read, but it
/// is asked exactly once per map. There is no action to perform and no later
/// event to deliver, which is precisely the shape `FutureProvider` exists for —
/// an `AsyncNotifier` would add a mutation surface nothing would call.
///
/// **Why `keepAlive`:** it inherits the lifetime of its only dependency. Since
/// `lastKnownLocation` is kept alive, auto-disposing this one would recompute a
/// cheap derivation for no benefit while adding a loading frame each time a map
/// is rebuilt.
///
/// **Why it cannot fail:** falling back to the service centre is always
/// possible, so this resolves to a usable camera target in every case — a map
/// that opens *somewhere* beats one that opens on an error state.
///
/// Returns `LatLng` rather than `GeoPoint` because its only consumer is a map
/// widget; the conversion happens here so callers do not each repeat it.

@ProviderFor(initialCameraTarget)
final initialCameraTargetProvider = InitialCameraTargetProvider._();

/// **What it does:** decides where a map should open its camera, before any live
/// fix exists.
///
/// **Data flow:** [lastKnownLocationProvider] → the cached coordinate if there
/// is one, otherwise `AppMapDefaults.initialTarget` (the service-area centre).
/// Exposes `AsyncValue<LatLng>` to whichever screen is constructing an `AppMap`.
///
/// **Why `FutureProvider`:** the answer depends on an awaited cache read, but it
/// is asked exactly once per map. There is no action to perform and no later
/// event to deliver, which is precisely the shape `FutureProvider` exists for —
/// an `AsyncNotifier` would add a mutation surface nothing would call.
///
/// **Why `keepAlive`:** it inherits the lifetime of its only dependency. Since
/// `lastKnownLocation` is kept alive, auto-disposing this one would recompute a
/// cheap derivation for no benefit while adding a loading frame each time a map
/// is rebuilt.
///
/// **Why it cannot fail:** falling back to the service centre is always
/// possible, so this resolves to a usable camera target in every case — a map
/// that opens *somewhere* beats one that opens on an error state.
///
/// Returns `LatLng` rather than `GeoPoint` because its only consumer is a map
/// widget; the conversion happens here so callers do not each repeat it.

final class InitialCameraTargetProvider
    extends $FunctionalProvider<AsyncValue<LatLng>, LatLng, FutureOr<LatLng>>
    with $FutureModifier<LatLng>, $FutureProvider<LatLng> {
  /// **What it does:** decides where a map should open its camera, before any live
  /// fix exists.
  ///
  /// **Data flow:** [lastKnownLocationProvider] → the cached coordinate if there
  /// is one, otherwise `AppMapDefaults.initialTarget` (the service-area centre).
  /// Exposes `AsyncValue<LatLng>` to whichever screen is constructing an `AppMap`.
  ///
  /// **Why `FutureProvider`:** the answer depends on an awaited cache read, but it
  /// is asked exactly once per map. There is no action to perform and no later
  /// event to deliver, which is precisely the shape `FutureProvider` exists for —
  /// an `AsyncNotifier` would add a mutation surface nothing would call.
  ///
  /// **Why `keepAlive`:** it inherits the lifetime of its only dependency. Since
  /// `lastKnownLocation` is kept alive, auto-disposing this one would recompute a
  /// cheap derivation for no benefit while adding a loading frame each time a map
  /// is rebuilt.
  ///
  /// **Why it cannot fail:** falling back to the service centre is always
  /// possible, so this resolves to a usable camera target in every case — a map
  /// that opens *somewhere* beats one that opens on an error state.
  ///
  /// Returns `LatLng` rather than `GeoPoint` because its only consumer is a map
  /// widget; the conversion happens here so callers do not each repeat it.
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
