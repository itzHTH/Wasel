import Flutter
import UIKit
import GoogleMaps
import flutter_foreground_task
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   // Flutter Foreground Task
    SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // Flutter Local Notifications
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    // User Notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    if let key = Bundle.main.object(forInfoDictionaryKey: "MapsApiKey") as? String {
      GMSServices.provideAPIKey(key)
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
