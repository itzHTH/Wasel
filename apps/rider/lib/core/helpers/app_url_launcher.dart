import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  /// Opens a URL in the external app (e.g. Play Store / App Store)
  static Future<void> launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
