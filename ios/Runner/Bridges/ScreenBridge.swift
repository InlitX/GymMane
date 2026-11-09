import Flutter
import UIKit

enum ScreenBridge {
  private static var savedBrightness: CGFloat?

  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/screen", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        let on = (call.arguments as? [String: Any])?["on"] as? Bool ?? false
        switch call.method {
        case "keepOn":
          UIApplication.shared.isIdleTimerDisabled = on
        case "bright":
          setBrightness(on ? 1 : nil)
        case "dim":
          setBrightness(on ? 0.02 : nil)
        default:
          result(FlutterMethodNotImplemented)
          return
        }
        result(nil)
      }
  }

  private static func setBrightness(_ level: CGFloat?) {
    let screen = UIScreen.main
    if let level = level {
      if savedBrightness == nil { savedBrightness = screen.brightness }
      screen.brightness = level
    } else if let saved = savedBrightness {
      screen.brightness = saved
      savedBrightness = nil
    }
  }
}
