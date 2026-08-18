import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';

/// Single owner of the stored auth session: the access token, the refresh
/// token, and the refresh token's expiry.
abstract final class SessionStore {
  /// Absorbs small differences between device and server clocks.
  static const Duration clockSkew = Duration(seconds: 30);

  static Future<void> save({
    required String token,
    required String refreshToken,
    DateTime? refreshTokenExpiration,
  }) async {
    await AppLocalCache.setSecuredString(AppConstants.tokenKey, token);
    await AppLocalCache.setSecuredString(
      AppConstants.refreshTokenKey,
      refreshToken,
    );

    // Clearing is as important as writing: a stale expiry left behind by a
    // refresh that omitted the field would expire a live session.
    if (refreshTokenExpiration == null) {
      await AppLocalCache.removeSecuredData(
        AppConstants.refreshTokenExpirationKey,
      );
    } else {
      await AppLocalCache.setSecuredString(
        AppConstants.refreshTokenExpirationKey,
        refreshTokenExpiration.toUtc().toIso8601String(),
      );
    }
  }

  /// Bumped on every [clear] so in-flight requests issued under a previous
  /// sign-in can be told apart from ones that merely need a token refresh.
  static int get epoch => _epoch;
  static int _epoch = 0;

  static Future<void> clear() async {
    _epoch++;
    await AppLocalCache.clearSession();
  }

  /// Empty is treated as absent so callers never have to check for both.
  static Future<String?> readToken() => _readNonEmpty(AppConstants.tokenKey);

  static Future<String?> readRefreshToken() =>
      _readNonEmpty(AppConstants.refreshTokenKey);

  static Future<String?> _readNonEmpty(String key) async {
    final value = await AppLocalCache.getSecuredString(key);
    return value == null || value.isEmpty ? null : value;
  }

  static Future<DateTime?> readRefreshTokenExpiration() async {
    final raw = await AppLocalCache.getSecuredString(
      AppConstants.refreshTokenExpirationKey,
    );
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw)?.toUtc();
  }

  /// A session with no stored expiry is treated as valid so users signed in
  /// before this key existed are not logged out by an update.
  static Future<bool> isRefreshTokenExpired() async {
    final expiry = await readRefreshTokenExpiration();
    if (expiry == null) return false;

    return !DateTime.now().toUtc().isBefore(expiry.subtract(clockSkew));
  }

  static Future<bool> hasUsableSession() async {
    if (await readToken() == null) return false;
    if (await readRefreshToken() == null) return false;

    return !await isRefreshTokenExpired();
  }
}
