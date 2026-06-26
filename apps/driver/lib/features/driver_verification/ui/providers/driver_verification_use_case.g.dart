// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_verification_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getVerificationStatusUseCase)
final getVerificationStatusUseCaseProvider =
    GetVerificationStatusUseCaseProvider._();

final class GetVerificationStatusUseCaseProvider
    extends
        $FunctionalProvider<
          GetVerificationStatusUseCase,
          GetVerificationStatusUseCase,
          GetVerificationStatusUseCase
        >
    with $Provider<GetVerificationStatusUseCase> {
  GetVerificationStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getVerificationStatusUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getVerificationStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetVerificationStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetVerificationStatusUseCase create(Ref ref) {
    return getVerificationStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetVerificationStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetVerificationStatusUseCase>(value),
    );
  }
}

String _$getVerificationStatusUseCaseHash() =>
    r'1f7e3a78e0a8fcfb57913b90f1c946c88e78ed18';
