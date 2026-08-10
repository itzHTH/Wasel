// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sole owner of the driver map's camera.
///
/// Two behaviours compete for it and must never run at once: the follow-camera
/// that trails the car, and the wide frame that shows a whole offered trip.
/// Keeping both here is what stops them from fighting over the same map.

@ProviderFor(DriverCameraController)
final driverCameraControllerProvider = DriverCameraControllerProvider._();

/// Sole owner of the driver map's camera.
///
/// Two behaviours compete for it and must never run at once: the follow-camera
/// that trails the car, and the wide frame that shows a whole offered trip.
/// Keeping both here is what stops them from fighting over the same map.
final class DriverCameraControllerProvider
    extends $NotifierProvider<DriverCameraController, void> {
  /// Sole owner of the driver map's camera.
  ///
  /// Two behaviours compete for it and must never run at once: the follow-camera
  /// that trails the car, and the wide frame that shows a whole offered trip.
  /// Keeping both here is what stops them from fighting over the same map.
  DriverCameraControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverCameraControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverCameraControllerHash();

  @$internal
  @override
  DriverCameraController create() => DriverCameraController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$driverCameraControllerHash() =>
    r'736789aa264e5d2e09684e39e3cb7cea7ca054cd';

/// Sole owner of the driver map's camera.
///
/// Two behaviours compete for it and must never run at once: the follow-camera
/// that trails the car, and the wide frame that shows a whole offered trip.
/// Keeping both here is what stops them from fighting over the same map.

abstract class _$DriverCameraController extends $Notifier<void> {
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
