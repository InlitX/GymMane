import Flutter
import HealthKit
import UIKit

enum HealthBridge {
  private static let store = HKHealthStore()
  private static let defaults = UserDefaults.standard
  private static let askedKey = "gymmane.health.asked"
  private static let metricsKey = "gymmane.health.metrics"
  private static let stepType = HKQuantityType(.stepCount)
  private static let perMinute = HKUnit.count().unitDivided(by: .minute())

  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "gymmane/health", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        guard HKHealthStore.isHealthDataAvailable() else {
          result(call.method == "status" ? "unsupported" : nil)
          return
        }
        let args = call.arguments as? [String: Any] ?? [:]
        switch call.method {
        case "takeUsage":
          result(false)
        case "status":
          result(defaults.bool(forKey: askedKey) ? "granted" : "denied")
        case "request":
          authorize(read: [stepType], share: [], completion: result)
        case "openSettings":
          openHealth(result)
        case "readSteps":
          readSteps(args["ranges"] as? [[NSNumber]] ?? [], result)
        case "metricsGranted":
          result(defaults.stringArray(forKey: metricsKey) ?? [])
        case "requestMetrics":
          requestMetrics(args["metrics"] as? [String] ?? [], result)
        case "readMetric":
          readMetric(
            args["metric"] as? String ?? "",
            from: date(args["from"]),
            to: date(args["to"]),
            result
          )
        case "writeWorkout":
          writeWorkout(args, result)
        case "deleteWorkout":
          deleteWorkouts(id: args["id"] as? String ?? "", result)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
  }

  private static func date(_ millis: Any?) -> Date {
    Date(timeIntervalSince1970: ((millis as? NSNumber)?.doubleValue ?? 0) / 1000)
  }

  private static func reply(_ result: @escaping FlutterResult, _ value: Any?) {
    DispatchQueue.main.async { result(value) }
  }

  private static func authorize(
    read: Set<HKObjectType>,
    share: Set<HKSampleType>,
    completion: @escaping FlutterResult
  ) {
    store.requestAuthorization(toShare: share, read: read) { ok, _ in
      if ok { defaults.set(true, forKey: askedKey) }
      reply(completion, ok)
    }
  }

  private static func requestMetrics(_ keys: [String], _ result: @escaping FlutterResult) {
    let read = Set(keys.flatMap(readTypes))
    let share: Set<HKSampleType> = keys.contains("writeWorkouts") ? [HKObjectType.workoutType()] : []
    store.requestAuthorization(toShare: share, read: read) { ok, _ in
      if ok {
        defaults.set(true, forKey: askedKey)
        let known = Set(defaults.stringArray(forKey: metricsKey) ?? [])
        defaults.set(Array(known.union(keys)), forKey: metricsKey)
      }
      reply(result, ok)
    }
  }

  private static func openHealth(_ result: @escaping FlutterResult) {
    guard let health = URL(string: "x-apple-health://"),
          let settings = URL(string: UIApplication.openSettingsURLString)
    else {
      result(false)
      return
    }
    UIApplication.shared.open(health) { opened in
      if opened {
        result(true)
      } else {
        UIApplication.shared.open(settings) { result($0) }
      }
    }
  }

  private static func readTypes(for key: String) -> [HKObjectType] {
    switch key {
    case "restingHr": return [HKQuantityType(.restingHeartRate)]
    case "heartRate", "workoutHr": return [HKQuantityType(.heartRate)]
    case "hrv": return [HKQuantityType(.heartRateVariabilitySDNN)]
    case "spo2": return [HKQuantityType(.oxygenSaturation)]
    case "respiration": return [HKQuantityType(.respiratoryRate)]
    case "bloodPressure": return [HKQuantityType(.bloodPressureSystolic), HKQuantityType(.bloodPressureDiastolic)]
    case "temperature": return [HKQuantityType(.bodyTemperature)]
    case "sleep": return [HKCategoryType(.sleepAnalysis)]
    case "distance": return [HKQuantityType(.distanceWalkingRunning)]
    case "floors": return [HKQuantityType(.flightsClimbed)]
    case "activeKcal": return [HKQuantityType(.activeEnergyBurned)]
    case "weight": return [HKQuantityType(.bodyMass)]
    case "steps": return [stepType]
    default: return []
    }
  }

  private static func readSteps(_ ranges: [[NSNumber]], _ result: @escaping FlutterResult) {
    guard !ranges.isEmpty else {
      result(nil)
      return
    }
    var counts = [Int](repeating: 0, count: ranges.count)
    var failed = false
    let lock = NSLock()
    let group = DispatchGroup()
    for (index, range) in ranges.enumerated() where range.count == 2 {
      group.enter()
      total(stepType, from: date(range[0]), to: date(range[1]), unit: .count()) { value in
        lock.lock()
        if let value = value { counts[index] = Int(value) } else { failed = true }
        lock.unlock()
        group.leave()
      }
    }
    group.notify(queue: .main) { result(failed ? nil : counts) }
  }

  private static func total(
    _ type: HKQuantityType,
    from: Date,
    to: Date,
    unit: HKUnit,
    completion: @escaping (Double?) -> Void
  ) {
    let predicate = HKQuery.predicateForSamples(withStart: from, end: to, options: .strictStartDate)
    let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) {
      _, statistics, error in
      if let error = error as? HKError, error.code != .errorNoData {
        completion(nil)
        return
      }
      completion(statistics?.sumQuantity()?.doubleValue(for: unit) ?? 0)
    }
    store.execute(query)
  }

  private static func readMetric(_ key: String, from: Date, to: Date, _ result: @escaping FlutterResult) {
    guard to > from else {
      result(nil)
      return
    }
    switch key {
    case "restingHr":
      daily(HKQuantityType(.restingHeartRate), unit: perMinute, average: true, from: from, to: to, result)
    case "heartRate":
      daily(HKQuantityType(.heartRate), unit: perMinute, average: true, from: from, to: to, result)
    case "distance":
      daily(HKQuantityType(.distanceWalkingRunning), unit: .meter(), average: false, from: from, to: to, result)
    case "floors":
      daily(HKQuantityType(.flightsClimbed), unit: .count(), average: false, from: from, to: to, result)
    case "activeKcal":
      daily(HKQuantityType(.activeEnergyBurned), unit: .kilocalorie(), average: false, from: from, to: to, result)
    case "hrv":
      points(HKQuantityType(.heartRateVariabilitySDNN), unit: .secondUnit(with: .milli), scale: 1, from: from, to: to, result)
    case "spo2":
      points(HKQuantityType(.oxygenSaturation), unit: .percent(), scale: 100, from: from, to: to, result)
    case "respiration":
      points(HKQuantityType(.respiratoryRate), unit: perMinute, scale: 1, from: from, to: to, result)
    case "temperature":
      points(HKQuantityType(.bodyTemperature), unit: .degreeCelsius(), scale: 1, from: from, to: to, result)
    case "workoutHr":
      points(HKQuantityType(.heartRate), unit: perMinute, scale: 1, from: from, to: to, result)
    case "weight":
      points(HKQuantityType(.bodyMass), unit: .gramUnit(with: .kilo), scale: 1, from: from, to: to, result)
    case "bloodPressure":
      bloodPressure(from: from, to: to, result)
    case "sleep":
      sleep(from: from, to: to, result)
    default:
      result(nil)
    }
  }

  private static func daily(
    _ type: HKQuantityType,
    unit: HKUnit,
    average: Bool,
    from: Date,
    to: Date,
    _ result: @escaping FlutterResult
  ) {
    let anchor = Calendar.current.startOfDay(for: from)
    let predicate = HKQuery.predicateForSamples(withStart: from, end: to, options: [])
    let query = HKStatisticsCollectionQuery(
      quantityType: type,
      quantitySamplePredicate: predicate,
      options: average ? .discreteAverage : .cumulativeSum,
      anchorDate: anchor,
      intervalComponents: DateComponents(day: 1)
    )
    query.initialResultsHandler = { _, collection, _ in
      guard let collection = collection else {
        reply(result, nil)
        return
      }
      var rows: [[Double]] = []
      collection.enumerateStatistics(from: anchor, to: to) { statistics, _ in
        let quantity = average ? statistics.averageQuantity() : statistics.sumQuantity()
        if let value = quantity?.doubleValue(for: unit) {
          rows.append([statistics.startDate.timeIntervalSince1970 * 1000, value])
        }
      }
      reply(result, rows)
    }
    store.execute(query)
  }

  private static func sampleQuery(
    _ type: HKSampleType,
    from: Date,
    to: Date,
    _ result: @escaping FlutterResult,
    row: @escaping ([HKSample]) -> [[Double]]
  ) {
    let predicate = HKQuery.predicateForSamples(withStart: from, end: to, options: [])
    let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
    let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: 20000, sortDescriptors: [sort]) {
      _, found, error in
      if error != nil {
        reply(result, nil)
        return
      }
      reply(result, row(found ?? []))
    }
    store.execute(query)
  }

  private static func points(
    _ type: HKQuantityType,
    unit: HKUnit,
    scale: Double,
    from: Date,
    to: Date,
    _ result: @escaping FlutterResult
  ) {
    sampleQuery(type, from: from, to: to, result) { samples in
      samples.compactMap { sample in
        guard let quantity = (sample as? HKQuantitySample)?.quantity else { return nil }
        return [sample.startDate.timeIntervalSince1970 * 1000, quantity.doubleValue(for: unit) * scale]
      }
    }
  }

  private static func bloodPressure(from: Date, to: Date, _ result: @escaping FlutterResult) {
    let systolic = HKQuantityType(.bloodPressureSystolic)
    let diastolic = HKQuantityType(.bloodPressureDiastolic)
    let unit = HKUnit.millimeterOfMercury()
    sampleQuery(HKCorrelationType(.bloodPressure), from: from, to: to, result) { samples in
      samples.compactMap { sample in
        guard let correlation = sample as? HKCorrelation,
              let high = (correlation.objects(for: systolic).first as? HKQuantitySample)?.quantity,
              let low = (correlation.objects(for: diastolic).first as? HKQuantitySample)?.quantity
        else { return nil }
        return [
          sample.startDate.timeIntervalSince1970 * 1000,
          high.doubleValue(for: unit),
          low.doubleValue(for: unit),
        ]
      }
    }
  }

  private static func sleep(from: Date, to: Date, _ result: @escaping FlutterResult) {
    let inBed = 0
    let awake = 2
    let gap: TimeInterval = 3600
    sampleQuery(HKCategoryType(.sleepAnalysis), from: from, to: to, result) { samples in
      var rows: [[Double]] = []
      var minutes = 0.0
      var covered: Date?
      var last: Date?
      func close() {
        if let end = last, minutes > 0 { rows.append([end.timeIntervalSince1970 * 1000, minutes]) }
        minutes = 0
        covered = nil
        last = nil
      }
      for sample in samples {
        guard let category = sample as? HKCategorySample, category.value != inBed, category.value != awake else {
          continue
        }
        if let end = last, sample.startDate.timeIntervalSince(end) > gap { close() }
        let begin = max(sample.startDate, covered ?? sample.startDate)
        minutes += max(0, sample.endDate.timeIntervalSince(begin)) / 60
        covered = max(covered ?? sample.endDate, sample.endDate)
        last = covered
      }
      close()
      return rows
    }
  }

  private static func writeWorkout(_ args: [String: Any], _ result: @escaping FlutterResult) {
    let id = args["id"] as? String ?? ""
    guard store.authorizationStatus(for: HKObjectType.workoutType()) == .sharingAuthorized else {
      result(false)
      return
    }
    let start = date(args["start"])
    let end = date(args["end"])
    guard end > start else {
      result(false)
      return
    }
    var metadata: [String: Any] = [HKMetadataKeyWasUserEntered: args["manual"] as? Bool ?? false]
    if !id.isEmpty { metadata[HKMetadataKeyExternalUUID] = id }
    if let title = args["title"] as? String, !title.isEmpty { metadata["GymManeTitle"] = title }
    if let notes = args["notes"] as? String, !notes.isEmpty { metadata["GymManeNotes"] = notes }

    let configuration = HKWorkoutConfiguration()
    configuration.activityType = activity(args["type"] as? String ?? "")
    let save = {
      let builder = HKWorkoutBuilder(healthStore: store, configuration: configuration, device: .local())
      builder.beginCollection(withStart: start) { began, _ in
        guard began else {
          reply(result, false)
          return
        }
        builder.addMetadata(metadata) { _, _ in
          builder.endCollection(withEnd: end) { _, _ in
            builder.finishWorkout { workout, _ in reply(result, workout != nil) }
          }
        }
      }
    }
    if id.isEmpty {
      save()
    } else {
      workouts(id: id) { found in
        if found.isEmpty {
          save()
        } else {
          store.delete(found) { _, _ in save() }
        }
      }
    }
  }

  private static func deleteWorkouts(id: String, _ result: @escaping FlutterResult) {
    guard !id.isEmpty else {
      result(false)
      return
    }
    workouts(id: id) { found in
      if found.isEmpty {
        reply(result, true)
      } else {
        store.delete(found) { deleted, _ in reply(result, deleted) }
      }
    }
  }

  private static func workouts(id: String, completion: @escaping ([HKWorkout]) -> Void) {
    let predicate = HKQuery.predicateForObjects(withMetadataKey: HKMetadataKeyExternalUUID, allowedValues: [id])
    let query = HKSampleQuery(sampleType: HKObjectType.workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
      _, found, _ in
      completion((found as? [HKWorkout]) ?? [])
    }
    store.execute(query)
  }

  private static func activity(_ type: String) -> HKWorkoutActivityType {
    switch type {
    case "strength": return .traditionalStrengthTraining
    case "running", "treadmill": return .running
    case "walking": return .walking
    case "biking", "stationaryBike": return .cycling
    case "rowing": return .rowing
    case "elliptical": return .elliptical
    case "stairs": return .stairClimbing
    case "swimming": return .swimming
    case "hiit": return .highIntensityIntervalTraining
    case "calisthenics": return .functionalStrengthTraining
    case "yoga": return .yoga
    case "stretching": return .flexibility
    case "football": return .soccer
    case "basketball": return .basketball
    case "volleyball": return .volleyball
    case "tennis": return .tennis
    case "padel": return .racquetball
    case "badminton": return .badminton
    case "squash": return .squash
    case "table-tennis": return .tableTennis
    case "handball": return .handball
    case "rugby": return .rugby
    case "boxing": return .boxing
    case "martial-arts": return .martialArts
    case "climbing": return .climbing
    case "skiing": return .downhillSkiing
    case "surfing": return .surfingSports
    case "dance": return .socialDance
    case "golf": return .golf
    default: return .other
    }
  }
}
