// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_dio_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(googleDioFactory)
final googleDioFactoryProvider = GoogleDioFactoryProvider._();

final class GoogleDioFactoryProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  GoogleDioFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleDioFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleDioFactoryHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return googleDioFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$googleDioFactoryHash() => r'90c16a3762c6c29ef1b0fdac3f76e5d611909270';
