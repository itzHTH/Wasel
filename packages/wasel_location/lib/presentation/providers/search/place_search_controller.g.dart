// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A provider so tests override it to zero instead of waiting on the clock.

@ProviderFor(placeSearchDebounce)
final placeSearchDebounceProvider = PlaceSearchDebounceProvider._();

/// A provider so tests override it to zero instead of waiting on the clock.

final class PlaceSearchDebounceProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  /// A provider so tests override it to zero instead of waiting on the clock.
  PlaceSearchDebounceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeSearchDebounceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeSearchDebounceHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return placeSearchDebounce(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$placeSearchDebounceHash() =>
    r'2f03b6fec74990c69d3dd599104f22ccdeaec6e4';

/// Debounced place search for a single [SearchFieldType].
///
/// Keyed by field so the pickup and drop-off searches never share state.
///
//! Consumers must `ref.watch` this while the field is on screen. Reaching it
//! only through `ref.read` lets the auto-disposed element die between
//! keystrokes, rebuilding the debouncer, so every character fires a request.

@ProviderFor(PlaceSearchController)
final placeSearchControllerProvider = PlaceSearchControllerFamily._();

/// Debounced place search for a single [SearchFieldType].
///
/// Keyed by field so the pickup and drop-off searches never share state.
///
//! Consumers must `ref.watch` this while the field is on screen. Reaching it
//! only through `ref.read` lets the auto-disposed element die between
//! keystrokes, rebuilding the debouncer, so every character fires a request.
final class PlaceSearchControllerProvider
    extends $NotifierProvider<PlaceSearchController, PlaceSearchState> {
  /// Debounced place search for a single [SearchFieldType].
  ///
  /// Keyed by field so the pickup and drop-off searches never share state.
  ///
  //! Consumers must `ref.watch` this while the field is on screen. Reaching it
  //! only through `ref.read` lets the auto-disposed element die between
  //! keystrokes, rebuilding the debouncer, so every character fires a request.
  PlaceSearchControllerProvider._({
    required PlaceSearchControllerFamily super.from,
    required SearchFieldType super.argument,
  }) : super(
         retry: null,
         name: r'placeSearchControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeSearchControllerHash();

  @override
  String toString() {
    return r'placeSearchControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PlaceSearchController create() => PlaceSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceSearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceSearchState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceSearchControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeSearchControllerHash() =>
    r'0a381b00a27e91a4deac2e51cbbbc5492c2deda5';

/// Debounced place search for a single [SearchFieldType].
///
/// Keyed by field so the pickup and drop-off searches never share state.
///
//! Consumers must `ref.watch` this while the field is on screen. Reaching it
//! only through `ref.read` lets the auto-disposed element die between
//! keystrokes, rebuilding the debouncer, so every character fires a request.

final class PlaceSearchControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PlaceSearchController,
          PlaceSearchState,
          PlaceSearchState,
          PlaceSearchState,
          SearchFieldType
        > {
  PlaceSearchControllerFamily._()
    : super(
        retry: null,
        name: r'placeSearchControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Debounced place search for a single [SearchFieldType].
  ///
  /// Keyed by field so the pickup and drop-off searches never share state.
  ///
  //! Consumers must `ref.watch` this while the field is on screen. Reaching it
  //! only through `ref.read` lets the auto-disposed element die between
  //! keystrokes, rebuilding the debouncer, so every character fires a request.

  PlaceSearchControllerProvider call(SearchFieldType field) =>
      PlaceSearchControllerProvider._(argument: field, from: this);

  @override
  String toString() => r'placeSearchControllerProvider';
}

/// Debounced place search for a single [SearchFieldType].
///
/// Keyed by field so the pickup and drop-off searches never share state.
///
//! Consumers must `ref.watch` this while the field is on screen. Reaching it
//! only through `ref.read` lets the auto-disposed element die between
//! keystrokes, rebuilding the debouncer, so every character fires a request.

abstract class _$PlaceSearchController extends $Notifier<PlaceSearchState> {
  late final _$args = ref.$arg as SearchFieldType;
  SearchFieldType get field => _$args;

  PlaceSearchState build(SearchFieldType field);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlaceSearchState, PlaceSearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaceSearchState, PlaceSearchState>,
              PlaceSearchState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
