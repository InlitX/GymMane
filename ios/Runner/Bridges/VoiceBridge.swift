import AVFoundation
import Flutter
import UIKit

final class VoiceBridge: NSObject, AVSpeechSynthesizerDelegate {
  private static let shared = VoiceBridge()

  private let synthesizer = AVSpeechSynthesizer()
  private var waiting: FlutterResult?
  private var waitingUtterance: AVSpeechUtterance?

  static func register(with messenger: FlutterBinaryMessenger) {
    shared.synthesizer.delegate = shared
    FlutterMethodChannel(name: "gymmane/voice", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        shared.handle(call, result)
      }
  }

  private func handle(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    let text = args?["text"] as? String ?? ""
    let lang = args?["lang"] as? String ?? ""
    switch call.method {
    case "say":
      if !text.isEmpty { speak(text, lang) }
      result(true)
    case "sayWait":
      release(false)
      guard !text.isEmpty else {
        result(false)
        return
      }
      waiting = result
      waitingUtterance = speak(text, lang)
    case "stop":
      synthesizer.stopSpeaking(at: .immediate)
      release(false)
      result(true)
    case "check":
      result(lang.isEmpty || voice(for: lang) != nil ? "ok" : "noLang")
    case "settings":
      guard let url = URL(string: UIApplication.openSettingsURLString) else {
        result(false)
        return
      }
      UIApplication.shared.open(url) { result($0) }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @discardableResult
  private func speak(_ text: String, _ lang: String) -> AVSpeechUtterance {
    if synthesizer.isSpeaking { synthesizer.stopSpeaking(at: .immediate) }
    let session = AVAudioSession.sharedInstance()
    try? session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
    try? session.setActive(true)
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = voice(for: lang)
    synthesizer.speak(utterance)
    return utterance
  }

  private func voice(for lang: String) -> AVSpeechSynthesisVoice? {
    let tag = lang.replacingOccurrences(of: "_", with: "-")
    if let exact = AVSpeechSynthesisVoice(language: tag) { return exact }
    let base = tag.split(separator: "-").first.map(String.init) ?? tag
    return AVSpeechSynthesisVoice.speechVoices().first { $0.language.hasPrefix(base) }
  }

  private func release(_ finished: Bool) {
    waiting?(finished)
    waiting = nil
    waitingUtterance = nil
  }

  private func finish(_ utterance: AVSpeechUtterance, finished: Bool) {
    if utterance === waitingUtterance { release(finished) }
    if !synthesizer.isSpeaking {
      try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
  }

  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    finish(utterance, finished: true)
  }

  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
    finish(utterance, finished: false)
  }
}
