// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** resolves a coordinate into a human-readable
/// `street، locality` label, in Arabic where Google has it.
///
/// **Data flow:** `getPointLabelUseCaseProvider` → `geocodingRepo` →
/// `GeocodingApiService` → Google. Exposes `AsyncValue<String>` to address rows
/// and ride cards in both apps.
///
/// **Why a family (`Ref, GeoPoint`):** the label is a pure function of the
/// point, so the point *is* the cache key. Riverpod then keeps one provider
/// instance per distinct coordinate, which means dragging a pin back to a place
/// already visited resolves instantly from cache instead of re-billing a
/// request. This only works because [GeoPoint] has value equality — two
/// structurally equal points must hit the same cache entry.
///
/// **Why `FutureProvider` and not `AsyncNotifier`:** there is no action. The
/// only way to change a point's label is to look it up again, which
/// `ref.invalidate` already expresses; a notifier would add a mutation surface
/// with nothing to put in it.
///
/// **Why `keepAlive`:** without it, the provider disposes the moment a label
/// scrolls off screen and re-bills the identical request when it scrolls back.
/// Labels for a coordinate do not change, so caching them for the session is
/// both correct and the cheapest option.
///
/// **Why it throws instead of returning `ApiResults`:** the boundary between the
/// two contracts is here. `ApiResults` is how the data and domain layers speak;
/// `AsyncValue` is how the UI speaks. Unwrapping the failure into a throw lets
/// Riverpod represent it as `AsyncError` — which is also what makes
/// [_retryLabelLookup] fire, since Riverpod's retry hook only sees thrown
/// errors, not a `Failure` returned as a perfectly valid value.

@ProviderFor(pointLabel)
final pointLabelProvider = PointLabelFamily._();

/// **What it does:** resolves a coordinate into a human-readable
/// `street، locality` label, in Arabic where Google has it.
///
/// **Data flow:** `getPointLabelUseCaseProvider` → `geocodingRepo` →
/// `GeocodingApiService` → Google. Exposes `AsyncValue<String>` to address rows
/// and ride cards in both apps.
///
/// **Why a family (`Ref, GeoPoint`):** the label is a pure function of the
/// point, so the point *is* the cache key. Riverpod then keeps one provider
/// instance per distinct coordinate, which means dragging a pin back to a place
/// already visited resolves instantly from cache instead of re-billing a
/// request. This only works because [GeoPoint] has value equality — two
/// structurally equal points must hit the same cache entry.
///
/// **Why `FutureProvider` and not `AsyncNotifier`:** there is no action. The
/// only way to change a point's label is to look it up again, which
/// `ref.invalidate` already expresses; a notifier would add a mutation surface
/// with nothing to put in it.
///
/// **Why `keepAlive`:** without it, the provider disposes the moment a label
/// scrolls off screen and re-bills the identical request when it scrolls back.
/// Labels for a coordinate do not change, so caching them for the session is
/// both correct and the cheapest option.
///
/// **Why it throws instead of returning `ApiResults`:** the boundary between the
/// two contracts is here. `ApiResults` is how the data and domain layers speak;
/// `AsyncValue` is how the UI speaks. Unwrapping the failure into a throw lets
/// Riverpod represent it as `AsyncError` — which is also what makes
/// [_retryLabelLookup] fire, since Riverpod's retry hook only sees thrown
/// errors, not a `Failure` returned as a perfectly valid value.

final class PointLabelProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// **What it does:** resolves a coordinate into a human-readable
  /// `street، locality` label, in Arabic where Google has it.
  ///
  /// **Data flow:** `getPointLabelUseCaseProvider` → `geocodingRepo` →
  /// `GeocodingApiService` → Google. Exposes `AsyncValue<String>` to address rows
  /// and ride cards in both apps.
  ///
  /// **Why a family (`Ref, GeoPoint`):** the label is a pure function of the
  /// point, so the point *is* the cache key. Riverpod then keeps one provider
  /// instance per distinct coordinate, which means dragging a pin back to a place
  /// already visited resolves instantly from cache instead of re-billing a
  /// request. This only works because [GeoPoint] has value equality — two
  /// structurally equal points must hit the same cache entry.
  ///
  /// **Why `FutureProvider` and not `AsyncNotifier`:** there is no action. The
  /// only way to change a point's label is to look it up again, which
  /// `ref.invalidate` already expresses; a notifier would add a mutation surface
  /// with nothing to put in it.
  ///
  /// **Why `keepAlive`:** without it, the provider disposes the moment a label
  /// scrolls off screen and re-bills the identical request when it scrolls back.
  /// Labels for a coordinate do not change, so caching them for the session is
  /// both correct and the cheapest option.
  ///
  /// **Why it throws instead of returning `ApiResults`:** the boundary between the
  /// two contracts is here. `ApiResults` is how the data and domain layers speak;
  /// `AsyncValue` is how the UI speaks. Unwrapping the failure into a throw lets
  /// Riverpod represent it as `AsyncError` — which is also what makes
  /// [_retryLabelLookup] fire, since Riverpod's retry hook only sees thrown
  /// errors, not a `Failure` returned as a perfectly valid value.
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

String _$pointLabelHash() => r'aaf25c71129b1812eda9a58e3d616ff2b77e8ce4';

/// **What it does:** resolves a coordinate into a human-readable
/// `street، locality` label, in Arabic where Google has it.
///
/// **Data flow:** `getPointLabelUseCaseProvider` → `geocodingRepo` →
/// `GeocodingApiService` → Google. Exposes `AsyncValue<String>` to address rows
/// and ride cards in both apps.
///
/// **Why a family (`Ref, GeoPoint`):** the label is a pure function of the
/// point, so the point *is* the cache key. Riverpod then keeps one provider
/// instance per distinct coordinate, which means dragging a pin back to a place
/// already visited resolves instantly from cache instead of re-billing a
/// request. This only works because [GeoPoint] has value equality — two
/// structurally equal points must hit the same cache entry.
///
/// **Why `FutureProvider` and not `AsyncNotifier`:** there is no action. The
/// only way to change a point's label is to look it up again, which
/// `ref.invalidate` already expresses; a notifier would add a mutation surface
/// with nothing to put in it.
///
/// **Why `keepAlive`:** without it, the provider disposes the moment a label
/// scrolls off screen and re-bills the identical request when it scrolls back.
/// Labels for a coordinate do not change, so caching them for the session is
/// both correct and the cheapest option.
///
/// **Why it throws instead of returning `ApiResults`:** the boundary between the
/// two contracts is here. `ApiResults` is how the data and domain layers speak;
/// `AsyncValue` is how the UI speaks. Unwrapping the failure into a throw lets
/// Riverpod represent it as `AsyncError` — which is also what makes
/// [_retryLabelLookup] fire, since Riverpod's retry hook only sees thrown
/// errors, not a `Failure` returned as a perfectly valid value.

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

  /// **What it does:** resolves a coordinate into a human-readable
  /// `street، locality` label, in Arabic where Google has it.
  ///
  /// **Data flow:** `getPointLabelUseCaseProvider` → `geocodingRepo` →
  /// `GeocodingApiService` → Google. Exposes `AsyncValue<String>` to address rows
  /// and ride cards in both apps.
  ///
  /// **Why a family (`Ref, GeoPoint`):** the label is a pure function of the
  /// point, so the point *is* the cache key. Riverpod then keeps one provider
  /// instance per distinct coordinate, which means dragging a pin back to a place
  /// already visited resolves instantly from cache instead of re-billing a
  /// request. This only works because [GeoPoint] has value equality — two
  /// structurally equal points must hit the same cache entry.
  ///
  /// **Why `FutureProvider` and not `AsyncNotifier`:** there is no action. The
  /// only way to change a point's label is to look it up again, which
  /// `ref.invalidate` already expresses; a notifier would add a mutation surface
  /// with nothing to put in it.
  ///
  /// **Why `keepAlive`:** without it, the provider disposes the moment a label
  /// scrolls off screen and re-bills the identical request when it scrolls back.
  /// Labels for a coordinate do not change, so caching them for the session is
  /// both correct and the cheapest option.
  ///
  /// **Why it throws instead of returning `ApiResults`:** the boundary between the
  /// two contracts is here. `ApiResults` is how the data and domain layers speak;
  /// `AsyncValue` is how the UI speaks. Unwrapping the failure into a throw lets
  /// Riverpod represent it as `AsyncError` — which is also what makes
  /// [_retryLabelLookup] fire, since Riverpod's retry hook only sees thrown
  /// errors, not a `Failure` returned as a perfectly valid value.

  PointLabelProvider call(GeoPoint point) =>
      PointLabelProvider._(argument: point, from: this);

  @override
  String toString() => r'pointLabelProvider';
}
