// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rasterizes an SVG asset into a map marker bitmap at the device pixel ratio.
/// Google Maps takes bitmaps only, so vector assets have to be baked once —
/// kept alive per (asset, size) so it survives ride restarts.
///
/// [logicalSize] is the device-independent length of the marker's longest side.

@ProviderFor(mapMarkerIcon)
final mapMarkerIconProvider = MapMarkerIconFamily._();

/// Rasterizes an SVG asset into a map marker bitmap at the device pixel ratio.
/// Google Maps takes bitmaps only, so vector assets have to be baked once —
/// kept alive per (asset, size) so it survives ride restarts.
///
/// [logicalSize] is the device-independent length of the marker's longest side.

final class MapMarkerIconProvider
    extends
        $FunctionalProvider<
          AsyncValue<BitmapDescriptor>,
          BitmapDescriptor,
          FutureOr<BitmapDescriptor>
        >
    with $FutureModifier<BitmapDescriptor>, $FutureProvider<BitmapDescriptor> {
  /// Rasterizes an SVG asset into a map marker bitmap at the device pixel ratio.
  /// Google Maps takes bitmaps only, so vector assets have to be baked once —
  /// kept alive per (asset, size) so it survives ride restarts.
  ///
  /// [logicalSize] is the device-independent length of the marker's longest side.
  MapMarkerIconProvider._({
    required MapMarkerIconFamily super.from,
    required (String, {double logicalSize}) super.argument,
  }) : super(
         retry: null,
         name: r'mapMarkerIconProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mapMarkerIconHash();

  @override
  String toString() {
    return r'mapMarkerIconProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<BitmapDescriptor> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BitmapDescriptor> create(Ref ref) {
    final argument = this.argument as (String, {double logicalSize});
    return mapMarkerIcon(ref, argument.$1, logicalSize: argument.logicalSize);
  }

  @override
  bool operator ==(Object other) {
    return other is MapMarkerIconProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mapMarkerIconHash() => r'b8966073fd5b9a12c7a2c0d15306d19621837ea7';

/// Rasterizes an SVG asset into a map marker bitmap at the device pixel ratio.
/// Google Maps takes bitmaps only, so vector assets have to be baked once —
/// kept alive per (asset, size) so it survives ride restarts.
///
/// [logicalSize] is the device-independent length of the marker's longest side.

final class MapMarkerIconFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<BitmapDescriptor>,
          (String, {double logicalSize})
        > {
  MapMarkerIconFamily._()
    : super(
        retry: null,
        name: r'mapMarkerIconProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Rasterizes an SVG asset into a map marker bitmap at the device pixel ratio.
  /// Google Maps takes bitmaps only, so vector assets have to be baked once —
  /// kept alive per (asset, size) so it survives ride restarts.
  ///
  /// [logicalSize] is the device-independent length of the marker's longest side.

  MapMarkerIconProvider call(String assetPath, {double logicalSize = 56.0}) =>
      MapMarkerIconProvider._(
        argument: (assetPath, logicalSize: logicalSize),
        from: this,
      );

  @override
  String toString() => r'mapMarkerIconProvider';
}
