// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** rasterises an SVG asset into a `BitmapDescriptor` the map
/// can draw as a marker, at the device's pixel density.
///
/// **Data flow:** reads an asset from the *host app's* bundle by path and
/// exposes `AsyncValue<BitmapDescriptor?>` to marker-building providers. Note
/// the direction: this package never names an asset, it only knows how to
/// convert one. Icon paths stay app-owned (`AppIcons`, `AppDriverConsts`),
/// which is what keeps rider and driver artwork independent.
///
/// **Why a family keyed by asset path and size:** the rasterisation is a pure
/// function of those two inputs, so they make a natural cache key. Both apps
/// draw the same pin repeatedly across rebuilds; the family turns that into one
/// decode per icon for the session.
///
/// **Why `FutureProvider`:** decoding is a genuinely async, one-shot operation
/// with no follow-up events and no action to expose.
///
/// **Why `keepAlive`:** this is the expensive one. Each miss costs an asset
/// load, a picture record, a raster and a PNG encode — all on the UI isolate.
/// Auto-disposing would repeat that work every time the last marker using an
/// icon left the screen, producing visible jank on a map that pans in and out
/// of showing a pin.
///
/// **Why it resolves to null instead of throwing:** every caller falls back to
/// `BitmapDescriptor.defaultMarker`. A default pin the map can still draw is
/// worth more to the user than an error state, so an unencodable icon degrades
/// rather than fails.

@ProviderFor(mapMarkerIcon)
final mapMarkerIconProvider = MapMarkerIconFamily._();

/// **What it does:** rasterises an SVG asset into a `BitmapDescriptor` the map
/// can draw as a marker, at the device's pixel density.
///
/// **Data flow:** reads an asset from the *host app's* bundle by path and
/// exposes `AsyncValue<BitmapDescriptor?>` to marker-building providers. Note
/// the direction: this package never names an asset, it only knows how to
/// convert one. Icon paths stay app-owned (`AppIcons`, `AppDriverConsts`),
/// which is what keeps rider and driver artwork independent.
///
/// **Why a family keyed by asset path and size:** the rasterisation is a pure
/// function of those two inputs, so they make a natural cache key. Both apps
/// draw the same pin repeatedly across rebuilds; the family turns that into one
/// decode per icon for the session.
///
/// **Why `FutureProvider`:** decoding is a genuinely async, one-shot operation
/// with no follow-up events and no action to expose.
///
/// **Why `keepAlive`:** this is the expensive one. Each miss costs an asset
/// load, a picture record, a raster and a PNG encode — all on the UI isolate.
/// Auto-disposing would repeat that work every time the last marker using an
/// icon left the screen, producing visible jank on a map that pans in and out
/// of showing a pin.
///
/// **Why it resolves to null instead of throwing:** every caller falls back to
/// `BitmapDescriptor.defaultMarker`. A default pin the map can still draw is
/// worth more to the user than an error state, so an unencodable icon degrades
/// rather than fails.

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
  /// **What it does:** rasterises an SVG asset into a `BitmapDescriptor` the map
  /// can draw as a marker, at the device's pixel density.
  ///
  /// **Data flow:** reads an asset from the *host app's* bundle by path and
  /// exposes `AsyncValue<BitmapDescriptor?>` to marker-building providers. Note
  /// the direction: this package never names an asset, it only knows how to
  /// convert one. Icon paths stay app-owned (`AppIcons`, `AppDriverConsts`),
  /// which is what keeps rider and driver artwork independent.
  ///
  /// **Why a family keyed by asset path and size:** the rasterisation is a pure
  /// function of those two inputs, so they make a natural cache key. Both apps
  /// draw the same pin repeatedly across rebuilds; the family turns that into one
  /// decode per icon for the session.
  ///
  /// **Why `FutureProvider`:** decoding is a genuinely async, one-shot operation
  /// with no follow-up events and no action to expose.
  ///
  /// **Why `keepAlive`:** this is the expensive one. Each miss costs an asset
  /// load, a picture record, a raster and a PNG encode — all on the UI isolate.
  /// Auto-disposing would repeat that work every time the last marker using an
  /// icon left the screen, producing visible jank on a map that pans in and out
  /// of showing a pin.
  ///
  /// **Why it resolves to null instead of throwing:** every caller falls back to
  /// `BitmapDescriptor.defaultMarker`. A default pin the map can still draw is
  /// worth more to the user than an error state, so an unencodable icon degrades
  /// rather than fails.
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

/// **What it does:** rasterises an SVG asset into a `BitmapDescriptor` the map
/// can draw as a marker, at the device's pixel density.
///
/// **Data flow:** reads an asset from the *host app's* bundle by path and
/// exposes `AsyncValue<BitmapDescriptor?>` to marker-building providers. Note
/// the direction: this package never names an asset, it only knows how to
/// convert one. Icon paths stay app-owned (`AppIcons`, `AppDriverConsts`),
/// which is what keeps rider and driver artwork independent.
///
/// **Why a family keyed by asset path and size:** the rasterisation is a pure
/// function of those two inputs, so they make a natural cache key. Both apps
/// draw the same pin repeatedly across rebuilds; the family turns that into one
/// decode per icon for the session.
///
/// **Why `FutureProvider`:** decoding is a genuinely async, one-shot operation
/// with no follow-up events and no action to expose.
///
/// **Why `keepAlive`:** this is the expensive one. Each miss costs an asset
/// load, a picture record, a raster and a PNG encode — all on the UI isolate.
/// Auto-disposing would repeat that work every time the last marker using an
/// icon left the screen, producing visible jank on a map that pans in and out
/// of showing a pin.
///
/// **Why it resolves to null instead of throwing:** every caller falls back to
/// `BitmapDescriptor.defaultMarker`. A default pin the map can still draw is
/// worth more to the user than an error state, so an unencodable icon degrades
/// rather than fails.

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

  /// **What it does:** rasterises an SVG asset into a `BitmapDescriptor` the map
  /// can draw as a marker, at the device's pixel density.
  ///
  /// **Data flow:** reads an asset from the *host app's* bundle by path and
  /// exposes `AsyncValue<BitmapDescriptor?>` to marker-building providers. Note
  /// the direction: this package never names an asset, it only knows how to
  /// convert one. Icon paths stay app-owned (`AppIcons`, `AppDriverConsts`),
  /// which is what keeps rider and driver artwork independent.
  ///
  /// **Why a family keyed by asset path and size:** the rasterisation is a pure
  /// function of those two inputs, so they make a natural cache key. Both apps
  /// draw the same pin repeatedly across rebuilds; the family turns that into one
  /// decode per icon for the session.
  ///
  /// **Why `FutureProvider`:** decoding is a genuinely async, one-shot operation
  /// with no follow-up events and no action to expose.
  ///
  /// **Why `keepAlive`:** this is the expensive one. Each miss costs an asset
  /// load, a picture record, a raster and a PNG encode — all on the UI isolate.
  /// Auto-disposing would repeat that work every time the last marker using an
  /// icon left the screen, producing visible jank on a map that pans in and out
  /// of showing a pin.
  ///
  /// **Why it resolves to null instead of throwing:** every caller falls back to
  /// `BitmapDescriptor.defaultMarker`. A default pin the map can still draw is
  /// worth more to the user than an error state, so an unencodable icon degrades
  /// rather than fails.

  MapMarkerIconProvider call(String assetPath, {double logicalSize = 56.0}) =>
      MapMarkerIconProvider._(
        argument: (assetPath, logicalSize: logicalSize),
        from: this,
      );

  @override
  String toString() => r'mapMarkerIconProvider';
}
