import Flutter

enum Bridges {
  static func register(with messenger: FlutterBinaryMessenger) {
    GalleryBridge.register(with: messenger)
    ScreenBridge.register(with: messenger)
    LiveActivityBridge.register(with: messenger)
    DeviceBridge.register(with: messenger)
    VoiceBridge.register(with: messenger)
    IncomingBridge.register(with: messenger)
    HealthBridge.register(with: messenger)
  }
}
