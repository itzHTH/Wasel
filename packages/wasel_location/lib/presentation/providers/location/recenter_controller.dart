import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/core/extensions/geo_point_map_x.dart';
import 'package:wasel_location/domain/entities/location_exception.dart';
import 'package:wasel_location/presentation/providers/location/device_location_provider.dart';
import 'package:wasel_location/presentation/providers/location/location_access_provider.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';
import 'package:wasel_location/presentation/providers/map/map_controller_provider.dart';

part 'recenter_controller.g.dart';

/// Represents the UI state for the "center on user" action.
class RecenterState {
  /// Whether an acquisition is currently in-flight (used for showing a spinner).
  final bool isLocating;

  /// Toggled on only after permission is verified, preventing Google Maps from
  /// launching its own native, unlocalized permission prompt.
  final bool myLocationEnabled;

  /// The reason for a failure, exposed so the UI can show a localized SnackBar.
  final LocationFailureReason? failure;

  const RecenterState({
    this.isLocating = false,
    this.myLocationEnabled = false,
    this.failure,
  });

  RecenterState copyWith({
    bool? isLocating,
    bool? myLocationEnabled,
    LocationFailureReason? failure,
    bool clearFailure = false,
  }) => RecenterState(
    isLocating: isLocating ?? this.isLocating,
    myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
    failure: clearFailure ? null : (failure ?? this.failure),
  );
}

/// Manages the "My Location" interaction flow: verifies permissions, acquires a fix,
/// and animates the map camera.
//
//? - Uses [Notifier] (not AsyncNotifier) because the core outcome is a side effect
//?   (camera animation), not readable data./
//
//? - Implements a "Fast Path": silently checks if a live location stream is
//?   already open (e.g., in the driver app) and uses it to avoid a cold GPS
//?   startup, falling back to a fresh acquisition (e.g., rider app) if not.
@riverpod
class RecenterController extends _$RecenterController {
  @override
  RecenterState build() => const RecenterState();

  /// Centres the map on the user at zoom.
  //
  // Takes a BuildContext //! only to reach the permission dialog;
  //  nothing is rendered from here
  Future<void> centerOnUser(BuildContext context, {double zoom = 16}) async {
    if (state.isLocating) return;

    final access = await ref
        .read(locationAccessControllerProvider.notifier)
        .request(context);

    if (!ref.mounted) return;

    if (!access.isGranted) {
      // A permanently denied permission has already shown the settings dialog
      // inside the gate, so reporting it again would stack a second message on
      // top of one the user is still reading.
      state = state.copyWith(
        failure: access.needsSettings
            ? null
            : LocationFailureReason.permissionDenied,
      );
      return;
    }

    state = state.copyWith(
      myLocationEnabled: true,
      isLocating: true,
      clearFailure: true,
    );

    try {
      await _moveCameraTo(await _resolveTarget(), zoom);
    } on LocationException catch (e) {
      if (ref.mounted) state = state.copyWith(failure: e.reason);
    } catch (_) {
      if (ref.mounted) {
        state = state.copyWith(failure: LocationFailureReason.unavailable);
      }
    } finally {
      if (ref.mounted) state = state.copyWith(isLocating: false);
    }
  }

  /// Deep-links to the OS location settings, for the `serviceDisabled` case
  /// where no in-app prompt can help.
  Future<void> openLocationSettings() =>
      ref.read(deviceLocationRepoProvider).openLocationSettings();

  /// Clears a reported failure once the UI has shown it, //* so the same message is
  //* not re-shown on the next unrelated rebuild.
  void acknowledgeFailure() {
    if (state.failure != null) state = state.copyWith(clearFailure: true);
  }

  /// Prefers a fix that is already streaming, falling back to a cold acquisition.
  //
  //! `exists` before `read`: [deviceLocationProvider] is auto-dispose, so
  //! reading it blind would *create* it — opening an OS position stream, handing
  //! back `AsyncLoading` in the same breath, and closing it again moments later.
  //? In the driver that read is free (the broadcaster already holds the stream
  //? open); in the rider nothing listens, so every tap paid for a stream whose
  //? value was always null.
  Future<LatLng> _resolveTarget() async {
    if (ref.exists(deviceLocationProvider)) {
      final streamed = ref.read(deviceLocationProvider).value;
      if (streamed != null) return streamed.toLatLng();
    }

    final fix = await ref.read(getCurrentLocationUseCaseProvider).call(null);
    return fix.toLatLng();
  }

  Future<void> _moveCameraTo(LatLng target, double zoom) async {
    final controller = await ref.read(mapControllerHolderProvider.future);

    if (!ref.mounted) return;

    await controller.animateCamera(CameraUpdate.newLatLngZoom(target, zoom));
  }
}
