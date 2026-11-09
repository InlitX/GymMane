import Flutter
import Photos

enum GalleryBridge {
  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/gallery", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        guard call.method == "savePng" else {
          result(FlutterMethodNotImplemented)
          return
        }
        guard let args = call.arguments as? [String: Any],
              let bytes = args["bytes"] as? FlutterStandardTypedData
        else {
          result(FlutterError(code: "no-bytes", message: "missing image", details: nil))
          return
        }
        save(png: bytes.data) { saved, error in
          if let error = error {
            result(FlutterError(code: "save-failed", message: error.localizedDescription, details: nil))
          } else {
            result(saved)
          }
        }
      }
  }

  private static func save(png: Data, completion: @escaping (Bool, Error?) -> Void) {
    let finish: (Bool, Error?) -> Void = { saved, error in
      DispatchQueue.main.async { completion(saved, error) }
    }
    PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
      guard status == .authorized || status == .limited else {
        finish(false, nil)
        return
      }
      PHPhotoLibrary.shared().performChanges({
        let request = PHAssetCreationRequest.forAsset()
        request.addResource(with: .photo, data: png, options: nil)
      }, completionHandler: finish)
    }
  }
}
