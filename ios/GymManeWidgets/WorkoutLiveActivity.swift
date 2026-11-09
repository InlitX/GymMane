import ActivityKit
import SwiftUI
import WidgetKit

@available(iOS 16.2, *)
struct WorkoutLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: WorkoutActivityAttributes.self) { context in
      LockScreenView(state: context.state)
        .activityBackgroundTint(LiveColors.card)
        .activitySystemActionForegroundColor(LiveColors.text)
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          LiveIcon(size: 36)
            .padding(.leading, 4)
        }
        DynamicIslandExpandedRegion(.trailing) {
          TrailingStatus(state: context.state, font: .system(size: 22, weight: .bold, design: .rounded))
            .padding(.trailing, 4)
        }
        DynamicIslandExpandedRegion(.center) {
          VStack(alignment: .leading, spacing: 2) {
            Text(context.state.exercise)
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(LiveColors.text)
              .lineLimit(1)
            Text(context.state.detail)
              .font(.system(size: 12))
              .foregroundColor(LiveColors.secondary)
              .lineLimit(1)
          }
        }
        DynamicIslandExpandedRegion(.bottom) {
          ExerciseProgress(index: context.state.index, total: context.state.total)
            .padding(.horizontal, 4)
            .padding(.top, 2)
        }
      } compactLeading: {
        LiveIcon(size: 22)
      } compactTrailing: {
        TrailingStatus(state: context.state, font: .system(size: 13, weight: .semibold, design: .rounded))
          .frame(maxWidth: 52)
      } minimal: {
        LiveIcon(size: 20)
      }
      .keylineTint(LiveColors.accent)
    }
  }
}

@available(iOS 16.2, *)
struct LockScreenView: View {
  let state: WorkoutActivityAttributes.ContentState

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .center, spacing: 12) {
        LiveIcon(size: 40)
        VStack(alignment: .leading, spacing: 2) {
          Text(state.exercise)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(LiveColors.text)
            .lineLimit(1)
          Text(state.detail)
            .font(.system(size: 13))
            .foregroundColor(LiveColors.secondary)
            .lineLimit(1)
        }
        Spacer(minLength: 8)
        TrailingStatus(state: state, font: .system(size: 24, weight: .bold, design: .rounded))
      }
      ExerciseProgress(index: state.index, total: state.total)
    }
    .padding(16)
  }
}

@available(iOS 16.2, *)
struct TrailingStatus: View {
  let state: WorkoutActivityAttributes.ContentState
  let font: Font

  var body: some View {
    if state.paused {
      Image(systemName: "pause.fill")
        .font(font)
        .foregroundColor(LiveColors.secondary)
    } else if let end = state.restEnd, end > Date() {
      VStack(alignment: .trailing, spacing: 0) {
        Text(timerInterval: Date()...end, countsDown: true)
          .font(font)
          .monospacedDigit()
          .multilineTextAlignment(.trailing)
          .foregroundColor(LiveColors.accent)
        Text(state.restLabel)
          .font(.system(size: 9, weight: .semibold))
          .foregroundColor(LiveColors.secondary)
          .lineLimit(1)
      }
    } else {
      Text("\(min(state.index + 1, max(state.total, 1)))/\(max(state.total, 1))")
        .font(font)
        .monospacedDigit()
        .foregroundColor(LiveColors.text)
    }
  }
}

struct ExerciseProgress: View {
  let index: Int
  let total: Int

  var body: some View {
    let count = max(total, 1)
    HStack(spacing: 4) {
      ForEach(0..<count, id: \.self) { i in
        Capsule()
          .fill(i < index ? LiveColors.accent : (i == index ? LiveColors.accent.opacity(0.55) : LiveColors.track))
          .frame(height: 5)
      }
    }
  }
}

struct LiveIcon: View {
  let size: CGFloat

  var body: some View {
    Image("LiveIcon")
      .resizable()
      .scaledToFit()
      .frame(width: size, height: size)
      .clipShape(RoundedRectangle(cornerRadius: size * 0.28, style: .continuous))
  }
}

enum LiveColors {
  static let card = Color(red: 0x1C / 255, green: 0x1C / 255, blue: 0x1C / 255)
  static let text = Color(red: 0xF4 / 255, green: 0xF1 / 255, blue: 0xEC / 255)
  static let secondary = Color(red: 0x9A / 255, green: 0x95 / 255, blue: 0x8E / 255)
  static let track = Color.white.opacity(0.14)
  static let accent = Color(red: 0xD9 / 255, green: 0xA1 / 255, blue: 0x84 / 255)
}
