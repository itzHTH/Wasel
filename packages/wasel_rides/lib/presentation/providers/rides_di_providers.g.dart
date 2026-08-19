// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rides_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ridesApiService)
final ridesApiServiceProvider = RidesApiServiceProvider._();

final class RidesApiServiceProvider
    extends
        $FunctionalProvider<RidesApiService, RidesApiService, RidesApiService>
    with $Provider<RidesApiService> {
  RidesApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ridesApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ridesApiServiceHash();

  @$internal
  @override
  $ProviderElement<RidesApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RidesApiService create(Ref ref) {
    return ridesApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RidesApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RidesApiService>(value),
    );
  }
}

String _$ridesApiServiceHash() => r'f4aa0224aac4fb3fd7461ac0cb7ed8da9e5c91e5';

@ProviderFor(ridesHistoryRepo)
final ridesHistoryRepoProvider = RidesHistoryRepoProvider._();

final class RidesHistoryRepoProvider
    extends
        $FunctionalProvider<
          BaseRidesHistoryRepo,
          BaseRidesHistoryRepo,
          BaseRidesHistoryRepo
        >
    with $Provider<BaseRidesHistoryRepo> {
  RidesHistoryRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ridesHistoryRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ridesHistoryRepoHash();

  @$internal
  @override
  $ProviderElement<BaseRidesHistoryRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseRidesHistoryRepo create(Ref ref) {
    return ridesHistoryRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseRidesHistoryRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseRidesHistoryRepo>(value),
    );
  }
}

String _$ridesHistoryRepoHash() => r'53f162aac23256e7732067f3b2ee2ab22bef18ec';

@ProviderFor(getRideHistoryUseCase)
final getRideHistoryUseCaseProvider = GetRideHistoryUseCaseProvider._();

final class GetRideHistoryUseCaseProvider
    extends
        $FunctionalProvider<
          GetRideHistoryUseCase,
          GetRideHistoryUseCase,
          GetRideHistoryUseCase
        >
    with $Provider<GetRideHistoryUseCase> {
  GetRideHistoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRideHistoryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRideHistoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRideHistoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRideHistoryUseCase create(Ref ref) {
    return getRideHistoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRideHistoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRideHistoryUseCase>(value),
    );
  }
}

String _$getRideHistoryUseCaseHash() =>
    r'309bb61872d26c7c813d9d777a32896a5a94b20d';
