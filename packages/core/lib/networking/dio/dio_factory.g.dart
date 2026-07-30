// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dioFactory)
final dioFactoryProvider = DioFactoryProvider._();

final class DioFactoryProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioFactoryHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dioFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioFactoryHash() => r'd31accf6b8a7dac0f0406e050dadb67b89f05e0e';
