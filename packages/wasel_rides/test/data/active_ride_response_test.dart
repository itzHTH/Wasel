import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_rides/data/models/active_ride/response/active_ride_response.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

void main() {
  Map<String, dynamic> dto({Map<String, dynamic> overrides = const {}}) => {
    'rideId': '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    'status': 2,
    'statusName': 'Accepted',
    'pickupLatitude': 33.3152,
    'pickupLongitude': 44.3661,
    'dropoffLatitude': 33.2989,
    'dropoffLongitude': 44.4009,
    'calculatedPrice': 7500,
    'paymentMethod': 'Cash',
    'requestedAt': '2026-08-26T10:00:00Z',
    'acceptedAt': '2026-08-26T10:01:12Z',
    'startedAt': null,
    'riderId': 'user-1',
    'riderName': 'Ali Hassan',
    'riderPhone': '+9647701234567',
    'driverId': 'user-2',
    'driverName': 'Kareem Ahmed',
    'driverPhone': '+9647709876543',
    'vehicleModel': 'Kia Cerato',
    'vehicleYear': 2021,
    'vinNumber': 'VIN-1',
    'driverLatitude': 33.3201,
    'driverLongitude': 44.3710,
    ...overrides,
  };

  group('envelope', () {
    test('reads the ride out of the data wrapper', () {
      final ride = ActiveRideEnvelopeResponse.fromJson({
        'succeeded': true,
        'message': 'Operation successful.',
        'data': dto(),
      }).toEntity();

      expect(ride, isNotNull);
      expect(ride!.rideId, '3fa85f64-5717-4562-b3fc-2c963f66afa6');
      expect(ride.status, RideStatus.accepted);
      expect(ride.calculatedPrice, 7500);
    });

    test('treats a null data as "no active ride", not a failure', () {
      final response = ActiveRideEnvelopeResponse.fromJson({
        'succeeded': true,
        'message': 'Operation successful.',
        'data': null,
      });

      expect(response.toEntity(), isNull);
    });
  });

  group('field coercion', () {
    test('parses numbers that arrive as strings', () {
      final ride = ActiveRideResponse.fromJson(
        dto(
          overrides: {
            'status': '4',
            'statusName': null,
            'pickupLatitude': '33.3152',
            'calculatedPrice': '7500.5',
            'vehicleYear': '2021',
            'driverLatitude': '33.32',
          },
        ),
      ).toEntity();

      expect(ride!.status, RideStatus.inProgress);
      expect(ride.pickupLatitude, 33.3152);
      expect(ride.calculatedPrice, 7500.5);
      expect(ride.vehicleYear, 2021);
      expect(ride.driverLatitude, 33.32);
    });

    test(
      'keeps an offline driver position null rather than snapping to 0,0',
      () {
        final ride = ActiveRideResponse.fromJson(
          dto(overrides: {'driverLatitude': null, 'driverLongitude': null}),
        ).toEntity();

        expect(ride!.driverLatitude, isNull);
        expect(ride.hasDriverPosition, isFalse);
        expect(ride.hasDriver, isTrue);
      },
    );

    test('blanks out empty strings so the UI can fall back', () {
      final ride = ActiveRideResponse.fromJson(
        dto(overrides: {'driverName': '   ', 'vinNumber': ''}),
      ).toEntity();

      expect(ride!.driverName, isNull);
      expect(ride.vinNumber, isNull);
    });

    test('hands timestamps back as local instants', () {
      final ride = ActiveRideResponse.fromJson(dto()).toEntity();

      expect(ride!.requestedAt!.isUtc, isFalse);
      expect(ride.requestedAt!.toUtc(), DateTime.utc(2026, 8, 26, 10));
      expect(ride.startedAt, isNull);
    });
  });

  test(
    'is null without a ride id, so no endpoint is called with a blank path',
    () {
      expect(
        ActiveRideResponse.fromJson(
          dto(overrides: {'rideId': '  '}),
        ).toEntity(),
        isNull,
      );
    },
  );
}
