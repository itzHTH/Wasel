import 'dart:async';

import 'package:wasal/core/consts/ride_hub_methods.dart';
import 'package:wasal/features/ride/data/models/ride_events/hub_ride_event.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';

abstract class IRideHubDatasource {
  Stream<HubRideEvent> get events;
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

  Future<void> connect({required String jwt, required String rideId}) async {
    _registerListeners(); // Register event listeners before connecting

    await _client.connect(hubPath: 'hubs/tracking', jwt: jwt);

    await trackRide(rideId); // Track the ride after connecting

    _client.onReconnected(() {
      // Rejoin the ride after reconnection
      if (_currentRideId != null) trackRide(_currentRideId!);
    });
  }

  void _registerListeners() {
    _client.on(RideHubMethods.receiveDriverLocation, (args) {
      if (args == null || args.length < 2) {
        return; // Ensure there are at least two arguments for latitude and longitude
      }
      final lat = (args[0] as num).toDouble();
      final lng = (args[1] as num).toDouble();
      _controller.add(HubRideEvent.driverMoved(LatLngDto(lat: lat, lng: lng)));
    });

    _client.on(RideHubMethods.rideAccepted, (args) {
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.accepted(
          rideId: d['rideId'] as String,
          driverId: d['driverId'] as String,
          message: d['message'] as String,
        ),
      );
    });

    _client.on(RideHubMethods.driverArrived, (args) {
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.driverArrived(
          rideId: d['rideId'] as String,
          message: d['message'] as String,
        ),
      );
    });

    _client.on(RideHubMethods.rideStarted, (args) {
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.started(
          rideId: d['rideId'] as String,
          message: d['message'] as String,
        ),
      );
    });

    _client.on(RideHubMethods.rideCompleted, (args) {
      final d = _obj(args);
      if (d == null) return;
      _controller.add(
        HubRideEvent.completed(
          rideId: d['rideId'] as String,
          message: d['message'] as String,
        ),
      );
    });

    _client.on(RideHubMethods.rideCancelled, (args) {
      _controller.add(
        HubRideEvent.cancelled(
          message: args?.firstOrNull as String?,
        ), // Assuming the first argument is the cancellation message
      );
    });
  }

  Map<String, dynamic>? _obj(List<Object?>? args) {
    final first = args?.firstOrNull;
    if (first is Map) {
      return first.cast<String, dynamic>(); // Cast to Map<String, dynamic>
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
