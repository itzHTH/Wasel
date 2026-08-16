/// Whether the app may read the device location, and if not, why.
enum LocationAccess {
  /// Granted outright, or granted with reduced (`limited`) precision — both
  /// mean a fix can be requested, which is all callers need to decide.
  granted,

  /// Refused for now. //* The OS will still show a prompt if asked again.
  denied,

  /// Refused for good, or blocked by device policy. Asking again is a no-op —
  /// the only way forward is deep-linking the user into app settings.
  permanentlyDenied;

  bool get isGranted => this == LocationAccess.granted;

  /// True when re-requesting would silently fail, //! so the UI must offer the
  //! settings route rather than another prompt.
  bool get needsSettings => this == LocationAccess.permanentlyDenied;
}
