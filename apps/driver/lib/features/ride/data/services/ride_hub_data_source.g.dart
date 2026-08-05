// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_hub_data_source.dart';

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
          IRideHubDataSource,
          IRideHubDataSource,
          IRideHubDataSource
        >
    with $Provider<IRideHubDataSource> {
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
  $ProviderElement<IRideHubDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IRideHubDataSource create(Ref ref) {
    return rideHubService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IRideHubDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IRideHubDataSource>(value),
    );
  }
}

String _$rideHubServiceHash() => r'c3a6e0f3db33f4a8466191c2aca4e3ef7d8b969d';
