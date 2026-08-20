// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RidePriceEstimate)
final ridePriceEstimateProvider = RidePriceEstimateProvider._();

final class RidePriceEstimateProvider
    extends $AsyncNotifierProvider<RidePriceEstimate, RidePrice?> {
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

String _$ridePriceEstimateHash() => r'2358a2031a03f267fc6891e65316b27d39183613';

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
