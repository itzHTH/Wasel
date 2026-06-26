// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verifyRepo)
final verifyRepoProvider = VerifyRepoProvider._();

final class VerifyRepoProvider
    extends $FunctionalProvider<VerifyRepo, VerifyRepo, VerifyRepo>
    with $Provider<VerifyRepo> {
  VerifyRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyRepoHash();

  @$internal
  @override
  $ProviderElement<VerifyRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyRepo create(Ref ref) {
    return verifyRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyRepo>(value),
    );
  }
}

String _$verifyRepoHash() => r'4a88ed1449669fadb94af096c4a103d306f04bc4';
