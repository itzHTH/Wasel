import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/repos/ride_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
