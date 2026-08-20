// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_radius_circles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchRadiusCircles)
final searchRadiusCirclesProvider = SearchRadiusCirclesProvider._();

final class SearchRadiusCirclesProvider
    extends $NotifierProvider<SearchRadiusCircles, Set<Circle>> {
  SearchRadiusCirclesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRadiusCirclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRadiusCirclesHash();

  @$internal
  @override
  SearchRadiusCircles create() => SearchRadiusCircles();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<Circle> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<Circle>>(value),
    );
  }
}

String _$searchRadiusCirclesHash() =>
    r'136efb887d47d9ee1c779f9b8e7950091bf069a5';

abstract class _$SearchRadiusCircles extends $Notifier<Set<Circle>> {
  Set<Circle> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<Circle>, Set<Circle>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<Circle>, Set<Circle>>,
              Set<Circle>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
