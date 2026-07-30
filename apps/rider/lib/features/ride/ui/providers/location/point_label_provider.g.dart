// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pointLabel)
final pointLabelProvider = PointLabelFamily._();

final class PointLabelProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  PointLabelProvider._({
    required PointLabelFamily super.from,
    required GeoPoint super.argument,
  }) : super(
         retry: null,
         name: r'pointLabelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pointLabelHash();

  @override
  String toString() {
    return r'pointLabelProvider'
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
    return pointLabel(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PointLabelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pointLabelHash() => r'14e17f58ca2e081073eda13507b3888333e1a2ea';

final class PointLabelFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, GeoPoint> {
  PointLabelFamily._()
    : super(
        retry: null,
        name: r'pointLabelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PointLabelProvider call(GeoPoint point) =>
      PointLabelProvider._(argument: point, from: this);

  @override
  String toString() => r'pointLabelProvider';
}
