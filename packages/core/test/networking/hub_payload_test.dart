import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/signalR/hub_payload.dart';

void main() {
  group('of', () {
    test('reads the first argument, whatever casing its keys came in', () {
      final data = HubPayload.of([
        {'RideId': 'ride-1', ' driverNAME ': 'Kareem'},
      ]);

      expect(data?.text('rideId'), 'ride-1');
      expect(data?.text('driverName'), 'Kareem');
    });

    test('is null when the push carries no object', () {
      expect(HubPayload.of(null), isNull);
      expect(HubPayload.of([]), isNull);
      expect(HubPayload.of([null]), isNull);
      expect(HubPayload.of(['ride-1']), isNull);
    });

    test('is null for a key the payload does not carry', () {
      final data = HubPayload.of([
        {'rideId': 'ride-1'},
      ]);

      expect(data?.text('driverName'), isNull);
    });
  });

  group('text', () {
    test('rejects anything that is not a string', () {
      final data = HubPayload.of([
        {'vehicleYear': 2021},
      ])!;

      expect(data.text('vehicleYear'), isNull);
    });

    test('blanks empty and whitespace-only strings', () {
      final data = HubPayload.of([
        {'driverName': '', 'vinNumber': '   '},
      ])!;

      expect(data.text('driverName'), isNull);
      expect(data.text('vinNumber'), isNull);
    });

    test('trims what it keeps', () {
      final data = HubPayload.of([
        {'rideId': ' ride-1 '},
      ])!;

      expect(data.text('rideId'), 'ride-1');
    });
  });

  test('loose keeps a number the hub sent untyped', () {
    final data = HubPayload.of([
      {'vehicleYear': 2021},
    ])!;

    expect(data.loose('vehicleYear'), '2021');
  });

  group('message', () {
    test('reads a bare string', () {
      expect(HubPayload.messageOf('الكابتن في الطريق'), 'الكابتن في الطريق');
    });

    test('unwraps the object the hub sometimes sends instead', () {
      expect(HubPayload.messageOf({'value': 'accepted'}), 'accepted');
      expect(HubPayload.messageOf({'name': 'Accepted'}), 'Accepted');
    });

    test('is null when there is nothing to say', () {
      expect(HubPayload.messageOf(null), isNull);
    });
  });

  group('number', () {
    test('reads a number sent as a string', () {
      final data = HubPayload.of([
        {'lat': '33.3152', 'lng': 44.3661},
      ])!;

      expect(data.number('lat'), 33.3152);
      expect(data.number('lng'), 44.3661);
    });

    test('is null rather than zero for an unparseable value', () {
      final data = HubPayload.of([
        {'lat': 'not-a-number'},
      ])!;

      expect(data.number('lat'), isNull);
    });
  });
}
