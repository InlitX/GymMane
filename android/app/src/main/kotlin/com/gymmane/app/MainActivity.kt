package com.gymmane.app

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import android.provider.MediaStore
import android.view.InputDevice
import android.view.MotionEvent
import android.view.ViewConfiguration
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private var incomingChannel: MethodChannel? = null
    private var rotaryChannel: MethodChannel? = null
    private var openChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, "gymmane/haptics").setMethodCallHandler { call, result ->
            if (call.method != "buzz") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            buzz()
            result.success(null)
        }

        val incoming = MethodChannel(messenger, "gymmane/incoming")
        incoming.setMethodCallHandler { call, result ->
            if (call.method != "take") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            result.success(takeIncoming(intent))
        }
        incomingChannel = incoming

        MethodChannel(messenger, "gymmane/gallery").setMethodCallHandler { call, result ->
            if (call.method != "savePng") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val bytes = call.argument<ByteArray>("bytes")
            val name = call.argument<String>("name") ?: "gymmane.png"
            if (bytes == null) {
                result.error("no-bytes", "missing image", null)
                return@setMethodCallHandler
            }
            try {
                result.success(savePng(bytes, name))
            } catch (e: Exception) {
                result.error("save-failed", e.message, null)
            }
        }

        MethodChannel(messenger, "gymmane/screen").setMethodCallHandler { call, result ->
            val on = call.argument<Boolean>("on") ?: false
            when (call.method) {
                "keepOn" -> {
                    if (on) {
                        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                    } else {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                    }
                    result.success(null)
                }
                "bright" -> {
                    val params = window.attributes
                    params.screenBrightness =
                        if (on) WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL else WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE
                    window.attributes = params
                    result.success(null)
                }
                "dim" -> {
                    val params = window.attributes
                    params.screenBrightness =
                        if (on) 0.02f else WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE
                    window.attributes = params
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        rotaryChannel = MethodChannel(messenger, "gymmane/rotary")

        val open = MethodChannel(messenger, "gymmane/open")
        open.setMethodCallHandler { call, result ->
            if (call.method != "take") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            result.success(takeOpen(intent))
        }
        openChannel = open

        val live = MethodChannel(messenger, "gymmane/live")
        live.setMethodCallHandler { call, result ->
            when (call.method) {
                "update" -> {
                    val args = call.arguments as? Map<*, *>
                    if (args != null) LiveNotifier.update(this, args)
                    result.success(null)
                }
                "end" -> {
                    LiveNotifier.cancel(this)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
        LiveNotifier.dart = live

        MethodChannel(messenger, "gymmane/device").setMethodCallHandler { call, result ->
            when (call.method) {
                "isWatch" -> result.success(packageManager.hasSystemFeature(PackageManager.FEATURE_WATCH))
                "isLowEnd" -> {
                    val am = getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
                    val info = android.app.ActivityManager.MemoryInfo()
                    am.getMemoryInfo(info)
                    result.success(am.isLowRamDevice || info.totalMem < 3_500_000_000L)
                }
                else -> result.notImplemented()
            }
        }

        HealthBridge.attach(this, MethodChannel(messenger, HealthBridge.CHANNEL))
        BackupBridge.attach(this, MethodChannel(messenger, BackupBridge.CHANNEL))
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (BackupBridge.onActivityResult(this, requestCode, resultCode, data)) return
        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if (HealthBridge.onPermissionResult(requestCode, grantResults)) return
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun dispatchGenericMotionEvent(event: MotionEvent): Boolean {
        val channel = rotaryChannel
        if (channel != null &&
            event.action == MotionEvent.ACTION_SCROLL &&
            event.isFromSource(InputDevice.SOURCE_ROTARY_ENCODER)
        ) {
            val factor = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                ViewConfiguration.get(this).scaledVerticalScrollFactor
            } else {
                64f
            }
            channel.invokeMethod("scroll", (-event.getAxisValue(MotionEvent.AXIS_SCROLL) * factor).toDouble())
            return true
        }
        return super.dispatchGenericMotionEvent(event)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        rotaryChannel = null
        openChannel = null
        LiveNotifier.dart = null
        HealthBridge.channel = null
        if (isFinishing) LiveNotifier.cancel(this)
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val open = takeOpen(intent)
        if (open != null) {
            openChannel?.invokeMethod("open", open)
            return
        }
        if (HealthBridge.takeUsage(intent)) {
            HealthBridge.channel?.invokeMethod("usage", null)
            return
        }
        val text = takeIncoming(intent) ?: return
        incomingChannel?.invokeMethod("incoming", text)
    }

    private fun takeOpen(intent: Intent?): String? {
        val route = intent?.getStringExtra(OPEN_EXTRA) ?: return null
        intent.removeExtra(OPEN_EXTRA)
        return route
    }

    private fun takeIncoming(intent: Intent?): String? {
        if (intent == null || intent.action == Intent.ACTION_VIEW_PERMISSION_USAGE) return null
        val text = when (intent.action) {
            Intent.ACTION_VIEW -> intent.data?.let { readText(it) }
            Intent.ACTION_SEND -> streamOf(intent)?.let { readText(it) }
                ?: intent.getStringExtra(Intent.EXTRA_TEXT)
            else -> null
        }
        intent.action = Intent.ACTION_MAIN
        intent.data = null
        return text
    }

    @Suppress("DEPRECATION")
    private fun streamOf(intent: Intent): Uri? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
        } else {
            intent.getParcelableExtra(Intent.EXTRA_STREAM)
        }

    private fun readText(uri: Uri): String? = try {
        contentResolver.openInputStream(uri)?.use { stream ->
            val bytes = stream.readBytes()
            if (bytes.size > 2_000_000) null else String(bytes, Charsets.UTF_8)
        }
    } catch (e: Exception) {
        null
    }

    @Suppress("DEPRECATION")
    private fun buzz() {
        val vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            (getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager).defaultVibrator
        } else {
            getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        }
        val pattern = longArrayOf(0, 350, 180, 350, 180, 600)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrator.vibrate(VibrationEffect.createWaveform(pattern, -1))
        } else {
            vibrator.vibrate(pattern, -1)
        }
    }

    private fun savePng(bytes: ByteArray, name: String): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val values = ContentValues().apply {
                put(MediaStore.Images.Media.DISPLAY_NAME, name)
                put(MediaStore.Images.Media.MIME_TYPE, "image/png")
                put(MediaStore.Images.Media.RELATIVE_PATH, "${Environment.DIRECTORY_PICTURES}/GymMane")
                put(MediaStore.Images.Media.IS_PENDING, 1)
            }
            val resolver = contentResolver
            val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
                ?: return false
            resolver.openOutputStream(uri)?.use { it.write(bytes) } ?: return false
            values.clear()
            values.put(MediaStore.Images.Media.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
            return true
        }

        val dir = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
            "GymMane",
        )
        if (!dir.exists() && !dir.mkdirs()) return false
        val file = File(dir, name)
        FileOutputStream(file).use { it.write(bytes) }
        MediaStore.Images.Media.insertImage(contentResolver, file.absolutePath, name, null)
        return true
    }
}
