package com.gymmane.app

import android.app.Activity
import android.app.ActivityManager
import android.app.ApplicationExitInfo
import android.content.Context
import android.content.Intent
import android.opengl.EGL14
import android.opengl.EGLConfig
import android.opengl.GLES20
import android.os.Build
import kotlin.system.exitProcess

object GraphicsMode {
    const val DISABLE_IMPELLER = "--enable-impeller=false"
    private const val PREFS = "gymmane_graphics"
    private const val KEY_MODE = "mode"
    private const val KEY_GPU = "gpu"
    private const val KEY_LAUNCH = "launchAt"
    private const val KEY_REACHED = "reached"
    private const val KEY_STRIKES = "strikes"
    private const val KEY_STUCK = "stuck"
    private const val EARLY_MS = 20_000L
    private val badGpus = Regex("Mali-G(31|51|52|71|72|76)\\b|PowerVR Rogue GE8\\d{3}")

    fun judgeLastLaunch(context: Context) {
        val p = prefs(context)
        val launchAt = p.getLong(KEY_LAUNCH, 0L)
        if (launchAt == 0L) return
        val failed = !p.getBoolean(KEY_REACHED, false) || diedEarly(context, launchAt)
        val strikes = if (failed) p.getInt(KEY_STRIKES, 0) + 1 else 0
        val edit = p.edit().putLong(KEY_LAUNCH, 0L).putInt(KEY_STRIKES, strikes)
        if (strikes >= 2) edit.putBoolean(KEY_STUCK, true)
        edit.commit()
    }

    fun starting(context: Context) {
        judgeLastLaunch(context)
        prefs(context).edit().putLong(KEY_LAUNCH, System.currentTimeMillis()).putBoolean(KEY_REACHED, false).commit()
    }

    fun ready(context: Context) {
        prefs(context).edit().putBoolean(KEY_REACHED, true).apply()
    }

    private fun diedEarly(context: Context, launchAt: Long): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return false
        return try {
            val manager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            manager.getHistoricalProcessExitReasons(context.packageName, 0, 3).any {
                (it.reason == ApplicationExitInfo.REASON_CRASH_NATIVE || it.reason == ApplicationExitInfo.REASON_ANR) &&
                    it.timestamp in launchAt..(launchAt + EARLY_MS)
            }
        } catch (e: Throwable) {
            false
        }
    }

    fun mode(context: Context): String =
        prefs(context).getString(KEY_MODE, "auto") ?: "auto"

    fun gpu(context: Context): String {
        val p = prefs(context)
        p.getString(KEY_GPU, null)?.let { return it }
        val name = renderer()
        p.edit().putString(KEY_GPU, name).commit()
        return name
    }

    fun detected(context: Context): Boolean =
        badGpus.containsMatchIn(gpu(context)) || prefs(context).getBoolean(KEY_STUCK, false)

    fun compat(context: Context): Boolean = when (mode(context)) {
        "compat" -> true
        "normal" -> false
        else -> detected(context)
    }

    fun setAndRestart(activity: Activity, compat: Boolean) {
        val mode = if (compat == detected(activity)) "auto" else if (compat) "compat" else "normal"
        prefs(activity).edit().putString(KEY_MODE, mode).commit()
        val launch = activity.packageManager.getLaunchIntentForPackage(activity.packageName) ?: return
        launch.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
        activity.startActivity(launch)
        activity.finishAffinity()
        exitProcess(0)
    }

    private fun prefs(context: Context) =
        context.applicationContext.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    private fun renderer(): String {
        val display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY)
        if (display == EGL14.EGL_NO_DISPLAY) return ""
        val version = IntArray(2)
        if (!EGL14.eglInitialize(display, version, 0, version, 1)) return ""
        try {
            val configs = arrayOfNulls<EGLConfig>(1)
            val count = IntArray(1)
            val attrs = intArrayOf(
                EGL14.EGL_RENDERABLE_TYPE, EGL14.EGL_OPENGL_ES2_BIT,
                EGL14.EGL_SURFACE_TYPE, EGL14.EGL_PBUFFER_BIT,
                EGL14.EGL_NONE,
            )
            if (!EGL14.eglChooseConfig(display, attrs, 0, configs, 0, 1, count, 0) || count[0] == 0) return ""
            val config = configs[0] ?: return ""
            val context = EGL14.eglCreateContext(
                display, config, EGL14.EGL_NO_CONTEXT,
                intArrayOf(EGL14.EGL_CONTEXT_CLIENT_VERSION, 2, EGL14.EGL_NONE), 0,
            )
            if (context == EGL14.EGL_NO_CONTEXT) return ""
            val surface = EGL14.eglCreatePbufferSurface(
                display, config, intArrayOf(EGL14.EGL_WIDTH, 1, EGL14.EGL_HEIGHT, 1, EGL14.EGL_NONE), 0,
            )
            try {
                if (surface == EGL14.EGL_NO_SURFACE || !EGL14.eglMakeCurrent(display, surface, surface, context)) return ""
                return GLES20.glGetString(GLES20.GL_RENDERER) ?: ""
            } finally {
                EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT)
                if (surface != EGL14.EGL_NO_SURFACE) EGL14.eglDestroySurface(display, surface)
                EGL14.eglDestroyContext(display, context)
            }
        } catch (e: Throwable) {
            return ""
        } finally {
            EGL14.eglTerminate(display)
        }
    }
}
