// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
//
//? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
//?   the expensive SVG-to-Bitmap rasterization process.
//
//? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
//
//? - Manually disposes Native graphics memory (Picture, Image) to prevent
//?   OOM (Out Of Memory) crashes during rapid map interactions.
//
//? - Fails gracefully by returning `null`, allowing callers to fall back to
//?   the default Google Maps red pin rather than crashing the UI.

@ProviderFor(mapMarkerIcon)
final mapMarkerIconProvider = MapMarkerIconFamily._();

/// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
//
//? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
//?   the expensive SVG-to-Bitmap rasterization process.
//
//? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
//
//? - Manually disposes Native graphics memory (Picture, Image) to prevent
//?   OOM (Out Of Memory) crashes during rapid map interactions.
//
//? - Fails gracefully by returning `null`, allowing callers to fall back to
//?   the default Google Maps red pin rather than crashing the UI.

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
  /// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
  //
  //? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
  //?   the expensive SVG-to-Bitmap rasterization process.
  //
  //? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
  //
  //? - Manually disposes Native graphics memory (Picture, Image) to prevent
  //?   OOM (Out Of Memory) crashes during rapid map interactions.
  //
  //? - Fails gracefully by returning `null`, allowing callers to fall back to
  //?   the default Google Maps red pin rather than crashing the UI.
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

/// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
//
//? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
//?   the expensive SVG-to-Bitmap rasterization process.
//
//? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
//
//? - Manually disposes Native graphics memory (Picture, Image) to prevent
//?   OOM (Out Of Memory) crashes during rapid map interactions.
//
//? - Fails gracefully by returning `null`, allowing callers to fall back to
//?   the default Google Maps red pin rather than crashing the UI.

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

  /// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
  //
  //? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
  //?   the expensive SVG-to-Bitmap rasterization process.
  //
  //? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
  //
  //? - Manually disposes Native graphics memory (Picture, Image) to prevent
  //?   OOM (Out Of Memory) crashes during rapid map interactions.
  //
  //? - Fails gracefully by returning `null`, allowing callers to fall back to
  //?   the default Google Maps red pin rather than crashing the UI.

  MapMarkerIconProvider call(String assetPath, {double logicalSize = 56.0}) =>
      MapMarkerIconProvider._(
        argument: (assetPath, logicalSize: logicalSize),
        from: this,
      );

  @override
  String toString() => r'mapMarkerIconProvider';
}
