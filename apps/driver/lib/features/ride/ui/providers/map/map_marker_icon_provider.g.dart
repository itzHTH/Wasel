// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rasterises an SVG into a marker icon, or null when it cannot be encoded.
///
/// Every caller already falls back to a default marker for a missing icon, so
/// a pin the map can still draw is worth more here than an error.

@ProviderFor(mapMarkerIcon)
final mapMarkerIconProvider = MapMarkerIconFamily._();

/// Rasterises an SVG into a marker icon, or null when it cannot be encoded.
///
/// Every caller already falls back to a default marker for a missing icon, so
/// a pin the map can still draw is worth more here than an error.

final class MapMarkerIconProvider
    extends
        $FunctionalProvider<
          AsyncValue<BitmapDescriptor?>,
          BitmapDescriptor?,
          FutureOr<BitmapDescriptor?>
        >
    with
        $FutureModifier<BitmapDescriptor?>,
        $FutureProvider<BitmapDescriptor?> {
  /// Rasterises an SVG into a marker icon, or null when it cannot be encoded.
  ///
  /// Every caller already falls back to a default marker for a missing icon, so
  /// a pin the map can still draw is worth more here than an error.
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
  $FutureProviderElement<BitmapDescriptor?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BitmapDescriptor?> create(Ref ref) {
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

String _$mapMarkerIconHash() => r'1e170c461fba4beefe677ad2b595b2ab239e1424';

/// Rasterises an SVG into a marker icon, or null when it cannot be encoded.
///
/// Every caller already falls back to a default marker for a missing icon, so
/// a pin the map can still draw is worth more here than an error.

final class MapMarkerIconFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<BitmapDescriptor?>,
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

  /// Rasterises an SVG into a marker icon, or null when it cannot be encoded.
  ///
  /// Every caller already falls back to a default marker for a missing icon, so
  /// a pin the map can still draw is worth more here than an error.

  MapMarkerIconProvider call(String assetPath, {double logicalSize = 56.0}) =>
      MapMarkerIconProvider._(
        argument: (assetPath, logicalSize: logicalSize),
        from: this,
      );

  @override
  String toString() => r'mapMarkerIconProvider';
}
