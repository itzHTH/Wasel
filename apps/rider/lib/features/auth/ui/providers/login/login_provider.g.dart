// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Login)
final loginProvider = LoginProvider._();

final class LoginProvider extends $AsyncNotifierProvider<Login, entity.Login?> {
  LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  Login create() => Login();
}

String _$loginHash() => r'acc335fe15dd59a9a0731c88d3297521846393d6';

abstract class _$Login extends $AsyncNotifier<entity.Login?> {
  FutureOr<entity.Login?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<entity.Login?>, entity.Login?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<entity.Login?>, entity.Login?>,
              AsyncValue<entity.Login?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
