package com.gymmane.app

import androidx.concurrent.futures.CallbackToFutureAdapter
import androidx.wear.protolayout.ActionBuilders
import androidx.wear.protolayout.ColorBuilders.argb
import androidx.wear.protolayout.DimensionBuilders.degrees
import androidx.wear.protolayout.DimensionBuilders.dp
import androidx.wear.protolayout.DimensionBuilders.expand
import androidx.wear.protolayout.DimensionBuilders.sp
import androidx.wear.protolayout.DimensionBuilders.wrap
import androidx.wear.protolayout.LayoutElementBuilders
import androidx.wear.protolayout.ModifiersBuilders
import androidx.wear.protolayout.ResourceBuilders
import androidx.wear.protolayout.TimelineBuilders
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import com.google.common.util.concurrent.ListenableFuture

class GymTileService : TileService() {
    private val accent = 0xFFD9A184.toInt()
    private val ink = 0xFF0A0A0A.toInt()
    private val track = 0xFF262626.toInt()
    private val white = 0xFFFFFFFF.toInt()
    private val grey = 0xFF9A9A9A.toInt()
    private val faint = 0xFF6A6A6A.toInt()

    override fun onTileRequest(requestParams: RequestBuilders.TileRequest): ListenableFuture<TileBuilders.Tile> =
        CallbackToFutureAdapter.getFuture { completer ->
            val data = WearSurfaces.read(this)
            val tile = TileBuilders.Tile.Builder()
                .setResourcesVersion("1")
                .setFreshnessIntervalMillis(0)
                .setTileTimeline(TimelineBuilders.Timeline.fromLayoutElement(layout(data)))
                .build()
            completer.set(tile)
            "gymmane-tile"
        }

    override fun onTileResourcesRequest(
        requestParams: RequestBuilders.ResourcesRequest
    ): ListenableFuture<ResourceBuilders.Resources> =
        CallbackToFutureAdapter.getFuture { completer ->
            completer.set(ResourceBuilders.Resources.Builder().setVersion("1").build())
            "gymmane-tile-resources"
        }

    private fun text(value: String, size: Float, color: Int, bold: Boolean): LayoutElementBuilders.Text =
        LayoutElementBuilders.Text.Builder()
            .setText(value)
            .setMaxLines(1)
            .setOverflow(LayoutElementBuilders.TEXT_OVERFLOW_ELLIPSIZE_END)
            .setFontStyle(
                LayoutElementBuilders.FontStyle.Builder()
                    .setSize(sp(size))
                    .setColor(argb(color))
                    .setWeight(
                        if (bold) LayoutElementBuilders.FONT_WEIGHT_BOLD else LayoutElementBuilders.FONT_WEIGHT_MEDIUM
                    )
                    .build()
            )
            .build()

    private fun line(sweep: Float, color: Int): LayoutElementBuilders.ArcLine =
        LayoutElementBuilders.ArcLine.Builder()
            .setLength(degrees(sweep))
            .setThickness(dp(6f))
            .setColor(argb(color))
            .build()

    private fun arc(sweep: Float, color: Int): LayoutElementBuilders.Arc =
        LayoutElementBuilders.Arc.Builder()
            .setAnchorAngle(degrees(0f))
            .setAnchorType(LayoutElementBuilders.ARC_ANCHOR_START)
            .addContent(line(sweep, color))
            .build()

    private fun spacer(height: Float): LayoutElementBuilders.Spacer =
        LayoutElementBuilders.Spacer.Builder().setHeight(dp(height)).build()

    private fun open(): ModifiersBuilders.Clickable =
        ModifiersBuilders.Clickable.Builder()
            .setId("open")
            .setOnClick(
                ActionBuilders.LaunchAction.Builder()
                    .setAndroidActivity(
                        ActionBuilders.AndroidActivity.Builder()
                            .setPackageName(packageName)
                            .setClassName(MainActivity::class.java.name)
                            .addKeyToExtraMapping(
                                "gymmane_open",
                                ActionBuilders.AndroidStringExtra.Builder().setValue("play").build()
                            )
                            .build()
                    )
                    .build()
            )
            .build()

    private fun layout(d: WearData): LayoutElementBuilders.LayoutElement {
        val frac = (d.done.toFloat() / d.goal).coerceIn(0f, 1f)
        val edge = LayoutElementBuilders.Box.Builder()
            .setWidth(expand())
            .setHeight(expand())
            .setModifiers(
                ModifiersBuilders.Modifiers.Builder()
                    .setPadding(ModifiersBuilders.Padding.Builder().setAll(dp(4f)).build())
                    .build()
            )
            .addContent(arc(359.9f, track))
            .apply { if (frac > 0f) addContent(arc(if (frac >= 1f) 359.9f else 360f * frac, accent)) }
            .build()

        val score = LayoutElementBuilders.Row.Builder()
            .setVerticalAlignment(LayoutElementBuilders.VERTICAL_ALIGN_BOTTOM)
            .addContent(text("${d.done}", 44f, white, true))
            .addContent(text("/${d.goal}", 22f, faint, true))
            .build()

        val label = if (d.live) getString(R.string.tile_continue) else getString(R.string.tile_start)
        val pill = LayoutElementBuilders.Box.Builder()
            .setWidth(dp(118f))
            .setHeight(dp(44f))
            .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
            .setVerticalAlignment(LayoutElementBuilders.VERTICAL_ALIGN_CENTER)
            .setModifiers(
                ModifiersBuilders.Modifiers.Builder()
                    .setBackground(
                        ModifiersBuilders.Background.Builder()
                            .setColor(argb(white))
                            .setCorner(ModifiersBuilders.Corner.Builder().setRadius(dp(22f)).build())
                            .build()
                    )
                    .setClickable(open())
                    .build()
            )
            .addContent(text(label, 15f, ink, true))
            .build()

        val column = LayoutElementBuilders.Column.Builder()
            .setWidth(wrap())
            .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
        if (d.streak > 0) {
            column.addContent(text(resources.getQuantityString(R.plurals.tile_streak, d.streak, d.streak), 12f, accent, true))
            column.addContent(spacer(2f))
        }
        column.addContent(score)
        column.addContent(text(getString(R.string.tile_week), 12f, grey, false))
        column.addContent(spacer(12f))
        column.addContent(pill)
        if (d.next.isNotEmpty() && !d.live) {
            column.addContent(spacer(6f))
            column.addContent(
                LayoutElementBuilders.Box.Builder()
                    .setWidth(dp(130f))
                    .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
                    .addContent(text(d.next, 12f, grey, false))
                    .build()
            )
        }

        return LayoutElementBuilders.Box.Builder()
            .setWidth(expand())
            .setHeight(expand())
            .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
            .setVerticalAlignment(LayoutElementBuilders.VERTICAL_ALIGN_CENTER)
            .addContent(edge)
            .addContent(column.build())
            .build()
    }
}
