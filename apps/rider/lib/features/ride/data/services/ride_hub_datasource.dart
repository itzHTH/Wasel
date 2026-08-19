import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/ride_hub_methods.dart';
import 'package:wasal/features/ride/data/models/ride_events/hub_ride_event.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/networking/signalR/signalr_client_impl.dart';

part 'ride_hub_datasource.g.dart';

abstract class IRideHubDatasource {
  Stream<HubRideEvent> get events;
  Future<void> connect({required String jwt});
  Future<void> trackRide(String rideId);
  Future<void> dispose();
}

class RideHubDatasource implements IRideHubDatasource {
  RideHubDatasource(this._client);
  final ISignalRClient _client;

  final _controller = StreamController<HubRideEvent>.broadcast();
  String? _currentRideId;

  @override
  Stream<HubRideEvent> get events => _controller.stream;

  @override
  Future<void> connect({required String jwt}) async {
    _registerListeners();

    await _client.connect(jwt: jwt);

    _client.onReconnected(() {

      if (_currentRideId != null) {
        trackRide(_currentRideId!);
      }
    });
  }

  void _registerListeners() {
    _client.on(RideHubMethods.receiveDriverLocation, (args) {
      if (_controller.isClosed) return;
      final position = _latLng(args);
      if (position == null) {

        debugPrint('🚗 ReceiveDriverLocation: unrecognized payload → $args');
        return;
      }
      _controller.add(HubRideEvent.driverMoved(position));
    });

    _client.on(RideHubMethods.rideAccepted, (args) {
      if (_controller.isClosed) return;
      final d = _obj(args);
      if (d == null) return;
      final rideId = _str(d['rideid']);
      final driverId = _str(d['driverid']);
      if (rideId == null || driverId == null) {
        debugPrint('🚕 RideAccepted: unrecognized payload → $args');
        return;
      }
      final lat = _coord(d['driverlatitude']);
      final lng = _coord(d['driverlongitude']);
      _controller.add(
        HubRideEvent.accepted(
          rideId: rideId,
          driverId: driverId,
          message: _msg(d['message']) ?? '',
          driverPosition: (lat != null && lng != null)
              ? LatLngDto(lat: lat, lng: lng)
              : null,
          driverName: _str(d['drivername']),
          driverProfilePictureUrl: _str(d['driverprofilepictureurl']),
          vehicleModel: _str(d['vehiclemodel']),
          vehicleYear: _loose(d['vehicleyear']),
          vinNumber: _str(d['vinnumber']),
          phoneNumber: _str(d['phonenumber']),
        ),
      );
    });

    _client.on(RideHubMethods.driverArrived, (args) {
      if (_controller.isClosed) return;
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.driverArrived(
          rideId: d['rideid'] as String,
          message: _msg(d['message']) ?? '',
        ),
      );
    });

    _client.on(RideHubMethods.rideStarted, (args) {
      if (_controller.isClosed) return;
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.started(
          rideId: d['rideid'] as String,
          message: _msg(d['message']) ?? '',
        ),
      );
    });

    _client.on(RideHubMethods.rideCompleted, (args) {
      if (_controller.isClosed) return;
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.completed(
          rideId: d['rideid'] as String,
          message: _msg(d['message']) ?? '',
        ),
      );
    });

    _client.on(RideHubMethods.rideCancelled, (args) {
      if (_controller.isClosed) return;

      _controller.add(
        HubRideEvent.cancelled(
          message: _msg(_obj(args)?['message'] ?? args?.firstOrNull),
        ),
      );
    });
  }

  String? _str(Object? raw) {
    if (raw is! String) return null;
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  // The hub sends vehicleYear as a number, which _str drops.
  String? _loose(Object? raw) {
    if (raw == null) return null;
    final text = raw.toString().trim();
    return text.isEmpty ? null : text;
  }

  String? _msg(Object? raw) {
    if (raw == null) return null;
    if (raw is String) return raw;
    if (raw is Map) return (raw['value'] ?? raw['name'])?.toString();
    return raw.toString();
  }

  LatLngDto? _latLng(List<Object?>? args) {
    if (args == null || args.isEmpty) return null;

    final first = args.first;
    if (args.length >= 2 && first is num && args[1] is num) {
      return LatLngDto(
        lat: first.toDouble(),
        lng: (args[1]! as num).toDouble(),
      );
    }

    final d = _obj(args);
    if (d == null) return null;
    final lat = _coord(d['lat'] ?? d['latitude']);
    final lng = _coord(d['lng'] ?? d['lon'] ?? d['longitude']);
    if (lat == null || lng == null) return null;
    return LatLngDto(lat: lat, lng: lng);
  }

  double? _coord(Object? raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw);
    return null;
  }

  Map<String, dynamic>? _obj(List<Object?>? args) {
    final first = args?.firstOrNull;
    if (first is Map) {

      return {
        for (final entry in first.entries)
          entry.key.toString().toLowerCase(): entry.value,
      };
    }
    return null;
  }

  @override
  Future<void> dispose() async {
    await _client.disconnect();
    await _controller.close();
  }

  @override
  Future<void> trackRide(String rideId) async {
    _currentRideId = rideId;
    await _client.invoke(RideHubMethods.trackRide, args: [rideId]);
  }
}

@Riverpod(keepAlive: false)
IRideHubDatasource rideHubService(Ref ref) {
  final signalRClient = ref.watch(signalRClientProvider);
  final rideHub = RideHubDatasource(signalRClient);
  ref.onDispose(rideHub.dispose);
  return rideHub;
}
