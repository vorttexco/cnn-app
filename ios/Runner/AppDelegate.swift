import UIKit
import Flutter
import Firebase
import MDMCore
import MDMNotification

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "mdm_notification_channel"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
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
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
    MDMCore.setDebugMode(true)

    let appId = "jmDLWQt0JAVA1iqY6J8MXRAoDY6wWQW1Wph1G3xV/AgrmkEaAiix3FLEk80xUI89BOh9FxFLqvyzR2ITK5zpN8kBhl5eHOTTFbGr+FaZwFEt0TFYMXbfXQnUwWQubpdwFAyQUA4Xjwz0J/4IP2R7si9cm+IporvUVRSyK2brIsBCBCsiOrJPw/FBcv69wmDBe2OxD9sN/VdjUL8eEk8EpIxg8obeF5Hqy5/0qEKCIhlN/TF9HTT1ugAvUUIYTn4YzcmcsrKQML0SaEv90OjH0CxSD6KI46LUM87ijd5ZLYadlzwzeeZ6lB4N4HPHbsQSa2exZ6Jrp0tZsWuWFS6J4Q=="

    MDMCore.start(withAppId: appId, kitModules: [
      MDMNotification.self()
    ])

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
