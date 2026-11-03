package com.gymmane.app

import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.os.Handler
import android.os.Looper
import android.speech.tts.TextToSpeech
import android.speech.tts.UtteranceProgressListener
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

object VoiceBridge {
    const val CHANNEL = "gymmane/voice"
    private var tts: TextToSpeech? = null
    private var ready = false
    private var starting = false
    private val waiting = mutableListOf<() -> Unit>()
    private var listening: MethodChannel.Result? = null
    private var testId = ""
    private var tests = 0
    private val main = Handler(Looper.getMainLooper())

    fun attach(context: Context, channel: MethodChannel) {
        val app = context.applicationContext
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "say" -> {
                    val text = call.argument<String>("text") ?: ""
                    val lang = call.argument<String>("lang") ?: ""
                    if (text.isNotEmpty()) ensure(app) { if (ready) speak(text, lang) }
                    finish()
                    result.success(true)
                }
                "sayWait" -> {
                    val text = call.argument<String>("text") ?: ""
                    val lang = call.argument<String>("lang") ?: ""
                    finish()
                    if (text.isEmpty()) {
                        result.success(false)
                    } else {
                        listening = result
                        tests++
                        val id = "gymmane-test-$tests"
                        testId = id
                        ensure(app) { if (ready) speak(text, lang, id) else finish() }
                    }
                }
                "stop" -> {
                    finish()
                    try {
                        tts?.stop()
                    } catch (_: Exception) {
                    }
                    result.success(true)
                }
                "check" -> {
                    val lang = call.argument<String>("lang") ?: ""
                    ensure(app) { result.success(status(lang)) }
                }
                "settings" -> {
                    result.success(
                        try {
                            app.startActivity(Intent("com.android.settings.TTS_SETTINGS").addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                            true
                        } catch (_: Exception) {
                            false
                        }
                    )
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun ensure(context: Context, then: () -> Unit) {
        if (ready && tts != null) {
            then()
            return
        }
        waiting.add(then)
        if (starting) return
        starting = true
        tts = TextToSpeech(context) { st ->
            ready = st == TextToSpeech.SUCCESS
            starting = false
            if (ready) {
                tts?.setOnUtteranceProgressListener(object : UtteranceProgressListener() {
                    override fun onStart(id: String?) {}
                    override fun onDone(id: String?) {
                        main.post { if (id == testId) finish() }
                    }
                    @Deprecated("Deprecated in Java")
                    override fun onError(id: String?) {
                        main.post { if (id == testId) finish() }
                    }
                    override fun onStop(id: String?, interrupted: Boolean) {
                        main.post { if (id == testId) finish() }
                    }
                })
            }
            if (!ready) {
                try {
                    tts?.shutdown()
                } catch (_: Exception) {
                }
                tts = null
            }
            val run = waiting.toList()
            waiting.clear()
            run.forEach { it() }
        }
    }

    private fun status(lang: String): String {
        val engine = tts
        if (!ready || engine == null) return "noEngine"
        if (lang.isEmpty()) return "ok"
        return try {
            if (engine.isLanguageAvailable(Locale.forLanguageTag(lang)) >= TextToSpeech.LANG_AVAILABLE) "ok" else "noLang"
        } catch (_: Exception) {
            "noLang"
        }
    }

    private fun finish() {
        val r = listening ?: return
        listening = null
        r.success(true)
    }

    private fun speak(text: String, lang: String, id: String = "gymmane") {
        val engine = tts ?: return
        try {
            if (lang.isNotEmpty()) engine.setLanguage(Locale.forLanguageTag(lang))
            engine.setAudioAttributes(
                AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_ASSISTANCE_NAVIGATION_GUIDANCE)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                    .build()
            )
            engine.speak(text, TextToSpeech.QUEUE_FLUSH, null, id)
        } catch (_: Exception) {
            if (id == testId) finish()
        }
    }
}
