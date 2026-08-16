import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/permissions/permission_gate.dart' as permission_gate;
import 'package:wasel_location/domain/entities/location_access.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';

part 'location_access_provider.g.dart';

const String _deniedTitle = 'إذن الموقع مطلوب';
const String _deniedMessage = 'يرجى تمكين إذن الموقع للوصول إلى هذه الميزة.';

/// Manages the global location permission state and handles prompting.
//
//? - Uses [AsyncNotifier] to provide a loading state during the initial read,
//?   while allowing state mutations via the [request] action.
//
//? - Kept alive (`keepAlive: true`) because permission is a device-wide truth,
//?   preventing unnecessary loading flickers during screen navigation.
//
//? - Delegates the actual UI prompting to the core `permission_gate` while
//?   relying on `DeviceLocationRepo` for the authoritative state read.

@Riverpod(keepAlive: true)
class LocationAccessController extends _$LocationAccessController {
  @override
  Future<LocationAccess> build() => _read();

  /// Prompts for permission using the core gate, then updates the state.
  Future<LocationAccess> request(BuildContext context) async {
    final granted = await permission_gate.ensurePermission(
      context,
      Permission.location,
      deniedTitle: _deniedTitle,
      deniedMessage: _deniedMessage,
    );

    // Re-read strictly from the platform to catch `permanentlyDenied` cases
    // that a simple boolean might miss.
    final access = granted ? LocationAccess.granted : await _read();

    if (ref.mounted) state = AsyncValue.data(access);
    return access;
  }

  /// Prompts without a BuildContext, for callers that have none (like the driver broadcaster).
  Future<LocationAccess> ensure() async {
    final access = await ref.read(deviceLocationRepoProvider).requestAccess();

    if (ref.mounted) state = AsyncValue.data(access);
    return access;
  }

  /// Silently re-reads the permission (useful for App Lifecycle resumes).
  Future<void> refresh() async {
    final access = await _read();
    if (ref.mounted) state = AsyncValue.data(access);
  }

  Future<LocationAccess> _read() =>
      ref.read(deviceLocationRepoProvider).checkAccess();
}
