// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapMarkerIcon)
final mapMarkerIconProvider = MapMarkerIconFamily._();

final class MapMarkerIconProvider
    extends
        $FunctionalProvider<
          AsyncValue<BitmapDescriptor>,
          BitmapDescriptor,
          FutureOr<BitmapDescriptor>
        >
    with $FutureModifier<BitmapDescriptor>, $FutureProvider<BitmapDescriptor> {
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

String _$mapMarkerIconHash() => r'ace5c004811c34bad6d0ca4f674f5cfdf1c98be9';

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

  MapMarkerIconProvider call(String assetPath, {double logicalSize = 56.0}) =>
      MapMarkerIconProvider._(
        argument: (assetPath, logicalSize: logicalSize),
        from: this,
      );

  @override
  String toString() => r'mapMarkerIconProvider';
}
