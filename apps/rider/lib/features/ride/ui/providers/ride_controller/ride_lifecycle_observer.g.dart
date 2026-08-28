// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_lifecycle_observer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Re-reads the ride whenever the app comes back from the background.
///
/// Auto-disposed on purpose: it lives exactly as long as the ride screen that
/// watches it. Kept alive it would outlive a sign-out and wake the controller
/// into an unauthenticated read on the next return to the foreground.

@ProviderFor(rideLifecycleObserver)
final rideLifecycleObserverProvider = RideLifecycleObserverProvider._();

/// Re-reads the ride whenever the app comes back from the background.
///
/// Auto-disposed on purpose: it lives exactly as long as the ride screen that
/// watches it. Kept alive it would outlive a sign-out and wake the controller
/// into an unauthenticated read on the next return to the foreground.

final class RideLifecycleObserverProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Re-reads the ride whenever the app comes back from the background.
  ///
  /// Auto-disposed on purpose: it lives exactly as long as the ride screen that
  /// watches it. Kept alive it would outlive a sign-out and wake the controller
  /// into an unauthenticated read on the next return to the foreground.
  RideLifecycleObserverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideLifecycleObserverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideLifecycleObserverHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return rideLifecycleObserver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$rideLifecycleObserverHash() =>
    r'b78af4c201a5ea56e30ff2b53032153e7296c0cd';
