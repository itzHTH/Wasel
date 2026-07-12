// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_remote_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routeRemoteService)
final routeRemoteServiceProvider = RouteRemoteServiceProvider._();

final class RouteRemoteServiceProvider
    extends
        $FunctionalProvider<
          RouteRemoteService,
          RouteRemoteService,
          RouteRemoteService
        >
    with $Provider<RouteRemoteService> {
  RouteRemoteServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeRemoteServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeRemoteServiceHash();

  @$internal
  @override
  $ProviderElement<RouteRemoteService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RouteRemoteService create(Ref ref) {
    return routeRemoteService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteRemoteService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteRemoteService>(value),
    );
  }
}

String _$routeRemoteServiceHash() =>
    r'a6c5395dca3641f977ea0ad22f8de41c4db0e868';
