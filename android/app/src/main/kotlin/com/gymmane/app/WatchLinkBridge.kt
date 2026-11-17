package com.gymmane.app

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothClass
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothServerSocket
import android.bluetooth.BluetoothSocket
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import io.flutter.plugin.common.MethodChannel
import java.io.DataInputStream
import java.io.DataOutputStream
import java.util.UUID
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

@SuppressLint("MissingPermission")
object WatchLinkBridge {
    const val CHANNEL = "gymmane/watchlink"
    private const val REQUEST_CODE = 4391
    private const val NAME = "GymMane"
    private const val MAX = 48 * 1024 * 1024
    private val SECURE: UUID = UUID.fromString("6a0f3c1e-5b7d-4e2a-9c41-8d2f7b1e6a53")
    private val OPEN: UUID = UUID.fromString("6a0f3c1e-5b7d-4e2a-9c41-8d2f7b1e6a54")
    private val main = Handler(Looper.getMainLooper())
    private var channel: MethodChannel? = null
    private var pending: MethodChannel.Result? = null
    @Volatile private var generation = 0
    private val servers = mutableListOf<BluetoothServerSocket>()

    fun attach(activity: Activity, ch: MethodChannel) {
        channel = ch
        ch.setMethodCallHandler { call, result ->
            when (call.method) {
                "state" -> result.success(state(activity))
                "permission" -> askPermission(activity, result)
                "listen" -> {
                    if (call.argument<Boolean>("on") == true) startServer(activity) else stopServer()
                    result.success(null)
                }
                "exchange" -> exchange(
                    activity,
                    call.argument<ByteArray>("data") ?: ByteArray(0),
                    call.argument<String>("last") ?: "",
                    call.argument<Boolean>("toWatch") == true,
                    result,
                )
                "settings" -> {
                    runCatching { activity.startActivity(Intent(Settings.ACTION_BLUETOOTH_SETTINGS)) }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    fun detach() {
        stopServer()
        channel = null
    }

    fun onPermissionResult(requestCode: Int, results: IntArray): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val result = pending ?: return true
        pending = null
        result.success(results.isNotEmpty() && results.all { it == PackageManager.PERMISSION_GRANTED })
        return true
    }

    private fun adapter(context: Context): BluetoothAdapter? =
        (context.getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager)?.adapter

    private fun granted(context: Context): Boolean =
        Build.VERSION.SDK_INT < 31 ||
            context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED

    private fun state(context: Context): Map<String, Any> {
        val a = adapter(context)
        val ok = granted(context)
        return mapOf(
            "available" to (a != null),
            "granted" to ok,
            "enabled" to (ok && runCatching { a?.isEnabled == true }.getOrDefault(false)),
        )
    }

    private fun askPermission(activity: Activity, result: MethodChannel.Result) {
        if (granted(activity)) {
            result.success(true)
            return
        }
        pending?.success(false)
        pending = result
        activity.requestPermissions(arrayOf(Manifest.permission.BLUETOOTH_CONNECT), REQUEST_CODE)
    }

    @Synchronized
    private fun startServer(context: Context) {
        if (servers.isNotEmpty() || !granted(context)) return
        val a = adapter(context) ?: return
        val gen = ++generation
        accept(gen) { a.listenUsingRfcommWithServiceRecord(NAME, SECURE) }
        accept(gen) { a.listenUsingInsecureRfcommWithServiceRecord(NAME, OPEN) }
    }

    private fun accept(gen: Int, open: () -> BluetoothServerSocket) {
        Thread {
            while (generation == gen) {
                var s: BluetoothServerSocket? = null
                try {
                    s = open()
                    synchronized(this) {
                        if (generation != gen) {
                            runCatching { s.close() }
                            return@Thread
                        }
                        servers.add(s)
                    }
                    while (generation == gen) serve(s.accept())
                } catch (_: Exception) {
                    if (generation == gen) runCatching { Thread.sleep(3000) }
                } finally {
                    if (s != null) {
                        synchronized(this) { servers.remove(s) }
                        runCatching { s.close() }
                    }
                }
            }
        }.apply {
            isDaemon = true
            start()
        }
    }

    @Synchronized
    private fun stopServer() {
        generation++
        for (s in servers.toList()) runCatching { s.close() }
        servers.clear()
    }

    private fun serve(sock: BluetoothSocket) {
        try {
            val input = DataInputStream(sock.inputStream)
            val output = DataOutputStream(sock.outputStream)
            val request = readFrame(input)
            val name = runCatching { sock.remoteDevice.name }.getOrNull() ?: ""
            val address = runCatching { sock.remoteDevice.address }.getOrNull() ?: ""
            val latch = CountDownLatch(1)
            var reply: ByteArray? = null
            main.post {
                val ch = channel
                if (ch == null) {
                    latch.countDown()
                    return@post
                }
                ch.invokeMethod(
                    "request",
                    mapOf("data" to request, "name" to name, "address" to address),
                    object : MethodChannel.Result {
                        override fun success(value: Any?) {
                            reply = value as? ByteArray
                            latch.countDown()
                        }

                        override fun error(code: String, message: String?, details: Any?) {
                            latch.countDown()
                        }

                        override fun notImplemented() {
                            latch.countDown()
                        }
                    },
                )
            }
            latch.await(90, TimeUnit.SECONDS)
            writeFrame(output, reply ?: ByteArray(0))
            runCatching { input.read() }
        } catch (_: Exception) {
        } finally {
            runCatching { sock.close() }
        }
    }

    private fun wanted(device: BluetoothDevice, toWatch: Boolean): Boolean {
        val major = runCatching { device.bluetoothClass?.majorDeviceClass }.getOrNull()
            ?: return true
        return when (major) {
            BluetoothClass.Device.Major.WEARABLE, BluetoothClass.Device.Major.UNCATEGORIZED,
            BluetoothClass.Device.Major.MISC, BluetoothClass.Device.Major.HEALTH -> true
            BluetoothClass.Device.Major.PHONE -> !toWatch
            else -> false
        }
    }

    private fun exchange(
        context: Context,
        data: ByteArray,
        last: String,
        toWatch: Boolean,
        result: MethodChannel.Result,
    ) {
        val a = adapter(context)
        if (a == null || !granted(context) || !runCatching { a.isEnabled }.getOrDefault(false)) {
            result.success(null)
            return
        }
        Thread {
            val bonded = runCatching { a.bondedDevices.toList() }.getOrDefault(emptyList())
            val known = bonded.firstOrNull { it.address == last }
            val order = if (known != null) listOf(known) + bonded.filter { it != known && wanted(it, toWatch) }
            else bonded.filter { wanted(it, toWatch) }
            var answer: Map<String, Any>? = null
            for (device in order) {
                val reply = talk(device, data, true) ?: talk(device, data, false) ?: continue
                answer = mapOf(
                    "data" to reply,
                    "name" to (runCatching { device.name }.getOrNull() ?: ""),
                    "address" to device.address,
                )
                break
            }
            main.post { result.success(answer) }
        }.apply {
            isDaemon = true
            start()
        }
    }

    private fun talk(device: BluetoothDevice, data: ByteArray, secure: Boolean): ByteArray? {
        var sock: BluetoothSocket? = null
        return try {
            sock = if (secure) device.createRfcommSocketToServiceRecord(SECURE)
            else device.createInsecureRfcommSocketToServiceRecord(OPEN)
            sock.connect()
            val output = DataOutputStream(sock.outputStream)
            val input = DataInputStream(sock.inputStream)
            writeFrame(output, data)
            val reply = readFrame(input)
            runCatching {
                output.write(1)
                output.flush()
            }
            reply.takeIf { it.isNotEmpty() }
        } catch (_: Exception) {
            null
        } finally {
            runCatching { sock?.close() }
        }
    }

    private fun readFrame(input: DataInputStream): ByteArray {
        val n = input.readInt()
        if (n < 0 || n > MAX) throw IllegalStateException("size")
        val bytes = ByteArray(n)
        input.readFully(bytes)
        return bytes
    }

    private fun writeFrame(output: DataOutputStream, bytes: ByteArray) {
        output.writeInt(bytes.size)
        output.write(bytes)
        output.flush()
    }
}
