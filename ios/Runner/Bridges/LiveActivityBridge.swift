import ActivityKit
import Flutter

enum LiveActivityBridge {
  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/live_activity", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        guard #available(iOS 16.2, *) else {
          result(nil)
          return
        }
        switch call.method {
        case "update":
          guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "bad-args", message: "missing state", details: nil))
            return
          }
          Task {
            await LiveWorkoutActivity.update(args)
            result(nil)
          }
        case "end":
          Task {
            await LiveWorkoutActivity.end()
            result(nil)
          }
        default:
          result(FlutterMethodNotImplemented)
        }
      }
  }
}

@available(iOS 16.2, *)
enum LiveWorkoutActivity {
  private static var current: Activity<WorkoutActivityAttributes>?

  static func update(_ args: [String: Any]) async {
    let state = WorkoutActivityAttributes.ContentState(
      exercise: args["exercise"] as? String ?? "GymMane",
      detail: args["detail"] as? String ?? "",
      index: args["index"] as? Int ?? 0,
      total: args["total"] as? Int ?? 0,
      restEnd: (args["restEnd"] as? NSNumber).map { Date(timeIntervalSince1970: $0.doubleValue / 1000) },
      restLabel: args["restLabel"] as? String ?? "",
      paused: args["paused"] as? Bool ?? false
    )
    let content = ActivityContent(state: state, staleDate: nil)

    if current == nil {
      current = Activity<WorkoutActivityAttributes>.activities.first
    }
    if let activity = current, activity.activityState == .active {
      await activity.update(content)
      return
    }
    guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
    do {
      current = try Activity.request(
        attributes: WorkoutActivityAttributes(startedAt: Date()),
        content: content,
        pushType: nil
      )
    } catch {
      NSLog("Live Activity request failed: \(error.localizedDescription)")
    }
  }

  static func end() async {
    for activity in Activity<WorkoutActivityAttributes>.activities {
      await activity.end(nil, dismissalPolicy: .immediate)
    }
    current = nil
  }
}
