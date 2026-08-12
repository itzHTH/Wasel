/// Whether the app may read the device location, and if not, why.
///
/// Richer than the rider app's current two-value enum on purpose. The rider
/// already needs the third case and reconstructs it by reaching past its own
/// abstraction — after a denied request it calls `Permission.location.status`
/// again just to check `isPermanentlyDenied`, because a permanently denied
/// permission must show the settings dialog instead of a "try again" prompt.
/// Modelling that case here removes the second lookup.
enum LocationAccess {
  /// Granted outright, or granted with reduced (`limited`) precision — both
  /// mean a fix can be requested, which is all callers need to decide.
  granted,

  /// Refused for now. The OS will still show a prompt if asked again.
  denied,

  /// Refused for good, or blocked by device policy. Asking again is a no-op —
  /// the only way forward is deep-linking the user into app settings.
  permanentlyDenied;

  bool get isGranted => this == LocationAccess.granted;

  /// True when re-requesting would silently fail, so the UI must offer the
  /// settings route rather than another prompt.
  bool get needsSettings => this == LocationAccess.permanentlyDenied;
}
