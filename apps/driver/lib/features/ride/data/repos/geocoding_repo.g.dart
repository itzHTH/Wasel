// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_repo.dart';

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

String _$geocodingRepoHash() => r'9a9540fd3cec9b44d418adf1e798ce1194eb6096';
