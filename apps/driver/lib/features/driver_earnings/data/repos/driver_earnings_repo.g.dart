// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverEarningsRepo)
final driverEarningsRepoProvider = DriverEarningsRepoProvider._();

final class DriverEarningsRepoProvider
    extends
        $FunctionalProvider<
          BaseDriverEarningsRepo,
          BaseDriverEarningsRepo,
          BaseDriverEarningsRepo
        >
    with $Provider<BaseDriverEarningsRepo> {
  DriverEarningsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverEarningsRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverEarningsRepoHash();

  @$internal
  @override
  $ProviderElement<BaseDriverEarningsRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseDriverEarningsRepo create(Ref ref) {
    return driverEarningsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseDriverEarningsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseDriverEarningsRepo>(value),
    );
  }
}

String _$driverEarningsRepoHash() =>
    r'bd816f0e3475544666a9082f4bb297b04ae20c93';
