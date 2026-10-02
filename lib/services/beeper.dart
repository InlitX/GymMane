import 'dart:io';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Beeper {
  Beeper._();

  static final instance = Beeper._();

  AudioPlayer? _player;
  String? _tick;
  String? _go;
  bool _failed = false;
  bool _loud = false;

  set loud(bool on) {
    if (_loud == on) return;
    _loud = on;
    final p = _player;
    if (p != null) p.setAudioContext(_context).catchError((_) {});
  }

  AudioContext get _context => AudioContext(
        android: AudioContextAndroid(
          contentType: AndroidContentType.sonification,
          usageType: _loud ? AndroidUsageType.alarm : AndroidUsageType.notification,
          audioFocus: AndroidAudioFocus.gainTransientMayDuck,
        ),
        iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient, options: const {}),
      );

  Future<bool> _ready() async {
    if (_player != null) return true;
    if (_failed || kIsWeb) return false;
    try {
      final dir = await getTemporaryDirectory();
      _tick = await _write(dir, 'gm_tick2.wav', _tone(880, 0.09));
      _go = await _write(dir, 'gm_go2.wav', _tone(1318.5, 0.32));
      final p = AudioPlayer();
      await p.setReleaseMode(ReleaseMode.stop);
      await p.setAudioContext(_context);
      _player = p;
      return true;
    } catch (_) {
      _failed = true;
      return false;
    }
  }

  Future<void> tick({required bool sound}) => _play(_TickKind.tick, sound);

  Future<void> go({required bool sound}) => _play(_TickKind.go, sound);

  Future<void> _play(_TickKind kind, bool sound) async {
    try {
      kind == _TickKind.go ? HapticFeedback.heavyImpact() : HapticFeedback.selectionClick();
    } catch (_) {}
    if (!sound || !await _ready()) return;
    final path = kind == _TickKind.go ? _go : _tick;
    if (path == null) return;
    try {
      await _player!.stop();
      await _player!.play(DeviceFileSource(path), volume: 1);
    } catch (_) {}
  }

  AudioPlayer? _soft;
  String? _chime;
  DateTime _lastChime = DateTime(2000);

  bool chimeOn = true;

  Future<void> chime() async {
    if (kIsWeb || _failed || !chimeOn) return;
    final now = DateTime.now();
    if (now.difference(_lastChime) < const Duration(milliseconds: 700)) return;
    _lastChime = now;
    try {
      if (_soft == null) {
        final dir = await getTemporaryDirectory();
        _chime = await _write(dir, 'gm_chime1.wav', chimeWav());
        final p = AudioPlayer();
        await p.setReleaseMode(ReleaseMode.stop);
        await p.setAudioContext(AudioContext(
          android: const AudioContextAndroid(
            contentType: AndroidContentType.sonification,
            usageType: AndroidUsageType.notification,
            audioFocus: AndroidAudioFocus.none,
          ),
          iOS: AudioContextIOS(category: AVAudioSessionCategory.ambient, options: const {}),
        ));
        _soft = p;
      }
      await _soft!.stop();
      await _soft!.play(DeviceFileSource(_chime!), volume: 0.55);
    } catch (_) {}
  }

  static Uint8List chimeWav() {
    const rate = 44100;
    const secs = 0.95;
    final n = (rate * secs).round();
    final samples = List<double>.filled(n, 0);
    void note(double hz, double at, double gain, double decay) {
      final start = (at * rate).round();
      for (var i = start; i < n; i++) {
        final t = (i - start) / rate;
        final a = math.min(1.0, t / 0.012);
        final attack = a * a * (3 - 2 * a);
        final body = math.exp(-t * decay);
        final shine = math.exp(-t * decay * 2.6);
        final wave = math.sin(2 * math.pi * hz * t) +
            math.sin(2 * math.pi * hz * 2 * t) * 0.18 * shine +
            math.sin(2 * math.pi * hz * 3 * t) * 0.05 * shine;
        samples[i] += wave * gain * attack * body;
      }
    }

    note(1046.5, 0, 0.42, 5.2);
    note(1568.0, 0.085, 0.34, 4.4);
    final data = ByteData(44 + n * 2);
    void text(int at, String s) {
      for (var i = 0; i < s.length; i++) {
        data.setUint8(at + i, s.codeUnitAt(i));
      }
    }

    text(0, 'RIFF');
    data.setUint32(4, 36 + n * 2, Endian.little);
    text(8, 'WAVE');
    text(12, 'fmt ');
    data.setUint32(16, 16, Endian.little);
    data.setUint16(20, 1, Endian.little);
    data.setUint16(22, 1, Endian.little);
    data.setUint32(24, rate, Endian.little);
    data.setUint32(28, rate * 2, Endian.little);
    data.setUint16(32, 2, Endian.little);
    data.setUint16(34, 16, Endian.little);
    text(36, 'data');
    data.setUint32(40, n * 2, Endian.little);
    for (var i = 0; i < n; i++) {
      final fade = i > n - 2205 ? (n - i) / 2205 : 1.0;
      data.setInt16(44 + i * 2, (samples[i].clamp(-1.0, 1.0) * fade * 32767).round(), Endian.little);
    }
    return data.buffer.asUint8List();
  }

  static Future<String> _write(Directory dir, String name, Uint8List bytes) async {
    final file = File('${dir.path}/$name');
    if (!await file.exists() || await file.length() != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return file.path;
  }

  static Uint8List _tone(double hz, double secs) {
    const rate = 44100;
    final n = (rate * secs).round();
    final data = ByteData(44 + n * 2);
    void text(int at, String s) {
      for (var i = 0; i < s.length; i++) {
        data.setUint8(at + i, s.codeUnitAt(i));
      }
    }

    text(0, 'RIFF');
    data.setUint32(4, 36 + n * 2, Endian.little);
    text(8, 'WAVE');
    text(12, 'fmt ');
    data.setUint32(16, 16, Endian.little);
    data.setUint16(20, 1, Endian.little);
    data.setUint16(22, 1, Endian.little);
    data.setUint32(24, rate, Endian.little);
    data.setUint32(28, rate * 2, Endian.little);
    data.setUint16(32, 2, Endian.little);
    data.setUint16(34, 16, Endian.little);
    text(36, 'data');
    data.setUint32(40, n * 2, Endian.little);
    for (var i = 0; i < n; i++) {
      final t = i / rate;
      final attack = math.min(1.0, i / (rate * 0.004));
      final release = math.exp(-t * (3 / secs));
      final wave = math.sin(2 * math.pi * hz * t) * 0.8 + math.sin(4 * math.pi * hz * t) * 0.2;
      data.setInt16(44 + i * 2, (wave * 0.9 * attack * release * 32767).round(), Endian.little);
    }
    return data.buffer.asUint8List();
  }
}

enum _TickKind { tick, go }
