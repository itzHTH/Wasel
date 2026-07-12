// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routeRepo)
final routeRepoProvider = RouteRepoProvider._();

final class RouteRepoProvider
    extends $FunctionalProvider<BaseRouteRepo, BaseRouteRepo, BaseRouteRepo>
    with $Provider<BaseRouteRepo> {
  RouteRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeRepoHash();

  @$internal
  @override
  $ProviderElement<BaseRouteRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseRouteRepo create(Ref ref) {
    return routeRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseRouteRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseRouteRepo>(value),
    );
  }
}

String _$routeRepoHash() => r'843bfcbb3b5ecf482f3d10081ef49cbec20fbd15';
