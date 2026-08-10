import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/entities/driver_balance.dart';
import 'package:driver/features/ride/domain/entities/driver_earnings.dart';
import 'package:driver/features/ride/domain/entities/earnings_period.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:wasel_core/networking/api_results.dart';

abstract class BaseRideRepo {
  Stream<DriverRideEvent> watchRideEvents();
  Stream<RideConnectionStatus> watchConnectionStatus();
  Future<void> updateLocation(UpdateLocationArg updateLocationArg);
  Future<ApiResults<void>> acceptRide(String rideId);
  Future<ApiResults<void>> arriveAtStartPoint(String rideId);
  Future<ApiResults<void>> startRide(String rideId);
  Future<ApiResults<void>> completeRide(String rideId);
  Future<ApiResults<void>> driverCancelRide(String rideId);
  Future<ApiResults<DriverBalance>> getDriverWalletBalance();
  Future<ApiResults<DriverEarnings>> getDriverEarnings(EarningsPeriod period);
}
