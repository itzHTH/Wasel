import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_rides/data/models/active_ride/active_ride_payload.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

void main() {
  test('reads a payload whose keys came back in a different casing', () {
    final ride = ActiveRidePayload.parse([
      {
        'RideId': 'ride-1',
        'StatusName': 'InProgress',
        'PickupLatitude': 33.3152,
        'PickupLongitude': 44.3661,
        'DropoffLatitude': 33.2989,
        'DropoffLongitude': 44.4009,
        'DriverId': 'driver-1',
        'DriverLatitude': '33.32',
        'DriverLongitude': '44.37',
      },
    ]);

    expect(ride, isNotNull);
    expect(ride!.rideId, 'ride-1');
    expect(ride.status, RideStatus.inProgress);
    expect(ride.pickupLatitude, 33.3152);
    expect(ride.driverLatitude, 33.32);
  });

  test('reads the documented camelCase payload unchanged', () {
    final ride = ActiveRidePayload.parse([
      {'rideId': 'ride-2', 'status': 5, 'calculatedPrice': 7500},
    ]);

    expect(ride!.rideId, 'ride-2');
    expect(ride.status, RideStatus.completed);
    expect(ride.status!.isTerminal, isTrue);
  });

  test('is null when the ride is over and the server pushes nothing', () {
    expect(ActiveRidePayload.parse(null), isNull);
    expect(ActiveRidePayload.parse([]), isNull);
    expect(ActiveRidePayload.parse([null]), isNull);
  });

  test('is null for a payload carrying nothing this DTO declares', () {
    expect(ActiveRidePayload.parse([<String, Object?>{}]), isNull);
    expect(ActiveRidePayload.parse(['not-a-map']), isNull);
  });
}
