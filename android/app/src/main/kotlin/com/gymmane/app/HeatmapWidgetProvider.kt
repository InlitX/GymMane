package com.gymmane.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HeatmapWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_heatmap).apply {
                bindThemedImage(context, widgetData, "heatmap_img", R.drawable.preview_heatmap)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
