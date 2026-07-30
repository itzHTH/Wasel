// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routePoints)
final routePointsProvider = RoutePointsProvider._();

final class RoutePointsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GeoPoint>>,
          List<GeoPoint>,
          FutureOr<List<GeoPoint>>
        >
    with $FutureModifier<List<GeoPoint>>, $FutureProvider<List<GeoPoint>> {
  RoutePointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routePointsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routePointsHash();

  @$internal
  @override
  $FutureProviderElement<List<GeoPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GeoPoint>> create(Ref ref) {
    return routePoints(ref);
  }
}

String _$routePointsHash() => r'd2d4ecbc1bdb6d66a99b0c6fd8ee63f4bae65685';
