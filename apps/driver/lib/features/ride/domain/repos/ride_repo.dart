import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:wasel_core/networking/api_results.dart';

abstract class BaseRideRepo {
  Stream<DriverRideEvent> watchRideEvents();
  Future<void> updateLocation(UpdateLocationArg updateLocationArg);
  Future<ApiResults<void>> acceptRide(String rideId);
  Future<ApiResults<void>> arriveAtStartPoint(String rideId);
  Future<ApiResults<void>> startRide(String rideId);
  Future<ApiResults<void>> completeRide(String rideId);
  Future<ApiResults<void>> driverCancelRide(String rideId);
}
