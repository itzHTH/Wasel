// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_heading_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The bearing the car marker is drawn at.
///
/// Stays driver-side: the rider's driver marker is fed by the SignalR hub, not
/// the device stream.

@ProviderFor(DriverHeading)
final driverHeadingProvider = DriverHeadingProvider._();

/// The bearing the car marker is drawn at.
///
/// Stays driver-side: the rider's driver marker is fed by the SignalR hub, not
/// the device stream.
final class DriverHeadingProvider
    extends $NotifierProvider<DriverHeading, double> {
  /// The bearing the car marker is drawn at.
  ///
  /// Stays driver-side: the rider's driver marker is fed by the SignalR hub, not
  /// the device stream.
  DriverHeadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverHeadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverHeadingHash();

  @$internal
  @override
  DriverHeading create() => DriverHeading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$driverHeadingHash() => r'1dda6f089fbc0477e45dee36199876c5a2914c3b';

/// The bearing the car marker is drawn at.
///
/// Stays driver-side: the rider's driver marker is fed by the SignalR hub, not
/// the device stream.

abstract class _$DriverHeading extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
