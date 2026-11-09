import SwiftUI
import WidgetKit

private let appGroup = "group.com.gymmane.app"
private let darkKey = "widget_dark"
private let themeKey = "widget_theme"

struct DayRing {
  let index: Int
  let geo: [CGFloat]
  let color: Color?
  let nightColor: Color?
}

struct ImageEntry: TimelineEntry {
  let date: Date
  let image: UIImage?
  let nightImage: UIImage?
  let dark: Bool
  let followsSystem: Bool
  var ring: DayRing? = nil
}

struct ImageProvider: TimelineProvider {
  let key: String

  func placeholder(in context: Context) -> ImageEntry {
    load()
  }

  func getSnapshot(in context: Context, completion: @escaping (ImageEntry) -> Void) {
    completion(load())
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ImageEntry>) -> Void) {
    completion(Timeline(entries: [load()], policy: .never))
  }

  func load(_ file: String? = nil, at date: Date = Date()) -> ImageEntry {
    let name = file ?? key
    let defaults = UserDefaults(suiteName: appGroup)
    let dark = (defaults?.object(forKey: darkKey) as? Bool) ?? true
    let followsSystem = defaults?.string(forKey: themeKey) == "system"
    return ImageEntry(
      date: date,
      image: loadImage(defaults, name: name),
      nightImage: followsSystem ? loadImage(defaults, name: "\(name)_night") : nil,
      dark: dark,
      followsSystem: followsSystem)
  }

  func loadImage(_ defaults: UserDefaults?, name: String) -> UIImage? {
    if let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) {
      let url = container.appendingPathComponent("home_widget/\(name).png")
      if let image = UIImage(contentsOfFile: url.path) {
        return image
      }
    }
    if let path = defaults?.string(forKey: name) {
      return UIImage(contentsOfFile: path)
    }
    return nil
  }
}

private func dayStamp(_ date: Date) -> String {
  let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
  return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
}

private func weekdayIndex(_ date: Date) -> Int {
  (Calendar.current.component(.weekday, from: date) + 5) % 7
}

private func midnights(from now: Date, _ make: (Date) -> ImageEntry) -> Timeline<ImageEntry> {
  let calendar = Calendar.current
  let start = calendar.startOfDay(for: now)
  var entries = [make(now)]
  for offset in 1...7 {
    if let next = calendar.date(byAdding: .day, value: offset, to: start) {
      entries.append(make(next))
    }
  }
  return Timeline(entries: entries, policy: .atEnd)
}

struct TodayProvider: TimelineProvider {
  private let images = ImageProvider(key: "today_img")

  func placeholder(in context: Context) -> ImageEntry {
    entry(at: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ImageEntry) -> Void) {
    completion(entry(at: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ImageEntry>) -> Void) {
    completion(midnights(from: Date()) { entry(at: $0) })
  }

  private func entry(at date: Date) -> ImageEntry {
    let defaults = UserDefaults(suiteName: appGroup)
    guard let saved = defaults?.string(forKey: "today_stamp"), saved != dayStamp(date) else {
      return images.load(at: date)
    }
    let week = Array(defaults?.string(forKey: "today_week") ?? "")
    let index = weekdayIndex(date)
    let planned = index < week.count && week[index] == "1"
    let entry = images.load(planned ? "today_plan_img" : "today_rest_img", at: date)
    return entry.image == nil ? images.load(at: date) : entry
  }
}

struct WeekProvider: TimelineProvider {
  private let images = ImageProvider(key: "week_img")

  func placeholder(in context: Context) -> ImageEntry {
    entry(at: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ImageEntry) -> Void) {
    completion(entry(at: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ImageEntry>) -> Void) {
    completion(midnights(from: Date()) { entry(at: $0) })
  }

  private func entry(at date: Date) -> ImageEntry {
    let defaults = UserDefaults(suiteName: appGroup)
    let today = weekdayIndex(date)
    let monday = Calendar.current.date(byAdding: .day, value: -today, to: date) ?? date
    let saved = defaults?.string(forKey: "week_start")
    let fresh = saved != nil && saved != dayStamp(monday)
    var entry = images.load(fresh ? "week_fresh_img" : "week_img", at: date)
    if entry.image == nil { entry = images.load(at: date) }
    let done = Array(defaults?.string(forKey: "week_done") ?? "")
    let doneToday = !fresh && today < done.count && done[today] == "1"
    let geo = (defaults?.string(forKey: "week_geo") ?? "")
      .split(separator: ",")
      .compactMap { Double($0) }
      .map { CGFloat($0) }
    if !doneToday && geo.count >= 5 {
      entry.ring = DayRing(
        index: today,
        geo: geo,
        color: Color(hex: defaults?.string(forKey: "week_ring")),
        nightColor: Color(hex: defaults?.string(forKey: "week_ring_night")))
    }
    return entry
  }
}

extension Color {
  init?(hex: String?) {
    guard let hex, hex.hasPrefix("#"), let value = UInt64(hex.dropFirst(), radix: 16) else { return nil }
    self.init(
      .sRGB,
      red: Double((value >> 16) & 0xFF) / 255,
      green: Double((value >> 8) & 0xFF) / 255,
      blue: Double(value & 0xFF) / 255,
      opacity: Double((value >> 24) & 0xFF) / 255)
  }
}

enum Palette {
  static func raised(_ dark: Bool) -> Color {
    dark ? Color(red: 0x1C / 255, green: 0x1C / 255, blue: 0x1C / 255) : Color.white
  }

  static func text(_ dark: Bool) -> Color {
    dark ? Color(red: 0xF4 / 255, green: 0xF1 / 255, blue: 0xEC / 255)
         : Color(red: 0x14 / 255, green: 0x12 / 255, blue: 0x10 / 255)
  }

  static func textSecondary(_ dark: Bool) -> Color {
    dark ? Color(red: 0x9A / 255, green: 0x95 / 255, blue: 0x8E / 255)
         : Color(red: 0x6B / 255, green: 0x66 / 255, blue: 0x60 / 255)
  }
}

struct ImageWidgetView: View {
  let entry: ImageEntry
  @Environment(\.colorScheme) private var scheme

  private var night: Bool {
    entry.followsSystem ? scheme == .dark : entry.dark
  }

  private var shown: UIImage? {
    night && entry.followsSystem ? (entry.nightImage ?? entry.image) : entry.image
  }

  var body: some View {
    Group {
      if let image = shown {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(todayRing(image))
      } else {
        EmptyState(dark: night)
      }
    }
    .widgetBackground(Palette.raised(night))
  }

  @ViewBuilder
  private func todayRing(_ image: UIImage) -> some View {
    if let ring = entry.ring, image.size.height > 0 {
      GeometryReader { box in
        let aspect = image.size.width / image.size.height
        let width = min(box.size.width, box.size.height * aspect)
        let height = width / aspect
        let x = (box.size.width - width) / 2 + (ring.geo[0] + ring.geo[1] * CGFloat(ring.index)) * width
        let y = (box.size.height - height) / 2 + ring.geo[2] * height
        let radius = ring.geo[3] * width
        Circle()
          .stroke((night && entry.followsSystem ? ring.nightColor : ring.color) ?? Palette.text(night),
                  lineWidth: ring.geo[4] * width)
          .frame(width: radius * 2, height: radius * 2)
          .position(x: x, y: y)
      }
    }
  }
}

struct EmptyState: View {
  let dark: Bool

  var body: some View {
    VStack(spacing: 6) {
      Text("GYMMANE")
        .font(.system(size: 13, weight: .semibold))
        .kerning(2)
        .foregroundColor(Palette.text(dark))
      Text("widget_open_app")
        .font(.system(size: 12))
        .foregroundColor(Palette.textSecondary(dark))
        .multilineTextAlignment(.center)
    }
    .padding(16)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension View {
  @ViewBuilder
  func widgetBackground(_ color: Color) -> some View {
    if #available(iOS 17.0, *) {
      containerBackground(for: .widget) { color }
    } else {
      background(color)
    }
  }
}

extension WidgetConfiguration {
  func edgeToEdge() -> some WidgetConfiguration {
    if #available(iOS 17.0, *) {
      return contentMarginsDisabled()
    } else {
      return self
    }
  }
}

struct HeatmapWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "HeatmapWidget", provider: ImageProvider(key: "heatmap_img")) { entry in
      ImageWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_activity_name")
    .description("widget_activity_desc")
    .supportedFamilies([.systemMedium])
    .edgeToEdge()
  }
}

struct StatsWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "StatsWidget", provider: ImageProvider(key: "stats_img")) { entry in
      ImageWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_stats_name")
    .description("widget_stats_desc")
    .supportedFamilies([.systemSmall])
    .edgeToEdge()
  }
}

struct BodyWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "BodyWidget", provider: ImageProvider(key: "body_img")) { entry in
      ImageWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_body_name")
    .description("widget_body_desc")
    .supportedFamilies([.systemLarge])
    .edgeToEdge()
  }
}

struct TodayWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "TodayWidget", provider: TodayProvider()) { entry in
      ImageWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_today_name")
    .description("widget_today_desc")
    .supportedFamilies([.systemSmall])
    .edgeToEdge()
  }
}

struct WeekWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "WeekWidget", provider: WeekProvider()) { entry in
      ImageWidgetView(entry: entry)
    }
    .configurationDisplayName("widget_week_name")
    .description("widget_week_desc")
    .supportedFamilies([.systemMedium])
    .edgeToEdge()
  }
}

@main
struct GymManeWidgetBundle: WidgetBundle {
  var body: some Widget {
    widgets()
  }

  func widgets() -> some Widget {
    if #available(iOS 16.2, *) {
      return WidgetBundleBuilder.buildBlock(
        HeatmapWidget(), StatsWidget(), BodyWidget(), TodayWidget(), WeekWidget(),
        WaterWidget(), ProteinWidget(), KcalWidget(), WorkoutLiveActivity())
    } else {
      return WidgetBundleBuilder.buildBlock(
        HeatmapWidget(), StatsWidget(), BodyWidget(), TodayWidget(), WeekWidget(),
        WaterWidget(), ProteinWidget(), KcalWidget())
    }
  }
}
