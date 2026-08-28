// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_ride_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveRideResponse _$ActiveRideResponseFromJson(Map<String, dynamic> json) =>
    ActiveRideResponse(
      rideId: json['rideId'] as String?,
      status: nullableIntFromJson(json['status']),
      statusName: json['statusName'] as String?,
      pickupLatitude: json['pickupLatitude'] == null
          ? 0
          : doubleFromJson(json['pickupLatitude']),
      pickupLongitude: json['pickupLongitude'] == null
          ? 0
          : doubleFromJson(json['pickupLongitude']),
      dropoffLatitude: json['dropoffLatitude'] == null
          ? 0
          : doubleFromJson(json['dropoffLatitude']),
      dropoffLongitude: json['dropoffLongitude'] == null
          ? 0
          : doubleFromJson(json['dropoffLongitude']),
      calculatedPrice: json['calculatedPrice'] == null
          ? 0
          : doubleFromJson(json['calculatedPrice']),
      paymentMethod: json['paymentMethod'] as String?,
      requestedAt: json['requestedAt'] as String?,
      acceptedAt: json['acceptedAt'] as String?,
      startedAt: json['startedAt'] as String?,
      riderId: json['riderId'] as String?,
      riderName: json['riderName'] as String?,
      riderPhone: json['riderPhone'] as String?,
      driverId: json['driverId'] as String?,
      driverName: json['driverName'] as String?,
      driverPhone: json['driverPhone'] as String?,
      vehicleModel: json['vehicleModel'] as String?,
      vehicleYear: nullableIntFromJson(json['vehicleYear']),
      vinNumber: json['vinNumber'] as String?,
      driverLatitude: nullableDoubleFromJson(json['driverLatitude']),
      driverLongitude: nullableDoubleFromJson(json['driverLongitude']),
    );
