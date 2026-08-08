import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fare', () {
    test('groups thousands and appends the iraqi dinar symbol', () {
      expect(RideFormatters.fare('12500'), '12,500 د.ع');
    });

    test('groups values above a million', () {
      expect(RideFormatters.fare('1234567'), '1,234,567 د.ع');
    });

    test('leaves values under a thousand ungrouped', () {
      expect(RideFormatters.fare('750'), '750 د.ع');
    });

    test('rounds fractional amounts', () {
      expect(RideFormatters.fare('12500.6'), '12,501 د.ع');
    });

    test('keeps the sign on negative amounts', () {
      expect(RideFormatters.fare('-12500'), '-12,500 د.ع');
    });

    test('falls back to the raw text when the amount is not a number', () {
      expect(RideFormatters.fare('n/a'), 'n/a د.ع');
    });

    test('uses the currency code when there is no symbol for it', () {
      expect(RideFormatters.fare('1000', currency: 'USD'), '1,000 USD');
    });
  });

  group('distance', () {
    test('renders one decimal place with the kilometre suffix', () {
      expect(RideFormatters.distance('3.456'), '3.5 كم');
    });

    test('falls back to the raw text when the distance is not a number', () {
      expect(RideFormatters.distance('far'), 'far كم');
    });
  });

  group('coordinates', () {
    test('renders five decimals separated by an arabic comma', () {
      expect(RideFormatters.coordinates(33.3152, 44.3661), '33.31520، 44.36610');
    });
  });
}
