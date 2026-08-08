// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_point_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Driver-side mirror of the rider's `pointLabel`.
///
/// The driver app has no geocoding slice yet, so this resolves to an empty
/// label and every consumer falls back to formatted coordinates. When the
/// geocoding slice is ported, only this body changes — the signature already
/// matches the rider's provider.

@ProviderFor(driverPointLabel)
final driverPointLabelProvider = DriverPointLabelFamily._();

/// Driver-side mirror of the rider's `pointLabel`.
///
/// The driver app has no geocoding slice yet, so this resolves to an empty
/// label and every consumer falls back to formatted coordinates. When the
/// geocoding slice is ported, only this body changes — the signature already
/// matches the rider's provider.

final class DriverPointLabelProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Driver-side mirror of the rider's `pointLabel`.
  ///
  /// The driver app has no geocoding slice yet, so this resolves to an empty
  /// label and every consumer falls back to formatted coordinates. When the
  /// geocoding slice is ported, only this body changes — the signature already
  /// matches the rider's provider.
  DriverPointLabelProvider._({
    required DriverPointLabelFamily super.from,
    required GeoPoint super.argument,
  }) : super(
         retry: null,
         name: r'driverPointLabelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driverPointLabelHash();

  @override
  String toString() {
    return r'driverPointLabelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as GeoPoint;
    return driverPointLabel(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriverPointLabelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driverPointLabelHash() => r'bed4a5b717fddb58cbcf473ad9705b3c16f9664d';

/// Driver-side mirror of the rider's `pointLabel`.
///
/// The driver app has no geocoding slice yet, so this resolves to an empty
/// label and every consumer falls back to formatted coordinates. When the
/// geocoding slice is ported, only this body changes — the signature already
/// matches the rider's provider.

final class DriverPointLabelFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, GeoPoint> {
  DriverPointLabelFamily._()
    : super(
        retry: null,
        name: r'driverPointLabelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Driver-side mirror of the rider's `pointLabel`.
  ///
  /// The driver app has no geocoding slice yet, so this resolves to an empty
  /// label and every consumer falls back to formatted coordinates. When the
  /// geocoding slice is ported, only this body changes — the signature already
  /// matches the rider's provider.

  DriverPointLabelProvider call(GeoPoint point) =>
      DriverPointLabelProvider._(argument: point, from: this);

  @override
  String toString() => r'driverPointLabelProvider';
}
