/// Why a location reading could not be produced.
enum LocationFailureReason {
  /// Device location services are switched off entirely. Recoverable, but only
  /// through the OS settings screen — no app-level prompt can fix it.
  serviceDisabled,

  /// The app lacks permission and //? can still ask for it.
  permissionDenied,

  /// The app lacks permission and //! asking again does nothing.
  permissionPermanentlyDenied,

  /// The sensors were reachable but did not settle on a fix in time — a cold
  /// start indoors, //* Retrying is reasonable.
  fixTimeout,

  /// Anything else the platform threw.
  unavailable,
}

/// A location acquisition failure, carrying [reason] so the UI can choose its
/// own copy and recovery action.
///
//?  Why instead of `ApiResults`
///
/// 1. `ErrorHandler.handle` only inspects `DioException`. Every other error —
///    including a GPS timeout or a denied permission — collapses to
///!   `DataSource.defaultError`.
///
/// 2. `ApiResults` cannot express a //!stream* failure,
///    and the position stream is this package's primary output.
class LocationException implements Exception {
  const LocationException(this.reason, [this.cause]);

  final LocationFailureReason reason;

  /// The underlying platform error, kept for logging. Never shown to the user.
  final Object? cause;

  @override
  String toString() => 'LocationException($reason)';
}
