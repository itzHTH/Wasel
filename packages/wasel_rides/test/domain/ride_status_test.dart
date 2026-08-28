import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

void main() {
  group('fromApi', () {
    test('reads every documented status name', () {
      expect(RideStatus.fromApi(name: 'Pending'), RideStatus.pending);
      expect(RideStatus.fromApi(name: 'Accepted'), RideStatus.accepted);
      expect(RideStatus.fromApi(name: 'Arrived'), RideStatus.arrived);
      expect(RideStatus.fromApi(name: 'InProgress'), RideStatus.inProgress);
      expect(RideStatus.fromApi(name: 'Completed'), RideStatus.completed);
      expect(RideStatus.fromApi(name: 'Cancelled'), RideStatus.cancelled);
    });

    test('ignores casing and surrounding space', () {
      expect(RideStatus.fromApi(name: '  inprogress '), RideStatus.inProgress);
    });

    test(
      'accepts the lifecycle wording the guide uses for the same states',
      () {
        expect(RideStatus.fromApi(name: 'DriverArrived'), RideStatus.arrived);
        expect(RideStatus.fromApi(name: 'Started'), RideStatus.inProgress);
        expect(RideStatus.fromApi(name: 'Canceled'), RideStatus.cancelled);
      },
    );

    test('falls back to the numeric code when the name is unusable', () {
      expect(
        RideStatus.fromApi(name: 'قيد التنفيذ', code: 4),
        RideStatus.inProgress,
      );
      expect(RideStatus.fromApi(code: 2), RideStatus.accepted);
    });

    test('prefers the name over a disagreeing code', () {
      expect(
        RideStatus.fromApi(name: 'Completed', code: 2),
        RideStatus.completed,
      );
    });

    test('is null when neither field is recognised', () {
      expect(RideStatus.fromApi(), isNull);
      expect(RideStatus.fromApi(name: '', code: 99), isNull);
    });
  });

  group('isTerminal', () {
    test('is true only once the ride is over', () {
      expect(RideStatus.completed.isTerminal, isTrue);
      expect(RideStatus.cancelled.isTerminal, isTrue);
    });

    test('is false for every live stage', () {
      for (final status in [
        RideStatus.pending,
        RideStatus.accepted,
        RideStatus.arrived,
        RideStatus.inProgress,
      ]) {
        expect(status.isTerminal, isFalse, reason: '$status');
      }
    });
  });
}
