// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the GoogleMapController of the currently mounted `AppMap`.
//
//? - Exposes a [Future] rather than a nullable controller so camera work can be
//?   queued *before* the platform view finishes creating itself — callers just
//?   `await` and the animation runs as soon as the map exists.
//
//? - Kept alive (`keepAlive: true`) because the controller outlives any single
//?   widget that wants to drive it; an auto-disposing holder would drop the
//?   completer the moment the last listener paused.

@ProviderFor(MapControllerHolder)
final mapControllerHolderProvider = MapControllerHolderProvider._();

/// Holds the GoogleMapController of the currently mounted `AppMap`.
//
//? - Exposes a [Future] rather than a nullable controller so camera work can be
//?   queued *before* the platform view finishes creating itself — callers just
//?   `await` and the animation runs as soon as the map exists.
//
//? - Kept alive (`keepAlive: true`) because the controller outlives any single
//?   widget that wants to drive it; an auto-disposing holder would drop the
//?   completer the moment the last listener paused.
final class MapControllerHolderProvider
    extends $AsyncNotifierProvider<MapControllerHolder, GoogleMapController> {
  /// Holds the GoogleMapController of the currently mounted `AppMap`.
  //
  //? - Exposes a [Future] rather than a nullable controller so camera work can be
  //?   queued *before* the platform view finishes creating itself — callers just
  //?   `await` and the animation runs as soon as the map exists.
  //
  //? - Kept alive (`keepAlive: true`) because the controller outlives any single
  //?   widget that wants to drive it; an auto-disposing holder would drop the
  //?   completer the moment the last listener paused.
  MapControllerHolderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapControllerHolderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapControllerHolderHash();

  @$internal
  @override
  MapControllerHolder create() => MapControllerHolder();
}

String _$mapControllerHolderHash() =>
    r'd9792eb1406511cc4571579a25d3d583a92ecc0b';

/// Holds the GoogleMapController of the currently mounted `AppMap`.
//
//? - Exposes a [Future] rather than a nullable controller so camera work can be
//?   queued *before* the platform view finishes creating itself — callers just
//?   `await` and the animation runs as soon as the map exists.
//
//? - Kept alive (`keepAlive: true`) because the controller outlives any single
//?   widget that wants to drive it; an auto-disposing holder would drop the
//?   completer the moment the last listener paused.

abstract class _$MapControllerHolder
    extends $AsyncNotifier<GoogleMapController> {
  FutureOr<GoogleMapController> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<GoogleMapController>, GoogleMapController>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GoogleMapController>, GoogleMapController>,
              AsyncValue<GoogleMapController>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
