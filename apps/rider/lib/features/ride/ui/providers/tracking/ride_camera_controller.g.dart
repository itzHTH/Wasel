// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Frames the camera on (captain + pickup) once per ride, the first time the
/// captain's location arrives. Side-effect only — the `void` state means
/// watching this never rebuilds its consumers.
///
/// The trigger is the first non-null `driverPosition`, not the transition to
/// [RideStage.accepted]: at acceptance the captain's location hasn't been
/// broadcast yet, so framing there would have nothing to frame on.

@ProviderFor(RideCameraController)
final rideCameraControllerProvider = RideCameraControllerProvider._();

/// Frames the camera on (captain + pickup) once per ride, the first time the
/// captain's location arrives. Side-effect only — the `void` state means
/// watching this never rebuilds its consumers.
///
/// The trigger is the first non-null `driverPosition`, not the transition to
/// [RideStage.accepted]: at acceptance the captain's location hasn't been
/// broadcast yet, so framing there would have nothing to frame on.
final class RideCameraControllerProvider
    extends $NotifierProvider<RideCameraController, void> {
  /// Frames the camera on (captain + pickup) once per ride, the first time the
  /// captain's location arrives. Side-effect only — the `void` state means
  /// watching this never rebuilds its consumers.
  ///
  /// The trigger is the first non-null `driverPosition`, not the transition to
  /// [RideStage.accepted]: at acceptance the captain's location hasn't been
  /// broadcast yet, so framing there would have nothing to frame on.
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
    r'ced5f89a2411678190084c71c82769a99471daac';

/// Frames the camera on (captain + pickup) once per ride, the first time the
/// captain's location arrives. Side-effect only — the `void` state means
/// watching this never rebuilds its consumers.
///
/// The trigger is the first non-null `driverPosition`, not the transition to
/// [RideStage.accepted]: at acceptance the captain's location hasn't been
/// broadcast yet, so framing there would have nothing to frame on.

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
