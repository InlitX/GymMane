#version 460 core
#include <flutter/runtime_effect.glsl>

precision highp float;

uniform vec2 uSize;
uniform float uAngle;
uniform float uTilt;
uniform float uTime;
uniform float uLocked;
uniform float uShape;
uniform float uGem;
uniform float uIconSpan;
uniform vec3 uBase;
uniform vec3 uLip;
uniform vec3 uPlateTop;
uniform vec3 uPlateLow;
uniform vec3 uInk;
uniform vec3 uGemColor;
uniform sampler2D uIcon;
uniform sampler2D uBack;

out vec4 fragColor;


const float R_BODY = 1.0;
const float R_STEP = 0.875;
const float R_PLATE = 0.735;
const float Z_BACK = -0.145;

float sdHex(vec2 p, float r) {
  const vec3 k = vec3(-0.866025404, 0.5, 0.577350269);
  p = abs(p);
  p -= 2.0 * min(dot(k.xy, p), 0.0) * k.xy;
  p -= vec2(clamp(p.x, -k.z * r, k.z * r), r);
  return length(p) * sign(p.y);
}

float outline2d(vec2 p, float r) {
  // hexagono en punta arriba, como el arte
  vec2 q = vec2(p.x * 0.866025404 - p.y * 0.5, p.x * 0.5 + p.y * 0.866025404);
  float k = r * 0.19;
  return mix(sdHex(q, r * 0.94 - k) - k, length(p) - r, uShape);
}

// slab between zBack and zFront with rounded edges
float prism(vec3 p, float r, float zFront, float round) {
  float d2 = outline2d(p.xy, r - round);
  float zc = (zFront + Z_BACK) * 0.5;
  float hz = (zFront - Z_BACK) * 0.5 - round;
  vec2 w = vec2(d2, abs(p.z - zc) - hz);
  return min(max(w.x, w.y), 0.0) + length(max(w, 0.0)) - round;
}

float mapMedal(vec3 p) {
  float body = prism(p, R_BODY, 0.145, 0.070);
  float step = prism(p, R_STEP, 0.180, 0.050);
  float plate = prism(p, R_PLATE, 0.212, 0.055);
  return min(body, min(step, plate));
}

vec3 normalAt(vec3 p) {
  vec2 e = vec2(0.0016, 0.0);
  return normalize(vec3(
    mapMedal(p + e.xyy) - mapMedal(p - e.xyy),
    mapMedal(p + e.yxy) - mapMedal(p - e.yxy),
    mapMedal(p + e.yyx) - mapMedal(p - e.yyx)));
}

const float BACK_SPAN = 0.92;

float backAt(vec2 xy) {
  vec2 uv = vec2(0.5 - xy.x / BACK_SPAN * 0.5, 0.5 - xy.y / BACK_SPAN * 0.5);
  if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) return 0.0;
  return texture(uBack, uv).a;
}

float iconAt(vec2 xy) {
  vec2 uv = vec2(0.5 + xy.x / uIconSpan * 0.5, 0.5 - xy.y / uIconSpan * 0.5);
  if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) return 0.0;
  return texture(uIcon, uv).a;
}

// estudio: cielo suave y dos focos alargados en diagonal que cruzan el borde
float bank(vec3 d, vec3 dir, vec3 up, float len, float wid, float soft) {
  float z = dot(d, dir);
  if (z < 0.08) return 0.0;
  vec3 side = normalize(cross(up, dir));
  float x = dot(d, side) / z;
  float y = dot(d, up) / z;
  float dx = max(abs(x) - len, 0.0);
  float dy = max(abs(y) - wid, 0.0);
  return exp(-(dx * dx + dy * dy) * soft);
}

vec3 env(vec3 d, float t) {
  float up = smoothstep(-0.9, 1.0, d.y);
  vec3 sky = mix(vec3(0.14, 0.145, 0.16), vec3(0.82, 0.85, 0.92), up * 0.55 + up * up * 0.45);
  float sway = sin(t * 0.45) * 0.35;

  vec3 a = normalize(vec3(-0.45 + sway, 0.72, 0.62));
  vec3 b = normalize(vec3(0.78, -0.28 + sway * 0.4, 0.56));
  vec3 c = normalize(vec3(0.10, 0.96, -0.25));

  float s1 = bank(d, a, normalize(vec3(0.62, 0.55, 0.0)), 0.95, 0.055, 26.0);
  float s2 = bank(d, b, normalize(vec3(-0.5, 0.7, 0.0)), 0.70, 0.05, 34.0);
  float s3 = bank(d, c, normalize(vec3(1.0, 0.0, 0.0)), 0.6, 0.35, 6.0);

  return sky
       + vec3(1.0, 0.97, 0.92) * s1 * 9.5
       + vec3(1.0, 0.86, 0.70) * s2 * 4.4
       + vec3(0.72, 0.80, 0.95) * s3 * 1.7;
}

vec3 metalShade(vec3 n, vec3 rd, vec3 tint, float rough, float t) {
  vec3 r = reflect(rd, n);
  vec3 sharp = env(r, t);
  vec3 wide = env(normalize(r + vec3(0.22, 0.30, 0.0)), t)
            + env(normalize(r - vec3(0.24, 0.18, 0.0)), t);
  vec3 refl = mix(sharp, wide * 0.5, clamp(rough * 1.6, 0.0, 1.0));
  float fres = pow(1.0 - max(dot(n, -rd), 0.0), 5.0);
  return tint * refl * 1.15 + vec3(fres) * 0.22;
}

vec3 dull(vec3 c) {
  float g = dot(c, vec3(0.30, 0.59, 0.11));
  return mix(c, vec3(g), 0.45) * 0.40;
}

vec3 matteShade(vec3 n, vec3 tint) {
  vec3 l = normalize(vec3(0.34, 0.78, 0.52));
  float d = max(dot(n, l), 0.0) * 0.74 + 0.30;
  float sheen = pow(max(dot(reflect(vec3(0.0, 0.0, -1.0), n), l), 0.0), 16.0) * 0.18;
  float rim = pow(1.0 - abs(n.z), 3.0) * 0.13;
  return tint * d + vec3(sheen + rim * 0.5);
}

void main() {
  vec2 fc = FlutterFragCoord().xy;
  vec2 uv = (fc - 0.5 * uSize) / (0.5 * min(uSize.x, uSize.y));
  uv.y = -uv.y;

  vec3 ro = vec3(0.0, 0.0, 3.4);
  vec3 rd = normalize(vec3(uv * 0.405, -1.0));

  float ca = cos(-uAngle), sa = sin(-uAngle);
  float ct = cos(-uTilt), st = sin(-uTilt);
  mat3 toObj = mat3(ca, 0.0, -sa, 0.0, 1.0, 0.0, sa, 0.0, ca)
             * mat3(1.0, 0.0, 0.0, 0.0, ct, st, 0.0, -st, ct);
  vec3 o = toObj * ro;
  vec3 d = toObj * rd;

  float tHit = 2.0;
  float tNear = 2.0;
  float near = 1.0;
  float hit = 0.0;
  for (int i = 0; i < 80; i++) {
    vec3 p = o + d * tHit;
    float dist = mapMedal(p);
    if (dist < near) { near = dist; tNear = tHit; }
    if (dist < 0.0008) { hit = 1.0; break; }
    tHit += max(dist, 0.0015);
    if (tHit > 5.2) break;
  }
  float px = fwidth(uv.x) * 1.35;
  float cover = hit > 0.5 ? 1.0 : 1.0 - smoothstep(0.0, px, near);
  if (cover < 0.004) {
    fragColor = vec4(0.0);
    return;
  }
  if (hit < 0.5) tHit = tNear;

  vec3 p = o + d * tHit;
  vec3 n = normalAt(p);
  float t = uTime;

  float dPlate = outline2d(p.xy, R_PLATE);
  float dStep = outline2d(p.xy, R_STEP);
  bool onPlate = dPlate < -0.02 && p.z > 0.16;
  bool onGem = uGem > 0.5 && dPlate > -0.05 && dStep < 0.0 && p.z > 0.12;

  vec3 tint = uBase;
  float rough = 0.28;
  if (dStep > 0.0) { tint = uLip; rough = 0.20; }

  if (!onPlate && uGem < 0.5 && p.z > 0.15 && dStep < 0.0) {
    tint = uLip;
    rough = 0.18;
  }

  if (onPlate) {
    float ink = iconAt(p.xy);
    float shade = clamp(p.y / (R_PLATE * 1.35) * 0.5 + 0.5, 0.0, 1.0);
    tint = mix(uPlateLow, uPlateTop, shade) * 1.14;
    rough = 0.19;
    if (ink > 0.5) {
      tint = uInk;
      rough = 0.45;
    }
    float e = 0.006;
    vec2 g = vec2(iconAt(p.xy + vec2(e, 0.0)) - iconAt(p.xy - vec2(e, 0.0)),
                  iconAt(p.xy + vec2(0.0, e)) - iconAt(p.xy - vec2(0.0, e)));
    n = normalize(n + vec3(-g * 0.55, 0.0));
  }

  if (onGem) {
    float ang = atan(p.y, p.x);
    float seg = 30.0;
    float k = floor(ang / (6.2831853 / seg));
    float odd = mod(k, 2.0) * 2.0 - 1.0;
    vec2 dir = normalize(p.xy + vec2(1e-5));
    vec2 tang = vec2(-dir.y, dir.x);
    n = normalize(n + vec3(dir * 0.42 * odd + tang * 0.30 * odd, 0.0));
    tint = uGemColor;
    rough = 0.05;
  }

  // sombra de contacto donde el plato y el escalon se apoyan
  float ao = 1.0;
  ao *= mix(0.62, 1.0, smoothstep(0.0, 0.055, abs(dPlate)));
  ao *= mix(0.70, 1.0, smoothstep(0.0, 0.05, abs(dStep)));

  if (p.z < Z_BACK + 0.02) {
    float dInner = outline2d(p.xy, R_STEP - 0.05);
    tint = dInner < 0.0 ? uBase : uLip;
    rough = dInner < 0.0 ? 0.30 : 0.20;
    ao *= mix(0.74, 1.0, smoothstep(0.0, 0.05, abs(dInner)));
    float mark = backAt(p.xy);
    if (mark > 0.5) {
      tint = mix(tint, uInk, 0.86);
      rough = 0.40;
    }
    float e = 0.0055;
    vec2 g = vec2(backAt(p.xy + vec2(e, 0.0)) - backAt(p.xy - vec2(e, 0.0)),
                  backAt(p.xy + vec2(0.0, e)) - backAt(p.xy - vec2(0.0, e)));
    n = normalize(n + vec3(g * 0.5, 0.0));
  }

  vec3 col = uLocked > 0.5
      ? matteShade(n, dull(onGem ? uGemColor : uBase)) * ao
      : metalShade(n, normalize(d), tint, rough, t) * ao * 1.16;

  col = col / (col + vec3(0.82));
  col = pow(col, vec3(1.0 / 2.2));
  col += (fract(sin(dot(fc, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) / 255.0;
  fragColor = vec4(col * cover, cover);
}
