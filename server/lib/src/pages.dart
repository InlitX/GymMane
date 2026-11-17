import 'dart:convert';

import 'config.dart';

String _esc(String s) => const HtmlEscape().convert(s);

String personalPage(String html, Person person) => html
    .replaceFirst(RegExp(r'<base href="[^"]*"\s*/?>'),
        '<base href="/${person.name}/">\n  <meta name="gymmane-person" content="${person.name}">')
    .replaceFirst('<title>GymMane</title>', '<title>GymMane · ${_esc(person.display)}</title>');

String personalManifest(String text, Person person) {
  try {
    final m = jsonDecode(text) as Map<String, dynamic>;
    final label = person.display;
    m['name'] = 'GymMane · $label';
    m['short_name'] = label.length <= 12 ? label : 'GymMane';
    m['id'] = '/${person.name}/';
    return jsonEncode(m);
  } catch (_) {
    return text;
  }
}

const _style = '''
@font-face { font-family: "Nunito"; font-weight: 800; font-display: swap; src: url("/assets/assets/fonts/Nunito-ExtraBold.ttf") format("truetype"); }
@font-face { font-family: "Nunito"; font-weight: 600; font-display: swap; src: url("/assets/assets/fonts/Nunito-SemiBold.ttf") format("truetype"); }
* { box-sizing: border-box; }
html, body { margin: 0; min-height: 100%; background: #0A0A0A; color: #F2EEE9; }
body { display: flex; align-items: center; justify-content: center; min-height: 100vh; padding: 32px 16px;
  font-family: "Nunito", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
main { width: 100%; max-width: 360px; display: flex; flex-direction: column; align-items: center; }
.icon { width: 72px; height: 72px; border-radius: 16px; }
h1 { margin: 22px 0 6px; max-width: 100%; font-size: 28px; font-weight: 800; letter-spacing: -.02em; text-align: center;
  overflow-wrap: anywhere; }
p { margin: 0 0 22px; color: #8C857F; font-size: 14px; font-weight: 600; text-align: center; }
nav, form { width: 100%; display: flex; flex-direction: column; gap: 8px; }
.row { display: flex; align-items: center; gap: 12px; min-height: 56px; padding: 10px 16px 10px 10px;
  border-radius: 16px; background: #161514; color: inherit; text-decoration: none; transition: background .15s ease; }
.row:hover, .row:focus-visible { background: #1F1D1B; outline: none; }
.row:active { background: #262321; }
.dot { flex: none; width: 36px; height: 36px; border-radius: 50%; display: grid; place-items: center;
  background: #241F1C; color: #D9A184; font-size: 16px; font-weight: 800; }
.name { flex: 1; min-width: 0; font-size: 17px; font-weight: 800; letter-spacing: -.01em;
  overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.row svg { flex: none; width: 16px; height: 16px; color: #8C857F; }
input[type=password] { width: 100%; height: 52px; padding: 0 16px; border-radius: 16px; border: 1.5px solid transparent;
  background: #161514; color: #F2EEE9; font: inherit; font-size: 16px; font-weight: 600; outline: none;
  transition: border-color .15s ease; }
input[type=password]::placeholder { color: #5E5853; }
input[type=password]:focus { border-color: #D9A184; }
.bad input[type=password] { border-color: #D97A6C; }
.err { display: none; margin: 2px 4px 0; color: #D97A6C; font-size: 13px; font-weight: 600; }
.bad .err { display: block; }
button { height: 52px; margin-top: 8px; border: 0; border-radius: 999px; background: #F2EEE9; color: #0A0A0A;
  font: inherit; font-size: 16px; font-weight: 800; cursor: pointer; transition: transform .1s ease, opacity .15s ease; }
button:active { transform: scale(.98); opacity: .9; }
.back { margin-top: 22px; color: #8C857F; font-size: 14px; font-weight: 600; text-decoration: none; }
.back:hover { color: #F2EEE9; }
.hide { position: absolute; width: 1px; height: 1px; opacity: 0; pointer-events: none; }
''';

String _page(String body, String script) => '''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0A0A0A">
<meta name="color-scheme" content="dark">
<link rel="icon" type="image/png" href="/favicon.png">
<title>GymMane</title>
<style>$_style</style>
</head>
<body>
<main>
<img class="icon" src="/icons/Icon-192.png" alt="">
$body
</main>
<script>
var es = (navigator.language || '').toLowerCase().indexOf('es') === 0;
function say(id, en, sp) { var e = document.getElementById(id); if (e) e[e.tagName === 'INPUT' ? 'placeholder' : 'textContent'] = es ? sp : en; }
if (es) document.documentElement.lang = 'es';
$script
</script>
</body>
</html>''';

String pickerPage(List<Person> people) {
  final rows = StringBuffer();
  for (final p in people) {
    final label = _esc(p.display);
    rows.write('<a class="row" href="/${p.name}/"><span class="dot">${_esc(p.display.substring(0, 1).toUpperCase())}</span>'
        '<span class="name">$label</span>'
        '<svg viewBox="0 0 256 256" aria-hidden="true"><path d="M96 48l80 80-80 80" fill="none" '
        'stroke="currentColor" stroke-width="20" stroke-linecap="round" stroke-linejoin="round"/></svg></a>');
  }
  return _page(
    '<h1 id="t">Who\'s training?</h1>\n<p id="s">Each person has their own data.</p>\n<nav>$rows</nav>',
    "say('t', \"Who's training?\", '¿Quién entrena?');\nsay('s', 'Each person has their own data.', 'Cada persona tiene sus propios datos.');",
  );
}

String loginPage({required String action, Person? person, bool wrong = false, bool wait = false, bool shared = false}) {
  final title = person == null ? 'GymMane' : _esc(person.display);
  final user = person?.name ?? 'gymmane';
  final back = shared ? '<a class="back" id="b" href="/">Not you?</a>' : '';
  return _page(
    '<h1>$title</h1>\n<p id="s">Enter your password to continue.</p>\n'
        '<form method="post" action="$action"${wrong || wait ? ' class="bad"' : ''}${wait ? ' data-wait="1"' : ''}>'
        '<input class="hide" type="text" name="username" value="$user" autocomplete="username" tabindex="-1" aria-hidden="true">'
        '<input id="p" type="password" name="password" placeholder="Password" autocomplete="current-password" autofocus required>'
        '<div class="err" id="e" role="alert">${wait ? 'Too many tries. Wait a few minutes and try again.' : 'That password isn\'t right.'}</div>'
        '<button id="go" type="submit">Sign in</button></form>$back',
    "say('s', 'Enter your password to continue.', 'Escribe tu contraseña para entrar.');\n"
        "say('p', 'Password', 'Contraseña');\n"
        "if (document.querySelector('form[data-wait]')) say('e', 'Too many tries. Wait a few minutes and try again.', 'Demasiados intentos. Espera unos minutos y vuelve a probar.');\n"
        "else say('e', \"That password isn't right.\", 'Esa contraseña no es correcta.');\n"
        "say('go', 'Sign in', 'Entrar');\n"
        "say('b', 'Not you?', '¿No eres tú?');",
  );
}
