package com.gymmane.app

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.nfc.NdefMessage
import android.nfc.NdefRecord
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.Ndef
import android.nfc.tech.NdefFormatable
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import io.flutter.plugin.common.MethodChannel

object NfcBridge {
    const val CHANNEL = "gymmane/nfc"
    private const val SCHEME = "gymmane"
    private const val HOST = "today"
    private const val ALIAS = "com.gymmane.app.NfcToday"
    private var channel: MethodChannel? = null
    @Volatile private var writing = false
    private val main = Handler(Looper.getMainLooper())

    fun attach(activity: Activity, ch: MethodChannel) {
        channel = ch
        ch.setMethodCallHandler { call, result ->
            when (call.method) {
                "state" -> {
                    val adapter = NfcAdapter.getDefaultAdapter(activity)
                    result.success(mapOf("available" to (adapter != null), "enabled" to (adapter?.isEnabled == true)))
                }
                "listen" -> {
                    listen(activity, call.argument<Boolean>("on") == true)
                    result.success(null)
                }
                "write" -> result.success(startWrite(activity))
                "cancel" -> {
                    stopWrite(activity)
                    result.success(null)
                }
                "settings" -> {
                    runCatching { activity.startActivity(Intent(Settings.ACTION_NFC_SETTINGS)) }
                        .onFailure { runCatching { activity.startActivity(Intent(Settings.ACTION_WIRELESS_SETTINGS)) } }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    fun detach(activity: Activity) {
        stopWrite(activity)
        channel = null
    }

    fun resume(activity: Activity) {
        if (writing) enableReader(activity)
    }

    fun pause(activity: Activity) {
        runCatching { NfcAdapter.getDefaultAdapter(activity)?.disableReaderMode(activity) }
    }

    fun isToday(intent: Intent?): Boolean {
        if (intent?.action != NfcAdapter.ACTION_NDEF_DISCOVERED) return false
        val uri = intent.data ?: return false
        if (uri.scheme != SCHEME || uri.host != HOST) return false
        intent.action = Intent.ACTION_MAIN
        intent.data = null
        return true
    }

    private fun listen(context: Context, on: Boolean) {
        val state = if (on) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED
        val component = ComponentName(context.packageName, ALIAS)
        runCatching {
            if (context.packageManager.getComponentEnabledSetting(component) != state) {
                context.packageManager.setComponentEnabledSetting(component, state, PackageManager.DONT_KILL_APP)
            }
        }
    }

    private fun startWrite(activity: Activity): Boolean {
        val adapter = NfcAdapter.getDefaultAdapter(activity) ?: return false
        if (!adapter.isEnabled) return false
        writing = true
        enableReader(activity)
        return true
    }

    private fun stopWrite(activity: Activity) {
        writing = false
        pause(activity)
    }

    private fun enableReader(activity: Activity) {
        val adapter = NfcAdapter.getDefaultAdapter(activity) ?: return
        val flags = NfcAdapter.FLAG_READER_NFC_A or NfcAdapter.FLAG_READER_NFC_B or
            NfcAdapter.FLAG_READER_NFC_F or NfcAdapter.FLAG_READER_NFC_V
        runCatching { adapter.enableReaderMode(activity, { tag -> onTag(activity, tag) }, flags, null) }
    }

    private fun message(): NdefMessage =
        NdefMessage(arrayOf(NdefRecord.createUri(Uri.Builder().scheme(SCHEME).authority(HOST).build())))

    private fun onTag(activity: Activity, tag: Tag) {
        if (!writing) return
        val outcome = write(tag, message())
        if (outcome == "ok") {
            writing = false
            main.post { pause(activity) }
        }
        main.post { channel?.invokeMethod("written", outcome) }
    }

    private fun holds(tag: Tag, bytes: ByteArray): Boolean {
        val ndef = Ndef.get(tag) ?: return false
        return try {
            ndef.connect()
            ndef.ndefMessage?.toByteArray()?.contentEquals(bytes) == true
        } catch (_: Exception) {
            false
        } finally {
            runCatching { ndef.close() }
        }
    }

    private fun write(tag: Tag, message: NdefMessage): String {
        val bytes = message.toByteArray()
        if (holds(tag, bytes)) return "ok"
        Ndef.get(tag)?.let { ndef ->
            val outcome = try {
                ndef.connect()
                when {
                    !ndef.isWritable -> "locked"
                    ndef.maxSize < bytes.size -> "small"
                    else -> {
                        ndef.writeNdefMessage(message)
                        val back = runCatching { ndef.ndefMessage?.toByteArray() }.getOrNull()
                        if (back == null || back.contentEquals(bytes)) "ok" else "lost"
                    }
                }
            } catch (_: Exception) {
                "lost"
            } finally {
                runCatching { ndef.close() }
            }
            return if (outcome == "lost" && holds(tag, bytes)) "ok" else outcome
        }
        NdefFormatable.get(tag)?.let { blank ->
            val outcome = try {
                blank.connect()
                blank.format(message)
                "ok"
            } catch (_: Exception) {
                "lost"
            } finally {
                runCatching { blank.close() }
            }
            return if (outcome == "lost" && holds(tag, bytes)) "ok" else outcome
        }
        return "unsupported"
    }
}
