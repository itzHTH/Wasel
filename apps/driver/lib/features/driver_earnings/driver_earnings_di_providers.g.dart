// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getDriverEarningsUseCase)
final getDriverEarningsUseCaseProvider = GetDriverEarningsUseCaseProvider._();

final class GetDriverEarningsUseCaseProvider
    extends
        $FunctionalProvider<
          GetDriverEarningsUseCase,
          GetDriverEarningsUseCase,
          GetDriverEarningsUseCase
        >
    with $Provider<GetDriverEarningsUseCase> {
  GetDriverEarningsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDriverEarningsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDriverEarningsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDriverEarningsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDriverEarningsUseCase create(Ref ref) {
    return getDriverEarningsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDriverEarningsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDriverEarningsUseCase>(value),
    );
  }
}

String _$getDriverEarningsUseCaseHash() =>
    r'c52dfd102c0d841c285797877f8789a665e72286';

@ProviderFor(getDriverBalanceUseCase)
final getDriverBalanceUseCaseProvider = GetDriverBalanceUseCaseProvider._();

final class GetDriverBalanceUseCaseProvider
    extends
        $FunctionalProvider<
          GetDriverBalanceUseCase,
          GetDriverBalanceUseCase,
          GetDriverBalanceUseCase
        >
    with $Provider<GetDriverBalanceUseCase> {
  GetDriverBalanceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDriverBalanceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDriverBalanceUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDriverBalanceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDriverBalanceUseCase create(Ref ref) {
    return getDriverBalanceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDriverBalanceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDriverBalanceUseCase>(value),
    );
  }
}

String _$getDriverBalanceUseCaseHash() =>
    r'42832ced7ff2d67a53b43be816b705ab01d2924e';
