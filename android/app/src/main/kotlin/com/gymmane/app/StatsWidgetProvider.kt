package com.gymmane.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

/// Widget cuadrado de estadísticas (racha + semana + objetivo). Muestra el PNG
/// que renderiza Flutter. Al tocarlo abre la app.
class StatsWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_stats).apply {
                val path = widgetData.getString("stats_img", null)
                if (path != null) {
                    val bmp = BitmapFactory.decodeFile(path)
                    if (bmp != null) setImageViewBitmap(R.id.widget_image, bmp)
                }
                val open = PendingIntent.getActivity(
                    context,
                    0,
                    Intent(context, MainActivity::class.java),
                    PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                )
                setOnClickPendingIntent(R.id.widget_image, open)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
