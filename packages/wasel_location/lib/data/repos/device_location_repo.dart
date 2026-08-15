import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:wasel_location/data/services/device_location_service.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/location_access.dart';
import 'package:wasel_location/domain/entities/location_exception.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';

/// Translates the platform's location API into domain terms.
class DeviceLocationRepo implements BaseDeviceLocationRepo {
  DeviceLocationRepo(this._service);

  final DeviceLocationService _service;

  @override
  Stream<DeviceFix> watchLocation() {
    return _service
        .positionStream()
        .map(_toFix)
        .handleError(
          (Object error, StackTrace stackTrace) => Error.throwWithStackTrace(
            _toLocationException(error),
            stackTrace,
          ),
        );
  }

  @override
  Future<DeviceFix> getCurrentLocation({Duration? timeout}) async {
    if (!await _service.isLocationServiceEnabled()) {
      throw const LocationException(
        LocationFailureReason.serviceDisabled,
      ); // to user know form settings not Internet.
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
      // Intentionally swallowed. Whether the cache is empty, permission is denied,
      // or the channel hung, we treat it simply as "no cached location available"
      // so callers can smoothly fallback to a default map target without try-catch boilerplate.
      return null;
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() =>
      _service.isLocationServiceEnabled();

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

    return _toAccess(permission);
  }

  LocationAccess _toAccess(
    LocationPermission permission,
  ) => switch (permission) {
    // `whileInUse` and `always` both permit a foreground read, so both granted
    LocationPermission.whileInUse ||
    LocationPermission.always => LocationAccess.granted,
    LocationPermission.denied => LocationAccess.denied,
    LocationPermission.deniedForever ||
    LocationPermission.unableToDetermine => LocationAccess.permanentlyDenied,
  };

  DeviceFix _toFix(Position position) => DeviceFix(
    point: GeoPoint(latitude: position.latitude, longitude: position.longitude),
    heading: position.heading,
    speed: position.speed,
    accuracy: position.accuracy,
    timestamp: position.timestamp,
  );

  LocationException _accessException(LocationAccess access) =>
      LocationException(
        access.needsSettings
            ? LocationFailureReason.permissionPermanentlyDenied
            : LocationFailureReason.permissionDenied,
      );

  LocationException _toLocationException(Object error) => switch (error) {
    LocationException() => error,
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
