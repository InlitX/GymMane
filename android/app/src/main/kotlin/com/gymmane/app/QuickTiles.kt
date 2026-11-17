package com.gymmane.app

import android.app.Activity
import android.app.PendingIntent
import android.app.StatusBarManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.drawable.Icon
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import io.flutter.plugin.common.MethodChannel

object QuickTiles {
    const val CHANNEL = "gymmane/qs"
    private const val PREFS = "gymmane_qs"

    fun attach(activity: Activity, ch: MethodChannel) {
        ch.setMethodCallHandler { call, result ->
            when (call.method) {
                "update" -> {
                    activity.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                        .putString("today", call.argument<String>("today") ?: "")
                        .putString("pass", call.argument<String>("pass") ?: "")
                        .putString("todayLabel", call.argument<String>("todayLabel") ?: "")
                        .putString("passLabel", call.argument<String>("passLabel") ?: "")
                        .apply()
                    refresh(activity)
                    result.success(null)
                }
                "canAdd" -> result.success(Build.VERSION.SDK_INT >= 33)
                "add" -> add(activity, call.argument<String>("tile") ?: "today", result)
                else -> result.notImplemented()
            }
        }
    }

    fun refresh(context: Context) {
        for (c in listOf(TodayTileService::class.java, PassTileService::class.java)) {
            runCatching { TileService.requestListeningState(context, ComponentName(context, c)) }
        }
    }

    fun text(context: Context, key: String): String =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(key, "") ?: ""

    private fun add(activity: Activity, tile: String, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < 33) {
            result.success("unsupported")
            return
        }
        val pass = tile == "pass"
        val service = if (pass) PassTileService::class.java else TodayTileService::class.java
        val label = text(activity, if (pass) "passLabel" else "todayLabel").ifEmpty { "GymMane" }
        val icon = Icon.createWithResource(activity, if (pass) R.drawable.ic_qs_pass else R.drawable.ic_qs_today)
        val manager = activity.getSystemService(StatusBarManager::class.java)
        if (manager == null) {
            result.success("unsupported")
            return
        }
        runCatching {
            manager.requestAddTileService(ComponentName(activity, service), label, icon, activity.mainExecutor) { code ->
                result.success(
                    when (code) {
                        StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ADDED -> "added"
                        StatusBarManager.TILE_ADD_REQUEST_RESULT_TILE_ALREADY_ADDED -> "already"
                        else -> "no"
                    },
                )
            }
        }.onFailure { result.success("unsupported") }
    }
}

abstract class OpenTile : TileService() {
    abstract val route: String
    abstract val labelKey: String
    abstract val subtitleKey: String

    override fun onStartListening() {
        super.onStartListening()
        val tile = qsTile ?: return
        tile.state = Tile.STATE_INACTIVE
        val label = QuickTiles.text(this, labelKey)
        if (label.isNotEmpty()) tile.label = label
        if (Build.VERSION.SDK_INT >= 29) {
            tile.subtitle = QuickTiles.text(this, subtitleKey).ifEmpty { null }
        }
        tile.updateTile()
    }

    override fun onClick() {
        super.onClick()
        val intent = Intent(this, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
            putExtra(OPEN_EXTRA, route)
        }
        val open = Runnable {
            if (Build.VERSION.SDK_INT >= 34) {
                val pending = PendingIntent.getActivity(
                    this,
                    route.hashCode(),
                    intent,
                    PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
                )
                startActivityAndCollapse(pending)
            } else {
                @Suppress("DEPRECATION")
                startActivityAndCollapse(intent)
            }
        }
        if (isLocked) unlockAndRun(open) else open.run()
    }
}

class TodayTileService : OpenTile() {
    override val route = "today"
    override val labelKey = "todayLabel"
    override val subtitleKey = "today"
}

class PassTileService : OpenTile() {
    override val route = "pass"
    override val labelKey = "passLabel"
    override val subtitleKey = "pass"
}
