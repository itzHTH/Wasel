import 'dart:async';

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
    _registerListeners(); // Register event listeners before connecting

    await _client.connect(jwt: jwt);

    _client.onReconnected(() {
      // Rejoin the ride after reconnection
      if (_currentRideId != null) {
        trackRide(_currentRideId!);
      }
    });
  }

  void _registerListeners() {
    _client.on(RideHubMethods.receiveDriverLocation, (args) {
      if (_controller.isClosed || args == null || args.length < 2) {
        return; // Need at least two arguments for latitude and longitude
      }
      final lat = (args[0] as num).toDouble();
      final lng = (args[1] as num).toDouble();
      _controller.add(HubRideEvent.driverMoved(LatLngDto(lat: lat, lng: lng)));
    });

    _client.on(RideHubMethods.rideAccepted, (args) {
      if (_controller.isClosed) return;
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.accepted(
          rideId: d['rideid'] as String,
          driverId: d['driverid'] as String,
          message: _msg(d['message']) ?? '',
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
      // The payload may be a plain string OR the same {rideId, message:{...}}
      // object shape as the other events — extract tolerantly either way.
      _controller.add(
        HubRideEvent.cancelled(
          message: _msg(_obj(args)?['message'] ?? args?.firstOrNull),
        ),
      );
    });
  }

  /// Extract a display string from an event's `message` field. The server sends
  /// it as a localization object `{name, value, resourceNotFound, ...}` — not a
  /// plain string — so a blind `as String` cast throws INSIDE signalr_netcore's
  /// onReceive, which tears the socket down and triggers an endless reconnect
  /// loop. Tolerate a plain String too, and fall back to `toString()`.
  String? _msg(Object? raw) {
    if (raw == null) return null;
    if (raw is String) return raw;
    if (raw is Map) return (raw['value'] ?? raw['name'])?.toString();
    return raw.toString();
  }

  Map<String, dynamic>? _obj(List<Object?>? args) {
    final first = args?.firstOrNull;
    if (first is Map) {
      // Normalize keys to lowercase so both camelCase
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
