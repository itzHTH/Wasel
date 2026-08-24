class AppFonts {
  AppFonts._();

  /// A package-declared family needs the `packages/<name>/` prefix to resolve
  /// from the apps that depend on it.
  static const String family = 'packages/wasel_core/ReadexPro';

  /// Readex Pro has no `tnum` and proportional digits, so a value that updates
  /// in place visibly shifts. Live numerals use this fixed-width family
  /// instead — every digit and separator is one 600-unit advance.
  static const String numeralFamily = 'packages/wasel_core/IBMPlexMono';

  /// Arabic descenders run deeper than Latin ones; the 1.5 default clips them.
  static const double bodyHeight = 1.7;

  static const double headingHeight = 1.45;
}
