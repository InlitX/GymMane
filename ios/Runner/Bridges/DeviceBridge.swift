import AVFoundation
import Flutter
import UIKit

enum DeviceBridge {
  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/device", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        switch call.method {
        case "isWatch":
          result(false)
        case "headphones":
          result(headphonesConnected())
        case "isLowEnd":
          result(ProcessInfo.processInfo.physicalMemory < 3_500_000_000)
        case "maxRefresh":
          result(Double(UIScreen.main.maximumFramesPerSecond))
        case "groupDir":
          result(FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.gymmane.app")?.path)
        case "setHighRefresh":
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }

    FlutterMethodChannel(name: "gymmane/haptics", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        guard call.method == "buzz" else {
          result(FlutterMethodNotImplemented)
          return
        }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        result(nil)
      }
  }

  private static func headphonesConnected() -> Bool {
    let wired: [AVAudioSession.Port] = [.headphones, .bluetoothA2DP, .bluetoothHFP, .bluetoothLE, .usbAudio, .airPlay]
    return AVAudioSession.sharedInstance().currentRoute.outputs.contains { wired.contains($0.portType) }
  }
}
