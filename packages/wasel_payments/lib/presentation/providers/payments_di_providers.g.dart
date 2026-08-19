// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(paymentsApiService)
final paymentsApiServiceProvider = PaymentsApiServiceProvider._();

final class PaymentsApiServiceProvider
    extends
        $FunctionalProvider<
          PaymentsApiService,
          PaymentsApiService,
          PaymentsApiService
        >
    with $Provider<PaymentsApiService> {
  PaymentsApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsApiServiceHash();

  @$internal
  @override
  $ProviderElement<PaymentsApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentsApiService create(Ref ref) {
    return paymentsApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentsApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentsApiService>(value),
    );
  }
}

String _$paymentsApiServiceHash() =>
    r'28df1289c4e1e0f398ff84258eb332dfb210a87d';

@ProviderFor(paymentsRepo)
final paymentsRepoProvider = PaymentsRepoProvider._();

final class PaymentsRepoProvider
    extends
        $FunctionalProvider<
          BasePaymentsRepo,
          BasePaymentsRepo,
          BasePaymentsRepo
        >
    with $Provider<BasePaymentsRepo> {
  PaymentsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsRepoHash();

  @$internal
  @override
  $ProviderElement<BasePaymentsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BasePaymentsRepo create(Ref ref) {
    return paymentsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BasePaymentsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BasePaymentsRepo>(value),
    );
  }
}

String _$paymentsRepoHash() => r'2079847d675707f2a65a26c5324860f9a5cd2d03';

@ProviderFor(tokenizeCardUseCase)
final tokenizeCardUseCaseProvider = TokenizeCardUseCaseProvider._();

final class TokenizeCardUseCaseProvider
    extends
        $FunctionalProvider<
          TokenizeCardUseCase,
          TokenizeCardUseCase,
          TokenizeCardUseCase
        >
    with $Provider<TokenizeCardUseCase> {
  TokenizeCardUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenizeCardUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenizeCardUseCaseHash();

  @$internal
  @override
  $ProviderElement<TokenizeCardUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenizeCardUseCase create(Ref ref) {
    return tokenizeCardUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenizeCardUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenizeCardUseCase>(value),
    );
  }
}

String _$tokenizeCardUseCaseHash() =>
    r'7aa202ba9d9bc486dc74974111b39e5cfde916c1';

@ProviderFor(getRiderWalletBalanceUseCase)
final getRiderWalletBalanceUseCaseProvider =
    GetRiderWalletBalanceUseCaseProvider._();

final class GetRiderWalletBalanceUseCaseProvider
    extends
        $FunctionalProvider<
          GetRiderWalletBalanceUseCase,
          GetRiderWalletBalanceUseCase,
          GetRiderWalletBalanceUseCase
        >
    with $Provider<GetRiderWalletBalanceUseCase> {
  GetRiderWalletBalanceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRiderWalletBalanceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRiderWalletBalanceUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRiderWalletBalanceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRiderWalletBalanceUseCase create(Ref ref) {
    return getRiderWalletBalanceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRiderWalletBalanceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRiderWalletBalanceUseCase>(value),
    );
  }
}

String _$getRiderWalletBalanceUseCaseHash() =>
    r'4ff05da8dd13220d48acf003227379ef2afe210e';
