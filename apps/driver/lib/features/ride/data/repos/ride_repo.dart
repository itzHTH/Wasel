import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/domain/entities/driver_balance.dart';
import 'package:driver/features/ride/domain/entities/driver_earnings.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/earnings_period.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/repos/ride_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_repo.g.dart';

class RideRepo implements BaseRideRepo {
  RideRepo(this._rideHubService, this._rideApiService);
  final IRideHubDataSource _rideHubService;
  final RideApiService _rideApiService;

  @override
  Stream<DriverRideEvent> watchRideEvents() {
    late final StreamController<DriverRideEvent> events;
    StreamSubscription<HubRideEvent>? sub;
    var released = false;

    Future<void> release() async {
      if (released) return;
      released = true;
      await sub?.cancel();
      await _rideHubService.disconnect();
    }

    Future<void> open() async {
      sub = _rideHubService.events.listen(
        (event) {
          if (!events.isClosed) events.add(event.toEntity());
        },
        onError: (Object error, StackTrace stackTrace) {
          if (!events.isClosed) events.addError(error, stackTrace);
        },
        onDone: () {
          if (!events.isClosed) events.close();
        },
      );

      try {
        final jwt =
            await AppLocalCache.getSecuredString(AppConstants.tokenKey) ?? '';

        // Reading the token is asynchronous, so a listener that cancels inside
        // that window releases before there is anything to release. Connecting
        // now would leave a socket no one holds — and the client keeps at most
        // one, so every later attempt would find it taken and quietly no-op.
        if (released) return;

        await _rideHubService.connect(jwt: jwt);
      } catch (e, stackTrace) {
        if (!events.isClosed) {
          events.addError(e, stackTrace);
          await events.close();
        }
      }
    }

    events = StreamController<DriverRideEvent>(
      onListen: open,
      onCancel: release,
    );

    return events.stream;
  }

  /// [distinct] because the hub republishes its state on every transition and
  /// callers act on changes — a repeated `connected` is not a reconnect.
  @override
  Stream<RideConnectionStatus> watchConnectionStatus() {
    return _rideHubService.connectionStatus.map(_toConnectionStatus).distinct();
  }

  RideConnectionStatus _toConnectionStatus(SignalRStatus status) {
    return switch (status) {
      SignalRStatus.disconnected => RideConnectionStatus.disconnected,
      SignalRStatus.connecting => RideConnectionStatus.connecting,
      SignalRStatus.connected => RideConnectionStatus.connected,
      SignalRStatus.reconnecting => RideConnectionStatus.reconnecting,
    };
  }

  @override
  Future<void> updateLocation(UpdateLocationArg updateLocationArg) async {
    await _rideHubService.updateLocation(
      updateLocationArg.lat,
      updateLocationArg.lng,
      updateLocationArg.rideId,
    );
  }

  @override
  Future<ApiResults<void>> acceptRide(String rideId) async {
    return _run(() => _rideApiService.acceptRide(rideId));
  }

  @override
  Future<ApiResults<void>> arriveAtStartPoint(String rideId) async {
    return _run(() => _rideApiService.arriveAtDestination(rideId));
  }

  @override
  Future<ApiResults<void>> completeRide(String rideId) async {
    return _run(() => _rideApiService.completeRide(rideId));
  }

  @override
  Future<ApiResults<void>> driverCancelRide(String rideId) async {
    return _run(() => _rideApiService.driverCancelRide(rideId));
  }

  @override
  Future<ApiResults<void>> startRide(String rideId) async {
    return _run(() => _rideApiService.startRide(rideId));
  }

  @override
  Future<ApiResults<DriverBalance>> getDriverWalletBalance() async {
    try {
      final response = await _rideApiService.getDriverWalletBalance();
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<DriverEarnings>> getDriverEarnings(
    EarningsPeriod period,
  ) async {
    try {
      final response = await _rideApiService.getDriverEarnings(
        startDate: period.start,
        endDate: period.end,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResults<void>> _run(Future<void> Function() action) async {
    try {
      await action();
      return ApiResults.success(null);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
RideRepo rideRepo(Ref ref) {
  final rideHubService = ref.watch(rideHubServiceProvider);
  final rideApiService = ref.watch(rideApiServiceProvider);
  return RideRepo(rideHubService, rideApiService);
}
