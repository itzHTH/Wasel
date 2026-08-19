import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/cancel_ride/cancel_ride_response.dart';
import 'package:wasal/features/ride/data/models/estimate_ride_price/response/estimate_ride_price_response.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/request/request_ride_body.dart';
import 'package:wasal/features/ride/data/models/request_ride/response/request_ride_response.dart';
import 'package:wasal/features/ride/data/models/review_ride/request/review_ride_body.dart';
import 'package:wasal/features/ride/data/models/review_ride/response/review_ride_response.dart';
import 'package:wasal/features/ride/data/models/ride_events/hub_ride_event.dart';
import 'package:wasal/features/ride/data/services/ride_api_service.dart';
import 'package:wasal/features/ride/data/services/ride_hub_datasource.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/domain/entities/review_ride.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart'
    hide RideAccepted;
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

part 'ride_repo.g.dart';

class RideRepo extends BaseRideRepo {
  final RideApiService _rideApiService;
  final IRideHubDatasource _rideHubService;

  RideRepo(this._rideApiService, this._rideHubService);

  @override
  Future<ApiResults<RidePrice>> estimateRidePrice(
    GeoPointRequestBody geoPointRequest, {
    CancelToken? cancelToken,
  }) async {
    try {
      final EstimateRidePriceResponse response = await _rideApiService
          .estimateRidePrice(geoPointRequest, cancelToken: cancelToken);

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<RequestRide>> requestRide(
    RequestRideBody requestRideBody, {
    CancelToken? cancelToken,
  }) async {
    try {
      final RequestRideResponse response = await _rideApiService.requestRide(
        requestRideBody,
        cancelToken: cancelToken,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<CancelRide>> cancelRide(
    String rideId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final CancelRideResponse response = await _rideApiService.cancelRide(
        rideId,
        cancelToken: cancelToken,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<ReviewRide>> reviewRide(
    String rideId,
    ReviewRideBody reviewRideBody, {
    CancelToken? cancelToken,
  }) async {
    try {
      final ReviewRideResponse response = await _rideApiService.reviewRide(
        rideId,
        reviewRideBody,
        cancelToken: cancelToken,
      );
      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Stream<RideEvent> watchRide(String rideId) async* {
    final queue = StreamController<HubRideEvent>();
    final subscription = _rideHubService.events.listen(
      queue.add,
      onError: queue.addError,
    );

    try {
      try {
        await _rideHubService.connect();
      } catch (_) {}

      await for (final event in queue.stream) {
        if (event is RideAccepted) {
          await _rideHubService.trackRide(rideId);

          final driver = DriverProfile(
            id: event.driverId,
            name: event.driverName ?? 'سائق وصل',
            phoneNumber: event.phoneNumber,
            photoUrl: event.driverProfilePictureUrl,
            plateNumber: event.vinNumber,
            carModel: event.vehicleModel,
            vehicleYear: event.vehicleYear,
          );
          yield RideEvent.accepted(
            rideId: event.rideId,
            driver: driver,
            driverPosition: event.driverPosition?.toEntity(),
          );
        } else {
          yield event.toEntity();
        }
      }
    } finally {
      await subscription.cancel();
      await queue.close();
    }
  }
}

@riverpod
BaseRideRepo rideRepo(Ref ref) {
  final rideApiService = ref.watch(rideApiServiceProvider);
  final rideHubService = ref.watch(rideHubServiceProvider);
  return RideRepo(rideApiService, rideHubService);
}
