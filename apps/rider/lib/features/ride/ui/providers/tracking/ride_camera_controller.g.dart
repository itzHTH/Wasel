// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideCameraController)
final rideCameraControllerProvider = RideCameraControllerProvider._();

final class RideCameraControllerProvider
    extends $NotifierProvider<RideCameraController, void> {
  RideCameraControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideCameraControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideCameraControllerHash();

  @$internal
  @override
  RideCameraController create() => RideCameraController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$rideCameraControllerHash() =>
    r'19f9e06fc7342cbf94fd3118d720ccbbcf8f15dc';

abstract class _$RideCameraController extends $Notifier<void> {
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
