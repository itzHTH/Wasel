// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the "My Location" interaction flow: verifies permissions, acquires a fix,
/// and animates the map camera.
//
//? - Uses [Notifier] (not AsyncNotifier) because the core outcome is a side effect
//?   (camera animation), not readable data./
//
//? - Implements a "Fast Path": silently checks if a live location stream is
//?   already open (e.g., in the driver app) and uses it to avoid a cold GPS
//?   startup, falling back to a fresh acquisition (e.g., rider app) if not.

@ProviderFor(RecenterController)
final recenterControllerProvider = RecenterControllerProvider._();

/// Manages the "My Location" interaction flow: verifies permissions, acquires a fix,
/// and animates the map camera.
//
//? - Uses [Notifier] (not AsyncNotifier) because the core outcome is a side effect
//?   (camera animation), not readable data./
//
//? - Implements a "Fast Path": silently checks if a live location stream is
//?   already open (e.g., in the driver app) and uses it to avoid a cold GPS
//?   startup, falling back to a fresh acquisition (e.g., rider app) if not.
final class RecenterControllerProvider
    extends $NotifierProvider<RecenterController, RecenterState> {
  /// Manages the "My Location" interaction flow: verifies permissions, acquires a fix,
  /// and animates the map camera.
  //
  //? - Uses [Notifier] (not AsyncNotifier) because the core outcome is a side effect
  //?   (camera animation), not readable data./
  //
  //? - Implements a "Fast Path": silently checks if a live location stream is
  //?   already open (e.g., in the driver app) and uses it to avoid a cold GPS
  //?   startup, falling back to a fresh acquisition (e.g., rider app) if not.
  RecenterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recenterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recenterControllerHash();

  @$internal
  @override
  RecenterController create() => RecenterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecenterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecenterState>(value),
    );
  }
}

String _$recenterControllerHash() =>
    r'5e299921d394633197e10ba9ef57dad14f5ef859';

/// Manages the "My Location" interaction flow: verifies permissions, acquires a fix,
/// and animates the map camera.
//
//? - Uses [Notifier] (not AsyncNotifier) because the core outcome is a side effect
//?   (camera animation), not readable data./
//
//? - Implements a "Fast Path": silently checks if a live location stream is
//?   already open (e.g., in the driver app) and uses it to avoid a cold GPS
//?   startup, falling back to a fresh acquisition (e.g., rider app) if not.

abstract class _$RecenterController extends $Notifier<RecenterState> {
  RecenterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecenterState, RecenterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecenterState, RecenterState>,
              RecenterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
