import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:wasel_location/data/services/device_location_service.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/location_access.dart';
import 'package:wasel_location/domain/entities/location_exception.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

/// Translates the platform's location API into domain terms.
///
/// Three translations happen here, and they are the whole job:
/// `Position` → [DeviceFix], geolocator's `LocationPermission` →
/// [LocationAccess], and assorted platform errors → [LocationException]. All of
/// it runs against an injected [DeviceLocationService], so every branch below is
/// reachable from a test without a device.
class DeviceLocationRepo implements BaseDeviceLocationRepo {
  DeviceLocationRepo(this._service);

  final DeviceLocationService _service;

  @override
  Stream<DeviceFix> watchLocation() {
    // Errors are mapped in-band rather than allowed through raw, so a listener
    // handling `AsyncError` sees the same LocationException type it would get
    // from the one-shot path instead of a bare PlatformException.
    return _service
        .positionStream()
        .map(_toFix)
        .handleError(
          (Object error, StackTrace stackTrace) =>
              Error.throwWithStackTrace(_toLocationException(error), stackTrace),
        );
  }

  @override
  Future<DeviceFix> getCurrentLocation({Duration? timeout}) async {
    // Checked before asking for a fix rather than after failing to get one: with
    // services off the platform error is generic, and the user would be told to
    // retry when the only thing that helps is the settings screen.
    if (!await _service.isLocationServiceEnabled()) {
      throw const LocationException(LocationFailureReason.serviceDisabled);
    }

    final access = await checkAccess();
    if (!access.isGranted) throw _accessException(access);

    try {
      return _toFix(await _service.currentPosition(timeout: timeout));
    } catch (e) {
      throw _toLocationException(e);
    }
  }

  @override
  Future<DeviceFix?> getLastKnownLocation() async {
    try {
      final position = await _service.lastKnownPosition().timeout(
        DeviceLocationService.lastKnownTimeout,
      );

      return position == null ? null : _toFix(position);
    } catch (_) {
      // Deliberately swallowed. Every caller of this treats it as "is there a
      // cheap fix lying around?", and an empty cache, a refused permission and a
      // hung channel are all answered the same way: no, carry on with a default.
      // Surfacing an error here would force each caller to write that fallback
      // itself.
      return null;
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() => _service.isLocationServiceEnabled();

  @override
  Future<void> openLocationSettings() => _service.openLocationSettings();

  @override
  Future<LocationAccess> checkAccess() async =>
      _toAccess(await _service.checkPermission());

  @override
  Future<LocationAccess> requestAccess() async {
    var permission = await _service.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _service.requestPermission();
    }

    // Branching on the *result* of the request rather than the status that
    // preceded it: answering "Don't allow" on a fresh prompt can resolve
    // straight to `deniedForever`, and treating that as an ordinary denial
    // would send the UI back to a prompt the OS will never show again.
    return _toAccess(permission);
  }

  DeviceFix _toFix(Position position) => DeviceFix(
    point: GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    ),
    heading: position.heading,
    speed: position.speed,
    accuracy: position.accuracy,
    timestamp: position.timestamp,
  );

  LocationAccess _toAccess(LocationPermission permission) =>
      switch (permission) {
        // `whileInUse` and `always` both permit a foreground read, which is the
        // only distinction any caller in either app cares about.
        LocationPermission.whileInUse ||
        LocationPermission.always => LocationAccess.granted,
        LocationPermission.denied => LocationAccess.denied,
        // `unableToDetermine` is grouped with the permanent cases on purpose: it
        // means the platform will not tell us, so optimistically prompting would
        // loop. Sending the user to settings is the only action that can resolve it.
        LocationPermission.deniedForever ||
        LocationPermission.unableToDetermine =>
          LocationAccess.permanentlyDenied,
      };

  LocationException _accessException(LocationAccess access) =>
      LocationException(
        access.needsSettings
            ? LocationFailureReason.permissionPermanentlyDenied
            : LocationFailureReason.permissionDenied,
      );

  LocationException _toLocationException(Object error) => switch (error) {
    LocationException() => error,
    // geolocator raises this for `LocationSettings.timeLimit`, and
    // `Future.timeout` raises the same type — a cold fix that never settled.
    TimeoutException() => LocationException(
      LocationFailureReason.fixTimeout,
      error,
    ),
    LocationServiceDisabledException() => LocationException(
      LocationFailureReason.serviceDisabled,
      error,
    ),
    PermissionDeniedException() => LocationException(
      LocationFailureReason.permissionDenied,
      error,
    ),
    PermissionDefinitionsNotFoundException() => LocationException(
      LocationFailureReason.permissionPermanentlyDenied,
      error,
    ),
    _ => LocationException(LocationFailureReason.unavailable, error),
  };
}
