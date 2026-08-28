import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_core/networking/json_num_converters.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

part 'active_ride_response.g.dart';

@JsonSerializable(createToJson: false)
class ActiveRideResponse {
  final String? rideId;

  @JsonKey(fromJson: nullableIntFromJson)
  final int? status;

  final String? statusName;

  @JsonKey(fromJson: doubleFromJson)
  final double pickupLatitude;

  @JsonKey(fromJson: doubleFromJson)
  final double pickupLongitude;

  @JsonKey(fromJson: doubleFromJson)
  final double dropoffLatitude;

  @JsonKey(fromJson: doubleFromJson)
  final double dropoffLongitude;

  @JsonKey(fromJson: doubleFromJson)
  final double calculatedPrice;

  final String? paymentMethod;

  final String? requestedAt;
  final String? acceptedAt;
  final String? startedAt;

  final String? riderId;
  final String? riderName;
  final String? riderPhone;

  final String? driverId;
  final String? driverName;
  final String? driverPhone;

  final String? vehicleModel;

  @JsonKey(fromJson: nullableIntFromJson)
  final int? vehicleYear;

  final String? vinNumber;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? driverLatitude;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? driverLongitude;

  const ActiveRideResponse({
    this.rideId,
    this.status,
    this.statusName,
    this.pickupLatitude = 0,
    this.pickupLongitude = 0,
    this.dropoffLatitude = 0,
    this.dropoffLongitude = 0,
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

  factory ActiveRideResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveRideResponseFromJson(json);

  static const List<String> jsonKeys = [
    'rideId',
    'status',
    'statusName',
    'pickupLatitude',
    'pickupLongitude',
    'dropoffLatitude',
    'dropoffLongitude',
    'calculatedPrice',
    'paymentMethod',
    'requestedAt',
    'acceptedAt',
    'startedAt',
    'riderId',
    'riderName',
    'riderPhone',
    'driverId',
    'driverName',
    'driverPhone',
    'vehicleModel',
    'vehicleYear',
    'vinNumber',
    'driverLatitude',
    'driverLongitude',
  ];

  ActiveRide? toEntity() {
    final id = rideId?.trim();
    if (id == null || id.isEmpty) return null;

    return ActiveRide(
      rideId: id,
      status: RideStatus.fromApi(name: statusName, code: status),
      pickupLatitude: pickupLatitude,
      pickupLongitude: pickupLongitude,
      dropoffLatitude: dropoffLatitude,
      dropoffLongitude: dropoffLongitude,
      calculatedPrice: calculatedPrice,
      paymentMethod: _text(paymentMethod),
      requestedAt: _dateTime(requestedAt),
      acceptedAt: _dateTime(acceptedAt),
      startedAt: _dateTime(startedAt),
      riderId: _text(riderId),
      riderName: _text(riderName),
      riderPhone: _text(riderPhone),
      driverId: _text(driverId),
      driverName: _text(driverName),
      driverPhone: _text(driverPhone),
      vehicleModel: _text(vehicleModel),
      vehicleYear: vehicleYear,
      vinNumber: _text(vinNumber),
      driverLatitude: driverLatitude,
      driverLongitude: driverLongitude,
    );
  }

  static String? _text(String? raw) {
    final trimmed = raw?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }

  static DateTime? _dateTime(String? raw) =>
      DateTime.tryParse(raw?.trim() ?? '')?.toLocal();
}

class ActiveRideEnvelopeResponse {
  final ActiveRideResponse? ride;

  const ActiveRideEnvelopeResponse(this.ride);

  factory ActiveRideEnvelopeResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      return const ActiveRideEnvelopeResponse(null);
    }
    return ActiveRideEnvelopeResponse(ActiveRideResponse.fromJson(data));
  }

  ActiveRide? toEntity() => ride?.toEntity();
}
