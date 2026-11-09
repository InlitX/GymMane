import ActivityKit
import Foundation

@available(iOS 16.2, *)
struct WorkoutActivityAttributes: ActivityAttributes {
  struct ContentState: Codable, Hashable {
    var exercise: String
    var detail: String
    var index: Int
    var total: Int
    var restEnd: Date?
    var restLabel: String
    var paused: Bool
  }

  var startedAt: Date
}
