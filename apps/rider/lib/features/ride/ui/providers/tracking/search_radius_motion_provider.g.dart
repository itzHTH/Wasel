// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_radius_motion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchRadiusMotion)
final searchRadiusMotionProvider = SearchRadiusMotionProvider._();

final class SearchRadiusMotionProvider
    extends
        $FunctionalProvider<
          SearchRadiusMotion,
          SearchRadiusMotion,
          SearchRadiusMotion
        >
    with $Provider<SearchRadiusMotion> {
  SearchRadiusMotionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRadiusMotionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRadiusMotionHash();

  @$internal
  @override
  $ProviderElement<SearchRadiusMotion> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchRadiusMotion create(Ref ref) {
    return searchRadiusMotion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRadiusMotion value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRadiusMotion>(value),
    );
  }
}

String _$searchRadiusMotionHash() =>
    r'8fb79bff05f1cf7f8c4e960078b2b123e6b2ca32';
