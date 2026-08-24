// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverCameraController)
final driverCameraControllerProvider = DriverCameraControllerProvider._();

final class DriverCameraControllerProvider
    extends $NotifierProvider<DriverCameraController, void> {
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
    r'919aa4be5b37e205bea6e3fd5418fd825928e44e';

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
