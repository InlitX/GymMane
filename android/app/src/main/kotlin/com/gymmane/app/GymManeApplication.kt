package com.gymmane.app

import android.app.Application
import io.flutter.FlutterInjector

class GymManeApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        if (!GraphicsMode.compat(this)) return
        try {
            val loader = FlutterInjector.instance().flutterLoader()
            loader.startInitialization(this)
            loader.ensureInitializationComplete(this, arrayOf(GraphicsMode.DISABLE_IMPELLER))
        } catch (e: Throwable) {
        }
    }
}
