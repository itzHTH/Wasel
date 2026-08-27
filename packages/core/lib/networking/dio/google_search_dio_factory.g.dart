// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_search_dio_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(placesDio)
final placesDioProvider = PlacesDioProvider._();

final class PlacesDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  PlacesDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placesDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placesDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return placesDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$placesDioHash() => r'ae1d26607bf403d89ddf6037e81a00859ff55dba';

@ProviderFor(geocodingDio)
final geocodingDioProvider = GeocodingDioProvider._();

final class GeocodingDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  GeocodingDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geocodingDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geocodingDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return geocodingDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$geocodingDioHash() => r'd5e73e3070e75f1717ca99cbe1df469ceb120bd0';
