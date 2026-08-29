(function () {
  'use strict';

  var DICT = {
    es: {
      metaDesc: 'GymMane es una app de gimnasio 100% offline: registra tus series, mira tu progreso real y entrena sin cuenta, sin anuncios y sin suscripción. Código abierto con licencia GPL-3.0.',
      title: 'GymMane — Diario de gimnasio, offline y sin humo',
      navFeatures: 'Funciones', navPrivacy: 'Privacidad', navTranslate: 'Traducir',
      navShots: 'Capturas', navDownload: 'Descargar',
      skip: 'Saltar al contenido',
      relNote: 'Ya disponible para Android',
      heroL1: 'Levanta.', heroL2: 'Anota.', heroL3: 'Mejora.',
      heroLead: 'La app de gimnasio sin humo: registra tus series y mira tu progreso <em>de verdad</em>. Todo en tu móvil.',
      ctaGithub: 'Ver en GitHub', ctaTry: 'Ver capturas',
      promiseFree: 'Gratis y sin anuncios', promiseNoAcc: 'Sin cuenta', promiseOffline: '100% offline',
      featKicker: 'Lo que llevas dentro',
      featTitle: 'Todo lo del gimnasio.<br>Nada de relleno.',
      featLead: 'Cada número sale de tus propias series. Si está en pantalla, lo has levantado tú.',
      f1t: 'Entrenar', f1d: 'Elige músculos sobre un cuerpo real —frente y espalda— y registra series, reps, peso y descanso con alarma de verdad, con tu propio sonido.',
      f2t: 'Progreso', f2d: 'Volumen, mapa muscular, heatmap estilo GitHub, récords personales y curvas de fuerza con 1RM estimado.',
      f3t: 'Herramientas', f3d: '1RM, discos de barra, IMC, calorías y macros, % de grasa y calentamiento. Todas con fórmulas publicadas.',
      f4t: 'Ejercicios propios', f4d: '+360 ejercicios con animación e instrucciones paso a paso. ¿Falta uno? Créalo con tu foto, GIF o vídeo.',
      f5t: 'Widgets de inicio', f5d: 'Tu actividad y tus estadísticas en la pantalla de inicio, con el mismo mimo que la app.',
      f6t: 'Offline de verdad', f6d: 'Sin servidores, sin cuenta, sin internet. Exporta a CSV o copia JSON y bórralo todo de un toque.',
      shotsKicker: 'Capturas reales',
      shotsTitle: 'Así se ve<br>por dentro.',
      shotsLead: 'Nada de maquetas inventadas: estas pantallas salen de la app corriendo en un teléfono. Toca cualquiera para verla grande.',
      sHome: 'Inicio', sProgress: 'Progreso', sTrain: 'Entrenar', sSession: 'Sesión',
      sHistory: 'Historial', sLibrary: 'Ejercicios', sRoutines: 'Rutinas', sSettings: 'Ajustes',
      restReady: 'Listo',
      privKicker: 'Tus datos son tuyos', privTitle: 'Sin humo,<br>sin letra pequeña',
      manifestNote: 'Sin permiso de internet, la app no puede mandar tus datos a ningún sitio. No es una promesa: es el sistema quien lo impide.',
      impKicker: 'Vienes de otra app', impTitle: 'Tráete<br>tu historial',
      impLead: 'CSV de Hevy o Strong, o la copia entera de FitNotes. Cada ejercicio se empareja solo y lo repetido se descarta.',
      whyKicker: 'Por qué existe',
      whyTitle: 'Me cansé de pagar<br>por ver mis propias series.',
      whyP1: 'Todas las apps de gimnasio acaban igual: una cuenta, un plan mensual y tu historial secuestrado detrás de un botón dorado. Así que hice la que yo quería usar — rápida, oscura, sin internet y gratis de verdad.',
      whyP2: 'GymMane es código abierto con licencia GPL-3.0: nadie puede cerrarla ni revenderla. Si le falta algo que necesitas, el repositorio está abierto y las incidencias también.',
      whySign: 'Autor de GymMane · un dev, sin empresa detrás',
      dlBtn: 'Descargar el APK',
      dl1: 'APK directo · Android 7+',
      dl2: 'Sin cuenta, sin anuncios, sin telemetría',
      dl3: 'F-Droid e IzzyOnDroid: en camino',
      endKicker: 'Se acabaron las notas sueltas', endTitle: 'Empieza a<br>llevar la cuenta',
      endLead: 'Descárgala, registra tu primera sesión y deja que los números hablen.',
      endBtn2: 'Invítame a un café',
      footFine: 'GymMane — hecha con Flutter para Android.',
      footTagline: 'Un diario de gimnasio que no pide nada: ni cuenta, ni internet, ni permisos.',
      footBadgeOffline: '100% offline',
      footCode: 'Código', footReleases: 'Descargar APK',
      footIssues: 'Reportar un fallo', footCoffee: 'Invítame a un café',
      footNoCookies: 'sin cookies ni analítica',
      liveNote: 'Demo real — tócala',
      app: {
        navhome: 'INICIO', navprogress: 'PROGRESO', navexercises: 'EJERCICIOS', navsettings: 'AJUSTES',
        today: 'Hoy', routine: 'RUTINA DE HOY', focus: 'FOCO DE HOY', pullDay: 'DÍA DE TIRÓN', exs: 'ejercicios',
        startWorkout: 'EMPEZAR', thisWeek: 'ESTA SEMANA', volume: 'Volumen', setsToday: 'Series hoy', goal: 'Meta',
        train: 'ENTRENAR', step1: 'PASO 1 DE 2', step2: 'PASO 2 DE 2',
        chooseFocus: 'ELIGE TU FOCO', yourSession: 'TU SESIÓN', front: 'FRENTE', back: 'ESPALDA',
        noMuscles: 'Nada elegido — toca el cuerpo.', continue: 'CONTINUAR', sets: 'series',
        inProgress: 'EN CURSO', finish: 'Terminar', pause: 'Pausar', exercise: 'EJERCICIO', of: 'DE',
        rest: 'DESCANSO', skip: 'SALTAR', backToIt: '¡A la barra!', reps: 'REPS', kg: 'PESO (KG)',
        addSet: 'AÑADIR SERIE', nextEx: 'SIGUIENTE',
        complete: 'SESIÓN COMPLETA', completeSub: 'Leo está orgulloso. Mantén la racha viva.',
        duration: 'Duración', saveExit: 'GUARDAR Y SALIR',
        vol30: 'VOLUMEN TOTAL · 30 DÍAS', consistency: 'CONSTANCIA', sessionsLogged: '33 sesiones',
        streak: 'racha de 27 días', split: 'REPARTO MUSCULAR', records: 'RÉCORDS PERSONALES',
        inLibrary: 'ejercicios en tu biblioteca', search: 'Buscar ejercicios',
        tapBody: 'Toca los músculos que quieras entrenar — frente y espalda.',
        last: 'ÚLTIMA', restDefault: 'Por defecto 90s — cámbialo en Ajustes',
        finishSession: 'TERMINAR', vsMonth: '+64% vs mes pasado', bodyweight: 'PESO CORPORAL',
        favs: 'FAVORITOS', muscle: 'Músculo', level: 'Nivel', newEx: 'NUEVO EJERCICIO',
        lvBeg: 'Principiante', lvInt: 'Intermedio', lvAdv: 'Avanzado',
        level4: 'Nivel 4', prefs: 'Preferencias', data: 'Datos',
        setTheme: 'Tema', dark: 'Oscuro', light: 'Claro', setBackup: 'Copia de seguridad (JSON)',
        demoTitle: 'Demo limitada. ', demoBody: 'En la app hay +360 ejercicios con animación, rutinas, historial, calculadoras, widgets y alarma de descanso. Esto es solo un aperitivo para que la toques.',
        setLang: 'Idioma', setUnits: 'Unidades', setRest: 'Descanso por defecto',
        setSound: 'Sonido de alarma', setSoundVal: 'El tuyo', setExport: 'Exportar entrenos (CSV)', setWipe: 'Borrar todo'
      },
      muscles: {
        chest: 'Pecho', back: 'Espalda', shoulders: 'Hombros', biceps: 'Bíceps', triceps: 'Tríceps',
        forearm: 'Antebrazo', trapezius: 'Trapecio', abdomen: 'Abdomen', obliques: 'Oblicuos',
        quads: 'Cuádriceps', hamstrings: 'Isquios', glutes: 'Glúteos', calves: 'Gemelos'
      }
    },
    en: {
      metaDesc: 'GymMane is a 100% offline gym log: track your sets, see your real progress and train with no account, no ads and no subscription. Open source under GPL-3.0.',
      title: 'GymMane — An offline gym log with no nonsense',
      navFeatures: 'Features', navPrivacy: 'Privacy', navTranslate: 'Translate',
      navShots: 'Screens', navDownload: 'Download',
      skip: 'Skip to content',
      relNote: 'Out now for Android',
      heroL1: 'Lift.', heroL2: 'Log it.', heroL3: 'Grow.',
      heroLead: 'The gym app with no nonsense: log your sets and watch your progress <em>for real</em>. All on your phone.',
      ctaGithub: 'View on GitHub', ctaTry: 'See the screens',
      promiseFree: 'Free, no ads', promiseNoAcc: 'No account', promiseOffline: '100% offline',
      featKicker: 'What you get',
      featTitle: 'Everything from the gym.<br>None of the filler.',
      featLead: 'Every number comes from your own sets. If it is on screen, you lifted it.',
      f1t: 'Train', f1d: 'Pick muscles on a real body — front and back — then log sets, reps, weight and rest with a real alarm, with your own sound.',
      f2t: 'Progress', f2d: 'Volume, a GitHub-style heatmap, personal records and strength curves with estimated 1RM.',
      f3t: 'Tools', f3d: '1RM, barbell plates, BMI, calories and macros, body fat and warm-up. All with published formulas.',
      f4t: 'Your own exercises', f4d: '+360 exercises with animations and step-by-step instructions. Missing one? Create it with your photo, GIF or video.',
      f5t: 'Home widgets', f5d: 'Your activity and your stats on the home screen, built with the same care as the app.',
      f6t: 'Properly offline', f6d: 'No servers, no account, no internet. Export to CSV or a JSON backup, and wipe it all in one tap.',
      shotsKicker: 'Real screenshots',
      shotsTitle: 'This is how<br>it looks inside.',
      shotsLead: 'No invented mockups: every screen here comes from the app running on a real phone. Tap any of them to see it big.',
      sHome: 'Home', sProgress: 'Progress', sTrain: 'Train', sSession: 'Session',
      sHistory: 'History', sLibrary: 'Exercises', sRoutines: 'Routines', sSettings: 'Settings',
      restReady: 'Ready',
      privKicker: 'Your data is yours', privTitle: 'No smoke,<br>no small print',
      manifestNote: 'With no internet permission the app cannot send your data anywhere. It is not a promise — the system enforces it.',
      impKicker: 'Coming from another app', impTitle: 'Bring your<br>history along',
      impLead: 'A CSV from Hevy or Strong, or the whole FitNotes backup. Every exercise is matched for you and anything you already logged is skipped.',
      whyKicker: 'Why it exists',
      whyTitle: 'I got tired of paying<br>to look at my own sets.',
      whyP1: 'Every gym app ends up the same: an account, a monthly plan and your history locked behind a golden button. So I built the one I wanted to use — fast, dark, offline and actually free.',
      whyP2: 'GymMane is open source under GPL-3.0, so nobody can close it up and resell it. If it is missing something you need, the repo is open and so is the issue tracker.',
      whySign: 'Author of GymMane · one dev, no company behind it',
      dlBtn: 'Download the APK',
      dl1: 'Direct APK · Android 7+',
      dl2: 'No account, no ads, no telemetry',
      dl3: 'F-Droid and IzzyOnDroid: on the way',
      endKicker: 'No more notes app', endTitle: 'Start keeping<br>the count',
      endLead: 'Download it, log your first session and let the numbers do the talking.',
      endBtn2: 'Buy me a coffee',
      footFine: 'GymMane — built with Flutter for Android.',
      footTagline: 'A gym log that asks for nothing: no account, no internet, no permissions.',
      footBadgeOffline: '100% offline',
      footCode: 'Source', footReleases: 'Download APK',
      footIssues: 'Report a bug', footCoffee: 'Buy me a coffee',
      footNoCookies: 'no cookies, no analytics',
      liveNote: 'Live demo — tap it',
      app: {
        navhome: 'HOME', navprogress: 'PROGRESS', navexercises: 'EXERCISES', navsettings: 'SETTINGS',
        today: 'Today', routine: "TODAY'S ROUTINE", focus: "TODAY'S FOCUS", pullDay: 'PULL DAY', exs: 'exercises',
        startWorkout: 'START WORKOUT', thisWeek: 'THIS WEEK', volume: 'Volume', setsToday: 'Sets today', goal: 'Goal',
        train: 'TRAIN', step1: 'STEP 1 OF 2', step2: 'STEP 2 OF 2',
        chooseFocus: 'CHOOSE YOUR FOCUS', yourSession: 'YOUR SESSION', front: 'FRONT', back: 'BACK',
        noMuscles: 'Nothing picked — tap the body.', continue: 'CONTINUE', sets: 'sets',
        inProgress: 'IN PROGRESS', finish: 'Finish', pause: 'Pause', exercise: 'EXERCISE', of: 'OF',
        rest: 'REST', skip: 'SKIP', backToIt: 'Back to it!', reps: 'REPS', kg: 'WEIGHT (KG)',
        addSet: 'ADD SET', nextEx: 'NEXT',
        complete: 'SESSION COMPLETE', completeSub: "Leo's proud of that one. Keep the streak alive.",
        duration: 'Duration', saveExit: 'SAVE AND EXIT',
        vol30: 'TOTAL VOLUME · 30 DAYS', consistency: 'CONSISTENCY', sessionsLogged: '33 sessions logged',
        streak: '27-day streak', split: 'MUSCLE SPLIT', records: 'PERSONAL RECORDS',
        inLibrary: 'exercises in your library', search: 'Search exercises',
        tapBody: 'Tap the muscles you want to train — front and back.',
        last: 'LAST', restDefault: 'Default is 90s — change it in Settings',
        finishSession: 'FINISH', vsMonth: '+64% vs last month', bodyweight: 'BODYWEIGHT',
        favs: 'FAVOURITES', muscle: 'Muscle', level: 'Level', newEx: 'NEW EXERCISE',
        lvBeg: 'Beginner', lvInt: 'Intermediate', lvAdv: 'Advanced',
        level4: 'Level 4', prefs: 'Preferences', data: 'Data',
        setTheme: 'Theme', dark: 'Dark', light: 'Light', setBackup: 'Backup (JSON)',
        demoTitle: 'Limited demo. ', demoBody: 'The app packs more than 360 animated exercises, routines, history, calculators, widgets and a real rest alarm. This is just a taste so you can poke at it.',
        setLang: 'Language', setUnits: 'Units', setRest: 'Default rest',
        setSound: 'Alarm sound', setSoundVal: 'Yours', setExport: 'Export workouts (CSV)', setWipe: 'Wipe everything'
      },
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
    aRender(true);
    document.querySelectorAll('#bodySvg .muscle').forEach(function (g) {
      var id = g.getAttribute('data-muscle');
      g.setAttribute('aria-label', d.muscles[id] || id);
    });
    if (lb.classList.contains('on')) lbCap.textContent = t(SHOTS[lbIdx].k);
    if (!timer.running) setState(t('restReady'));
    paintLive('stars', false);
    paintLive('dl', false);
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
    { f: 'progress', k: 'sProgress' }, { f: 'history', k: 'sHistory' }, { f: 'library', k: 'sLibrary' },
    { f: 'routines', k: 'sRoutines' }, { f: 'settings', k: 'sSettings' }
  ];
  var rail = document.getElementById('shotsRail');
  var track = document.getElementById('shotsTrack');

  function buildShots() {
    function card(s, i, dup) {
      return '<figure class="shot"' + (dup ? ' aria-hidden="true"' : '') + '>' +
        '<div class="phone" role="button" tabindex="' + (dup ? '-1' : '0') + '" data-i="' + i +
        '" aria-label="' + t(s.k) + '"><div class="island"></div>' +
        '<img src="assets/shots/' + s.f + '.webp" width="630" height="1400" loading="lazy" alt="GymMane — ' +
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
    lbImg.src = 'assets/shots/' + SHOTS[lbIdx].f + '.webp';
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

  var EXDB = {
    chest:      ['Barbell Bench Press', 'Press de banca con barra', 'Barbell', 1],
    back:       ['Barbell Bent Over Row', 'Remo con barra', 'Barbell', 1],
    shoulders:  ['Dumbbell Standing Overhead Press', 'Press militar de pie con mancuernas', 'Dumbbell', 1],
    biceps:     ['Barbell Curl', 'Curl de bíceps con barra', 'Barbell', 0],
    triceps:    ['Cable Pushdown', 'Extensión de tríceps en polea', 'Cable', 0],
    trapezius:  ['Barbell Shrug', 'Encogimientos con barra', 'Barbell', 0],
    abdomen:    ['Crunch Floor', 'Crunch en el suelo', 'Bodyweight', 0],
    obliques:   ['Side Plank Hip Adduction', 'Aducción de cadera en plancha lateral', 'Bodyweight', 1],
    forearm:    ['Barbell Wrist Curl', 'Curl de muñeca con barra', 'Barbell', 0],
    quads:      ['Dumbbell Goblet Squat', 'Sentadilla goblet con mancuerna', 'Dumbbell', 1],
    hamstrings: ['Barbell Good Morning', 'Buenos días con barra', 'Barbell', 1],
    glutes:     ['Barbell Romanian Deadlift', 'Peso muerto rumano con barra', 'Barbell', 2],
    calves:     ['Barbell Standing Calf Raise', 'Elevación de gemelos de pie con barra', 'Barbell', 0]
  };
  var LAST = {
    chest: '95×8 · 95×8 · 95×7 · 90×9', back: '80×10 · 80×9 · 75×10',
    shoulders: '22×10 · 22×9 · 20×10', biceps: '35×10 · 35×9 · 30×11',
    triceps: '30×12 · 30×11 · 27×12', trapezius: '90×12 · 90×12 · 85×12',
    abdomen: '0×20 · 0×18 · 0×16', obliques: '0×14 · 0×12', forearm: '30×15 · 30×14',
    quads: '32×12 · 32×10 · 28×12', hamstrings: '60×10 · 60×10 · 55×10',
    glutes: '110×8 · 110×8 · 100×9', calves: '80×15 · 80×14 · 75×15'
  };

  function exGif(m) { return 'assets/ex/' + m + '.webp'; }

  var A = {
    screen: 'home', step: 1,
    picked: ['chest', 'shoulders'],
    ex: [], exIdx: 0, sets: [], rest: 0, restTotal: 90, restOver: false,
    elapsed: 0, paused: false, saved: false, week: [1, 1, 1, 1, 1, 0, 0], today: 0, id: null
  };

  var app = document.getElementById('app');
  A.today = (new Date().getDay() + 6) % 7;
  for (var wi = 0; wi < 7; wi++) A.week[wi] = wi < A.today ? 1 : 0;

  function exName(m) { return EXDB[m][lang === 'es' ? 1 : 0]; }
  function exKit(m) { return EXDB[m][2]; }
  function exLevel(m) { return [ta('lvBeg'), ta('lvInt'), ta('lvAdv')][EXDB[m][3]]; }
  function ta(k) { return DICT[lang].app[k]; }
  function mus(id) { return DICT[lang].muscles[id]; }
  function pad(n) { return (n < 10 ? '0' : '') + n; }
  function clock(s) { return pad(Math.floor(s / 60)) + ':' + pad(s % 60); }

  function buildSession() {
    A.ex = (A.picked.length ? A.picked : ['chest']).slice(0, 6);
    A.exIdx = 0;
    loadSets();
  }
  function loadSets() {
    A.sets = [{ r: 8, w: 95, ok: false }, { r: 8, w: 95, ok: false }, { r: 7, w: 95, ok: false }, { r: 9, w: 90, ok: false }];
    A.rest = 0; A.restOver = false;
  }

  var PH = {
    rhouse: 'M877 525 557 845Q549 854 537.0 859.0Q525 864 512 864Q499 864 487.0 859.0Q475 854 467 845L147 525Q138 517 133.0 505.0Q128 493 128 480Q128 480 128.0 480.0Q128 480 128 480V96Q128 83 137.5 73.5Q147 64 160 64H416Q429 64 438.5 73.5Q448 83 448 96V320H576V96Q576 83 585.5 73.5Q595 64 608 64H864Q877 64 886.5 73.5Q896 83 896 96V480Q896 480 896.0 480.0Q896 480 896 480Q896 493 891.0 505.0Q886 517 877 525ZM832 128H640V352Q640 365 630.5 374.5Q621 384 608 384H416Q403 384 393.5 374.5Q384 365 384 352V128H192V480L512 800L832 480Z',
    fhouse: 'M896 480V96Q896 83 886.5 73.5Q877 64 864 64H640Q627 64 617.5 73.5Q608 83 608 96V304Q608 311 603.5 315.5Q599 320 592 320H432Q425 320 420.5 315.5Q416 311 416 304V96Q416 83 406.5 73.5Q397 64 384 64H160Q147 64 137.5 73.5Q128 83 128 96V480Q128 493 133.0 505.0Q138 517 147 525L467 845Q475 854 487.0 859.0Q499 864 512 864Q525 864 537.0 859.0Q549 854 557 845L877 525Q886 517 891.0 505.0Q896 493 896 480Z',
    rchartLineUp: 'M928 128Q928 115 918.5 105.5Q909 96 896 96H128Q115 96 105.5 105.5Q96 115 96 128V768Q96 781 105.5 790.5Q115 800 128 800Q141 800 150.5 790.5Q160 781 160 768V333L361 535Q366 539 371.5 541.5Q377 544 384 544Q391 544 396.5 541.5Q402 539 407 535L512 429L723 640H640Q627 640 617.5 649.5Q608 659 608 672Q608 685 617.5 694.5Q627 704 640 704H800Q813 704 822.5 694.5Q832 685 832 672V512Q832 499 822.5 489.5Q813 480 800 480Q787 480 777.5 489.5Q768 499 768 512V595L535 361Q530 357 524.5 354.5Q519 352 512 352Q505 352 499.5 354.5Q494 357 489 361L384 467L160 243V160H896Q909 160 918.5 150.5Q928 141 928 128Z',
    fchartLineUp: 'M864 800H160Q133 800 114.5 781.5Q96 763 96 736V160Q96 133 114.5 114.5Q133 96 160 96H864Q891 96 909.5 114.5Q928 133 928 160V736Q928 763 909.5 781.5Q891 800 864 800ZM800 192H224Q211 192 201.5 201.5Q192 211 192 224V672Q192 685 201.5 694.5Q211 704 224 704Q237 704 246.5 694.5Q256 685 256 672V365L393 503Q398 507 403.5 509.5Q409 512 416 512Q423 512 428.5 509.5Q434 507 439 503L512 429L691 608H576Q563 608 553.5 617.5Q544 627 544 640Q544 653 553.5 662.5Q563 672 576 672H768Q781 672 790.5 662.5Q800 653 800 640V448Q800 435 790.5 425.5Q781 416 768 416Q755 416 745.5 425.5Q736 435 736 448V563L535 361Q530 357 524.5 354.5Q519 352 512 352Q505 352 499.5 354.5Q494 357 489 361L416 435L256 275V256H800Q813 256 822.5 246.5Q832 237 832 224Q832 211 822.5 201.5Q813 192 800 192Z',
    rbarbell: 'M992 480H960V608Q960 635 941.5 653.5Q923 672 896 672H832V704Q832 731 813.5 749.5Q795 768 768 768H672Q645 768 626.5 749.5Q608 731 608 704V480H416V704Q416 731 397.5 749.5Q379 768 352 768H256Q229 768 210.5 749.5Q192 731 192 704V672H128Q101 672 82.5 653.5Q64 635 64 608V480H32Q19 480 9.5 470.5Q0 461 0 448Q0 435 9.5 425.5Q19 416 32 416H64V288Q64 261 82.5 242.5Q101 224 128 224H192V192Q192 165 210.5 146.5Q229 128 256 128H352Q379 128 397.5 146.5Q416 165 416 192V416H608V192Q608 165 626.5 146.5Q645 128 672 128H768Q795 128 813.5 146.5Q832 165 832 192V224H896Q923 224 941.5 242.5Q960 261 960 288V416H992Q1005 416 1014.5 425.5Q1024 435 1024 448Q1024 461 1014.5 470.5Q1005 480 992 480ZM128 288V608H192V288ZM352 192H256V704H352ZM768 192H672V704H768V257Q768 257 768.0 256.5Q768 256 768 256Q768 256 768.0 255.5Q768 255 768 255ZM896 288H832V608H896Z',
    fbarbell: 'M800 704V192Q800 165 781.5 146.5Q763 128 736 128H672Q645 128 626.5 146.5Q608 165 608 192V416H416V192Q416 165 397.5 146.5Q379 128 352 128H288Q261 128 242.5 146.5Q224 165 224 192V704Q224 731 242.5 749.5Q261 768 288 768H352Q379 768 397.5 749.5Q416 731 416 704V480H608V704Q608 731 626.5 749.5Q645 768 672 768H736Q763 768 781.5 749.5Q800 731 800 704ZM144 672H128Q101 672 82.5 653.5Q64 635 64 608V480H33Q33 480 33.0 480.0Q33 480 33 480Q20 480 10.5 471.5Q1 463 0 450Q0 450 0.0 449.5Q0 449 0 448Q0 435 9.5 425.5Q19 416 32 416Q32 416 32.0 416.0Q32 416 32 416H64V288Q64 261 82.5 242.5Q101 224 128 224H144Q151 224 155.5 228.5Q160 233 160 240V656Q160 663 155.5 667.5Q151 672 144 672ZM1024 450Q1023 463 1013.5 471.5Q1004 480 991 480Q991 480 991.0 480.0Q991 480 991 480H960V608Q960 635 941.5 653.5Q923 672 896 672H880Q873 672 868.5 667.5Q864 663 864 656V240Q864 233 868.5 228.5Q873 224 880 224H896Q923 224 941.5 242.5Q960 261 960 288V416H992Q992 416 992.0 416.0Q992 416 992 416Q1005 416 1014.5 425.5Q1024 435 1024 448Q1024 449 1024.0 449.5Q1024 450 1024 450Z',
    rgearSix: 'M512 640Q432 640 376.0 584.0Q320 528 320 448Q320 368 376.0 312.0Q432 256 512 256Q592 256 648.0 312.0Q704 368 704 448Q704 527 647.5 583.5Q591 640 512 640ZM512 320Q459 320 421.5 357.5Q384 395 384 448Q384 501 421.5 538.5Q459 576 512 576Q565 576 602.5 538.5Q640 501 640 448Q640 395 602.5 357.5Q565 320 512 320ZM952 531Q950 538 946.0 543.5Q942 549 936 553L817 621L816 755Q816 763 813.0 769.0Q810 775 805 780Q774 806 737.5 827.0Q701 848 661 861L658 862Q656 863 653.5 863.5Q651 864 648 864Q644 864 640.0 863.0Q636 862 632 860L512 793L392 860Q388 862 384.0 863.0Q380 864 376 864Q373 864 370.5 863.5Q368 863 365 862H366Q323 848 286.5 827.0Q250 806 218 779H219Q214 775 211.0 768.5Q208 762 208 755L207 621L88 553Q82 549 78.0 543.5Q74 538 72 531Q68 512 66.0 491.0Q64 470 64 448Q64 426 66.0 404.5Q68 383 73 362L72 365Q74 358 78.0 352.5Q82 347 88 343L207 275V141Q208 133 211.0 127.0Q214 121 219 116Q250 90 286.0 69.0Q322 48 363 35L366 34Q368 33 370.5 32.5Q373 32 376 32Q380 32 384.0 33.0Q388 34 392 36L512 103L632 36Q636 34 640.0 33.0Q644 32 648 32Q648 32 648.0 32.0Q648 32 648 32Q651 32 653.5 32.5Q656 33 659 34H658Q701 48 737.5 69.0Q774 90 806 117H805Q810 121 813.0 127.5Q816 134 816 141L817 275L936 343Q942 347 946.0 352.5Q950 358 952 365Q956 384 958.0 405.0Q960 426 960 448Q960 470 958.0 491.5Q956 513 951 534L952 531ZM892 392 777 327Q774 324 771.0 321.0Q768 318 766 315H765Q764 312 762.0 308.5Q760 305 758 302Q756 299 754.5 294.5Q753 290 753 285V156Q731 139 706.0 125.0Q681 111 654 100L651 99L536 163Q533 165 529.0 166.0Q525 167 521 167Q520 167 520.0 167.0Q520 167 520 167Q516 167 512.5 167.0Q509 167 505 167Q505 167 504.5 167.0Q504 167 504 167Q500 167 496.0 166.0Q492 165 488 163H489L373 99Q344 110 318.5 124.5Q293 139 271 157L272 156L271 285Q271 289 269.5 293.5Q268 298 266 302Q264 305 262.5 308.0Q261 311 259 314Q257 318 254.0 321.0Q251 324 247 326L133 391Q130 404 129.0 418.5Q128 433 128 448Q128 463 129.5 477.5Q131 492 133 506V504L247 569Q250 572 253.0 575.0Q256 578 259 581Q260 584 262.0 587.5Q264 591 266 594Q268 597 269.5 601.5Q271 606 271 611V740Q293 757 318.0 771.0Q343 785 370 796L373 797L488 733Q491 731 495.0 730.0Q499 729 504 729Q504 729 504.0 729.0Q504 729 504 729Q508 729 511.5 729.0Q515 729 519 729Q519 729 519.5 729.0Q520 729 520 729Q524 729 528.0 730.0Q532 731 536 733H535L651 797Q680 786 705.5 771.5Q731 757 753 739L752 740L753 611Q753 607 754.5 602.5Q756 598 758 594Q760 591 761.5 588.0Q763 585 765 582Q767 578 770.0 575.0Q773 572 777 570L891 505Q894 492 895.0 477.5Q896 463 896 447Q896 433 895.0 418.5Q894 404 891 389L892 392Z',
    fgearSix: 'M952 531Q950 538 946.0 543.5Q942 549 936 553L817 621L816 755Q816 763 813.0 769.0Q810 775 805 780Q774 806 737.5 827.0Q701 848 661 861L658 862Q656 863 653.5 863.5Q651 864 648 864Q644 864 640.0 863.0Q636 862 632 860L512 793L392 860Q388 862 384.0 863.0Q380 864 376 864Q373 864 370.5 863.5Q368 863 365 862H366Q323 848 286.5 827.0Q250 806 218 779H219Q214 775 211.0 768.5Q208 762 208 755L207 621L88 553Q82 549 78.0 543.5Q74 538 72 531Q68 512 66.0 491.0Q64 470 64 448Q64 426 66.0 404.5Q68 383 73 362L72 365Q74 358 78.0 352.5Q82 347 88 343L207 275V141Q208 133 211.0 127.0Q214 121 219 116Q250 90 286.0 69.0Q322 48 363 34H366Q368 33 370.5 32.5Q373 32 376 32Q380 32 384.0 33.0Q388 34 392 36L512 103L632 36Q636 34 640.0 33.0Q644 32 648 32Q648 32 648.0 32.0Q648 32 648 32Q651 32 653.5 32.5Q656 33 659 34H658Q701 48 737.5 69.0Q774 90 806 117H805Q810 121 813.0 127.5Q816 134 816 141L817 275L936 343Q942 347 946.0 352.5Q950 358 952 365Q956 384 958.0 405.0Q960 426 960 448Q960 470 958.0 491.5Q956 513 951 534L952 531ZM512 288Q446 288 399.0 335.0Q352 382 352 448Q352 514 399.0 561.0Q446 608 512 608Q578 608 625.0 561.0Q672 514 672 448Q672 382 625.0 335.0Q578 288 512 288Z',
    rplay: 'M930 502 353 855Q346 859 337.5 861.5Q329 864 320 864Q311 864 303.0 862.0Q295 860 288 856Q274 848 265.0 833.0Q256 818 256 801V95Q256 69 274.5 50.5Q293 32 320 32Q320 32 320.0 32.0Q320 32 320 32Q329 32 337.5 34.5Q346 37 354 42L353 41L930 394Q943 402 951.5 416.5Q960 431 960 448Q960 465 951.5 479.0Q943 493 930 502ZM320 96V800L895 448Z',
    fplay: 'M960 448Q960 448 960.0 448.0Q960 448 960 448Q960 431 951.5 416.5Q943 402 930 394L353 41Q346 37 337.5 34.5Q329 32 320 32Q311 32 303.0 34.0Q295 36 288 40Q274 48 265.0 63.0Q256 78 256 95V801Q256 818 265.0 832.5Q274 847 288 856Q295 860 303.0 862.0Q311 864 320 864Q329 864 337.5 861.5Q346 859 354 854L353 855L930 502Q943 494 951.5 479.5Q960 465 960 448Q960 448 960.0 448.0Q960 448 960 448Z'
  };

  var ICON = {
    check: '<path d="M4 12l5 5L20 6"/>',
    flame: '<path d="M12 2c1 4-3 5-3 9a3 3 0 0 0 6 0c0-1.5-.5-2-1-3 2 1 3 3 3 5a5 5 0 0 1-10 0c0-5 4-6 5-11z"/>',
    play: '<path d="M8 5v14l11-7z"/>'
  };
  var NAV = [
    ['home', 'house'], ['progress', 'chartLineUp'], ['exercises', 'barbell'], ['settings', 'gearSix']
  ];
  function sv(p, o) {
    return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" ' +
      (o || 'width="16" height="16"') + '>' + p + '</svg>';
  }

  function phos(name, on, size) {
    return '<svg class="ph" viewBox="0 0 256 256" width="' + size + '" height="' + size + '" aria-hidden="true">' +
      '<g transform="translate(0 240) scale(.25 -.25)"><path d="' + PH[(on ? 'f' : 'r') + name] + '"/></g></svg>';
  }

  function aStatus() {
    return '<div class="a-status"><span>9:41</span><span class="rt">' +
      sv('<rect x="2" y="7" width="17" height="10" rx="2.4"/><path d="M21 10v4"/>', 'width="22" height="12"') +
      '</span></div>';
  }

  var navEl = null, navLang = null;
  function aNavEl() {
    if (!navEl) {
      navEl = document.createElement('div');
      navEl.className = 'a-nav';
    }
    if (navLang !== lang) {
      navLang = lang;
      navEl.innerHTML = '<span class="a-navpill"></span>' +
        NAV.slice(0, 2).map(navItem).join('') +
        '<button class="go" data-a="start" aria-label="' + ta('startWorkout') + '">' +
          '<svg viewBox="0 0 256 256" width="24" height="24"><g transform="translate(0 240) scale(.25 -.25)"><path d="' + PH.fplay + '"/></g></svg>' +
        '</button>' +
        NAV.slice(2).map(navItem).join('');
    }
    navEl.hidden = A.screen === 'train' || A.screen === 'session' || A.screen === 'done';
    var pill = navEl.querySelector('.a-navpill'), active = null;
    NAV.forEach(function (n) {
      var b = navEl.querySelector('[data-a="go:' + n[0] + '"]');
      var on = A.screen === n[0];
      b.classList.toggle('on', on);
      b.setAttribute('aria-current', on ? 'page' : 'false');
      b.querySelector('.ph path').setAttribute('d', PH[(on ? 'f' : 'r') + n[1]]);
      if (on) active = b;
    });
    if (active && active.offsetWidth) {
      pill.hidden = false;
      pill.style.left = active.offsetLeft + 'px';
      pill.style.width = active.offsetWidth + 'px';
    } else {
      pill.hidden = !active;
    }
    return navEl;
  }
  function navItem(n) {
    return '<button data-a="go:' + n[0] + '">' + phos(n[1], false, 22) +
      '<span>' + ta('nav' + n[0]) + '</span></button>';
  }

  function aDemoNote() {
    return '<div class="a-demo"><b>' + ta('demoTitle') + '</b>' + ta('demoBody') + '</div>';
  }

  function aHome() {
    var d = new Date();
    var day = d.toLocaleDateString(lang === 'es' ? 'es-ES' : 'en-GB', { weekday: 'long', day: 'numeric', month: 'short' });
    day = day.charAt(0).toUpperCase() + day.slice(1).replace('.', '');
    var focus = A.picked.length ? A.picked.map(mus).join(' · ') : mus('back') + ' · ' + mus('biceps');
    var total = 0; (A.picked.length ? A.picked : ['back', 'biceps']).forEach(function (m) { total += COUNTS[m]; });
    var days = lang === 'es' ? ['L', 'M', 'X', 'J', 'V', 'S', 'D'] : ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return '<div class="a-scroll">' +
      '<div style="display:flex;align-items:center;justify-content:space-between">' +
        '<div><div class="a-lbl">' + ta('today') + '</div>' +
        '<div class="a-dsp" style="font-size:20px;letter-spacing:.01em;margin-top:1px">' + day + '</div></div>' +
        '<span class="a-pill"><svg viewBox="0 0 24 24" width="14" height="14" fill="currentColor">' + ICON.flame + '</svg>' +
        '<b class="a-dsp" style="font-size:13px">' + (A.saved ? 28 : 27) + '</b></span>' +
      '</div>' +

      '<div class="a-card big a-focus">' +
        '<img src="assets/runner.webp" alt="" class="a-runner" />' +
        '<div style="position:relative">' +
          '<div class="a-kick">' + ta('focus') + '</div>' +
          '<div class="a-dsp" style="font-size:40px;line-height:.98;margin-top:6px">' + ta('pullDay') + '</div>' +
          '<div style="font-size:12.5px;color:var(--at2);margin-top:7px">' + focus + ' · ' + total + ' ' + ta('exs') + '</div>' +
          '<button class="a-btn" style="margin-top:17px" data-a="start">' +
            '<svg viewBox="0 0 24 24" width="15" height="15" fill="currentColor">' + ICON.play + '</svg>' + ta('startWorkout') + '</button>' +
        '</div>' +
      '</div>' +

      '<div class="a-card" style="display:flex;align-items:center;justify-content:space-between;gap:14px">' +
        '<div><div class="a-kick" style="font-size:10.5px;letter-spacing:.22em">' + ta('routine') + '</div>' +
        '<div class="a-dsp" style="font-size:22px;letter-spacing:0;margin-top:3px">Push</div>' +
        '<div style="font-size:12px;color:var(--at2)">5 ' + ta('exs') + '</div></div>' +
        '<button data-a="start" style="width:44px;height:44px;border-radius:50%;background:#fff;display:grid;place-items:center;flex:none">' +
          '<svg viewBox="0 0 24 24" width="17" height="17" fill="#0A0A0A">' + ICON.play + '</svg></button>' +
      '</div>' +

      '<div class="a-card"><div class="a-week">' + days.map(function (l, i) {
        var on = !!A.week[i];
        return '<button class="d" data-a="day:' + i + '" aria-pressed="' + on + '" aria-label="' + l + '">' +
          '<i>' + l + '</i><span class="o' + (on ? ' on' : '') + (i === A.today ? ' today' : '') + '">' +
          (on ? '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#0A0A0A" stroke-width="3.4" stroke-linecap="round">' + ICON.check + '</svg>' : '') +
          '</span></button>';
      }).join('') + '</div></div>' +

      '<div><div class="a-kick" style="color:var(--at2);letter-spacing:.22em;margin-bottom:9px">' + ta('thisWeek') + '</div>' +
        '<div class="a-grid2">' +
          '<div class="a-card a-stat"><div class="a-lbl">' + ta('volume') + '</div><div class="v">' + (A.saved ? '35.1' : '32.7') + '<small> t</small></div></div>' +
          '<div class="a-card a-stat"><div class="a-lbl">' + ta('setsToday') + '</div><div class="v">' + (A.saved ? 19 : 16) + '</div></div>' +
          '<div class="a-card a-stat"><div class="a-lbl">PRs</div><div class="v">15</div></div>' +
          '<div class="a-card a-stat" style="display:flex;align-items:center;gap:11px">' +
            '<svg width="36" height="36" viewBox="0 0 40 40" style="flex:none">' +
              '<circle cx="20" cy="20" r="16" fill="none" stroke="var(--ar2)" stroke-width="4"/>' +
              '<circle cx="20" cy="20" r="16" fill="none" stroke="var(--clay)" stroke-width="4" stroke-linecap="round" stroke-dasharray="100.5" stroke-dashoffset="' + (A.saved ? 0 : 24) + '" transform="rotate(-90 20 20)"/>' +
            '</svg>' +
            '<div><div class="a-lbl">' + ta('goal') + '</div><div class="v" style="font-size:20px">' + (A.saved ? 100 : 76) + '<small>%</small></div></div>' +
          '</div>' +
        '</div>' +
      '</div>' +
      aDemoNote() +
    '</div>';
  }

  function aTrain() {
    var head = '<div style="display:flex;align-items:center;justify-content:space-between">' +
      '<button data-a="go:home" style="width:36px;height:36px;border-radius:50%;background:var(--ar);border:1px solid var(--abd);display:grid;place-items:center">' +
        sv('<path d="M6 6l12 12M18 6L6 18"/>', 'width="15" height="15"') + '</button>' +
      '<div class="a-dsp" style="font-size:16px;letter-spacing:.2em">' + ta('train') + '</div><div style="width:36px"></div></div>';

    if (A.step === 2) {
      return '<div class="a-scroll plain">' + head +
        '<div><div class="a-kick">' + ta('step2') + '</div>' +
        '<div class="a-dsp" style="font-size:22px;margin-top:2px">' + ta('yourSession') + '</div></div>' +
        A.ex.map(function (m) {
          return '<div class="a-card" style="display:flex;align-items:center;gap:12px;padding:11px;border-radius:16px">' +
            '<div class="a-thumb"><img src="' + exGif(m) + '" width="300" height="300" loading="lazy" alt="" /></div>' +
            '<div><div style="font-size:13.5px;font-weight:600">' + exName(m) + '</div>' +
            '<div style="font-size:12px;color:var(--at2);margin-top:1px">' + mus(m) + ' · 4 ' + ta('sets') + '</div></div></div>';
        }).join('') +
        '<button class="a-btn" style="margin-top:4px" data-a="begin">' + ta('startWorkout') + '</button></div>';
    }

    var chips = A.picked.length
      ? A.picked.map(function (id) {
          return '<span class="a-chip">' + mus(id) + '<button data-a="m:' + id + '" aria-label="x">' +
            sv('<path d="M6 6l12 12M18 6L6 18"/>', 'width="11" height="11"') + '</button></span>';
        }).join('')
      : '<span class="a-empty">' + ta('noMuscles') + '</span>';

    return '<div class="a-scroll plain">' + head +
      '<div><div class="a-kick">' + ta('step1') + '</div>' +
      '<div class="a-dsp" style="font-size:26px;margin-top:3px">' + ta('chooseFocus') + '</div></div>' +
      '<div class="a-body" id="aBody">' + (BODY_SVG || '') + '</div>' +
      '<div style="text-align:center;font-size:12px;color:var(--at2)">' + ta('tapBody') + '</div>' +
      '<div class="a-chips">' + chips + '</div>' +
      '<button class="a-btn' + (A.picked.length ? '' : ' dim') + '" data-a="review">' + ta('continue') + '</button>' +
    '</div>';
  }

  function aSession() {
    var m = A.ex[A.exIdx] || 'chest';
    var rest = '';
    if (A.rest > 0 || A.restOver) {
      rest = '<div class="a-card a-rest' + (A.restOver ? ' done' : '') + '">' +
        '<div class="a-kick">' + ta('rest') + '</div>' +
        (A.restOver
          ? '<div class="n" id="aRestN">' + ta('backToIt') + '</div>'
          : '<div class="a-restrow"><button data-a="rest-15">–15</button>' +
            '<span class="n" id="aRestN">' + A.rest + 's</span>' +
            '<button data-a="rest15">+15</button></div>' +
            '<div style="font-size:11.5px;color:var(--at3)">' + ta('restDefault') + '</div>') +
        '<button class="a-skip" data-a="skip">' + ta('skip') + '</button></div>';
    }
    return '<div class="a-scroll plain">' +
      '<div style="display:flex;align-items:center;gap:10px">' +
        '<span class="a-pulse" style="background:#fff"></span>' +
        '<span class="a-dsp" style="font-size:12px;letter-spacing:.2em;flex:1">' + ta('inProgress') + '</span>' +
        '<span class="a-dsp" id="aEl2" style="font-size:19px">' + clock(A.elapsed) + '</span>' +
        '<button data-a="pause" aria-label="' + ta('pause') + '" style="width:38px;height:38px;border-radius:50%;background:var(--ar2);display:grid;place-items:center;flex:none">' +
          (A.paused
            ? '<svg viewBox="0 0 24 24" width="15" height="15" fill="#fff"><path d="M8 5v14l11-7z"/></svg>'
            : '<svg viewBox="0 0 24 24" width="14" height="14" fill="#fff"><rect x="6" y="5" width="4" height="14" rx="1"/><rect x="14" y="5" width="4" height="14" rx="1"/></svg>') +
          '</button>' +
      '</div>' +
      '<div><div style="font-size:11.5px;font-weight:600;letter-spacing:.1em;color:var(--at2)">' +
        ta('exercise') + ' ' + (A.exIdx + 1) + ' ' + ta('of') + ' ' + A.ex.length + '</div>' +
        '<div class="a-dsp" style="font-size:25px;margin-top:4px;letter-spacing:0">' + exName(m) + '</div>' +
        '<div style="margin-top:8px"><span class="a-chip" style="padding:6px 12px;font-size:12.5px">' + mus(m) + '</span></div>' +
        '<div style="margin-top:10px;font-size:12.5px;color:var(--at2)"><b style="color:var(--at3);font-weight:600;letter-spacing:.1em">' + ta('last') + '</b> ' + LAST[m] + '</div></div>' +
      '<div class="a-art"><img src="' + exGif(m) + '" width="300" height="300" alt="" /></div>' +
      rest +
      '<div class="a-card">' +
        '<div class="a-sets"><span class="h">#</span><span class="h">' + ta('reps') + '</span><span class="h">' + ta('kg') + '</span><span></span></div>' +
        A.sets.map(function (s, i) {
          return '<div class="a-row' + (s.ok ? ' ok' : '') + '">' +
            '<span class="i">' + (i + 1) + '</span>' +
            '<div class="a-num"><button data-a="r-:' + i + '">–</button><span>' + s.r + '</span><button data-a="r+:' + i + '">+</button></div>' +
            '<div class="a-num"><button data-a="w-:' + i + '">–</button><span>' + s.w + '</span><button data-a="w+:' + i + '">+</button></div>' +
            '<button class="a-tick' + (s.ok ? ' on' : '') + '" data-a="ok:' + i + '" aria-pressed="' + s.ok + '">' +
              '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#fff" stroke-width="3.4" stroke-linecap="round">' + ICON.check + '</svg>' +
            '</button></div>';
        }).join('') +
        '<button class="a-add" data-a="addset">+ ' + ta('addSet') + '</button>' +
      '</div>' +
      '<div style="display:flex;gap:9px;align-items:center">' +
        '<button data-a="prev" style="width:46px;height:46px;flex:none;background:var(--ar);border:1px solid var(--abd);border-radius:50%;display:grid;place-items:center">' +
          sv('<path d="M15 18l-6-6 6-6"/>', 'width="17" height="17"') + '</button>' +
        '<button class="a-btn" data-a="next">' + (A.exIdx < A.ex.length - 1 ? ta('nextEx') : ta('finishSession')) + '</button>' +
      '</div>' +
    '</div>';
  }

  function aDone() {
    var vol = 0; A.sets.forEach(function (s) { if (s.ok) vol += s.r * s.w; });
    var done = 0; A.sets.forEach(function (s) { if (s.ok) done++; });
    return '<div class="a-scroll plain a-done">' +
      '<svg width="62" height="62" viewBox="0 0 100 100">' +
        '<circle cx="50" cy="50" r="47" fill="none" stroke="var(--clay)" stroke-width="2"/>' +
        '<g fill="var(--clay)"><path d="M50 8 L56 26 L50 20 L44 26 Z"/><path d="M50 92 L44 74 L50 80 L56 74 Z"/>' +
        '<path d="M8 50 L26 44 L20 50 L26 56 Z"/><path d="M92 50 L74 56 L80 50 L74 44 Z"/></g>' +
        '<circle cx="50" cy="50" r="24" fill="var(--ar2)" stroke="var(--clay)" stroke-width="2"/>' +
        '<path d="M39 44 Q50 52 61 44" stroke="#fff" stroke-width="2.5" fill="none" stroke-linecap="round"/>' +
        '<circle cx="42" cy="46" r="2.5" fill="#fff"/><circle cx="58" cy="46" r="2.5" fill="#fff"/></svg>' +
      '<div><div class="a-kick">' + ta('complete') + '</div>' +
      '<div style="font-size:13.5px;color:var(--at2);margin-top:7px;max-width:270px">' + ta('completeSub') + '</div></div>' +
      '<div class="a-grid3">' +
        '<div class="a-card" style="padding:13px;border-radius:16px"><div class="a-lbl" style="font-size:10px">' + ta('duration') + '</div><div class="a-dsp" style="font-size:17px;margin-top:3px">' + clock(A.elapsed) + '</div></div>' +
        '<div class="a-card" style="padding:13px;border-radius:16px"><div class="a-lbl" style="font-size:10px">' + ta('sets') + '</div><div class="a-dsp" style="font-size:17px;margin-top:3px">' + done + '</div></div>' +
        '<div class="a-card" style="padding:13px;border-radius:16px"><div class="a-lbl" style="font-size:10px">' + ta('volume') + '</div><div class="a-dsp" style="font-size:17px;margin-top:3px">' + (vol / 1000).toFixed(1) + 't</div></div>' +
      '</div>' +
      '<button class="a-btn" style="margin-top:6px" data-a="save">' + ta('saveExit') + '</button>' +
    '</div>';
  }

  function aProgress() {
    var heat = '', seed = 20260726;
    for (var i = 0; i < 84; i++) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      var r = seed / 0x7fffffff;
      var c = r < .44 ? 'var(--heat)' : r < .62 ? 'rgba(217,161,132,.42)' : r < .84 ? 'rgba(217,161,132,.68)' : 'var(--clay)';
      heat += '<i style="background:' + c + '"></i>';
    }
    return '<div class="a-scroll">' +
      '<div class="a-title">' + ta('navprogress') + '</div>' +
      '<div class="a-card big">' +
        '<div class="a-kick">' + ta('vol30') + '</div>' +
        '<div style="display:flex;align-items:center;gap:11px;margin-top:4px">' +
          '<div class="a-dsp" style="font-size:44px;line-height:1">142<small style="font-size:18px;color:var(--at2)"> t</small></div>' +
          '<span style="display:inline-flex;align-items:center;gap:5px;background:var(--sage-soft);color:var(--sage);padding:5px 10px;border-radius:9px;font-size:11.5px;font-weight:600">' +
            sv('<path d="M4 16l6-6 4 4 6-8"/>', 'width="11" height="11"') + ta('vsMonth') + '</span>' +
        '</div>' +
        '<svg width="100%" height="88" viewBox="0 0 300 100" style="margin-top:16px;overflow:visible">' +
          '<line x1="0" y1="22" x2="300" y2="22" stroke="var(--abd)"/><line x1="0" y1="55" x2="300" y2="55" stroke="var(--abd)"/><line x1="0" y1="88" x2="300" y2="88" stroke="var(--abd)"/>' +
          '<path d="M0,86 L34,80 L64,76 L96,52 L128,44 L164,38 L196,30 L232,26 L264,20 L292,8 L292,92 L0,92 Z" fill="rgba(217,161,132,.13)"/>' +
          '<path d="M0,86 L34,80 L64,76 L96,52 L128,44 L164,38 L196,30 L232,26 L264,20 L292,8" fill="none" stroke="var(--clay)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>' +
          '<circle cx="292" cy="8" r="5.5" fill="var(--ar)" stroke="var(--clay)" stroke-width="3"/>' +
        '</svg>' +
      '</div>' +
      '<div class="a-card">' +
        '<div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px">' +
          '<div class="a-dsp" style="font-size:15px;letter-spacing:.06em">' + ta('consistency') + '</div>' +
          '<div style="font-size:12px;color:var(--at2)">' + ta('sessionsLogged') + '</div></div>' +
        '<div class="a-heat">' + heat + '</div>' +
        '<div style="display:flex;align-items:center;gap:7px;margin-top:14px">' +
          '<svg viewBox="0 0 24 24" width="14" height="14" fill="var(--clay)">' + ICON.flame + '</svg>' +
          '<span style="font-size:13px;font-weight:600">' + ta('streak') + '</span></div>' +
      '</div>' +
      '<div class="a-card">' +
        '<div style="display:flex;align-items:flex-start;justify-content:space-between">' +
          '<div><div class="a-dsp" style="font-size:15px;letter-spacing:.06em">' + ta('bodyweight') + '</div>' +
          '<div class="a-dsp" style="font-size:26px;margin-top:2px">79.8<small style="font-size:14px;color:var(--at2)"> kg</small></div></div>' +
          '<span style="background:var(--ar2);border-radius:999px;padding:8px 14px;font-family:var(--display);font-weight:600;font-size:12px;letter-spacing:.1em">+ LOG</span>' +
        '</div>' +
        '<svg width="100%" height="54" viewBox="0 0 300 60" style="margin-top:10px;overflow:visible">' +
          '<path d="M4,10 L60,16 L104,18 L150,28 L200,36 L250,42 L292,48" fill="none" stroke="var(--clay)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>' +
          '<circle cx="292" cy="48" r="4.5" fill="var(--ar)" stroke="var(--clay)" stroke-width="2.5"/>' +
        '</svg>' +
      '</div>' +
      '<div class="a-card">' +
        '<div class="a-dsp" style="font-size:15px;letter-spacing:.06em;margin-bottom:4px">' + ta('records') + '</div>' +
        [['chest', 95, 119], ['glutes', 110, 138], ['back', 80, 100]].map(function (p) {
          return '<div class="a-pr"><span style="font-size:13.5px;font-weight:500">' + exName(p[0]) + '</span>' +
            '<div style="text-align:right"><div class="a-dsp" style="font-size:17px;letter-spacing:0">' + p[1] + ' kg</div>' +
            '<div style="font-size:10.5px;color:var(--at2)">1RM ' + p[2] + ' kg</div></div></div>';
        }).join('') +
      '</div>' +
      aDemoNote() +
    '</div>';
  }

  function aExercises() {
    var rows = ['chest', 'back', 'shoulders', 'biceps', 'quads', 'glutes'];
    var lv = [ta('lvBeg'), ta('lvInt'), ta('lvAdv')];
    return '<div class="a-scroll">' +
      '<div><div class="a-title">' + ta('navexercises') + '</div>' +
      '<div style="font-size:12.5px;color:var(--at2);margin-top:3px">361 ' + ta('inLibrary') + '</div></div>' +
      '<div class="a-card" style="display:flex;align-items:center;gap:10px;padding:14px 16px;border-radius:14px;color:var(--at3)">' +
        sv('<circle cx="11" cy="11" r="7"/><path d="M20 20l-4.5-4.5"/>', 'width="15" height="15"') +
        '<span style="font-size:13px">' + ta('search') + '</span></div>' +
      '<div class="a-card" style="display:flex;align-items:center;justify-content:center;gap:8px;padding:13px;border-radius:14px">' +
        sv('<path d="M12 4l2.4 5 5.6.6-4 3.9 1 5.5-5-2.7-5 2.7 1-5.5-4-3.9 5.6-.6z"/>', 'width="14" height="14"') +
        '<span class="a-dsp" style="font-size:12.5px;letter-spacing:.14em">' + ta('favs') + ' · 4</span></div>' +
      '<div><div class="a-lbl" style="margin-bottom:8px">' + ta('muscle') + '</div>' +
      '<div class="a-chips">' + ['chest', 'back', 'shoulders', 'biceps'].map(function (m, i) {
        return '<span class="a-chip" style="font-size:12.5px;padding:7px 12px' + (i ? ';background:var(--ar);color:var(--at2)' : '') + '">' + mus(m) + '</span>';
      }).join('') + '</div></div>' +
      '<div><div class="a-lbl" style="margin-bottom:8px">' + ta('level') + '</div>' +
      '<div class="a-chips">' + lv.map(function (l) {
        return '<span class="a-chip" style="font-size:12.5px;padding:7px 12px;background:var(--ar);color:var(--at2)">' + l + '</span>';
      }).join('') + '</div></div>' +
      '<div class="a-card" style="display:flex;align-items:center;justify-content:center;gap:8px;padding:14px;border-radius:14px">' +
        sv('<path d="M12 5v14M5 12h14"/>', 'width="15" height="15"') +
        '<span class="a-dsp" style="font-size:12.5px;letter-spacing:.14em">' + ta('newEx') + '</span></div>' +
      rows.map(function (m, k) {
        return '<div class="a-card" style="display:flex;align-items:center;gap:12px;padding:11px;border-radius:16px">' +
          '<div class="a-thumb"><img src="' + exGif(m) + '" width="300" height="300" loading="lazy" alt="" /></div>' +
          '<div style="flex:1"><div style="font-size:13.5px;font-weight:600">' + exName(m) + '</div>' +
          '<div style="display:flex;gap:8px;align-items:center;margin-top:4px">' +
            '<span style="font-size:10.5px;font-weight:600;color:var(--clay);background:var(--clay-soft);padding:2px 7px;border-radius:6px">' + mus(m) + '</span>' +
            '<span style="font-size:11px;color:var(--at2)">' + exKit(m) + '</span></div>' +
          '<div style="font-size:10.5px;color:var(--at3);margin-top:3px">• ' + exLevel(m) + '</div></div>' +
          '<svg viewBox="0 0 24 24" width="15" height="15" fill="' + (k ? 'none' : 'var(--clay)') + '" stroke="' + (k ? 'var(--at3)' : 'var(--clay)') + '" stroke-width="1.8">' +
            '<path d="M12 4l2.4 5 5.6.6-4 3.9 1 5.5-5-2.7-5 2.7 1-5.5-4-3.9 5.6-.6z"/></svg></div>';
      }).join('') +
      aDemoNote() +
    '</div>';
  }

  function aSettings() {
    function seg(a, b, first) {
      return '<span class="a-seg2"><i class="' + (first ? 'on' : '') + '">' + a + '</i><i class="' + (first ? '' : 'on') + '">' + b + '</i></span>';
    }
    function row(icon, label, ctl, last) {
      return '<div class="a-srow' + (last ? ' last' : '') + '">' +
        sv(icon, 'width="19" height="19" style="color:var(--at2);flex:none"') +
        '<span style="flex:1;font-size:13.5px">' + label + '</span>' + ctl + '</div>';
    }
    var chev = '<span style="display:flex;align-items:center;gap:7px;font-size:12.5px;font-weight:600;color:var(--at2)">';
    return '<div class="a-scroll">' +
      '<div class="a-title">' + ta('navsettings') + '</div>' +
      '<div class="a-card" style="display:flex;align-items:center;gap:14px">' +
        '<div style="width:48px;height:48px;border-radius:50%;background:rgba(217,161,132,.18);color:var(--clay);display:grid;place-items:center;font-family:var(--display);font-weight:700;font-size:20px;flex:none">A</div>' +
        '<div style="flex:1"><div class="a-dsp" style="font-size:17px">ALEX</div>' +
        '<div style="font-size:12px;color:var(--at2)">' + ta('level4') + ' · ' + ta('streak') + '</div></div>' +
        sv('<path d="M4 20h4L20 8l-4-4L4 16z"/>', 'width="16" height="16" style="color:var(--at2)"') +
      '</div>' +
      '<div><div class="a-lbl" style="margin-bottom:9px">' + ta('prefs') + '</div>' +
      '<div class="a-card" style="padding:4px 16px">' +
        row('<path d="M20 14a8 8 0 11-8-10 6.5 6.5 0 008 10z"/>', ta('setTheme'), seg(ta('dark'), ta('light'), true)) +
        row('<path d="M4 5h10M9 3v2c0 5-2.5 8-5 9M7 12c1.5 3 4 5 7 6M14 21l4-10 4 10M15.5 18h5"/>', ta('setLang'), chev + (lang === 'es' ? 'Español' : 'English') + sv('<path d="M9 6l6 6-6 6"/>', 'width="13" height="13"') + '</span>') +
        row('<path d="M12 3v18M4 8h16M6 8l-2 5h4zM18 8l-2 5h4z"/>', ta('setUnits'), seg('kg', 'lb', true)) +
        row('<circle cx="12" cy="13" r="8"/><path d="M12 9v4M9 2h6"/>', ta('setRest'), '<span class="a-num"><button>–</button><span class="a-dsp" style="font-size:14px">90s</span><button>+</button></span>') +
        row('<path d="M18 16V11a6 6 0 10-12 0v5l-2 3h16zM10 22h4"/>', ta('setSound'), chev + ta('setSoundVal') + sv('<path d="M9 6l6 6-6 6"/>', 'width="13" height="13"') + '</span>', true) +
      '</div></div>' +
      '<div><div class="a-lbl" style="margin-bottom:9px">' + ta('data') + '</div>' +
      '<div class="a-card" style="padding:4px 16px">' +
        row('<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 10h18M9 10v10"/>', ta('setExport'), sv('<path d="M9 6l6 6-6 6"/>', 'width="13" height="13" style="color:var(--at3)"')) +
        row('<path d="M12 16V4M8 8l4-4 4 4M4 20h16"/>', ta('setBackup'), sv('<path d="M9 6l6 6-6 6"/>', 'width="13" height="13" style="color:var(--at3)"'), true) +
      '</div></div>' +
      '<div class="a-card" style="display:flex;align-items:center;gap:11px;border-color:rgba(217,161,132,.35);color:var(--clay)">' +
        sv('<path d="M4 7h16M9 7V4h6v3M6 7l1 13h10l1-13"/>', 'width="17" height="17"') +
        '<span style="font-size:13.5px;font-weight:600">' + ta('setWipe') + '</span></div>' +
      '<div style="font-size:11.5px;color:var(--at3);text-align:center">GymMane · GPL-3.0</div>' +
      aDemoNote() +
    '</div>';
  }

  var SCREENS = { home: aHome, train: aTrain, session: aSession, done: aDone, progress: aProgress, exercises: aExercises, settings: aSettings };

  function aRender(keepScroll) {
    var sc = app.querySelector('.a-scroll');
    var top = keepScroll && sc ? sc.scrollTop : 0;
    app.innerHTML = aStatus() + SCREENS[A.screen]();
    app.appendChild(aNavEl());
    aNavEl();
    var ns = app.querySelector('.a-scroll');
    if (ns && top) ns.scrollTop = top;
    var b = app.querySelector('#aBody');
    if (b) b.querySelectorAll('.muscle').forEach(function (g) {
      var id = g.getAttribute('data-muscle');
      g.setAttribute('data-a', 'm:' + id);
      g.setAttribute('aria-label', mus(id));
      g.setAttribute('aria-pressed', String(A.picked.indexOf(id) >= 0));
      g.classList.toggle('on', A.picked.indexOf(id) >= 0);
    });
  }

  function aFit() {
    var w = document.querySelector('.device .screen').clientWidth;
    app.style.transform = 'scale(' + (w / 390).toFixed(4) + ')';
  }

  function aTimer(on) {
    if (A.id) { clearInterval(A.id); A.id = null; }
    if (!on) return;
    A.id = setInterval(function () {
      if (!A.paused) A.elapsed++;
      var el = document.getElementById('aEl2');
      if (el) el.textContent = clock(A.elapsed);
      if (A.rest > 0 && !A.paused) {
        A.rest--;
        var n = document.getElementById('aRestN');
        if (A.rest === 0) { A.restOver = true; aRender(true); setTimeout(function () { if (A.restOver) { A.restOver = false; aRender(true); } }, 2800); }
        else if (n) n.textContent = A.rest + 's';
      }
    }, 1000);
  }

  function aGo(s) {
    A.screen = s;
    if (s === 'session' && !A.ex.length) buildSession();
    aTimer(s === 'session');
    if (s !== 'session' && s !== 'done') { A.rest = 0; A.restOver = false; }
    aRender();
  }

  var ACTS = {
    start: function () { A.step = 1; A.screen = 'train'; aTimer(false); aRender(); },
    review: function () { if (!A.picked.length) return; buildSession(); A.step = 2; aRender(); },
    begin: function () { A.elapsed = 0; A.paused = false; loadSets(); aGo('session'); },
    pause: function () { A.paused = !A.paused; aRender(true); },
    finish: function () { aTimer(false); A.screen = 'done'; aRender(); },
    save: function () { A.saved = true; A.week[A.today] = 1; A.ex = []; aGo('home'); },
    skip: function () { A.rest = 0; A.restOver = false; aRender(true); },
    rest15: function () { A.rest += 15; aRender(true); },
    prev: function () { if (A.exIdx > 0) { A.exIdx--; loadSets(); aRender(); } },
    next: function () { if (A.exIdx < A.ex.length - 1) { A.exIdx++; loadSets(); aRender(); } else ACTS.finish(); },
    addset: function () { var l = A.sets[A.sets.length - 1]; A.sets.push({ r: l.r, w: l.w, ok: false }); aRender(true); }
  };

  app.addEventListener('click', function (e) {
    var t = e.target.closest('[data-a]');
    if (!t) return;
    var a = t.dataset.a, p = a.split(':'), k = p[0], v = p[1];
    if (ACTS[k]) return ACTS[k]();
    if (k === 'go') return aGo(v);
    if (k === 'day') { A.week[+v] = A.week[+v] ? 0 : 1; return aRender(true); }
    if (k === 'view') { A.view = v; return aRender(true); }
    if (k === 'm') {
      var i = A.picked.indexOf(v);
      if (i >= 0) A.picked.splice(i, 1); else A.picked.push(v);
      return aRender(true);
    }
    var n = +v, st = A.sets[n];
    if (!st) return;
    if (k === 'r+') st.r++;
    else if (k === 'r-') st.r = Math.max(1, st.r - 1);
    else if (k === 'w+') st.w += 2.5;
    else if (k === 'w-') st.w = Math.max(0, st.w - 2.5);
    else if (k === 'ok') {
      st.ok = !st.ok;
      if (st.ok) { A.rest = A.restTotal; A.restOver = false; }
    }
    aRender(true);
  });

  app.addEventListener('keydown', function (e) {
    if (e.key !== 'Enter' && e.key !== ' ') return;
    var t = e.target.closest('g[data-a]');
    if (t) { e.preventDefault(); t.dispatchEvent(new MouseEvent('click', { bubbles: true })); }
  });

  addEventListener('resize', aFit);
  if (window.ResizeObserver) new ResizeObserver(aFit).observe(document.querySelector('.device .screen'));
  aFit();

  var bodyTpl = document.getElementById('bodyTpl');
  var BODY_SVG = bodyTpl ? bodyTpl.innerHTML : '';

  var slowMo = matchMedia('(prefers-reduced-motion: reduce)').matches;
  var io = new IntersectionObserver(function (es) {
    es.forEach(function (e) {
      if (!e.isIntersecting) return;
      e.target.classList.add('in');

      io.unobserve(e.target);
    });
  }, { threshold: 0.14 });
  document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });

  document.querySelectorAll('.card').forEach(function (c) {
    c.addEventListener('pointermove', function (e) {
      var r = c.getBoundingClientRect();
      c.style.setProperty('--mx', (e.clientX - r.left) + 'px');
      c.style.setProperty('--my', (e.clientY - r.top) + 'px');
    });
  });

  var bar = document.getElementById('bar');
  var head = document.querySelector('header');
  var spy = [].slice.call(document.querySelectorAll('.lnks a.lnk')).map(function (a) {
    return { a: a, sec: document.querySelector(a.getAttribute('href')) };
  }).filter(function (s) { return s.sec; });

  addEventListener('scroll', function () {
    var h = document.documentElement;
    var p = h.scrollTop / (h.scrollHeight - h.clientHeight || 1);
    bar.style.width = (p * 100).toFixed(2) + '%';
    head.classList.toggle('small', h.scrollTop > 40);

    var mark = h.scrollTop + 140, on = null;
    spy.forEach(function (s) { if (s.sec.offsetTop <= mark) on = s.a; });
    spy.forEach(function (s) { s.a.classList.toggle('on', s.a === on); });
  }, { passive: true });

  document.getElementById('y').textContent = new Date().getFullYear();
  applyLang();
})();
