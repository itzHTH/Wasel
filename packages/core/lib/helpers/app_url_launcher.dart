import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  /// Opens a URL in the external app (e.g. Play Store / App Store)
  static Future<void> launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Opens the phone dialer with [phoneNumber] prefilled.
  ///
  /// Whitespace is stripped because a `tel:` path percent-encodes it, and
  /// dialers reject the encoded form.
  static Future<void> dial(String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(RegExp(r'\s'), ''),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Opens a URL inside an in-app web view
  static Future<void> launchInApp(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }
}
