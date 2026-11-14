import Flutter
import UIKit

enum AppIconBridge {
  private static let prefix = "AppIcon-"

  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/app_icon", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        switch call.method {
        case "current":
          guard UIApplication.shared.supportsAlternateIcons else {
            result(FlutterError(code: "unsupported", message: nil, details: nil))
            return
          }
          let name = UIApplication.shared.alternateIconName ?? ""
          result(name.hasPrefix(prefix) ? String(name.dropFirst(prefix.count)) : "default")
        case "set":
          let id = (call.arguments as? [String: Any])?["name"] as? String ?? "default"
          let target: String? = id == "default" ? nil : prefix + id
          guard UIApplication.shared.alternateIconName != target else {
            result(true)
            return
          }
          UIApplication.shared.setAlternateIconName(target) { error in
            DispatchQueue.main.async { result(error == nil) }
          }
        default:
          result(FlutterMethodNotImplemented)
        }
      }
  }
}
