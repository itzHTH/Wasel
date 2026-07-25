// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the live [GoogleMapController] so providers — not widgets — can drive
/// the camera. Await [MapControllerHolder.future] to get the controller once
/// the map has been created.

@ProviderFor(MapControllerHolder)
final mapControllerHolderProvider = MapControllerHolderProvider._();

/// Holds the live [GoogleMapController] so providers — not widgets — can drive
/// the camera. Await [MapControllerHolder.future] to get the controller once
/// the map has been created.
final class MapControllerHolderProvider
    extends $AsyncNotifierProvider<MapControllerHolder, GoogleMapController> {
  /// Holds the live [GoogleMapController] so providers — not widgets — can drive
  /// the camera. Await [MapControllerHolder.future] to get the controller once
  /// the map has been created.
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

/// Holds the live [GoogleMapController] so providers — not widgets — can drive
/// the camera. Await [MapControllerHolder.future] to get the controller once
/// the map has been created.

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
