import 'package:wasel_rides/domain/entities/ride_status.dart';

class ActiveRide {
  final String rideId;
  final RideStatus? status;

  final double pickupLatitude;
  final double pickupLongitude;
  final double dropoffLatitude;
  final double dropoffLongitude;

  final double calculatedPrice;
  final String? paymentMethod;

  final DateTime? requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;

  final String? riderId;
  final String? riderName;
  final String? riderPhone;

  final String? driverId;
  final String? driverName;
  final String? driverPhone;

  final String? vehicleModel;
  final int? vehicleYear;
  final String? vinNumber;

  final double? driverLatitude;
  final double? driverLongitude;

  const ActiveRide({
    required this.rideId,
    this.status,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    this.calculatedPrice = 0,
    this.paymentMethod,
    this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.riderId,
    this.riderName,
    this.riderPhone,
    this.driverId,
    this.driverName,
    this.driverPhone,
    this.vehicleModel,
    this.vehicleYear,
    this.vinNumber,
    this.driverLatitude,
    this.driverLongitude,
  });

  ActiveRide withPaymentMethod(String method) => ActiveRide(
    rideId: rideId,
    status: status,
    pickupLatitude: pickupLatitude,
    pickupLongitude: pickupLongitude,
    dropoffLatitude: dropoffLatitude,
    dropoffLongitude: dropoffLongitude,
    calculatedPrice: calculatedPrice,
    paymentMethod: method,
    requestedAt: requestedAt,
    acceptedAt: acceptedAt,
    startedAt: startedAt,
    riderId: riderId,
    riderName: riderName,
    riderPhone: riderPhone,
    driverId: driverId,
    driverName: driverName,
    driverPhone: driverPhone,
    vehicleModel: vehicleModel,
    vehicleYear: vehicleYear,
    vinNumber: vinNumber,
    driverLatitude: driverLatitude,
    driverLongitude: driverLongitude,
  );

  bool get hasDriver => (driverId?.trim().isNotEmpty ?? false);

  bool get hasDriverPosition =>
      driverLatitude != null && driverLongitude != null;
}
