import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/dio/secret_paths.dart';

void main() {
  group('ApiSecretPaths.carries', () {
    test('covers every path that carries credentials or card data', () {
      const secret = [
        '/api/v1/Payments/tokenize',
        '/api/v1/Auth/login',
        '/api/v1/Auth/reset-password',
        '/api/v1/Auth/refresh-token',
        '/api/v1/Auth/revoke-token',
        '/api/v1/Auth/rider/complete-registration',
        '/api/v1/Auth/driver/complete-registration',
      ];

      for (final path in secret) {
        expect(ApiSecretPaths.carries(path), isTrue, reason: path);
      }
    });

    test('leaves ordinary endpoints loggable', () {
      const loggable = [
        '/api/v1/profile/rider',
        '/api/v1/profile/driver',
        '/api/v1/Rides/history',
        '/api/v1/DriverEarnings/overview',
        '/api/v1/wallet/driver/balance',
      ];

      for (final path in loggable) {
        expect(ApiSecretPaths.carries(path), isFalse, reason: path);
      }
    });
  });
}
