package com.gymmane.app

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "gymmane/gallery")
            .setMethodCallHandler { call, result ->
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
