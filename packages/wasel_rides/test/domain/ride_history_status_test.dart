import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_rides/domain/entities/ride_history_status.dart';

void main() {
  group('RideHistoryStatus.fromApi', () {
    test('reads the Arabic cancelled wording the API actually sends', () {
      // Regression: the API answers "ملغية" (ي) while the parser only knew
      // "ملغاة" (ا), so every cancelled ride rendered as unknown.
      expect(RideHistoryStatus.fromApi('ملغية'), RideHistoryStatus.cancelled);
    });

    test('reads the other Arabic cancelled spellings', () {
      expect(RideHistoryStatus.fromApi('ملغاة'), RideHistoryStatus.cancelled);
      expect(RideHistoryStatus.fromApi('ملغي'), RideHistoryStatus.cancelled);
    });

    test('reads the Arabic completed wording', () {
      expect(RideHistoryStatus.fromApi('مكتملة'), RideHistoryStatus.completed);
      expect(RideHistoryStatus.fromApi('مكتمل'), RideHistoryStatus.completed);
    });

    test('reads the English wording in either spelling', () {
      expect(
        RideHistoryStatus.fromApi('Completed'),
        RideHistoryStatus.completed,
      );
      expect(
        RideHistoryStatus.fromApi('Cancelled'),
        RideHistoryStatus.cancelled,
      );
      expect(
        RideHistoryStatus.fromApi('canceled'),
        RideHistoryStatus.cancelled,
      );
    });

    test('tolerates surrounding whitespace', () {
      expect(
        RideHistoryStatus.fromApi('  ملغية '),
        RideHistoryStatus.cancelled,
      );
    });

    test('falls back to unknown for a missing or unrecognised value', () {
      expect(RideHistoryStatus.fromApi(null), RideHistoryStatus.unknown);
      expect(RideHistoryStatus.fromApi(''), RideHistoryStatus.unknown);
      expect(RideHistoryStatus.fromApi('Pending'), RideHistoryStatus.unknown);
    });
  });
}
