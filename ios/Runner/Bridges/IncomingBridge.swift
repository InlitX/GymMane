import Flutter
import UIKit

enum IncomingBridge {
  static let startWorkoutType = "com.gymmane.app.start"

  private static var incoming: FlutterMethodChannel?
  private static var openChannel: FlutterMethodChannel?
  private static var pendingText: String?
  private static var pendingRoute: String?
  private static var textReady = false
  private static var routeReady = false

  static func register(with messenger: FlutterBinaryMessenger) {
    let incomingChannel = FlutterMethodChannel(name: "gymmane/incoming", binaryMessenger: messenger)
    incomingChannel.setMethodCallHandler { call, result in
      guard call.method == "take" else {
        result(FlutterMethodNotImplemented)
        return
      }
      textReady = true
      result(pendingText)
      pendingText = nil
    }
    incoming = incomingChannel

    let channel = FlutterMethodChannel(name: "gymmane/open", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      guard call.method == "take" else {
        result(FlutterMethodNotImplemented)
        return
      }
      routeReady = true
      result(pendingRoute)
      pendingRoute = nil
    }
    openChannel = channel
  }

  static func receive(url: URL) {
    if url.scheme == "gymmane" {
      if let route = url.host, !route.isEmpty { open(route) }
      return
    }
    guard let text = read(url) else { return }
    if textReady {
      incoming?.invokeMethod("incoming", arguments: text)
    } else {
      pendingText = text
    }
  }

  static func receive(shortcut: UIApplicationShortcutItem) {
    guard shortcut.type == startWorkoutType else { return }
    open("play")
  }

  private static func open(_ route: String) {
    if routeReady {
      openChannel?.invokeMethod("open", arguments: route)
    } else {
      pendingRoute = route
    }
  }

  private static func read(_ url: URL) -> String? {
    let scoped = url.startAccessingSecurityScopedResource()
    defer {
      if scoped { url.stopAccessingSecurityScopedResource() }
    }
    return try? String(contentsOf: url, encoding: .utf8)
  }
}
