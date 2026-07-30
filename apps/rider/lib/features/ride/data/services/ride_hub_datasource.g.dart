// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_hub_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideHubService)
final rideHubServiceProvider = RideHubServiceProvider._();

final class RideHubServiceProvider
    extends
        $FunctionalProvider<
          IRideHubDatasource,
          IRideHubDatasource,
          IRideHubDatasource
        >
    with $Provider<IRideHubDatasource> {
  RideHubServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideHubServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideHubServiceHash();

  @$internal
  @override
  $ProviderElement<IRideHubDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IRideHubDatasource create(Ref ref) {
    return rideHubService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IRideHubDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IRideHubDatasource>(value),
    );
  }
}

String _$rideHubServiceHash() => r'42c9c2a235b1cb625d62b51d9a4777e062c55660';
