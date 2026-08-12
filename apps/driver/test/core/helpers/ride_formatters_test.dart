import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RideFormatters.fare', () {
    test('appends the symbol mapped to the currency code', () {
      expect(RideFormatters.fare('12500'), '12,500 د.ع');
    });

    test('honours a currency passed by the caller', () {
      expect(RideFormatters.fare('12500', currency: 'IQD'), '12,500 د.ع');
    });

    test('passes an unmapped currency code through verbatim', () {
      expect(RideFormatters.fare('1200', currency: 'USD'), '1,200 USD');
    });

    test('groups thousands', () {
      expect(RideFormatters.fare('1000000'), '1,000,000 د.ع');
      expect(RideFormatters.fare('999'), '999 د.ع');
    });

    test('keeps the sign on a negative amount', () {
      expect(RideFormatters.fare('-1500'), '-1,500 د.ع');
    });

    test('returns unparseable input unchanged, still with the symbol', () {
      expect(RideFormatters.fare('—'), '— د.ع');
    });
  });
}
