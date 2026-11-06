(function () {
  'use strict';

  var DICT = {
    es: {
      metaDesc: 'Diario de gimnasio y nutrición gratis para Android: sin cuenta, sin anuncios, sin suscripción y sin permiso de internet. Más de 500 ejercicios animados, progresión automática y código abierto.',
      title: 'GymMane: diario de gimnasio gratis, sin cuenta y sin conexión',
      navFeatures: 'Qué hace', navCompare: 'Comparativa', navShots: 'Capturas', navPrivacy: 'Privacidad', navDownload: 'Descargar', navTranslate: 'Traducir',
      skip: 'Saltar al contenido',
      heroL1: 'Levanta.', heroL2: 'Anota.', heroL3: 'Mejora.',
      heroLead: 'El diario de gimnasio que no te pide nada: ni cuenta, ni suscripción, ni internet. Toca los músculos que quieres entrenar, apunta tus series y mira cómo suben tus números.',
      ctaDownload: 'Descargar', ctaGithub: 'Ver en GitHub',
      heroMeta: 'Android 7.0 o superior · Sin cuenta · Sin anuncios · Sin suscripción',
      liveNote: 'Demo interactiva y limitada: la app tiene mucho más',
      featTitle: 'Qué hace',
      f1t: 'Entrenar tocando el cuerpo', f1d: 'Toca los músculos, de frente y de espalda, y te sale la sesión. Series de calentamiento, normales, al fallo o dropset, con RPE o RIR, discos por lado y series izquierda y derecha en ejercicios a un lado.',
      f2t: 'Progresión automática', f2d: 'Te sugiere más reps o más peso la próxima vez, avisa de estancamientos, programa semanas de descarga y te deja marcar una sesión ligera sin romper tus números.',
      f3t: 'Descanso que sí suena', f3d: 'Temporizador con tu sonido, cuenta atrás en la notificación con la pantalla apagada, una voz que te dice el siguiente paso (beta) y la sesión sobrevive a un reinicio.',
      f4t: 'Rutinas y circuitos', f4d: 'Plan semanal o rotación, carpetas, superseries, circuitos con tiempos y rondas, planes ya hechos y alternativas cuando la máquina está ocupada.',
      f5t: 'Progreso de verdad', f5d: 'Récords por repeticiones, 1RM estimado, volumen, racha que aguanta días libres, mapa de recuperación, informes en PDF o CSV y el resumen de tu mes para compartir.',
      f6t: 'Cuerpo y fotos', f6d: 'Peso, diez medidas y las tuyas, fotos de frente, lado y espalda con antes y después, y si no quieres fotos, la misma línea de tiempo dibujada como mapa muscular.',
      f7t: 'Nutrición y salud (beta)', f7d: 'Calorías y macros, agua, suplementos con dosis y existencias, planes y meal prep, ayuno, sueño, energía y pasos. Todo en el móvil, sin base de datos en la nube.',
      f8t: 'Más de 500 ejercicios', f8d: 'Con animación e instrucciones, filtros por material y nivel, lugares (casa, gimnasio, parque) para que solo veas lo que puedes hacer. Si falta alguno, créalo con tu foto, GIF o vídeo.',
      f9t: 'Diario y notas', f9d: 'Notas por ejercicio y por serie, un diario en calendario con carpetas, fotos y vídeo, y lo que apuntaste la última vez a la vista mientras entrenas.',
      f10t: 'Widgets y calculadoras', f10d: 'Cinco widgets (hoy, semana, actividad, estadísticas y mapa muscular) y seis calculadoras: 1RM, discos, IMC, calorías y macros, grasa corporal y calentamiento.',
      f11t: 'Tus datos, tuyos', f11d: 'Importa Hevy, Strong, Lyfta, FitNotes, openGym o cualquier CSV. Exporta a CSV o a una copia completa, manda tus entrenos a Strava o Health Connect y bórralo todo en un toque.',
      f12t: '17 idiomas y a tu gusto', f12d: 'Tema oscuro o claro, kg o lb, modos de rendimiento para cualquier móvil y un diseño pensado para usarse con las manos sudadas.',
      cmpTitle: 'GymMane frente a otras apps',
      cmpLead: 'Lo que cuenta cuando eliges una app de gimnasio, sin letra pequeña.',
      cmpCol: 'GymMane', cmpColO: 'Apps típicas con cuenta',
      cmp1: 'Precio', cmp1a: 'Gratis, sin versión de pago', cmp1b: 'Gratis limitada y suscripción',
      cmp2: 'Cuenta', cmp2a: 'No existe', cmp2b: 'Obligatoria para sincronizar',
      cmp3: 'Internet', cmp3a: 'Sin permiso: no puede enviar nada', cmp3b: 'Necesario para casi todo',
      cmp4: 'Anuncios y rastreo', cmp4a: 'Ninguno', cmp4b: 'Anuncios o analítica habituales',
      cmp5: 'Tus datos', cmp5a: 'Solo en tu móvil, con copia y exportación completas', cmp5b: 'En sus servidores',
      cmp6: 'Código', cmp6a: 'Abierto (GPL-3.0), compilado por F-Droid', cmp6b: 'Cerrado',
      cmp7: 'Límites', cmp7a: 'Rutinas, gráficas y exportación sin tope', cmp7b: 'Parte detrás de suscripción',
      cmp8: 'Todo en una app', cmp8a: 'Entreno, progreso, nutrición, salud, notas y widgets', cmp8b: 'Suele ser solo entreno',
      cmp9: 'Si te vas', cmp9a: 'Importa tu historial y te lo llevas cuando quieras', cmp9b: 'Exportar suele costar',
      shotsTitle: 'Capturas',
      shotsLead: 'Capturas de la última versión, sacadas en un móvil. Toca una para verla en grande.',
      sHome: 'Inicio', sProgress: 'Progreso', sTrain: 'Entrenar', sSession: 'Sesión',
      sLibrary: 'Ejercicios', sRoutines: 'Rutinas', sProfile: 'Perfil', sSettings: 'Ajustes', sNutrition: 'Nutrición', sMeal: 'Una comida',
      restReady: 'Listo',
      privTitle: 'Tus datos no salen del móvil',
      privP1: 'GymMane no tiene permiso de internet, así que no puede enviar nada a ningún sitio. No hay cuenta, ni anuncios, ni analítica.',
      privP2: 'Los permisos que pide son para el temporizador de descanso, su notificación y los widgets. Tus fotos, vídeos y notas se quedan en el almacenamiento de la app.',
      whyTitle: 'Por qué existe',
      whyP1: 'Quería una app de gimnasio que no me pidiera una cuenta ni una suscripción para ver mis propias series. No la encontré, así que la hice.',
      whyP2: 'Es código abierto con licencia GPL-3.0 y la sigo mejorando con lo que me piden en GitHub. Si le falta algo, abre una incidencia o manda un cambio.',
      dlTitle: 'Descárgala', dlLead: 'Gratis, para Android 7.0 o superior.',
      dlHint: 'En GitHub, si no sabes qué APK elegir, coge el <code>arm64-v8a</code>.',
      footCode: 'Código', footIssues: 'Reportar un fallo', footCoffee: 'Invítame a un café',
      dlCount: 'descargas en GitHub',
      supTitle: 'Apoya el proyecto',
      supP1: 'GymMane es gratis y lo seguirá siendo, sin anuncios ni versión de pago. Si te ayuda a entrenar y quieres echar una mano, puedes invitarme a un café en Ko-fi.',
      supP2: 'Una traducción o un buen reporte de fallo también ayudan mucho.',
      supBtn: 'Invítame a un café', supStar: 'Dale una estrella',
      supCrypto: 'También con cripto', copy: 'Copiar', copied: 'Copiada',
      privNet: 'Sin permiso de internet', privNetSub: 'Míralo en el AndroidManifest.xml',
      privFd: 'Compilada por F-Droid', privFdSub: 'Desde el código, sin rastreadores',
      muscles: {
        chest: 'Pecho', back: 'Espalda', shoulders: 'Hombros', biceps: 'Bíceps', triceps: 'Tríceps',
        forearm: 'Antebrazo', trapezius: 'Trapecio', abdomen: 'Abdomen', obliques: 'Oblicuos',
        quads: 'Cuádriceps', hamstrings: 'Isquios', glutes: 'Glúteos', calves: 'Gemelos'
      }
    },
    en: {
      metaDesc: 'A free gym and nutrition log for Android: no account, no ads, no subscription and no internet permission. 500+ animated exercises, automatic progression and open source.',
      title: 'GymMane: a free gym log with no account and no internet',
      navFeatures: 'What it does', navCompare: 'Compare', navShots: 'Screens', navPrivacy: 'Privacy', navDownload: 'Download', navTranslate: 'Translate',
      skip: 'Skip to content',
      heroL1: 'Lift.', heroL2: 'Log it.', heroL3: 'Grow.',
      heroLead: 'The gym log that asks for nothing: no account, no subscription, no internet. Tap the muscles you want to train, log your sets and watch your numbers go up.',
      ctaDownload: 'Download', ctaGithub: 'View on GitHub',
      heroMeta: 'Android 7.0 or later · No account · No ads · No subscription',
      liveNote: 'Interactive, limited demo: the app has much more',
      featTitle: 'What it does',
      f1t: 'Train by tapping the body', f1d: 'Tap muscles, front and back, and get a session for them. Warm-up, working, failure and drop sets, RPE or RIR, plates per side, and left and right sets for one-sided exercises.',
      f2t: 'Automatic progression', f2d: 'Suggests more reps or more weight next time, flags plateaus, schedules deload weeks and lets you mark a light session without wrecking your numbers.',
      f3t: 'A rest timer you can hear', f3d: 'Your own alarm sound, the countdown in the notification with the screen off, a voice that tells you the next step (beta), and a session that survives a reboot.',
      f4t: 'Routines and circuits', f4d: 'Fixed weekly plan or rotation, folders, supersets, timed circuits with rounds, ready-made plans and alternatives for when the machine is taken.',
      f5t: 'Progress that is real', f5d: 'Records per rep count, estimated 1RM, volume, a streak that survives days off, a recovery map, PDF or CSV reports and a monthly recap to share.',
      f6t: 'Body and photos', f6d: 'Weight, ten measurements plus your own, front, side and back photos with a before and after, and if you would rather not photograph yourself, the same timeline drawn as a muscle map.',
      f7t: 'Nutrition and health (beta)', f7d: 'Calories and macros, water, supplements with doses and stock, meal plans and meal prep, fasting, sleep, energy and steps. All on the phone, no cloud food database.',
      f8t: '500+ exercises', f8d: 'With animations and instructions, filters by equipment and level, and places (home, gym, park) so you only see what you can actually do. If one is missing, add it with your own photo, GIF or video.',
      f9t: 'Journal and notes', f9d: 'Notes per exercise and per set, a calendar journal with folders, photos and video, and what you wrote last time in view while you train.',
      f10t: 'Widgets and calculators', f10d: 'Five widgets (today, this week, activity, stats and muscle map) and six calculators: 1RM, plates, BMI, calories and macros, body fat and warm-up.',
      f11t: 'Your data, yours', f11d: 'Import Hevy, Strong, Lyfta, FitNotes, openGym or any CSV. Export to CSV or a full backup, send workouts to Strava or Health Connect and delete everything in one tap.',
      f12t: '17 languages, your way', f12d: 'Dark or light theme, kg or lb, performance modes for any phone and a layout built to be used with sweaty hands.',
      cmpTitle: 'GymMane versus other apps',
      cmpLead: 'What matters when you pick a gym app, with no small print.',
      cmpCol: 'GymMane', cmpColO: 'Typical apps with an account',
      cmp1: 'Price', cmp1a: 'Free, no paid version', cmp1b: 'Limited free tier plus a subscription',
      cmp2: 'Account', cmp2a: 'There is none', cmp2b: 'Required to sync',
      cmp3: 'Internet', cmp3a: 'No permission: it cannot send anything', cmp3b: 'Needed for almost everything',
      cmp4: 'Ads and tracking', cmp4a: 'None', cmp4b: 'Ads or analytics are common',
      cmp5: 'Your data', cmp5a: 'Only on your phone, with full backup and export', cmp5b: 'On their servers',
      cmp6: 'Code', cmp6a: 'Open (GPL-3.0), built by F-Droid', cmp6b: 'Closed',
      cmp7: 'Limits', cmp7a: 'Unlimited routines, charts and export', cmp7b: 'Part of it behind a subscription',
      cmp8: 'All in one', cmp8a: 'Training, progress, nutrition, health, notes and widgets', cmp8b: 'Usually training only',
      cmp9: 'If you leave', cmp9a: 'Import your history and take it with you anytime', cmp9b: 'Exporting often costs extra',
      shotsTitle: 'Screens',
      shotsLead: 'Screens from the latest version, taken on a phone. Tap one to see it bigger.',
      sHome: 'Home', sProgress: 'Progress', sTrain: 'Train', sSession: 'Session',
      sLibrary: 'Exercises', sRoutines: 'Routines', sProfile: 'Profile', sSettings: 'Settings', sNutrition: 'Nutrition', sMeal: 'A meal',
      restReady: 'Ready',
      privTitle: 'Your data stays on your phone',
      privP1: 'GymMane doesn\'t have the internet permission, so it can\'t send anything anywhere. No account, no ads, no analytics.',
      privP2: 'The permissions it asks for are for the rest timer, its notification and the widgets. Your photos, videos and notes stay in the app\'s own storage.',
      whyTitle: 'Why it exists',
      whyP1: 'I wanted a gym app that didn\'t ask for an account or a subscription to look at my own sets. I couldn\'t find one, so I made it.',
      whyP2: 'It\'s open source under GPL-3.0 and I keep improving it with what people ask for on GitHub. If something is missing, open an issue or send a pull request.',
      dlTitle: 'Get it', dlLead: 'Free, for Android 7.0 or later.',
      dlHint: 'On GitHub, take the <code>arm64-v8a</code> APK if you\'re not sure which one you need.',
      footCode: 'Source', footIssues: 'Report a bug', footCoffee: 'Buy me a coffee',
      dlCount: 'downloads on GitHub',
      supTitle: 'Support the project',
      supP1: 'GymMane is free and will stay free, with no ads and no paid version. If it helps you train and you want to chip in, you can buy me a coffee on Ko-fi.',
      supP2: 'A translation or a clear bug report helps a lot too.',
      supBtn: 'Buy me a coffee', supStar: 'Give it a star',
      supCrypto: 'Or with crypto', copy: 'Copy', copied: 'Copied',
      privNet: 'No internet permission', privNetSub: 'Check the AndroidManifest.xml',
      privFd: 'Built by F-Droid', privFdSub: 'From source, no trackers',
      muscles: {
        chest: 'Chest', back: 'Back', shoulders: 'Shoulders', biceps: 'Biceps', triceps: 'Triceps',
        forearm: 'Forearm', trapezius: 'Traps', abdomen: 'Abs', obliques: 'Obliques',
        quads: 'Quads', hamstrings: 'Hamstrings', glutes: 'Glutes', calves: 'Calves'
      }
    }
  };

  var COUNTS = {
    chest: 40, back: 56, shoulders: 41, biceps: 96, triceps: 111, forearm: 86, trapezius: 16,
    abdomen: 37, obliques: 21, quads: 34, hamstrings: 93, glutes: 88, calves: 73
  };

  var lang = localStorage.getItem('gm-lang');
  if (!lang) lang = (navigator.language || 'es').toLowerCase().indexOf('es') === 0 ? 'es' : 'en';

  function t(key) { return (DICT[lang] && DICT[lang][key]) || DICT.es[key] || key; }

  function applyLang() {
    var d = DICT[lang];
    document.documentElement.lang = lang;
    document.title = d.title;
    var meta = document.querySelector('meta[name="description"]');
    if (meta) meta.setAttribute('content', d.metaDesc);

    document.querySelectorAll('[data-i18n]').forEach(function (el) {
      var v = d[el.getAttribute('data-i18n')];
      if (v != null) el.textContent = v;
    });
    document.querySelectorAll('[data-i18n-html]').forEach(function (el) {
      var v = d[el.getAttribute('data-i18n-html')];
      if (v != null) el.innerHTML = v;
    });
    document.querySelectorAll('.lang button').forEach(function (b) {
      b.setAttribute('aria-pressed', String(b.dataset.lang === lang));
    });
    buildShots();
    fmtDlNow();
    aRender();
    document.querySelectorAll('#bodySvg .muscle').forEach(function (g) {
      var id = g.getAttribute('data-muscle');
      g.setAttribute('aria-label', d.muscles[id] || id);
    });
    if (lb.classList.contains('on')) lbCap.textContent = t(SHOTS[lbIdx].k);
  }

  document.querySelectorAll('.lang button').forEach(function (b) {
    b.addEventListener('click', function () {
      lang = b.dataset.lang;
      localStorage.setItem('gm-lang', lang);
      applyLang();
    });
  });


  var SHOTS = [
    { f: 'home', k: 'sHome' }, { f: 'train', k: 'sTrain' }, { f: 'session', k: 'sSession' },
    { f: 'progress', k: 'sProgress' }, { f: 'nutrition', k: 'sNutrition' }, { f: 'meal', k: 'sMeal' }, { f: 'library', k: 'sLibrary' }, { f: 'routines', k: 'sRoutines' },
    { f: 'profile', k: 'sProfile' }, { f: 'settings', k: 'sSettings' }
  ];
  var rail = document.getElementById('shotsRail');
  var track = document.getElementById('shotsTrack');

  function buildShots() {
    function card(s, i, dup) {
      return '<figure class="shot"' + (dup ? ' aria-hidden="true"' : '') + '>' +
        '<div class="phone" role="button" tabindex="' + (dup ? '-1' : '0') + '" data-i="' + i +
        '" aria-label="' + t(s.k) + '"><div class="island"></div>' +
        '<img src="assets/shots/' + lang + '/' + s.f + '.webp" width="630" height="1400" loading="lazy" alt="GymMane — ' +
        t(s.k) + '" /></div><figcaption class="cap">' + t(s.k) + '</figcaption></figure>';
    }
    track.innerHTML = SHOTS.map(function (s, i) { return card(s, i, false); }).join('') +
      SHOTS.map(function (s, i) { return card(s, i, true); }).join('');
  }

  var lb = document.getElementById('lb');
  var lbImg = document.getElementById('lbImg');
  var lbCap = document.getElementById('lbCap');
  var lbIdx = 0, lbOpener = null;

  function openLb(i, opener) {
    lbIdx = (i + SHOTS.length) % SHOTS.length;
    lbImg.src = 'assets/shots/' + lang + '/' + SHOTS[lbIdx].f + '.webp';
    lbImg.alt = 'GymMane — ' + t(SHOTS[lbIdx].k);
    lbCap.textContent = t(SHOTS[lbIdx].k);
    lb.classList.add('on');
    document.body.style.overflow = 'hidden';
    lbOpener = opener || null;
    document.getElementById('lbX').focus();
  }
  function closeLb() {
    lb.classList.remove('on');
    document.body.style.overflow = '';
    if (lbOpener) lbOpener.focus();
  }
  track.addEventListener('click', function (e) {
    var p = e.target.closest('.phone');
    if (p) openLb(parseInt(p.dataset.i, 10), p);
  });
  track.addEventListener('keydown', function (e) {
    if (e.key !== 'Enter' && e.key !== ' ') return;
    var p = e.target.closest('.phone');
    if (p) { e.preventDefault(); openLb(parseInt(p.dataset.i, 10), p); }
  });
  document.getElementById('lbX').addEventListener('click', closeLb);
  document.getElementById('lbPrev').addEventListener('click', function () { openLb(lbIdx - 1, lbOpener); });
  document.getElementById('lbNext').addEventListener('click', function () { openLb(lbIdx + 1, lbOpener); });
  lb.addEventListener('click', function (e) { if (e.target === lb) closeLb(); });
  addEventListener('keydown', function (e) {
    if (!lb.classList.contains('on')) return;
    if (e.key === 'Escape') closeLb();
    else if (e.key === 'ArrowLeft') openLb(lbIdx - 1, lbOpener);
    else if (e.key === 'ArrowRight') openLb(lbIdx + 1, lbOpener);
  });

  var frame = document.getElementById('demoFrame');
  var poster = document.getElementById('demoPoster');
  var frameSrc = '';
  function aRender() {
    if (!frame) return;
    var src = 'app/?lang=' + lang;
    if (frameSrc === src) return;
    frameSrc = src;
    frame.classList.remove('on');
    poster.src = 'assets/shots/' + lang + '/home.webp';
    frame.src = src;
  }
  if (frame) {
    frame.addEventListener('load', function () { setTimeout(function () { frame.classList.add('on'); }, 600); });
    aRender();
  }

  var slowMo = matchMedia('(prefers-reduced-motion: reduce)').matches;
  var io = new IntersectionObserver(function (es) {
    es.forEach(function (e) {
      if (!e.isIntersecting) return;
      e.target.classList.add('in');

      io.unobserve(e.target);
    });
  }, { threshold: 0.14 });
  document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });

  var spy = [].slice.call(document.querySelectorAll('.lnks a.lnk')).map(function (a) {
    return { a: a, sec: document.querySelector(a.getAttribute('href')) };
  }).filter(function (s) { return s.sec; });

  addEventListener('scroll', function () {
    var mark = document.documentElement.scrollTop + 140, on = null;
    spy.forEach(function (s) { if (s.sec.offsetTop <= mark) on = s.a; });
    spy.forEach(function (s) { s.a.classList.toggle('on', s.a === on); });
  }, { passive: true });

  var dlNum = document.getElementById('dlNum');
  var dlShown = 0, dlRaf = 0;
  function fmtDl(v) { return Math.round(v).toLocaleString(lang === 'es' ? 'es-ES' : 'en-GB'); }
  function fmtDlNow() { if (dlNum && dlShown) dlNum.textContent = fmtDl(dlShown); }
  function countDl(n) {
    if (!n) return;
    cancelAnimationFrame(dlRaf);
    if (slowMo) { dlShown = n; fmtDlNow(); return; }
    var from = dlShown, t0 = performance.now(), dur = 1800;
    (function step(now) {
      var p = Math.min(1, Math.max(0, (now - t0) / dur));
      dlShown = from + (n - from) * (1 - Math.pow(1 - p, 3));
      dlNum.textContent = fmtDl(dlShown);
      if (p < 1) dlRaf = requestAnimationFrame(step);
    })(t0);
  }
  var dlCache = null;
  try {
    localStorage.removeItem('gm-dl');
    dlCache = JSON.parse(localStorage.getItem('gm-downloads') || 'null');
  } catch (e) {}
  if (!dlCache || !(dlCache.n > 0) || !(dlCache.t > 0)) dlCache = null;
  if (dlCache) countDl(dlCache.n);
  function saveDl(n) {
    if (!n) return;
    try { localStorage.setItem('gm-downloads', JSON.stringify({ n: n, t: Date.now() })); } catch (e) {}
    if (!dlCache || dlCache.n !== n) countDl(n);
  }
  function shieldsDl() {
    return fetch('https://img.shields.io/github/downloads/InlitX/GymMane/total.json')
      .then(function (r) { return r.ok ? r.json() : null; })
      .then(function (j) {
        var m = j && /^([\d.]+)\s*([kM]?)$/.exec(j.value || j.message || '');
        if (m) saveDl(Math.round(parseFloat(m[1]) * (m[2] === 'M' ? 1e6 : m[2] === 'k' ? 1e3 : 1)));
      });
  }
  if (!dlCache || Date.now() - dlCache.t > 36e5) {
    fetch('https://api.github.com/repos/InlitX/GymMane/releases?per_page=100')
      .then(function (r) { if (!r.ok) throw r; return r.json(); })
      .then(function (rs) {
        var n = 0;
        rs.forEach(function (r) { (r.assets || []).forEach(function (a) { n += a.download_count || 0; }); });
        if (!n) throw n;
        saveDl(n);
      })
      .catch(function () { return shieldsDl(); })
      .catch(function () {});
  }

  document.querySelectorAll('.coin button').forEach(function (b) {
    b.addEventListener('click', function () {
      var addr = b.parentNode.querySelector('code').textContent;
      var done = function () {
        b.textContent = t('copied');
        b.classList.add('ok');
        setTimeout(function () { b.textContent = t('copy'); b.classList.remove('ok'); }, 1600);
      };
      if (navigator.clipboard) navigator.clipboard.writeText(addr).then(done, function () {});
    });
  });

  document.getElementById('y').textContent = new Date().getFullYear();
  applyLang();
})();
