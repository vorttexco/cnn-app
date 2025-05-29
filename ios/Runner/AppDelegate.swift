import UIKit
import Flutter
import MDMCore
import MDMNotification

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "mdm_notification_channel"
  private var notificationCenter = UNUserNotificationCenter.current()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {   

    MDMCore.setDebugMode(true)

    let appId = "jmDLWQt0JAVA1iqY6J8MXRAoDY6wWQW1Wph1G3xV/AgrmkEaAiix3FLEk80xUI89BOh9FxFLqvyzR2ITK5zpN8kBhl5eHOTTFbGr+FaZwFEt0TFYMXbfXQnUwWQubpdwFAyQUA4Xjwz0J/4IP2R7si9cm+IporvUVRSyK2brIsBCBCsiOrJPw/FBcv69wmDBe2OxD9sN/VdjUL8eEk8EpIxg8obeF5Hqy5/0qEKCIhlN/TF9HTT1ugAvUUIYTn4YzcmcsrKQML0SaEv90OjH0CxSD6KI46LUM87ijd5ZLYadlzwzeeZ6lB4N4HPHbsQSa2exZ6Jrp0tZsWuWFS6J4Q=="

    MDMCore.start(withAppId: appId, kitModules: [
      MDMNotification.self()
    ])

    self.notificationCenter = UNUserNotificationCenter.current()
    self.notificationCenter.delegate = self
    self.notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        if granted {
            OperationQueue.main.addOperation({
                if !UIApplication.shared.isRegisteredForRemoteNotifications {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        }
    }

    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("Root view controller is not a FlutterViewController")
    }

    let methodChannel = FlutterMethodChannel(
      name: CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )

    methodChannel.setMethodCallHandler { call, result in
      guard let args = call.arguments as? [String: Any] else {
        result(FlutterError(code: "INVALID_ARGUMENTS",
                            message: "Expected map",
                            details: nil))
        return
      }
      Task {
        switch call.method {
        case "isMDMNotification":
          let isMDM = await MDMNotification.isMDMNotification(args)
          result(isMDM)
        case "processMDMNotification":
          await MDMNotification.processNotification(args)
          result(nil)
        case "getManagedConfig":
          if let managedConfig = UserDefaults.standard.dictionary(forKey: "com.apple.configuration.managed") {
            result(managedConfig)
          } else {
            result([:])
          }
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    MDMNotification.registerToken(deviceToken)
  }

  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    MDMNotification.unregisterToken()
  }
}

extension AppDelegate {
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if MDMNotification.isMDMNotification(userInfo) {
            MDMNotification.receive(userInfo)
        } else {
            // Process your notification here
        }
        completionHandler();
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if MDMNotification.isMDMNotification(userInfo) {
            MDMNotification.processNotification(userInfo, completionBlock: completionHandler)
        } else {
            // Open your notification here
        }
    }
}