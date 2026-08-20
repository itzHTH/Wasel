// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_polylines_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routePolylines)
final routePolylinesProvider = RoutePolylinesProvider._();

final class RoutePolylinesProvider
    extends $FunctionalProvider<Set<Polyline>, Set<Polyline>, Set<Polyline>>
    with $Provider<Set<Polyline>> {
  RoutePolylinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routePolylinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routePolylinesHash();

  @$internal
  @override
  $ProviderElement<Set<Polyline>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Set<Polyline> create(Ref ref) {
    return routePolylines(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<Polyline> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<Polyline>>(value),
    );
  }
}

String _$routePolylinesHash() => r'ec668036804064bdf54a3413f565bc7994012eb4';
