// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The drawn route between the draft's pickup and dropoff.

@ProviderFor(routePoints)
final routePointsProvider = RoutePointsProvider._();

/// The drawn route between the draft's pickup and dropoff.

final class RoutePointsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GeoPoint>>,
          List<GeoPoint>,
          FutureOr<List<GeoPoint>>
        >
    with $FutureModifier<List<GeoPoint>>, $FutureProvider<List<GeoPoint>> {
  /// The drawn route between the draft's pickup and dropoff.
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

String _$routePointsHash() => r'a82016fe744e39b2cf9e4263d2196cc236a366ea';
