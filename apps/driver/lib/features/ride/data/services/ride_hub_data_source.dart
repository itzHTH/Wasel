import 'dart:async';

import 'package:driver/core/const/ride_hub_methods.dart';
import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/networking/signalR/signalr_client_impl.dart';

part 'ride_hub_data_source.g.dart';

abstract class IRideHubDataSource {
  Stream<HubRideEvent> get events;
  Stream<SignalRStatus> get connectionStatus;
  Future<void> connect({required String jwt});
  Future<void> updateLocation(
    double latitude,
    double longitude,
    String? rideId,
  );
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
    // Stream.multi rather than an async* generator: the current state has to be
    // read and the live stream subscribed to in the same synchronous step, or a
    // transition landing between the two would be dropped.
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
  Future<void> connect({required String jwt}) async {
    _registerListeners();
    await _client.connect(jwt: jwt);
  }

  void _registerListeners() {
    _client.on(RideHubMethods.receiveRideRequest, (args) {
      if (_controller.isClosed) return;

      final data = _obj(args);
      if (data == null) return;

      final rideId = data['rideid'];
      final position = _point(data['lat'], data['lng']);
      final dropPosition = _point(data['droplat'], data['droplng']);
      final price = _number(data['calculatedprice']);

      if (rideId is! String || position == null || dropPosition == null) {
        return;
      }

      _controller.add(
        HubRideEvent.receiveRideRequest(
          rideId: rideId,
          position: position,
          dropPosition: dropPosition,
          calculatedPrice: price ?? 0,
          paymentMethod: data['paymentmethod']?.toString() ?? '',
          riderName: data['ridername']?.toString() ?? '',
          riderPhone: data['riderphone']?.toString() ?? '',
          message: _msg(data['message']) ?? '',
        ),
      );
    });

    _client.on(RideHubMethods.hideRideRequest, (args) {
      if (_controller.isClosed) return;

      final rideId = _obj(args)?['rideid'] ?? args?.firstOrNull;
      if (rideId is! String) return;

      _controller.add(HubRideEvent.hideRideRequest(rideId));
    });

    _client.on(RideHubMethods.profileReviewed, (args) {
      if (_controller.isClosed) return;

      final data = _obj(args);
      if (data == null) return;

      final isApproved = data['isapproved'];
      if (isApproved is! bool) return;

      _controller.add(
        HubRideEvent.profileReviewed(
          isApproved: isApproved,
          message: _msg(data['message']) ?? '',
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
  Future<void> disconnect() async {
    await _client.disconnect();
  }

  String? _msg(Object? raw) {
    if (raw == null) return null;
    if (raw is String) return raw;
    if (raw is Map) return (raw['value'] ?? raw['name'])?.toString();
    return raw.toString();
  }

  LatLngDto? _point(Object? rawLat, Object? rawLng) {
    final lat = _number(rawLat);
    final lng = _number(rawLng);
    if (lat == null || lng == null) return null;
    return LatLngDto(lat: lat, lng: lng);
  }

  double? _number(Object? raw) {
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
}

@Riverpod(keepAlive: false)
IRideHubDataSource rideHubService(Ref ref) {
  final signalRClient = ref.watch(signalRClientProvider);
  final rideHub = RideHubDatasource(signalRClient);
  ref.onDispose(rideHub.dispose);
  return rideHub;
}
