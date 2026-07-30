// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideRepo)
final rideRepoProvider = RideRepoProvider._();

final class RideRepoProvider
    extends $FunctionalProvider<BaseRideRepo, BaseRideRepo, BaseRideRepo>
    with $Provider<BaseRideRepo> {
  RideRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideRepoHash();

  @$internal
  @override
  $ProviderElement<BaseRideRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseRideRepo create(Ref ref) {
    return rideRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseRideRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseRideRepo>(value),
    );
  }
}

String _$rideRepoHash() => r'56157a880090d845d40d60929d3af3bda214506a';
