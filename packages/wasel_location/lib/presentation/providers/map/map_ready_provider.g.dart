// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_ready_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `true` once the map has drawn its first settled frame, so overlays can stop
/// covering it.

@ProviderFor(MapReady)
final mapReadyProvider = MapReadyProvider._();

/// `true` once the map has drawn its first settled frame, so overlays can stop
/// covering it.
final class MapReadyProvider extends $NotifierProvider<MapReady, bool> {
  /// `true` once the map has drawn its first settled frame, so overlays can stop
  /// covering it.
  MapReadyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapReadyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapReadyHash();

  @$internal
  @override
  MapReady create() => MapReady();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$mapReadyHash() => r'eab03eea6026d936723099dd6fa7c0cdd935d357';

/// `true` once the map has drawn its first settled frame, so overlays can stop
/// covering it.

abstract class _$MapReady extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
