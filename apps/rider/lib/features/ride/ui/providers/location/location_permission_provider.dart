import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/permissions/permission_gate.dart' as permission_gate;

part 'location_permission_provider.g.dart';

enum LocationAccess { granted, denied }

@Riverpod(keepAlive: true)
class LocationPermission extends _$LocationPermission {
  @override
  Future<LocationAccess> build() => _read();

  Future<LocationAccess> request(BuildContext context) async {
    final granted = await permission_gate.ensurePermission(
      context,
      Permission.location,
      deniedTitle: 'إذن الموقع مطلوب',
      deniedMessage: 'يرجى تمكين إذن الموقع للوصول إلى هذه الميزة.',
    );

    final access = granted ? LocationAccess.granted : LocationAccess.denied;
    if (ref.mounted) state = AsyncValue.data(access);
    return access;
  }

  Future<LocationAccess> _read() async {
    final status = await Permission.location.status;
    return status.isGranted || status.isLimited
        ? LocationAccess.granted
        : LocationAccess.denied;
  }
}
