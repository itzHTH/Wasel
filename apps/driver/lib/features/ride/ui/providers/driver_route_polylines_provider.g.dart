// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_route_polylines_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverRoutePolylines)
final driverRoutePolylinesProvider = DriverRoutePolylinesProvider._();

final class DriverRoutePolylinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<Polyline>>,
          Set<Polyline>,
          FutureOr<Set<Polyline>>
        >
    with $FutureModifier<Set<Polyline>>, $FutureProvider<Set<Polyline>> {
  DriverRoutePolylinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverRoutePolylinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverRoutePolylinesHash();

  @$internal
  @override
  $FutureProviderElement<Set<Polyline>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Set<Polyline>> create(Ref ref) {
    return driverRoutePolylines(ref);
  }
}

String _$driverRoutePolylinesHash() =>
    r'bdf44604b1b44cb4027c8b86a81cd3dc0eea696b';
