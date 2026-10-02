package com.gymmane.app

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import java.util.Calendar
import java.util.Locale

fun RemoteViews.bindThemedImage(context: Context, widgetData: SharedPreferences, key: String, preview: Int) {
    val day = widgetData.getString(key, null)?.let { BitmapFactory.decodeFile(it) }
    val night = widgetData.getString("${key}_night", null)?.let { BitmapFactory.decodeFile(it) } ?: day
    bindThemedBitmaps(context, day, night, preview)
}

fun RemoteViews.bindThemedBitmaps(context: Context, day: Bitmap?, night: Bitmap?, preview: Int) {
    val shown = day ?: night
    if (shown == null) {
        setImageViewResource(R.id.widget_image, preview)
        setImageViewResource(R.id.widget_image_night, preview)
    } else {
        setImageViewBitmap(R.id.widget_image, shown)
        setImageViewBitmap(R.id.widget_image_night, night ?: shown)
    }
    val open = PendingIntent.getActivity(
        context,
        0,
        Intent(context, MainActivity::class.java),
        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
    )
    setOnClickPendingIntent(R.id.widget_image, open)
    setOnClickPendingIntent(R.id.widget_image_night, open)
}

fun dayStamp(day: Calendar): String = String.format(
    Locale.ROOT,
    "%04d-%02d-%02d",
    day.get(Calendar.YEAR),
    day.get(Calendar.MONTH) + 1,
    day.get(Calendar.DAY_OF_MONTH)
)

fun weekdayIndex(day: Calendar) = (day.get(Calendar.DAY_OF_WEEK) + 5) % 7

abstract class DayWidgetProvider : HomeWidgetProvider() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action in rollover) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, javaClass))
            if (ids.isNotEmpty()) onUpdate(context, manager, ids)
            return
        }
        super.onReceive(context, intent)
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        context.getSystemService(AlarmManager::class.java)?.cancel(newDayIntent(context))
    }

    protected fun scheduleNewDay(context: Context) {
        val alarms = context.getSystemService(AlarmManager::class.java) ?: return
        val next = Calendar.getInstance().apply {
            add(Calendar.DAY_OF_YEAR, 1)
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 5)
            set(Calendar.MILLISECOND, 0)
        }
        alarms.setAndAllowWhileIdle(AlarmManager.RTC, next.timeInMillis, newDayIntent(context))
    }

    private fun newDayIntent(context: Context): PendingIntent = PendingIntent.getBroadcast(
        context,
        javaClass.name.hashCode(),
        Intent(context, javaClass).setAction(ACTION_NEW_DAY),
        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
    )

    companion object {
        private const val ACTION_NEW_DAY = "com.gymmane.app.NEW_DAY"
        private val rollover = setOf(
            ACTION_NEW_DAY,
            Intent.ACTION_TIME_CHANGED,
            Intent.ACTION_TIMEZONE_CHANGED
        )
    }
}
