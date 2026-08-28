import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:driver/core/const/ride_hub_methods.dart';
import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/signalR/hub_payload.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/networking/signalR/signalr_client_impl.dart';
import 'package:wasel_rides/data/models/active_ride/active_ride_payload.dart';

part 'ride_hub_data_source.g.dart';

abstract class IRideHubDataSource {
  Stream<HubRideEvent> get events;
  Stream<SignalRStatus> get connectionStatus;
  Future<void> connect();
  Future<void> updateLocation(
    double latitude,
    double longitude,
    String? rideId,
  );
  Future<bool> reconnectToRide(String rideId);
  Future<void> disconnect();
  Future<void> dispose();
}

class RideHubDatasource implements IRideHubDataSource {
  RideHubDatasource(this._client);

  final ISignalRClient _client;

  final _controller = StreamController<HubRideEvent>.broadcast();

  @override
  Stream<HubRideEvent> get events => _controller.stream;

  @override
  Stream<SignalRStatus> get connectionStatus {
    return Stream.multi((controller) {
      controller.add(_client.status);

      final subscription = _client.statusStream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );

      controller.onCancel = subscription.cancel;
    });
  }

  @override
  Future<void> connect() async {
    _registerListeners();
    await _client.connect();
  }

  @override
  Future<void> updateLocation(
    double latitude,
    double longitude,
    String? rideId,
  ) {
    return _client.invoke(
      RideHubMethods.updateLocation,
      args: [latitude, longitude, rideId ?? ''],
    );
  }

  @override
  Future<bool> reconnectToRide(String rideId) async {
    try {
      await _client.invoke(RideHubMethods.reconnectToRide, args: [rideId]);
      return true;
    } catch (e) {
      debugPrint('🔁 ReconnectToRide($rideId) refused → $e');
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _client.disconnect();
  }

  @override
  Future<void> dispose() async {
    await _client.disconnect();
    await _controller.close();
  }

  void _registerListeners() {
    _listen(RideHubMethods.receiveRideRequest, _readRideRequest);
    _listen(RideHubMethods.hideRideRequest, _readHideRequest);
    _listen(RideHubMethods.profileReviewed, _readProfileReviewed);
    _listen(RideHubMethods.rideCancelled, _readCancelled);
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

  static HubRideEvent? _readRideRequest(List<Object?>? args) {
    final data = HubPayload.of(args);
    if (data == null) return null;

    final rideId = data.text('rideId');
    final position = _point(data, 'lat', 'lng');
    final dropPosition = _point(data, 'dropLat', 'dropLng');
    if (rideId == null || position == null || dropPosition == null) return null;

    return HubRideEvent.receiveRideRequest(
      rideId: rideId,
      position: position,
      dropPosition: dropPosition,
      calculatedPrice: data.number('calculatedPrice') ?? 0,
      paymentMethod: data.loose('paymentMethod') ?? '',
      riderName: data.loose('riderName') ?? '',
      riderPhone: data.loose('riderPhone') ?? '',
      message: data.message('message') ?? '',
    );
  }

  static HubRideEvent? _readHideRequest(List<Object?>? args) {
    final rideId =
        HubPayload.of(args)?.text('rideId') ??
        HubPayload.textOf(args?.firstOrNull);

    return rideId == null ? null : HubRideEvent.hideRideRequest(rideId);
  }

  static HubRideEvent? _readProfileReviewed(List<Object?>? args) {
    final data = HubPayload.of(args);
    final isApproved = data?['isApproved'];
    if (data == null || isApproved is! bool) return null;

    return HubRideEvent.profileReviewed(
      isApproved: isApproved,
      message: data.message('message') ?? '',
    );
  }

  static HubRideEvent _readCancelled(List<Object?>? args) {
    final data = HubPayload.of(args);

    return HubRideEvent.cancelled(
      message: data == null
          ? HubPayload.messageOf(args?.firstOrNull)
          : data.message('message'),
    );
  }

  static HubRideEvent _readStatusSync(List<Object?>? args) =>
      HubRideEvent.statusSync(ActiveRidePayload.parse(args));

  static LatLngDto? _point(HubPayload data, String latKey, String lngKey) {
    final lat = data.number(latKey);
    final lng = data.number(lngKey);
    if (lat == null || lng == null) return null;

    return LatLngDto(lat: lat, lng: lng);
  }
}

@Riverpod(keepAlive: false)
IRideHubDataSource rideHubService(Ref ref) {
  final signalRClient = ref.watch(signalRClientProvider);
  final rideHub = RideHubDatasource(signalRClient);
  ref.onDispose(rideHub.dispose);
  return rideHub;
}
