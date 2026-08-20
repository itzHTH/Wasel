// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Register)
final registerProvider = RegisterProvider._();

final class RegisterProvider extends $AsyncNotifierProvider<Register, void> {
  RegisterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerHash();

  @$internal
  @override
  Register create() => Register();
}

String _$registerHash() => r'ff0deb5ace74cbd9cce9a33233080d3c9a1cd40f';

abstract class _$Register extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
