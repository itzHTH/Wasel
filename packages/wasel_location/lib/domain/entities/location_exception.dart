/// Why a location reading could not be produced.
enum LocationFailureReason {
  /// Device location services are switched off entirely. Recoverable, but only
  /// through the OS settings screen — no app-level prompt can fix it.
  serviceDisabled,

  /// The app lacks permission and can still ask for it.
  permissionDenied,

  /// The app lacks permission and asking again does nothing.
  permissionPermanentlyDenied,

  /// The sensors were reachable but did not settle on a fix in time — a cold
  /// start indoors, typically. Retrying is reasonable.
  fixTimeout,

  /// Anything else the platform threw.
  unavailable,
}

/// A location acquisition failure, carrying [reason] so the UI can choose its
/// own copy and recovery action.
///
/// ## Why this is not `ApiResults`
///
/// `CLAUDE.md §B5` puts data-layer failures behind `ApiResults` /
/// `ErrorHandler`, and the geocoding and route repositories in this package
/// follow that to the letter — they are HTTP calls, which is exactly what that
/// contract was built for. Device location is not, and forcing it through the
/// same pipe loses information:
///
/// 1. `ErrorHandler.handle` only inspects `DioException`. Every other error —
///    including a GPS timeout or a denied permission — collapses to
///    `DataSource.defaultError`, one generic Arabic message. The four cases
///    above would arrive at the UI indistinguishable from one another.
/// 2. The rider app already needs them distinguished. `centerOnUserLocation`
///    picks between three different snackbars (services off + settings action,
///    fix timed out, generic failure) plus a silent path for a permanently
///    denied permission. That branching is only possible with a typed reason.
/// 3. `ApiResults` cannot express a *stream* failure, and the position stream is
///    this package's primary output. A repo split half between `ApiResults` and
///    raw stream errors would be less coherent than one that consistently
///    signals location failures with a typed exception.
///
/// Riverpod carries these natively: a throwing future or an errored stream
/// becomes `AsyncError`, and the UI pattern-matches on [reason] to pick copy.
class LocationException implements Exception {
  const LocationException(this.reason, [this.cause]);

  final LocationFailureReason reason;

  /// The underlying platform error, kept for logging. Never shown to the user.
  final Object? cause;

  @override
  String toString() => 'LocationException($reason)';
}
