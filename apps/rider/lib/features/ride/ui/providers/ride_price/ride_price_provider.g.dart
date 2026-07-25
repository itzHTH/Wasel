// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kept alive so the quoted fare survives the price card being replaced by the
/// tracking cards — those show the fare too, as does the completed screen.
/// [RideTrackingCards] invalidates it when a ride ends.

@ProviderFor(RidePriceEstimate)
final ridePriceEstimateProvider = RidePriceEstimateProvider._();

/// Kept alive so the quoted fare survives the price card being replaced by the
/// tracking cards — those show the fare too, as does the completed screen.
/// [RideTrackingCards] invalidates it when a ride ends.
final class RidePriceEstimateProvider
    extends $AsyncNotifierProvider<RidePriceEstimate, RidePrice?> {
  /// Kept alive so the quoted fare survives the price card being replaced by the
  /// tracking cards — those show the fare too, as does the completed screen.
  /// [RideTrackingCards] invalidates it when a ride ends.
  RidePriceEstimateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ridePriceEstimateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ridePriceEstimateHash();

  @$internal
  @override
  RidePriceEstimate create() => RidePriceEstimate();
}

String _$ridePriceEstimateHash() => r'96a7f273c959a93dad90569c535a8d247335fac3';

/// Kept alive so the quoted fare survives the price card being replaced by the
/// tracking cards — those show the fare too, as does the completed screen.
/// [RideTrackingCards] invalidates it when a ride ends.

abstract class _$RidePriceEstimate extends $AsyncNotifier<RidePrice?> {
  FutureOr<RidePrice?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RidePrice?>, RidePrice?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RidePrice?>, RidePrice?>,
              AsyncValue<RidePrice?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
