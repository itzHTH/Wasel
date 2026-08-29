// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_offer_alert.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideOfferAlert)
final rideOfferAlertProvider = RideOfferAlertProvider._();

final class RideOfferAlertProvider
    extends $NotifierProvider<RideOfferAlert, void> {
  RideOfferAlertProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideOfferAlertProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideOfferAlertHash();

  @$internal
  @override
  RideOfferAlert create() => RideOfferAlert();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$rideOfferAlertHash() => r'8d838c89555882d4f6c4ab9503fba344a8ef0048';

abstract class _$RideOfferAlert extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
