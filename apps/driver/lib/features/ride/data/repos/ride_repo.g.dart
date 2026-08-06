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
    extends $FunctionalProvider<RideRepo, RideRepo, RideRepo>
    with $Provider<RideRepo> {
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
  $ProviderElement<RideRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RideRepo create(Ref ref) {
    return rideRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideRepo>(value),
    );
  }
}

String _$rideRepoHash() => r'beb1693197a26bd9ae1942675f36866c3240e8a4';
