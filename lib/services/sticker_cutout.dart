import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

class StickerResult {
  const StickerResult(this.png, {required this.cut});

  final Uint8List png;
  final bool cut;
}

Future<StickerResult?> makeSticker(Uint8List source, {bool cutout = true}) async {
  final rgba = await _decode(source, 900);
  if (rgba == null) return null;
  final out = await compute(_process, (rgba.$1, rgba.$2, rgba.$3, cutout));
  final cut = out.$4;
  final png = await _encode(out.$1, out.$2, out.$3);
  return png == null ? null : StickerResult(png, cut: cut);
}

class CutoutDraft {
  const CutoutDraft(this.width, this.height, this.rgba, this.mask, {required this.auto, required this.found});

  final int width;
  final int height;
  final Uint8List rgba;
  final Uint8List mask;
  final Uint8List auto;
  final bool found;

  CutoutDraft withMask(Uint8List next) => CutoutDraft(width, height, rgba, next, auto: auto, found: found);
}

Future<CutoutDraft?> prepareCutout(Uint8List source) async {
  final rgba = await _decode(source, 900);
  if (rgba == null) return null;
  final mask = await compute(_draftMask, rgba);
  final (w, h, px) = rgba;
  final start = mask ?? (Uint8List(w * h)..fillRange(0, w * h, 1));
  return CutoutDraft(w, h, px, start, auto: start, found: mask != null);
}

Uint8List? _draftMask((int, int, Uint8List) args) {
  final (w, h, src) = args;
  return cutoutMask(w, h, src) ?? cutoutMask(w, h, src, force: true);
}

Future<Uint8List?> renderSticker(CutoutDraft draft, Uint8List mask) async {
  var any = false;
  for (final v in mask) {
    if (v != 0) {
      any = true;
      break;
    }
  }
  if (!any) return null;
  final out = await compute(_renderMasked, (draft.width, draft.height, draft.rgba, mask));
  return _encode(out.$1, out.$2, out.$3);
}

(int, int, Uint8List, bool) _renderMasked((int, int, Uint8List, Uint8List) args) {
  final (w, h, src, mask) = args;
  final clean = Uint8List.fromList(mask);
  _open(clean, w, h);
  return _outlined(w, h, src, clean);
}

Future<Uint8List> regionAt(CutoutDraft draft, int x, int y) =>
    compute(_region, (draft.width, draft.height, draft.rgba, x, y));

Uint8List _region((int, int, Uint8List, int, int) args) {
  final (w, h, src, x0, y0) = args;
  final n = w * h;
  final y = Float32List(n), cb = Float32List(n), cr = Float32List(n);
  for (var i = 0; i < n; i++) {
    final r = src[i * 4].toDouble(), g = src[i * 4 + 1].toDouble(), b = src[i * 4 + 2].toDouble();
    final l = 0.299 * r + 0.587 * g + 0.114 * b;
    y[i] = l;
    cb[i] = b - l;
    cr[i] = r - l;
  }
  final wall = _edges(y, w, h);
  _blur(y, w, h);
  _blur(cb, w, h);
  _blur(cr, w, h);
  final seed = y0.clamp(0, h - 1) * w + x0.clamp(0, w - 1);
  double diff(int a, int b) {
    final dy = y[a] - y[b], db = cb[a] - cb[b], dr = cr[a] - cr[b];
    return math.sqrt(0.3 * dy * dy + db * db + dr * dr);
  }

  final out = Uint8List(n);
  final queue = Int32List(n);
  var head = 0, tail = 0;
  out[seed] = 1;
  queue[tail++] = seed;
  while (head < tail) {
    final p = queue[head++];
    final px = p % w, py = p ~/ w;
    for (final q in [if (px > 0) p - 1, if (px < w - 1) p + 1, if (py > 0) p - w, if (py < h - 1) p + w]) {
      if (out[q] != 0) continue;
      if (diff(q, seed) <= 34 && diff(p, q) <= 10 && (wall[q] == 0 || diff(q, seed) <= 14)) {
        out[q] = 1;
        queue[tail++] = q;
      }
    }
  }
  for (var pass = 0; pass < 2; pass++) {
    final grow = <int>[];
    for (var i = 0; i < n; i++) {
      if (out[i] != 0) continue;
      final px = i % w, py = i ~/ w;
      if ((px > 0 && out[i - 1] != 0) ||
          (px < w - 1 && out[i + 1] != 0) ||
          (py > 0 && out[i - w] != 0) ||
          (py < h - 1 && out[i + w] != 0)) {
        grow.add(i);
      }
    }
    for (final i in grow) {
      out[i] = 1;
    }
  }
  _fillHoles(out, w, h);
  return out;
}

Future<(int, int, Uint8List)?> _decode(Uint8List bytes, int maxSide) async {
  try {
    final probe = await ui.instantiateImageCodec(bytes);
    final first = (await probe.getNextFrame()).image;
    final w = first.width, h = first.height;
    final scale = math.min(1.0, maxSide / math.max(w, h));
    ui.Image image = first;
    if (scale < 1) {
      first.dispose();
      final codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: (w * scale).round(),
        targetHeight: (h * scale).round(),
      );
      image = (await codec.getNextFrame()).image;
    }
    final data = await image.toByteData(format: ui.ImageByteFormat.rawStraightRgba);
    final result = (image.width, image.height, data!.buffer.asUint8List());
    image.dispose();
    return result;
  } catch (_) {
    return null;
  }
}

Future<Uint8List?> _encode(int w, int h, Uint8List rgba) async {
  final done = Completer<ui.Image>();
  ui.decodeImageFromPixels(rgba, w, h, ui.PixelFormat.rgba8888, done.complete);
  final image = await done.future;
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return png?.buffer.asUint8List();
}

(int, int, Uint8List, bool) _process((int, int, Uint8List, bool) args) {
  final (w, h, src, wantCut) = args;
  final mask = wantCut ? (cutoutMask(w, h, src) ?? cutoutMask(w, h, src, force: true)) : null;
  return mask == null ? _framed(w, h, src) : _outlined(w, h, src, mask);
}

@visibleForTesting
Uint8List? cutoutMask(int w, int h, Uint8List src, {bool force = false}) {
  final n = w * h;
  final y = Float32List(n), cb = Float32List(n), cr = Float32List(n);
  for (var i = 0; i < n; i++) {
    final r = src[i * 4].toDouble(), g = src[i * 4 + 1].toDouble(), b = src[i * 4 + 2].toDouble();
    final l = 0.299 * r + 0.587 * g + 0.114 * b;
    y[i] = l;
    cb[i] = b - l;
    cr[i] = r - l;
  }
  final wall = _edges(y, w, h);
  _blur(y, w, h);
  _blur(cb, w, h);
  _blur(cr, w, h);

  double dist(int a, int b) {
    final dy = y[a] - y[b], db = cb[a] - cb[b], dr = cr[a] - cr[b];
    return math.sqrt(0.3 * dy * dy + db * db + dr * dr);
  }

  final border = <int>[];
  for (var x = 0; x < w; x++) {
    border
      ..add(x)
      ..add((h - 1) * w + x);
  }
  for (var r = 1; r < h - 1; r++) {
    border
      ..add(r * w)
      ..add(r * w + w - 1);
  }
  final my = _median([for (final i in border) y[i]]);
  final mb = _median([for (final i in border) cb[i]]);
  final mr = _median([for (final i in border) cr[i]]);
  double toBg(int i) {
    final dy = y[i] - my, db = cb[i] - mb, dr = cr[i] - mr;
    return math.sqrt(0.3 * dy * dy + db * db + dr * dr);
  }

  final spread = [for (final i in border) toBg(i)]..sort();
  final p80 = spread[(spread.length * 0.8).floor().clamp(0, spread.length - 1)];
  if (p80 > 30 && !force) return null;
  final seedLimit = (p80 * 1.5 + 14).clamp(18.0, 60.0);
  final globalLimit = seedLimit * 1.9;
  const step = 9.0;

  bool shadow(int i) {
    final db = cb[i] - mb, dr = cr[i] - mr;
    return db * db + dr * dr < 64 && y[i] < my && y[i] > my * 0.5;
  }

  final bg = Uint8List(n);
  final queue = Int32List(n);
  var head = 0, tail = 0;
  for (final i in border) {
    if (bg[i] == 0 && toBg(i) <= seedLimit) {
      bg[i] = 1;
      queue[tail++] = i;
    }
  }
  if (tail < border.length * (force ? 0.05 : 0.35)) return null;
  while (head < tail) {
    final p = queue[head++];
    final px = p % w, py = p ~/ w;
    for (final q in [if (px > 0) p - 1, if (px < w - 1) p + 1, if (py > 0) p - w, if (py < h - 1) p + w]) {
      if (bg[q] != 0 || wall[q] != 0) continue;
      if (dist(p, q) <= step && (toBg(q) <= globalLimit || shadow(q))) {
        bg[q] = 1;
        queue[tail++] = q;
      }
    }
  }

  for (var pass = 0; pass < 3; pass++) {
    final grow = <int>[];
    for (var i = 0; i < n; i++) {
      if (bg[i] != 0 || wall[i] == 0 || toBg(i) > globalLimit) continue;
      final px = i % w, py = i ~/ w;
      if ((px > 0 && bg[i - 1] != 0) ||
          (px < w - 1 && bg[i + 1] != 0) ||
          (py > 0 && bg[i - w] != 0) ||
          (py < h - 1 && bg[i + w] != 0)) {
        grow.add(i);
      }
    }
    for (final i in grow) {
      bg[i] = 1;
    }
  }

  final fg = Uint8List(n);
  for (var i = 0; i < n; i++) {
    fg[i] = bg[i] == 0 ? 1 : 0;
  }
  _open(fg, w, h);
  _open(fg, w, h);
  _keepMain(fg, w, h);
  _fillHoles(fg, w, h, keep: (i) => toBg(i) <= seedLimit, minHole: (n * 0.002).round());

  var edge = 0;
  for (final i in border) {
    edge += fg[i];
  }
  if (edge > border.length * (force ? 0.6 : 0.2)) return null;
  var area = 0;
  for (var i = 0; i < n; i++) {
    area += fg[i];
  }
  final share = area / n;
  if (share < (force ? 0.02 : 0.04) || share > (force ? 0.97 : 0.93)) return null;
  return fg;
}

(int, int, Uint8List, bool) _framed(int w, int h, Uint8List src) {
  final side = math.min(w, h);
  final ox = (w - side) ~/ 2, oy = (h - side) ~/ 2;
  final crop = Uint8List(side * side * 4);
  for (var r = 0; r < side; r++) {
    final from = ((oy + r) * w + ox) * 4;
    crop.setRange(r * side * 4, (r + 1) * side * 4, src, from);
  }
  final mask = Uint8List(side * side);
  final radius = side * 0.16;
  for (var r = 0; r < side; r++) {
    for (var c = 0; c < side; c++) {
      final dx = math.max(0.0, math.max(radius - c, c - (side - 1 - radius)));
      final dy = math.max(0.0, math.max(radius - r, r - (side - 1 - radius)));
      mask[r * side + c] = dx * dx + dy * dy <= radius * radius ? 1 : 0;
    }
  }
  return _outlined(side, side, crop, mask, cut: false);
}

(int, int, Uint8List, bool) _outlined(int w, int h, Uint8List src, Uint8List mask, {bool cut = true}) {
  var x0 = w, y0 = h, x1 = -1, y1 = -1;
  for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
      if (mask[r * w + c] == 0) continue;
      if (c < x0) x0 = c;
      if (c > x1) x1 = c;
      if (r < y0) y0 = r;
      if (r > y1) y1 = r;
    }
  }
  final bw = x1 - x0 + 1, bh = y1 - y0 + 1;
  final ring = math.max(5, (math.max(bw, bh) * 0.035).round());
  final pad = ring + 3;
  final ow = bw + pad * 2, oh = bh + pad * 2;

  final alpha = Float32List(ow * oh);
  final inside = Uint8List(ow * oh);
  for (var r = 0; r < bh; r++) {
    for (var c = 0; c < bw; c++) {
      if (mask[(y0 + r) * w + x0 + c] == 1) inside[(r + pad) * ow + c + pad] = 1;
    }
  }
  for (var r = 1; r < oh - 1; r++) {
    for (var c = 1; c < ow - 1; c++) {
      var s = 0;
      for (var dy = -1; dy <= 1; dy++) {
        for (var dx = -1; dx <= 1; dx++) {
          s += inside[(r + dy) * ow + c + dx];
        }
      }
      alpha[r * ow + c] = inside[r * ow + c] == 1 ? (s >= 9 ? 1.0 : 0.55 + s / 20) : (s > 0 ? s / 18 : 0);
    }
  }
  final dist = _distance(inside, ow, oh);

  final out = Uint8List(ow * oh * 4);
  for (var r = 0; r < oh; r++) {
    for (var c = 0; c < ow; c++) {
      final o = r * ow + c;
      final a = alpha[o].clamp(0.0, 1.0);
      final ring01 = (ring - dist[o] + 0.5).clamp(0.0, 1.0);
      final total = a + ring01 * (1 - a);
      if (total <= 0) continue;
      final sr = r - pad + y0, sc = c - pad + x0;
      final inImg = sr >= 0 && sr < h && sc >= 0 && sc < w;
      final si = inImg ? (sr * w + sc) * 4 : 0;
      for (var k = 0; k < 3; k++) {
        final s = inImg ? src[si + k].toDouble() : 255.0;
        out[o * 4 + k] = ((s * a + 255 * ring01 * (1 - a)) / total).round().clamp(0, 255);
      }
      out[o * 4 + 3] = (total * 255).round().clamp(0, 255);
    }
  }
  return (ow, oh, out, cut);
}

Uint8List _edges(Float32List y, int w, int h) {
  final g = Float32List(w * h);
  for (var r = 1; r < h - 1; r++) {
    for (var c = 1; c < w - 1; c++) {
      final i = r * w + c;
      final gx = y[i - w + 1] + 2 * y[i + 1] + y[i + w + 1] - y[i - w - 1] - 2 * y[i - 1] - y[i + w - 1];
      final gy = y[i + w - 1] + 2 * y[i + w] + y[i + w + 1] - y[i - w - 1] - 2 * y[i - w] - y[i - w + 1];
      g[i] = math.sqrt(gx * gx + gy * gy);
    }
  }
  const limit = 28.0;
  final hard = Uint8List(w * h);
  for (var i = 0; i < g.length; i++) {
    if (g[i] > limit) hard[i] = 1;
  }
  final wall = Uint8List(w * h);
  for (var r = 1; r < h - 1; r++) {
    for (var c = 1; c < w - 1; c++) {
      final i = r * w + c;
      wall[i] = hard[i] | hard[i - 1] | hard[i + 1] | hard[i - w] | hard[i + w];
    }
  }
  return wall;
}

void _blur(Float32List v, int w, int h) {
  final tmp = Float32List(v.length);
  for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
      final a = v[r * w + math.max(0, c - 1)], b = v[r * w + c], d = v[r * w + math.min(w - 1, c + 1)];
      tmp[r * w + c] = (a + b + d) / 3;
    }
  }
  for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
      final a = tmp[math.max(0, r - 1) * w + c], b = tmp[r * w + c], d = tmp[math.min(h - 1, r + 1) * w + c];
      v[r * w + c] = (a + b + d) / 3;
    }
  }
}

double _median(List<double> xs) {
  xs.sort();
  return xs[xs.length ~/ 2];
}

void _open(Uint8List m, int w, int h) {
  final e = Uint8List(m.length);
  for (var r = 1; r < h - 1; r++) {
    for (var c = 1; c < w - 1; c++) {
      final i = r * w + c;
      e[i] = m[i] & m[i - 1] & m[i + 1] & m[i - w] & m[i + w];
    }
  }
  for (var r = 1; r < h - 1; r++) {
    for (var c = 1; c < w - 1; c++) {
      final i = r * w + c;
      m[i] = e[i] | e[i - 1] | e[i + 1] | e[i - w] | e[i + w];
    }
  }
}

void _keepMain(Uint8List m, int w, int h) {
  final label = Int32List(m.length);
  final sizes = <int>[0];
  final touch = <int>[0];
  final sx = <double>[0], sy = <double>[0];
  final queue = Int32List(m.length);
  for (var i = 0; i < m.length; i++) {
    if (m[i] == 0 || label[i] != 0) continue;
    final id = sizes.length;
    var head = 0, tail = 0, count = 0, edge = 0;
    var ax = 0.0, ay = 0.0;
    label[i] = id;
    queue[tail++] = i;
    while (head < tail) {
      final p = queue[head++];
      count++;
      final px = p % w, py = p ~/ w;
      ax += px;
      ay += py;
      if (px == 0 || py == 0 || px == w - 1 || py == h - 1) edge++;
      for (final q in [if (px > 0) p - 1, if (px < w - 1) p + 1, if (py > 0) p - w, if (py < h - 1) p + w]) {
        if (m[q] == 1 && label[q] == 0) {
          label[q] = id;
          queue[tail++] = q;
        }
      }
    }
    sizes.add(count);
    touch.add(edge);
    sx.add(ax / count);
    sy.add(ay / count);
  }
  if (sizes.length <= 1) return;
  final perimeter = 2 * (w + h);
  double score(int id) {
    final dx = (sx[id] - w / 2) / (w / 2), dy = (sy[id] - h / 2) / (h / 2);
    final centred = 1 - 0.55 * math.min(1.0, math.sqrt(dx * dx + dy * dy));
    final edgy = touch[id] > perimeter * 0.03 ? 0.4 : 1.0;
    return sizes[id] * centred * edgy;
  }

  var best = 1;
  for (var id = 2; id < sizes.length; id++) {
    if (score(id) > score(best)) best = id;
  }
  final keep = Uint8List(sizes.length);
  for (var id = 1; id < sizes.length; id++) {
    keep[id] = id == best || (sizes[id] >= sizes[best] * 0.15 && touch[id] <= perimeter * 0.01) ? 1 : 0;
  }
  for (var i = 0; i < m.length; i++) {
    if (m[i] == 1 && keep[label[i]] == 0) m[i] = 0;
  }
}

void _fillHoles(Uint8List m, int w, int h, {bool Function(int)? keep, int minHole = 0}) {
  final out = Uint8List(m.length);
  final queue = Int32List(m.length);
  var head = 0, tail = 0;
  void seed(int i) {
    if (m[i] == 0 && out[i] == 0) {
      out[i] = 1;
      queue[tail++] = i;
    }
  }

  for (var x = 0; x < w; x++) {
    seed(x);
    seed((h - 1) * w + x);
  }
  for (var r = 0; r < h; r++) {
    seed(r * w);
    seed(r * w + w - 1);
  }
  void spread(void Function(int) visit) {
    while (head < tail) {
      final p = queue[head++];
      final px = p % w, py = p ~/ w;
      if (px > 0) visit(p - 1);
      if (px < w - 1) visit(p + 1);
      if (py > 0) visit(p - w);
      if (py < h - 1) visit(p + w);
    }
  }

  spread(seed);
  final hole = Int32List(m.length);
  for (var i = 0; i < m.length; i++) {
    if (m[i] != 0 || out[i] != 0) continue;
    if (keep == null) {
      m[i] = 1;
      continue;
    }
    head = 0;
    tail = 0;
    var size = 0, open = 0;
    void grow(int q) {
      if (m[q] == 0 && out[q] == 0) {
        out[q] = 2;
        queue[tail++] = q;
        hole[size++] = q;
        if (keep(q)) open++;
      }
    }

    grow(i);
    spread(grow);
    final clear = size >= minHole && open >= size * 0.8;
    if (!clear) {
      for (var k = 0; k < size; k++) {
        m[hole[k]] = 1;
      }
    }
  }
}

Float32List _distance(Uint8List inside, int w, int h) {
  const big = 1e9;
  final d = Float32List(w * h);
  for (var i = 0; i < d.length; i++) {
    d[i] = inside[i] == 1 ? 0 : big;
  }
  const a = 1.0, b = 1.4142;
  for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
      final i = r * w + c;
      var v = d[i];
      if (c > 0) v = math.min(v, d[i - 1] + a);
      if (r > 0) {
        v = math.min(v, d[i - w] + a);
        if (c > 0) v = math.min(v, d[i - w - 1] + b);
        if (c < w - 1) v = math.min(v, d[i - w + 1] + b);
      }
      d[i] = v;
    }
  }
  for (var r = h - 1; r >= 0; r--) {
    for (var c = w - 1; c >= 0; c--) {
      final i = r * w + c;
      var v = d[i];
      if (c < w - 1) v = math.min(v, d[i + 1] + a);
      if (r < h - 1) {
        v = math.min(v, d[i + w] + a);
        if (c < w - 1) v = math.min(v, d[i + w + 1] + b);
        if (c > 0) v = math.min(v, d[i + w - 1] + b);
      }
      d[i] = v;
    }
  }
  return d;
}
