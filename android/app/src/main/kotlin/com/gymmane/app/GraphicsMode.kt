package com.gymmane.app

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.opengl.EGL14
import android.opengl.EGLConfig
import android.opengl.GLES20
import kotlin.system.exitProcess

object GraphicsMode {
    const val DISABLE_IMPELLER = "--enable-impeller=false"
    private const val PREFS = "gymmane_graphics"
    private const val KEY_MODE = "mode"
    private const val KEY_GPU = "gpu"
    private val badGpus = Regex("Mali-G(31|51|52|71|72|76)\\b")

    fun mode(context: Context): String =
        prefs(context).getString(KEY_MODE, "auto") ?: "auto"

    fun gpu(context: Context): String {
        val p = prefs(context)
        p.getString(KEY_GPU, null)?.let { return it }
        val name = renderer()
        p.edit().putString(KEY_GPU, name).commit()
        return name
    }

    fun detected(context: Context): Boolean = badGpus.containsMatchIn(gpu(context))

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
