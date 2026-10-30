package com.gymmane.app

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.health.connect.AggregateRecordsGroupedByPeriodResponse
import android.health.connect.AggregateRecordsRequest
import android.health.connect.AggregateRecordsResponse
import android.health.connect.HealthConnectException
import android.health.connect.HealthConnectManager
import android.health.connect.HealthPermissions
import android.health.connect.LocalTimeRangeFilter
import android.health.connect.ReadRecordsRequestUsingFilters
import android.health.connect.ReadRecordsResponse
import android.health.connect.TimeInstantRangeFilter
import android.health.connect.datatypes.ActiveCaloriesBurnedRecord
import android.health.connect.datatypes.AggregationType
import android.health.connect.datatypes.BloodPressureRecord
import android.health.connect.datatypes.BodyTemperatureRecord
import android.health.connect.datatypes.DistanceRecord
import android.health.connect.datatypes.ElevationGainedRecord
import android.health.connect.datatypes.FloorsClimbedRecord
import android.health.connect.datatypes.HeartRateRecord
import android.health.connect.datatypes.HeartRateVariabilityRmssdRecord
import android.health.connect.datatypes.OxygenSaturationRecord
import android.health.connect.datatypes.Record
import android.health.connect.datatypes.RespiratoryRateRecord
import android.health.connect.datatypes.RestingHeartRateRecord
import android.health.connect.datatypes.SleepSessionRecord
import android.health.connect.datatypes.StepsRecord
import android.os.Build
import android.os.OutcomeReceiver
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodChannel
import java.time.Instant
import java.time.LocalDateTime
import java.time.Period
import java.time.ZoneId
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicInteger

object HealthBridge {
    const val CHANNEL = "gymmane/health"
    private const val REQUEST_CODE = 4271
    private var pending: MethodChannel.Result? = null
    var channel: MethodChannel? = null

    private val supported get() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE

    private const val MAX_ROWS = 20000

    private val metrics = mapOf(
        "restingHr" to "android.permission.health.READ_RESTING_HEART_RATE",
        "heartRate" to "android.permission.health.READ_HEART_RATE",
        "hrv" to "android.permission.health.READ_HEART_RATE_VARIABILITY",
        "spo2" to "android.permission.health.READ_OXYGEN_SATURATION",
        "respiration" to "android.permission.health.READ_RESPIRATORY_RATE",
        "bloodPressure" to "android.permission.health.READ_BLOOD_PRESSURE",
        "temperature" to "android.permission.health.READ_BODY_TEMPERATURE",
        "sleep" to "android.permission.health.READ_SLEEP",
        "distance" to "android.permission.health.READ_DISTANCE",
        "floors" to "android.permission.health.READ_FLOORS_CLIMBED",
        "elevation" to "android.permission.health.READ_ELEVATION_GAINED",
        "activeKcal" to "android.permission.health.READ_ACTIVE_CALORIES_BURNED",
    )

    fun attach(activity: Activity, channel: MethodChannel) {
        this.channel = channel
        channel.setMethodCallHandler { call, result ->
            if (call.method == "takeUsage") {
                result.success(takeUsage(activity.intent))
                return@setMethodCallHandler
            }
            if (!supported) {
                result.success(if (call.method == "status") "unsupported" else null)
                return@setMethodCallHandler
            }
            when (call.method) {
                "status" -> result.success(status(activity))
                "request" -> request(activity, result)
                "openSettings" -> result.success(openSettings(activity))
                "readSteps" -> readSteps(activity, call.argument<List<List<Number>>>("ranges").orEmpty(), result)
                "metricsGranted" -> result.success(metricsGranted(activity))
                "requestMetrics" -> requestMetrics(activity, call.argument<List<String>>("metrics").orEmpty(), result)
                "readMetric" -> readMetric(
                    activity,
                    call.argument<String>("metric").orEmpty(),
                    call.argument<Number>("from")?.toLong() ?: 0L,
                    call.argument<Number>("to")?.toLong() ?: 0L,
                    result,
                )
                else -> result.notImplemented()
            }
        }
    }

    fun onPermissionResult(requestCode: Int, results: IntArray): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val result = pending ?: return true
        pending = null
        result.success(results.isNotEmpty() && results.all { it == PackageManager.PERMISSION_GRANTED })
        return true
    }

    fun takeUsage(intent: Intent?): Boolean {
        if (intent?.action != Intent.ACTION_VIEW_PERMISSION_USAGE) return false
        intent.action = Intent.ACTION_MAIN
        return true
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun status(activity: Activity): String = when {
        activity.getSystemService(HealthConnectManager::class.java) == null -> "unsupported"
        activity.checkSelfPermission(HealthPermissions.READ_STEPS) == PackageManager.PERMISSION_GRANTED -> "granted"
        else -> "denied"
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun request(activity: Activity, result: MethodChannel.Result) {
        if (status(activity) == "granted") return result.success(true)
        pending?.success(false)
        pending = result
        activity.requestPermissions(arrayOf(HealthPermissions.READ_STEPS), REQUEST_CODE)
    }

    private fun metricsGranted(activity: Activity): List<String> =
        metrics.filterValues { activity.checkSelfPermission(it) == PackageManager.PERMISSION_GRANTED }.keys.toList()

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun requestMetrics(activity: Activity, keys: List<String>, result: MethodChannel.Result) {
        if (activity.getSystemService(HealthConnectManager::class.java) == null) return result.success(false)
        val wanted = keys.mapNotNull { metrics[it] }
            .filter { activity.checkSelfPermission(it) != PackageManager.PERMISSION_GRANTED }
        if (wanted.isEmpty()) return result.success(keys.all { it in metrics })
        pending?.success(false)
        pending = result
        activity.requestPermissions(wanted.toTypedArray(), REQUEST_CODE)
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun readMetric(activity: Activity, key: String, from: Long, to: Long, result: MethodChannel.Result) {
        val manager = activity.getSystemService(HealthConnectManager::class.java)
        val permission = metrics[key]
        if (manager == null || permission == null || to <= from ||
            activity.checkSelfPermission(permission) != PackageManager.PERMISSION_GRANTED
        ) {
            return result.success(null)
        }
        val reader = Reader(activity, manager, from, to, result)
        when (key) {
            "restingHr" -> reader.daily(RestingHeartRateRecord.BPM_AVG) { it.toDouble() }
            "heartRate" -> reader.daily(HeartRateRecord.BPM_AVG) { it.toDouble() }
            "distance" -> reader.daily(DistanceRecord.DISTANCE_TOTAL) { it.inMeters }
            "floors" -> reader.daily(FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL) { it }
            "elevation" -> reader.daily(ElevationGainedRecord.ELEVATION_GAINED_TOTAL) { it.inMeters }
            "activeKcal" -> reader.daily(ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL) { it.inCalories / 1000 }
            "hrv" -> reader.records(HeartRateVariabilityRmssdRecord::class.java) {
                listOf(it.time.toEpochMilli().toDouble(), it.heartRateVariabilityMillis)
            }
            "spo2" -> reader.records(OxygenSaturationRecord::class.java) {
                listOf(it.time.toEpochMilli().toDouble(), it.percentage.value)
            }
            "respiration" -> reader.records(RespiratoryRateRecord::class.java) {
                listOf(it.time.toEpochMilli().toDouble(), it.rate)
            }
            "bloodPressure" -> reader.records(BloodPressureRecord::class.java) {
                listOf(
                    it.time.toEpochMilli().toDouble(),
                    it.systolic.inMillimetersOfMercury,
                    it.diastolic.inMillimetersOfMercury,
                )
            }
            "temperature" -> reader.records(BodyTemperatureRecord::class.java) {
                listOf(it.time.toEpochMilli().toDouble(), it.temperature.inCelsius)
            }
            "sleep" -> reader.records(SleepSessionRecord::class.java) {
                val start = it.startTime.toEpochMilli()
                val end = it.endTime.toEpochMilli()
                listOf(end.toDouble(), (end - start) / 60000.0)
            }
            else -> result.success(null)
        }
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private class Reader(
        val activity: Activity,
        val manager: HealthConnectManager,
        val from: Long,
        val to: Long,
        val result: MethodChannel.Result,
    ) {
        fun <T> daily(type: AggregationType<T>, value: (T) -> Double) {
            val zone = ZoneId.systemDefault()
            val filter = LocalTimeRangeFilter.Builder()
                .setStartTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(from), zone))
                .setEndTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(to), zone))
                .build()
            val request = AggregateRecordsRequest.Builder<T>(filter).addAggregationType(type).build()
            try {
                manager.aggregateGroupByPeriod(
                    request,
                    Period.ofDays(1),
                    activity.mainExecutor,
                    object : OutcomeReceiver<List<AggregateRecordsGroupedByPeriodResponse<T>>, HealthConnectException> {
                        override fun onResult(groups: List<AggregateRecordsGroupedByPeriodResponse<T>>) {
                            result.success(
                                groups.mapNotNull { g ->
                                    val v: T = g.get(type) ?: return@mapNotNull null
                                    listOf(g.startTime.atZone(zone).toInstant().toEpochMilli().toDouble(), value(v))
                                },
                            )
                        }

                        override fun onError(error: HealthConnectException) {
                            result.success(null)
                        }
                    },
                )
            } catch (e: Exception) {
                result.success(null)
            }
        }

        fun <T : Record> records(type: Class<T>, row: (T) -> List<Double>) {
            val filter = TimeInstantRangeFilter.Builder()
                .setStartTime(Instant.ofEpochMilli(from))
                .setEndTime(Instant.ofEpochMilli(to))
                .build()
            val rows = mutableListOf<List<Double>>()
            fun page(token: Long?) {
                val builder = ReadRecordsRequestUsingFilters.Builder(type)
                    .setTimeRangeFilter(filter)
                    .setPageSize(1000)
                if (token != null) builder.setPageToken(token)
                try {
                    manager.readRecords(
                        builder.build(),
                        activity.mainExecutor,
                        object : OutcomeReceiver<ReadRecordsResponse<T>, HealthConnectException> {
                            override fun onResult(response: ReadRecordsResponse<T>) {
                                response.records.forEach { rows.add(row(it)) }
                                val next = response.nextPageToken
                                if (next != -1L && rows.size < MAX_ROWS) page(next) else result.success(rows)
                            }

                            override fun onError(error: HealthConnectException) {
                                result.success(if (rows.isEmpty()) null else rows)
                            }
                        },
                    )
                } catch (e: Exception) {
                    result.success(if (rows.isEmpty()) null else rows)
                }
            }
            page(null)
        }
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun openSettings(activity: Activity): Boolean {
        val tries = listOf(
            Intent(HealthConnectManager.ACTION_MANAGE_HEALTH_PERMISSIONS)
                .putExtra(Intent.EXTRA_PACKAGE_NAME, activity.packageName),
            Intent("android.health.connect.action.HEALTH_HOME_SETTINGS"),
            Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                .setData(android.net.Uri.fromParts("package", activity.packageName, null)),
        )
        for (intent in tries) {
            try {
                activity.startActivity(intent)
                return true
            } catch (e: Exception) {
            }
        }
        return false
    }

    @RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
    private fun readSteps(activity: Activity, ranges: List<List<Number>>, result: MethodChannel.Result) {
        val manager = activity.getSystemService(HealthConnectManager::class.java)
        if (manager == null || ranges.isEmpty() || status(activity) != "granted") return result.success(null)
        val counts = LongArray(ranges.size)
        val left = AtomicInteger(ranges.size)
        val failed = AtomicBoolean(false)
        fun finish() {
            if (left.decrementAndGet() == 0) result.success(if (failed.get()) null else counts.toList())
        }
        ranges.forEachIndexed { i, range ->
            val filter = TimeInstantRangeFilter.Builder()
                .setStartTime(Instant.ofEpochMilli(range[0].toLong()))
                .setEndTime(Instant.ofEpochMilli(range[1].toLong()))
                .build()
            val request = AggregateRecordsRequest.Builder<Long>(filter)
                .addAggregationType(StepsRecord.STEPS_COUNT_TOTAL)
                .build()
            try {
                manager.aggregate(
                    request,
                    activity.mainExecutor,
                    object : OutcomeReceiver<AggregateRecordsResponse<Long>, HealthConnectException> {
                        override fun onResult(response: AggregateRecordsResponse<Long>) {
                            counts[i] = response.get(StepsRecord.STEPS_COUNT_TOTAL) ?: 0L
                            finish()
                        }

                        override fun onError(error: HealthConnectException) {
                            failed.set(true)
                            finish()
                        }
                    },
                )
            } catch (e: Exception) {
                failed.set(true)
                finish()
            }
        }
    }
}
