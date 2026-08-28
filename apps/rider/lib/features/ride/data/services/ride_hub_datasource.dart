import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/ride_hub_methods.dart';
import 'package:wasal/features/ride/data/models/ride_events/hub_ride_event.dart';
import 'package:wasel_core/networking/signalR/hub_payload.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/networking/signalR/signalr_client_impl.dart';
import 'package:wasel_rides/data/models/active_ride/active_ride_payload.dart';

part 'ride_hub_datasource.g.dart';

abstract class IRideHubDatasource {
  Stream<HubRideEvent> get events;
  Future<void> connect();
  Future<void> trackRide(String rideId);
  Future<bool> reconnectToRide(String rideId);
  Future<void> dispose();
}

class RideHubDatasource implements IRideHubDatasource {
  RideHubDatasource(this._client);

  final ISignalRClient _client;

  final _controller = StreamController<HubRideEvent>.broadcast();

  String? _currentRideId;

  bool _reconnectHooked = false;

  @override
  Stream<HubRideEvent> get events => _controller.stream;

  @override
  Future<void> connect() async {
    _registerListeners();

    await _client.connect();

    if (_reconnectHooked) return;
    _reconnectHooked = true;

    _client.onReconnected(() {
      final rideId = _currentRideId;
      if (rideId != null) unawaited(reconnectToRide(rideId));
    });
  }

  @override
  Future<void> trackRide(String rideId) async {
    _currentRideId = rideId;
    await _client.invoke(RideHubMethods.trackRide, args: [rideId]);
  }

  @override
  Future<bool> reconnectToRide(String rideId) async {
    _currentRideId = rideId;

    try {
      await _client.invoke(RideHubMethods.reconnectToRide, args: [rideId]);
      return true;
    } catch (e) {
      debugPrint('🔁 ReconnectToRide($rideId) refused → $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    await _client.disconnect();
    await _controller.close();
  }

  void _registerListeners() {
    _listen(RideHubMethods.receiveDriverLocation, _readDriverMoved);
    _listen(RideHubMethods.rideAccepted, _readAccepted);
    _listen(RideHubMethods.driverArrived, _readDriverArrived);
    _listen(RideHubMethods.rideStarted, _readStarted);
    _listen(RideHubMethods.rideCompleted, _readCompleted);
    _listen(RideHubMethods.rideCancelled, _readCancelled);
    _listen(RideHubMethods.driverDisconnected, _readDriverDisconnected);
    _listen(RideHubMethods.rideStatusSync, _readStatusSync);
  }

  void _listen(
    String method,
    HubRideEvent? Function(List<Object?>? args) read,
  ) {
    _client.on(method, (args) {
      if (_controller.isClosed) return;

      final event = read(args);
      if (event == null) {
        debugPrint('📡 $method: unrecognized payload → $args');
        return;
      }
      _controller.add(event);
    });
  }

  static HubRideEvent? _readDriverMoved(List<Object?>? args) {
    final position = _latLng(args);
    return position == null ? null : HubRideEvent.driverMoved(position);
  }

  static HubRideEvent? _readAccepted(List<Object?>? args) {
    final data = HubPayload.of(args);
    final rideId = data?.text('rideId');
    final driverId = data?.text('driverId');
    if (data == null || rideId == null || driverId == null) return null;

    final lat = data.number('driverLatitude');
    final lng = data.number('driverLongitude');

    return HubRideEvent.accepted(
      rideId: rideId,
      driverId: driverId,
      message: data.message('message') ?? '',
      driverPosition: (lat != null && lng != null)
          ? LatLngDto(lat: lat, lng: lng)
          : null,
      driverName: data.text('driverName'),
      driverProfilePictureUrl: data.text('driverProfilePictureUrl'),
      vehicleModel: data.text('vehicleModel'),
      vehicleYear: data.loose('vehicleYear'),
      vinNumber: data.text('vinNumber'),
      phoneNumber: data.text('phoneNumber'),
    );
  }

  static HubRideEvent? _readDriverArrived(List<Object?>? args) =>
      _readStageChange(args, HubRideEvent.driverArrived);

  static HubRideEvent? _readStarted(List<Object?>? args) =>
      _readStageChange(args, HubRideEvent.started);

  static HubRideEvent? _readCompleted(List<Object?>? args) =>
      _readStageChange(args, HubRideEvent.completed);

  static HubRideEvent? _readStageChange(
    List<Object?>? args,
    HubRideEvent Function({required String rideId, required String message})
    build,
  ) {
    final data = HubPayload.of(args);
    final rideId = data?.text('rideId');
    if (data == null || rideId == null) return null;

    return build(rideId: rideId, message: data.message('message') ?? '');
  }

  static HubRideEvent _readCancelled(List<Object?>? args) {
    final data = HubPayload.of(args);

    return HubRideEvent.cancelled(
      message: data == null
          ? HubPayload.messageOf(args?.firstOrNull)
          : data.message('message'),
    );
  }

  static HubRideEvent? _readDriverDisconnected(List<Object?>? args) {
    final data = HubPayload.of(args);
    final rideId = data?.text('rideId');
    if (data == null || rideId == null) return null;

    return HubRideEvent.driverDisconnected(
      rideId: rideId,
      message: data.message('message') ?? '',
    );
  }

  static HubRideEvent _readStatusSync(List<Object?>? args) =>
      HubRideEvent.statusSync(ActiveRidePayload.parse(args));

  static LatLngDto? _latLng(List<Object?>? args) {
    if (args == null || args.isEmpty) return null;

    final first = args.first;
    if (args.length >= 2 && first is num && args[1] is num) {
      return LatLngDto(
        lat: first.toDouble(),
        lng: (args[1]! as num).toDouble(),
      );
    }

    final data = HubPayload.of(args);
    if (data == null) return null;

    final lat = data.number('lat') ?? data.number('latitude');
    final lng =
        data.number('lng') ?? data.number('lon') ?? data.number('longitude');
    if (lat == null || lng == null) return null;

    return LatLngDto(lat: lat, lng: lng);
  }
}

@Riverpod(keepAlive: false)
IRideHubDatasource rideHubService(Ref ref) {
  final signalRClient = ref.watch(signalRClientProvider);
  final rideHub = RideHubDatasource(signalRClient);
  ref.onDispose(rideHub.dispose);
  return rideHub;
}
