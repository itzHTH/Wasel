import 'dart:math';

/// Groups a burst of autocomplete requests and the Place Details call that
/// ends them into one billable Google session.
///
//! The token must survive every keystroke and be passed to Place Details to
//! close the session. Regenerating it per request, or omitting it, silently
//! reverts to per-request billing.
class PlaceSearchSession {
  PlaceSearchSession({Random? random}) : _random = random ?? Random.secure();

  final Random _random;
  String? _token;

  String get token => _token ??= _uuidV4();

  /// Called once the selection is resolved; the next search opens a new session.
  void close() => _token = null;

  String _uuidV4() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final hex = bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
