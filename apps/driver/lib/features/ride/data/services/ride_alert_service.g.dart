// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_alert_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideAlertService)
final rideAlertServiceProvider = RideAlertServiceProvider._();

final class RideAlertServiceProvider
    extends
        $FunctionalProvider<
          IRideAlertService,
          IRideAlertService,
          IRideAlertService
        >
    with $Provider<IRideAlertService> {
  RideAlertServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideAlertServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideAlertServiceHash();

  @$internal
  @override
  $ProviderElement<IRideAlertService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IRideAlertService create(Ref ref) {
    return rideAlertService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IRideAlertService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IRideAlertService>(value),
    );
  }
}

String _$rideAlertServiceHash() => r'8366d0876fc6f6693fe045da3f05afb764cd854c';
