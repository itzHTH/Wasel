import 'dart:ui';

/// Alert and availability tokens. These carry universal meaning (error is red,
/// online is green) so both brands share one ramp rather than tinting them.
class AlertTokens {
  AlertTokens._();

  //Light
  static const Color info100Light = Color(0xFFE3EDFD);
  static const Color info500Light = Color(0xFF2563EB);
  static const Color success100Light = Color(0xFFDEF7E9);
  static const Color success500Light = Color(0xFF15803D);
  static const Color warning100Light = Color(0xFFFEF3D3);
  static const Color warning500Light = Color(0xFFA16207);
  static const Color error100Light = Color(0xFFFDE4E2);
  static const Color error500Light = Color(0xFFC1231D);
  static const Color error700Light = Color(0xFF991B1B);
  static const Color onlineLight = Color(0xFF059669);
  static const Color offlineLight = Color(0xFF64748B);

  // Dark
  static const Color info100Dark = Color(0xFF17233B);
  static const Color info500Dark = Color(0xFF7DA9F5);
  static const Color success100Dark = Color(0xFF14281C);
  static const Color success500Dark = Color(0xFF5FD98B);
  static const Color warning100Dark = Color(0xFF2B2312);
  static const Color warning500Dark = Color(0xFFF0C14B);
  static const Color error100Dark = Color(0xFF3A1A18);
  static const Color error500Dark = Color(0xFFFF8A80);
  static const Color error700Dark = Color(0xFFFFB4AB);
  static const Color onlineDark = Color(0xFF34D399);
  static const Color offlineDark = Color(0xFF7B8B98);

  // Media overlays (identical in both modes)
  static const Color scrim = Color(0xFF0B0F14);
  static const Color onScrim = Color(0xFFFFFFFF);
}
