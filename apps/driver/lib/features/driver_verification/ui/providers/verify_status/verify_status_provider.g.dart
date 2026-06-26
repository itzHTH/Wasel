// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyStatusProvider)
final verifyStatusProviderProvider = VerifyStatusProviderProvider._();

final class VerifyStatusProviderProvider
    extends $AsyncNotifierProvider<VerifyStatusProvider, VerificationStatus?> {
  VerifyStatusProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyStatusProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyStatusProviderHash();

  @$internal
  @override
  VerifyStatusProvider create() => VerifyStatusProvider();
}

String _$verifyStatusProviderHash() =>
    r'1d5d845454f8f7f50c5523232e9a62bcce103441';

abstract class _$VerifyStatusProvider
    extends $AsyncNotifier<VerificationStatus?> {
  FutureOr<VerificationStatus?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<VerificationStatus?>, VerificationStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VerificationStatus?>, VerificationStatus?>,
              AsyncValue<VerificationStatus?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
