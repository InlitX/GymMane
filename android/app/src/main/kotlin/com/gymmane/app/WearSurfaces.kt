package com.gymmane.app

import android.content.ComponentName
import android.content.Context
import androidx.wear.tiles.TileService
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceUpdateRequester
import io.flutter.plugin.common.MethodChannel

data class WearData(val done: Int, val goal: Int, val streak: Int, val next: String, val live: Boolean)

object WearSurfaces {
    const val CHANNEL = "gymmane/wear"
    private const val PREFS = "gymmane_wear"

    fun attach(context: Context, channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            if (call.method != "update") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val args = call.arguments as? Map<*, *>
            if (args != null) {
                save(context, args)
                refresh(context)
            }
            result.success(null)
        }
    }

    private fun save(context: Context, args: Map<*, *>) {
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
            .putInt("done", (args["done"] as? Number)?.toInt() ?: 0)
            .putInt("goal", (args["goal"] as? Number)?.toInt() ?: 1)
            .putInt("streak", (args["streak"] as? Number)?.toInt() ?: 0)
            .putString("next", args["next"] as? String ?: "")
            .putBoolean("live", args["live"] as? Boolean ?: false)
            .apply()
    }

    fun read(context: Context): WearData {
        val p = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        return WearData(
            done = p.getInt("done", 0),
            goal = p.getInt("goal", 1).coerceAtLeast(1),
            streak = p.getInt("streak", 0),
            next = p.getString("next", "") ?: "",
            live = p.getBoolean("live", false),
        )
    }

    private fun refresh(context: Context) {
        try {
            TileService.getUpdater(context).requestUpdate(GymTileService::class.java)
        } catch (_: Throwable) {
        }
        try {
            ComplicationDataSourceUpdateRequester
                .create(context, ComponentName(context, GymComplicationService::class.java))
                .requestUpdateAll()
        } catch (_: Throwable) {
        }
    }
}
