// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_use_case_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geocodingRepo)
final geocodingRepoProvider = GeocodingRepoProvider._();

final class GeocodingRepoProvider
    extends
        $FunctionalProvider<
          BaseGeocodingRepo,
          BaseGeocodingRepo,
          BaseGeocodingRepo
        >
    with $Provider<BaseGeocodingRepo> {
  GeocodingRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geocodingRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geocodingRepoHash();

  @$internal
  @override
  $ProviderElement<BaseGeocodingRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseGeocodingRepo create(Ref ref) {
    return geocodingRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseGeocodingRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseGeocodingRepo>(value),
    );
  }
}

String _$geocodingRepoHash() => r'2686cf1af06f443d3afa07c23f4c282f0983dddf';

@ProviderFor(getPointLabelUseCase)
final getPointLabelUseCaseProvider = GetPointLabelUseCaseProvider._();

final class GetPointLabelUseCaseProvider
    extends
        $FunctionalProvider<
          GetPointLabelUseCase,
          GetPointLabelUseCase,
          GetPointLabelUseCase
        >
    with $Provider<GetPointLabelUseCase> {
  GetPointLabelUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPointLabelUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPointLabelUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPointLabelUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPointLabelUseCase create(Ref ref) {
    return getPointLabelUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPointLabelUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPointLabelUseCase>(value),
    );
  }
}

String _$getPointLabelUseCaseHash() =>
    r'7bf576e2054df42765b50b19916bfb55af851708';

@ProviderFor(getRidePriceUseCase)
final getRidePriceUseCaseProvider = GetRidePriceUseCaseProvider._();

final class GetRidePriceUseCaseProvider
    extends
        $FunctionalProvider<
          GetRidePriceUseCase,
          GetRidePriceUseCase,
          GetRidePriceUseCase
        >
    with $Provider<GetRidePriceUseCase> {
  GetRidePriceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRidePriceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRidePriceUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRidePriceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRidePriceUseCase create(Ref ref) {
    return getRidePriceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRidePriceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRidePriceUseCase>(value),
    );
  }
}

String _$getRidePriceUseCaseHash() =>
    r'bce8894022ef0a1e5e8614620881575f3914ef5a';
