package com.gymmane.app

import android.content.ComponentName
import android.content.Context
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodChannel

object AppIconBridge {
    const val CHANNEL = "gymmane/app_icon"
    private const val DEFAULT = "default"
    private val NAMES = listOf(
        DEFAULT, "light", "sand", "graphite", "sage", "night",
        "material", "medal", "glass", "stopwatch", "marble",
    )

    fun attach(context: Context, channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "current" -> result.success(current(context))
                "set" -> {
                    val name = call.argument<String>("name")
                    if (name == null || name !in NAMES) {
                        result.success(false)
                    } else {
                        result.success(runCatching { set(context, name) }.isSuccess)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun component(context: Context, name: String): ComponentName {
        val alias = "Icon" + name.replaceFirstChar { it.uppercase() }
        return ComponentName(context.packageName, "com.gymmane.app.$alias")
    }

    private fun current(context: Context): String {
        val pm = context.packageManager
        for (name in NAMES) {
            if (name == DEFAULT) continue
            if (pm.getComponentEnabledSetting(component(context, name)) == PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                return name
            }
        }
        return DEFAULT
    }

    private fun set(context: Context, name: String) {
        if (current(context) == name) return
        val pm = context.packageManager
        pm.setComponentEnabledSetting(
            component(context, name),
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
            PackageManager.DONT_KILL_APP,
        )
        for (other in NAMES) {
            if (other == name) continue
            val state = if (other == DEFAULT) {
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            } else {
                PackageManager.COMPONENT_ENABLED_STATE_DEFAULT
            }
            pm.setComponentEnabledSetting(component(context, other), state, PackageManager.DONT_KILL_APP)
        }
    }
}
