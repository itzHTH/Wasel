// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Resolves a GeoPoint into a localized 'street, locality' label.
///
//? - Uses GeoPoint as the cache key: structurally identical points resolve
//?   instantly from memory instead of triggering duplicate Google API billing.
//
//? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
//?  do not repeatedly fetch the same label when remounted.
//
//? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
//?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.

@ProviderFor(pointLabel)
final pointLabelProvider = PointLabelFamily._();

/// Resolves a GeoPoint into a localized 'street, locality' label.
///
//? - Uses GeoPoint as the cache key: structurally identical points resolve
//?   instantly from memory instead of triggering duplicate Google API billing.
//
//? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
//?  do not repeatedly fetch the same label when remounted.
//
//? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
//?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.

final class PointLabelProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Resolves a GeoPoint into a localized 'street, locality' label.
  ///
  //? - Uses GeoPoint as the cache key: structurally identical points resolve
  //?   instantly from memory instead of triggering duplicate Google API billing.
  //
  //? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
  //?  do not repeatedly fetch the same label when remounted.
  //
  //? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
  //?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.
  PointLabelProvider._({
    required PointLabelFamily super.from,
    required GeoPoint super.argument,
  }) : super(
         retry: _retryLabelLookup,
         name: r'pointLabelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pointLabelHash();

  @override
  String toString() {
    return r'pointLabelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as GeoPoint;
    return pointLabel(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PointLabelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pointLabelHash() => r'09c3c2d5649f0a8c222591fc692875c9efa31c12';

/// Resolves a GeoPoint into a localized 'street, locality' label.
///
//? - Uses GeoPoint as the cache key: structurally identical points resolve
//?   instantly from memory instead of triggering duplicate Google API billing.
//
//? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
//?  do not repeatedly fetch the same label when remounted.
//
//? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
//?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.

final class PointLabelFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, GeoPoint> {
  PointLabelFamily._()
    : super(
        retry: _retryLabelLookup,
        name: r'pointLabelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Resolves a GeoPoint into a localized 'street, locality' label.
  ///
  //? - Uses GeoPoint as the cache key: structurally identical points resolve
  //?   instantly from memory instead of triggering duplicate Google API billing.
  //
  //? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
  //?  do not repeatedly fetch the same label when remounted.
  //
  //? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
  //?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.

  PointLabelProvider call(GeoPoint point) =>
      PointLabelProvider._(argument: point, from: this);

  @override
  String toString() => r'pointLabelProvider';
}
