import AppIntents
import SwiftUI
import WidgetKit

private let group = "group.com.gymmane.app"
private let pendingKey = "nutri_pending"
private let openURL = URL(string: "gymmane://nutrition")

private func stamp(_ date: Date) -> String {
  let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
  return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
}

struct VesselEntry: TimelineEntry {
  let date: Date
  let on: Bool
  let value: Int
  let goal: Int
  let step: Int
  let mode: String
  let decimal: String
  let geo: [CGFloat]
  let base: UIImage?
  let baseNight: UIImage?
  let liquid: UIImage?
  let tone: Color?
  let toneNight: Color?
  let text: Color?
  let textNight: Color?
  let done: Color?
  let doneNight: Color?
  let dark: Bool
  let followsSystem: Bool
  let prefix: String

  var ready: Bool { on && liquid != nil && geo.count >= 9 }
  var level: CGFloat { goal <= 0 ? 0 : min(1, max(0, CGFloat(value) / CGFloat(goal))) }

  var label: String {
    switch mode {
    case "L":
      let tenths = Int((Double(value) / 100).rounded())
      if tenths % 10 == 0 { return "\(tenths / 10)" }
      return String(format: "%.1f", Double(tenths) / 10).replacingOccurrences(of: ".", with: decimal)
    case "oz":
      return "\(Int((Double(value) / 29.5735).rounded()))"
    default:
      return "\(value)"
    }
  }
}

struct VesselProvider: TimelineProvider {
  let prefix: String

  func placeholder(in context: Context) -> VesselEntry {
    entry(at: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (VesselEntry) -> Void) {
    completion(entry(at: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<VesselEntry>) -> Void) {
    let calendar = Calendar.current
    let start = calendar.startOfDay(for: Date())
    var entries = [entry(at: Date())]
    for offset in 1...7 {
      if let next = calendar.date(byAdding: .day, value: offset, to: start) {
        entries.append(entry(at: next))
      }
    }
    completion(Timeline(entries: entries, policy: .atEnd))
  }

  private func entry(at date: Date) -> VesselEntry {
    let defaults = UserDefaults(suiteName: group)
    let number = { (key: String) in Int(defaults?.string(forKey: "\(prefix)_\(key)") ?? "") ?? 0 }
    let step = number("step")
    let today = stamp(date)
    var value = defaults?.string(forKey: "nutri_day") == today ? number("value") : 0
    let kind = prefix == "water" ? "w" : "s"
    for item in (defaults?.string(forKey: pendingKey) ?? "").split(separator: ";") {
      let p = item.split(separator: ",", omittingEmptySubsequences: false)
      guard p.count == 3, p[0] == kind, let ms = Double(p[1]) else { continue }
      guard stamp(Date(timeIntervalSince1970: ms / 1000)) == today else { continue }
      value += kind == "w" ? Int(p[2]) ?? 0 : step
    }
    let images = ImageProvider(key: "\(prefix)_base")
    let count = number("frames_n")
    let level = number("goal") <= 0 ? 0 : min(1, max(0, Double(value) / Double(number("goal"))))
    let theme = defaults?.string(forKey: "widget_theme")
    let followsSystem = theme == "system"
    return VesselEntry(
      date: date,
      on: defaults?.string(forKey: "nutri_on") == "1",
      value: value,
      goal: number("goal"),
      step: step,
      mode: defaults?.string(forKey: "\(prefix)_mode") ?? "g",
      decimal: defaults?.string(forKey: "nutri_dec") ?? ".",
      geo: (defaults?.string(forKey: "nutri_geo") ?? "").split(separator: ",").compactMap { Double($0) }.map { CGFloat($0) },
      base: images.loadImage(defaults, name: "\(prefix)_base"),
      baseNight: followsSystem ? images.loadImage(defaults, name: "\(prefix)_base_night") : nil,
      liquid: count > 0 ? frame(Int((level * Double(count)).rounded())) : nil,
      tone: Color(hex: defaults?.string(forKey: "\(prefix)_tone")),
      toneNight: Color(hex: defaults?.string(forKey: "\(prefix)_tone_night")),
      text: Color(hex: defaults?.string(forKey: "nutri_text")),
      textNight: Color(hex: defaults?.string(forKey: "nutri_text_night")),
      done: Color(hex: defaults?.string(forKey: "nutri_done")),
      doneNight: Color(hex: defaults?.string(forKey: "nutri_done_night")),
      dark: (defaults?.object(forKey: "widget_dark") as? Bool) ?? true,
      followsSystem: followsSystem,
      prefix: prefix)
  }

  private func frame(_ index: Int) -> UIImage? {
    guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: group) else {
      return nil
    }
    let url = container.appendingPathComponent("home_widget/frames/\(prefix)_\(index).png")
    return UIImage(contentsOfFile: url.path)
  }
}

struct VesselWidgetView: View {
  let entry: VesselEntry
  @Environment(\.colorScheme) private var scheme

  private var night: Bool {
    entry.followsSystem ? scheme == .dark : entry.dark
  }

  private var base: UIImage? {
    night && entry.followsSystem ? (entry.baseNight ?? entry.base) : entry.base
  }

  var body: some View {
    Group {
      if let image = base {
        picture(image)
      } else {
        EmptyState(dark: night)
      }
    }
    .widgetBackground(Palette.raised(night))
    .widgetURL(openURL)
  }

  private func picture(_ image: UIImage) -> some View {
    GeometryReader { box in
      let aspect = image.size.width / max(image.size.height, 1)
      let width = min(box.size.width, box.size.height * aspect)
      let height = width / aspect
      ZStack(alignment: .topLeading) {
        Image(uiImage: image)
          .resizable()
          .frame(width: width, height: height)
        if entry.ready {
          vessel(width: width, height: height)
          add(width: width, height: height)
        }
      }
      .frame(width: width, height: height)
      .position(x: box.size.width / 2, y: box.size.height / 2)
    }
  }

  @ViewBuilder
  private func vessel(width: CGFloat, height: CGFloat) -> some View {
    let g = entry.geo
    let finished = entry.goal > 0 && entry.value >= entry.goal
    let tone = (night && entry.followsSystem ? entry.toneNight : entry.tone) ?? .white
    let done = (night && entry.followsSystem ? entry.doneNight : entry.done) ?? tone
    let ink = (night && entry.followsSystem ? entry.textNight : entry.text) ?? Palette.text(night)
    let room = g[6] * width
    let fill = room * entry.level
    let thick = g[8] * height

    if let liquid = entry.liquid {
      let top = g[1] * height
      let tall = g[2] * height
      Image(uiImage: liquid)
        .resizable()
        .frame(width: tall * liquid.size.width / max(liquid.size.height, 1), height: tall)
        .offset(x: g[0] * width, y: top)
    }

    Text(entry.label)
      .font(.system(size: g[5] * height, weight: .heavy, design: .rounded))
      .foregroundColor(finished ? done : ink)
      .lineLimit(1)
      .minimumScaleFactor(0.4)
      .frame(width: room, alignment: .leading)
      .alignmentGuide(.top) { $0[.firstTextBaseline] }
      .offset(x: g[3] * width, y: g[4] * height)

    if fill > 0.5 {
      Capsule()
        .fill(finished ? done : tone)
        .frame(width: max(fill, thick), height: thick)
        .offset(x: g[3] * width, y: g[7] * height)
    }
  }

  @ViewBuilder
  private func add(width: CGFloat, height: CGFloat) -> some View {
    if #available(iOS 17.0, *) {
      if entry.step > 0 {
        Button(intent: AddNutritionIntent(prefix: entry.prefix)) {
          Color.clear
            .frame(width: width, height: height * 0.32)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .offset(y: height * 0.68)
      }
    }
  }
}

@available(iOS 17.0, *)
struct AddNutritionIntent: AppIntent {
  static let title: LocalizedStringResource = "widget_add"
  static let isDiscoverable = false

  @Parameter(title: "prefix")
  var prefix: String

  init() {}

  init(prefix: String) {
    self.prefix = prefix
  }

  func perform() async throws -> some IntentResult {
    guard let defaults = UserDefaults(suiteName: group), defaults.string(forKey: "nutri_on") == "1" else {
      return .result()
    }
    let step = Int(defaults.string(forKey: "\(prefix)_step") ?? "") ?? 0
    guard step > 0 else { return .result() }
    let now = Int(Date().timeIntervalSince1970 * 1000)
    let entry = prefix == "water"
      ? "w,\(now),\(step)"
      : "s,\(now),\(defaults.string(forKey: "\(prefix)_food") ?? "")"
    let pending = defaults.string(forKey: pendingKey) ?? ""
    defaults.set(pending.isEmpty ? entry : "\(pending);\(entry)", forKey: pendingKey)
    WidgetCenter.shared.reloadAllTimelines()
    return .result()
  }
}

struct KcalProvider: TimelineProvider {
  private let images = ImageProvider(key: "kcal_img")

  func placeholder(in context: Context) -> ImageEntry {
    entry(at: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ImageEntry) -> Void) {
    completion(entry(at: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ImageEntry>) -> Void) {
    let calendar = Calendar.current
    let start = calendar.startOfDay(for: Date())
    var entries = [entry(at: Date())]
    for offset in 1...7 {
      if let next = calendar.date(byAdding: .day, value: offset, to: start) {
        entries.append(entry(at: next))
      }
    }
    completion(Timeline(entries: entries, policy: .atEnd))
  }

  private func entry(at date: Date) -> ImageEntry {
    let defaults = UserDefaults(suiteName: group)
    let fresh = defaults?.string(forKey: "nutri_day") != stamp(date)
    let entry = images.load(fresh ? "kcal_fresh_img" : "kcal_img", at: date)
    return entry.image == nil ? images.load(at: date) : entry
  }
}

struct WaterWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "WaterWidget", provider: VesselProvider(prefix: "water")) { entry in
      VesselWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_water_name")
    .description("widget_water_desc")
    .supportedFamilies([.systemSmall])
    .edgeToEdge()
  }
}

struct ProteinWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "ProteinWidget", provider: VesselProvider(prefix: "protein")) { entry in
      VesselWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_protein_name")
    .description("widget_protein_desc")
    .supportedFamilies([.systemSmall])
    .edgeToEdge()
  }
}

struct KcalWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "KcalWidget", provider: KcalProvider()) { entry in
      ImageWidgetView(entry: entry).widgetURL(openURL)
    }
    .configurationDisplayName("widget_kcal_name")
    .description("widget_kcal_desc")
    .supportedFamilies([.systemMedium])
    .edgeToEdge()
  }
}
