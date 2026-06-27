// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerifyStatus)
final verifyStatusProvider = VerifyStatusProvider._();

final class VerifyStatusProvider
    extends $AsyncNotifierProvider<VerifyStatus, VerificationStatus?> {
  VerifyStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyStatusHash();

  @$internal
  @override
  VerifyStatus create() => VerifyStatus();
}

String _$verifyStatusHash() => r'95c145a9f7bab32cfe48b35ab5b455d5037ab610';

abstract class _$VerifyStatus extends $AsyncNotifier<VerificationStatus?> {
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
