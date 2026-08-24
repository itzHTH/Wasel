class AppFonts {
  AppFonts._();

  /// A package-declared family needs the `packages/<name>/` prefix to resolve
  /// from the apps that depend on it.
  ///
  /// Cairo rather than Readex Pro: the copy is Iraqi dialect and uses گ
  /// (U+06AF), which Readex Pro does not carry. A fallback font cannot rescue
  /// it — Arabic joining is resolved per font run, so the word would break.
  static const String family = 'packages/wasel_core/Cairo';

  /// Cairo has no `tnum` and proportional digits, so a value that updates in
  /// place visibly shifts. Live numerals use this fixed-width family instead —
  /// every digit and separator is one 600-unit advance.
  static const String numeralFamily = 'packages/wasel_core/IBMPlexMono';

  /// Cairo's glyph ink spans 1.514 em, so both values clear it. Anything
  /// under that lets consecutive lines collide.
  static const double bodyHeight = 1.7;

  static const double headingHeight = 1.55;
}
