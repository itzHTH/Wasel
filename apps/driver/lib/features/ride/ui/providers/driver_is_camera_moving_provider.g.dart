// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_is_camera_moving_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Driver-side mirror of the rider's `IsCameraMoving`.
///
/// Fed from [AppMap]'s `onCameraMoveStarted` / `onCameraIdle` on the ride
/// screen so expandable cards can collapse while the driver pans the map.

@ProviderFor(DriverIsCameraMoving)
final driverIsCameraMovingProvider = DriverIsCameraMovingProvider._();

/// Driver-side mirror of the rider's `IsCameraMoving`.
///
/// Fed from [AppMap]'s `onCameraMoveStarted` / `onCameraIdle` on the ride
/// screen so expandable cards can collapse while the driver pans the map.
final class DriverIsCameraMovingProvider
    extends $NotifierProvider<DriverIsCameraMoving, bool> {
  /// Driver-side mirror of the rider's `IsCameraMoving`.
  ///
  /// Fed from [AppMap]'s `onCameraMoveStarted` / `onCameraIdle` on the ride
  /// screen so expandable cards can collapse while the driver pans the map.
  DriverIsCameraMovingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverIsCameraMovingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverIsCameraMovingHash();

  @$internal
  @override
  DriverIsCameraMoving create() => DriverIsCameraMoving();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$driverIsCameraMovingHash() =>
    r'de6cef80bf76503a85de69bf26ac85497151889f';

/// Driver-side mirror of the rider's `IsCameraMoving`.
///
/// Fed from [AppMap]'s `onCameraMoveStarted` / `onCameraIdle` on the ride
/// screen so expandable cards can collapse while the driver pans the map.

abstract class _$DriverIsCameraMoving extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
