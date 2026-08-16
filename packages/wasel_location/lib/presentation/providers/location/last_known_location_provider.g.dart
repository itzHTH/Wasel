// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_known_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches the last known OS location cache as a one-shot read.
//
//? - Uses [FutureProvider] because this is a single, immediate cache lookup.
//
//? - Kept alive (`keepAlive: true`) in memory for the session to prevent
//?   micro-stutters when the map screen is remounted.
//
//? - Errors are intentionally swallowed by the repository and yield `null`,
//?  allowing the UI to smoothly fallback to a default camera target.

@ProviderFor(lastKnownLocation)
final lastKnownLocationProvider = LastKnownLocationProvider._();

/// Fetches the last known OS location cache as a one-shot read.
//
//? - Uses [FutureProvider] because this is a single, immediate cache lookup.
//
//? - Kept alive (`keepAlive: true`) in memory for the session to prevent
//?   micro-stutters when the map screen is remounted.
//
//? - Errors are intentionally swallowed by the repository and yield `null`,
//?  allowing the UI to smoothly fallback to a default camera target.

final class LastKnownLocationProvider
    extends
        $FunctionalProvider<
          AsyncValue<GeoPoint?>,
          GeoPoint?,
          FutureOr<GeoPoint?>
        >
    with $FutureModifier<GeoPoint?>, $FutureProvider<GeoPoint?> {
  /// Fetches the last known OS location cache as a one-shot read.
  //
  //? - Uses [FutureProvider] because this is a single, immediate cache lookup.
  //
  //? - Kept alive (`keepAlive: true`) in memory for the session to prevent
  //?   micro-stutters when the map screen is remounted.
  //
  //? - Errors are intentionally swallowed by the repository and yield `null`,
  //?  allowing the UI to smoothly fallback to a default camera target.
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
  $FutureProviderElement<GeoPoint?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GeoPoint?> create(Ref ref) {
    return lastKnownLocation(ref);
  }
}

String _$lastKnownLocationHash() => r'96d5dbcb191e0b91eccbd62a2e749b318c221651';
