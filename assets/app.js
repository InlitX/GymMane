(function () {
  'use strict';

  var DICT = {
    es: {
      metaDesc: 'GymMane es un diario de gimnasio gratis y sin conexión para Android. Apunta tus series y mira tu progreso sin cuenta, sin anuncios y sin permiso de internet. Código abierto (GPL-3.0).',
      title: 'GymMane: diario de gimnasio gratis y sin conexión',
      navFeatures: 'Qué hace', navShots: 'Capturas', navPrivacy: 'Privacidad', navDownload: 'Descargar', navTranslate: 'Traducir',
      skip: 'Saltar al contenido',
      heroL1: 'Levanta.', heroL2: 'Anota.', heroL3: 'Mejora.',
      heroLead: 'Un diario de gimnasio gratis y sin conexión. Toca los músculos que quieres entrenar, apunta tus series y mira cómo suben tus números.',
      ctaDownload: 'Descargar', ctaGithub: 'Ver en GitHub',
      heroMeta: 'Android 7.0 o superior · Sin cuenta · Sin anuncios',
      liveNote: 'Demo interactiva, puedes tocarla',
      featTitle: 'Qué hace',
      f1t: 'Entrenar', f1d: 'Toca los músculos en el cuerpo, de frente y de espalda, y te sale la sesión. Apunta reps, peso y, si quieres, RPE o RIR.',
      f2t: 'Descanso', f2d: 'Temporizador con tu propio sonido de alarma y la cuenta atrás en la notificación, también con la pantalla apagada.',
      f3t: 'Rutinas', f3d: 'Crea las tuyas, agrúpalas y prográmalas, o empieza con un plan ya hecho. Con superseries y discos por lado.',
      f4t: 'Progreso', f4d: 'Récords, 1RM estimado, racha, mapa de actividad, medidas corporales y fotos de progreso.',
      f5t: 'Ejercicios', f5d: 'Más de 500 con animación e instrucciones. Si falta alguno, créalo con tu foto, GIF o vídeo.',
      f6t: 'Widgets', f6d: 'Cinco widgets para la pantalla de inicio: hoy, esta semana, actividad, estadísticas y mapa muscular.',
      f7t: 'Calculadoras', f7d: '1RM, discos, IMC, calorías y macros, grasa corporal y calentamiento.',
      f8t: 'Importar y exportar', f8d: 'Trae tu historial de Hevy, Strong, Lyfta, FitNotes, openGym o cualquier CSV. Exporta a CSV o a una copia completa.',
      shotsTitle: 'Capturas',
      shotsLead: 'Sacadas de la app en un móvil. Toca una para verla en grande.',
      sHome: 'Inicio', sProgress: 'Progreso', sTrain: 'Entrenar', sSession: 'Sesión',
      sLibrary: 'Ejercicios', sRoutines: 'Rutinas', sProfile: 'Perfil', sSettings: 'Ajustes',
      restReady: 'Listo',
      privTitle: 'Tus datos no salen del móvil',
      privP1: 'GymMane no tiene permiso de internet, así que no puede enviar nada a ningún sitio. No hay cuenta, ni anuncios, ni analítica.',
      privP2: 'Los permisos que pide son para el temporizador de descanso, su notificación y los widgets. Tus fotos, vídeos y notas se quedan en el almacenamiento de la app.',
      whyTitle: 'Por qué existe',
      whyP1: 'Quería una app de gimnasio que no me pidiera una cuenta ni una suscripción para ver mis propias series. No la encontré, así que la hice.',
      whyP2: 'Es código abierto con licencia GPL-3.0. Si le falta algo, abre una incidencia o manda un cambio en GitHub.',
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
      app: {
        navhome: 'INICIO', navprogress: 'PROGRESO', navexercises: 'EJERCICIOS', navprofile: 'PERFIL', today: 'Hoy',
        routine: 'RUTINA DE HOY', exs: 'ejercicios', startWorkout: 'Empezar', thisWeek: 'Esta semana',
        volume: 'Volumen', setsToday: 'Series hoy', train: 'Entrenar', step1: 'PASO 1 DE 2', step2: 'PASO 2 DE 2',
        chooseFocus: 'ELIGE TU FOCO', yourSession: 'TU SESIÓN', noMuscles: 'Nada elegido — toca el cuerpo.',
        continue: 'Continuar', sets: 'series', inProgress: 'EN CURSO', pause: 'Pausar', exercise: 'EJERCICIO',
        of: 'DE', backToIt: '¡A la barra!', reps: 'REPS', kg: 'PESO (KG)', addSet: 'Añadir serie', nextEx: 'Siguiente',
        complete: 'Sesión completa', completeSub: 'Leo está orgulloso. Mantén la racha viva.', duration: 'Duración',
        saveExit: 'Guardar y salir', vol30: 'Volumen · 30D', consistency: 'Constancia', streak: 'racha de 4 días',
        inLibrary: 'ejercicios en tu biblioteca', activity: 'Actividad', prs: 'Récords', progressT: 'Progreso',
        exercisesT: 'Ejercicios', settingsT: 'Ajustes', weight: 'Peso', weightDate: '19 sept',
        weekOf: '4 de 4 esta semana', sessions: 'Sesiones', setsT: 'Series', time: 'Tiempo',
        muscleMap: 'Mapa muscular', recovery: 'Recuperación', filters: 'Filtros', noKit: 'Sin material',
        legs: 'Piernas', arms: 'Brazos', kitBarbell: 'Barra', kitDumbbell: 'Mancuerna', kitCable: 'Polea',
        kitBodyweight: 'Peso corporal', editProfile: 'Editar perfil', level7: 'Nivel 7',
        toLevel8: '6 entrenos para el nivel 8', workouts: 'Entrenos', trained: 'Entrenado', days: 'días',
        lifted: 'Levantado', medals: 'Medallas', mStep: 'Primer paso', mWorkout: 'Primer entreno',
        mRoutine: 'Primera rutina', mRecord: 'Primer récord', photos: 'Fotos', yourPhotos: 'Tus fotos',
        takeOne: 'Hacer una', setRemind: 'Aviso para entrenar', never: 'Nunca', setFocus: 'El foco de hoy',
        setEffort: 'Anotar el esfuerzo', off: 'Apagado', setAutoNext: 'Pasar al siguiente solo',
        setAwake: 'Pantalla encendida al entrenar', resting: 'DESCANSANDO', elapsed: 'transcurrido',
        tapSkip: 'toca para saltar', nextUp: 'SIGUIENTE', prevEx: 'Ejercicio anterior',
        nextHint: 'mismo peso hasta cumplir todas las reps', search: 'Buscar ejercicios',
        tapBody: 'Toca los músculos que quieras entrenar — frente y espalda.', last: 'ÚLTIMA',
        finishSession: 'Terminar', favs: 'Favoritos', newEx: 'Nuevo ejercicio', lvBeg: 'Principiante',
        lvInt: 'Intermedio', lvAdv: 'Avanzado', prefs: 'Preferencias', data: 'Datos', setTheme: 'Tema', dark: 'Oscuro',
        setBackup: 'Copia de seguridad (JSON)', demoTitle: 'Demo limitada. ',
        demoBody: 'En la app hay más de 500 ejercicios con animación, rutinas, historial, calculadoras, widgets y alarma de descanso. Esto es solo un aperitivo para que la toques.',
        setLang: 'Idioma', setUnits: 'Unidades', setRest: 'Descanso por defecto', setSound: 'Sonido de alarma',
        setSoundVal: 'Por defecto', setExport: 'Exportar entrenos (CSV)'
      },
      muscles: {
        chest: 'Pecho', back: 'Espalda', shoulders: 'Hombros', biceps: 'Bíceps', triceps: 'Tríceps',
        forearm: 'Antebrazo', trapezius: 'Trapecio', abdomen: 'Abdomen', obliques: 'Oblicuos',
        quads: 'Cuádriceps', hamstrings: 'Isquios', glutes: 'Glúteos', calves: 'Gemelos'
      }
    },
    en: {
      metaDesc: 'GymMane is a free, offline gym log for Android. Log your sets and track your progress with no account, no ads and no internet permission. Open source (GPL-3.0).',
      title: 'GymMane: a free, offline gym log',
      navFeatures: 'What it does', navShots: 'Screens', navPrivacy: 'Privacy', navDownload: 'Download', navTranslate: 'Translate',
      skip: 'Skip to content',
      heroL1: 'Lift.', heroL2: 'Log it.', heroL3: 'Grow.',
      heroLead: 'A free, offline gym log. Tap the muscles you want to train, log your sets and watch your numbers go up.',
      ctaDownload: 'Download', ctaGithub: 'View on GitHub',
      heroMeta: 'Android 7.0 or later · No account · No ads',
      liveNote: 'Interactive demo, try tapping it',
      featTitle: 'What it does',
      f1t: 'Train', f1d: 'Tap muscles on the body, front and back, and get a session for them. Log reps, weight and, if you like, RPE or RIR.',
      f2t: 'Rest', f2d: 'A rest timer with your own alarm sound and the countdown in the notification, even with the screen off.',
      f3t: 'Routines', f3d: 'Build your own, group and schedule them, or start from a ready-made plan. Supersets and plates per side included.',
      f4t: 'Progress', f4d: 'Records, estimated 1RM, streaks, an activity heatmap, body measurements and progress photos.',
      f5t: 'Exercises', f5d: 'Over 500 with animations and instructions. If one is missing, add it with your own photo, GIF or video.',
      f6t: 'Widgets', f6d: 'Five home-screen widgets: today, this week, activity, stats and muscle map.',
      f7t: 'Calculators', f7d: '1RM, plates, BMI, calories and macros, body fat and warm-up.',
      f8t: 'Import and export', f8d: 'Bring your history from Hevy, Strong, Lyfta, FitNotes, openGym or any CSV. Export to CSV or a full backup.',
      shotsTitle: 'Screens',
      shotsLead: 'Taken from the app on a phone. Tap one to see it bigger.',
      sHome: 'Home', sProgress: 'Progress', sTrain: 'Train', sSession: 'Session',
      sLibrary: 'Exercises', sRoutines: 'Routines', sProfile: 'Profile', sSettings: 'Settings',
      restReady: 'Ready',
      privTitle: 'Your data stays on your phone',
      privP1: 'GymMane doesn\'t have the internet permission, so it can\'t send anything anywhere. No account, no ads, no analytics.',
      privP2: 'The permissions it asks for are for the rest timer, its notification and the widgets. Your photos, videos and notes stay in the app\'s own storage.',
      whyTitle: 'Why it exists',
      whyP1: 'I wanted a gym app that didn\'t ask for an account or a subscription to look at my own sets. I couldn\'t find one, so I made it.',
      whyP2: 'It\'s open source under GPL-3.0. If something is missing, open an issue or send a pull request on GitHub.',
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
      app: {
        navhome: 'HOME', navprogress: 'PROGRESS', navexercises: 'EXERCISES', navprofile: 'PROFILE', today: 'Today',
        routine: "TODAY'S ROUTINE", exs: 'exercises', startWorkout: 'Start', thisWeek: 'This week', volume: 'Volume',
        setsToday: 'Sets today', train: 'Train', step1: 'STEP 1 OF 2', step2: 'STEP 2 OF 2',
        chooseFocus: 'CHOOSE YOUR FOCUS', yourSession: 'YOUR SESSION', noMuscles: 'Nothing picked — tap the body.',
        continue: 'Continue', sets: 'sets', inProgress: 'IN PROGRESS', pause: 'Pause', exercise: 'EXERCISE', of: 'OF',
        backToIt: 'Back to it!', reps: 'REPS', kg: 'WEIGHT (KG)', addSet: 'Add set', nextEx: 'Next',
        complete: 'Session complete', completeSub: "Leo's proud of that one. Keep the streak alive.",
        duration: 'Duration', saveExit: 'Save and exit', vol30: 'Volume · 30D', consistency: 'Consistency',
        streak: '4-day streak', inLibrary: 'exercises in your library', activity: 'Activity', prs: 'Records',
        progressT: 'Progress', exercisesT: 'Exercises', settingsT: 'Settings', weight: 'Weight', weightDate: '19 Sept',
        weekOf: '4 of 4 this week', sessions: 'Sessions', setsT: 'Sets', time: 'Time', muscleMap: 'Muscle map',
        recovery: 'Recovery', filters: 'Filters', noKit: 'No equipment', legs: 'Legs', arms: 'Arms',
        kitBarbell: 'Barbell', kitDumbbell: 'Dumbbell', kitCable: 'Cable', kitBodyweight: 'Bodyweight',
        editProfile: 'Edit profile', level7: 'Level 7', toLevel8: '6 workouts to level 8', workouts: 'Workouts',
        trained: 'Trained', days: 'days', lifted: 'Lifted', medals: 'Medals', mStep: 'First step',
        mWorkout: 'First workout', mRoutine: 'First routine', mRecord: 'First record', photos: 'Photos',
        yourPhotos: 'Your photos', takeOne: 'Take one', setRemind: 'Workout reminder', never: 'Never',
        setFocus: "Today's focus", setEffort: 'Log effort', off: 'Off', setAutoNext: 'Auto-advance',
        setAwake: 'Keep screen on while training', resting: 'RESTING', elapsed: 'elapsed', tapSkip: 'tap to skip',
        nextUp: 'NEXT', prevEx: 'Previous exercise', nextHint: 'same weight until you hit every rep',
        search: 'Search exercises', tapBody: 'Tap the muscles you want to train — front and back.', last: 'LAST',
        finishSession: 'Finish', favs: 'Favourites', newEx: 'New exercise', lvBeg: 'Beginner', lvInt: 'Intermediate',
        lvAdv: 'Advanced', prefs: 'Preferences', data: 'Data', setTheme: 'Theme', dark: 'Dark',
        setBackup: 'Backup (JSON)', demoTitle: 'Limited demo. ',
        demoBody: 'The app packs more than 500 animated exercises, routines, history, calculators, widgets and a real rest alarm. This is just a taste so you can poke at it.',
        setLang: 'Language', setUnits: 'Units', setRest: 'Default rest', setSound: 'Alarm sound',
        setSoundVal: 'Default', setExport: 'Export workouts (CSV)'
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
    fmtDlNow();
    aRender(true);
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
    { f: 'progress', k: 'sProgress' }, { f: 'library', k: 'sLibrary' }, { f: 'routines', k: 'sRoutines' },
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
    ruserCircle: 'M512 864Q426 864 350 831Q274 799 217.5 742.5Q161 686 129 610Q96 534 96 448Q96 362 129 286Q161 210 217.5 153.5Q274 97 350 65Q426 32 512 32Q598 32 674 65Q750 97 806.5 153.5Q863 210 895 286Q928 362 928 448Q928 534 895 610Q862 686 806.0 742.0Q750 798 674 831Q598 864 512 864ZM296 170Q331 224 387.5 256.0Q444 288 512 288Q580 288 636.5 256.0Q693 224 727 171L728 170Q684 135 628.5 115.5Q573 96 512 96Q451 96 395.5 116.0Q340 136 296 171V170ZM384 480Q384 533 421.5 570.5Q459 608 512 608Q565 608 602.5 570.5Q640 533 640 480Q640 427 602.5 389.5Q565 352 512 352Q459 352 421.5 389.5Q384 427 384 480ZM775 214Q748 253 712.0 282.0Q676 311 633 329H631Q664 356 684.0 395.0Q704 434 704 480Q704 560 648.0 616.0Q592 672 512 672Q432 672 376.0 616.0Q320 560 320 480Q320 434 340.0 395.0Q360 356 393 330V329Q349 311 312.5 282.0Q276 253 250 215L249 214Q208 261 184.0 321.0Q160 381 160 448Q160 521 188 585Q215 649 263.0 697.0Q311 745 375 773Q439 800 512 800Q585 800 649 773Q713 745 761.0 697.0Q809 649 836 585Q864 521 864 448Q864 381 840.0 321.0Q816 261 775 214Z',
    fuserCircle: 'M688 480Q688 407 636.5 355.5Q585 304 512 304Q439 304 387.5 355.5Q336 407 336 480Q336 553 387.5 604.5Q439 656 512 656Q585 656 636.5 604.5Q688 553 688 480ZM928 448Q928 362 895 286Q863 210 806.5 153.5Q750 97 674 65Q598 32 512 32Q426 32 350 65Q274 97 217.5 153.5Q161 210 129 286Q96 362 96 448Q96 534 129 610Q161 686 217.5 742.5Q274 799 350 831Q426 864 512 864Q598 864 674 831Q750 798 806.0 742.0Q862 686 895 610Q928 534 928 448ZM864 448Q864 521 836 585Q808 649 760.5 697.0Q713 745 649 772Q585 800 512 800Q508 800 504.5 800.0Q501 800 497 800H498Q427 797 366 768Q304 739 258.0 691.5Q212 644 186 581Q160 518 160 447Q160 380 184.0 320.0Q208 260 249 214Q267 240 288.5 261.0Q310 282 335 299L336 300Q338 301 340.0 301.5Q342 302 345 302Q348 302 350.5 301.0Q353 300 355 298Q387 271 427.0 255.5Q467 240 512 240Q557 240 597.0 255.5Q637 271 669 299L668 298Q671 300 673.5 301.0Q676 302 679 302Q681 302 683.5 301.5Q686 301 688 300Q714 282 735.5 261.0Q757 240 774 215L775 214Q816 261 840.0 320.5Q864 380 864 448Q864 448 864.0 448.0Q864 448 864 448Z',
    rplay: 'M930 502 353 855Q346 859 337.5 861.5Q329 864 320 864Q311 864 303.0 862.0Q295 860 288 856Q274 848 265.0 833.0Q256 818 256 801V95Q256 69 274.5 50.5Q293 32 320 32Q320 32 320.0 32.0Q320 32 320 32Q329 32 337.5 34.5Q346 37 354 42L353 41L930 394Q943 402 951.5 416.5Q960 431 960 448Q960 465 951.5 479.0Q943 493 930 502ZM320 96V800L895 448Z',
    fplay: 'M960 448Q960 448 960.0 448.0Q960 448 960 448Q960 431 951.5 416.5Q943 402 930 394L353 41Q346 37 337.5 34.5Q329 32 320 32Q311 32 303.0 34.0Q295 36 288 40Q274 48 265.0 63.0Q256 78 256 95V801Q256 818 265.0 832.5Q274 847 288 856Q295 860 303.0 862.0Q311 864 320 864Q329 864 337.5 861.5Q346 859 354 854L353 855L930 502Q943 494 951.5 479.5Q960 465 960 448Q960 448 960.0 448.0Q960 448 960 448Z'
  };

  var ICON = {
    check: '<path d="M4 12l5 5L20 6"/>',
    flame: '<path d="M12 2c1 4-3 5-3 9a3 3 0 0 0 6 0c0-1.5-.5-2-1-3 2 1 3 3 3 5a5 5 0 0 1-10 0c0-5 4-6 5-11z"/>',
    play: '<path d="M8 5v14l11-7z"/>'
  };
  var NAV = [
    ['home', 'house'], ['progress', 'chartLineUp'], ['exercises', 'barbell'], ['profile', 'userCircle']
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
      var on = A.screen === n[0] || (n[0] === 'profile' && A.screen === 'settings');
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

  function heatCells(n, seed) {
    var out = '';
    for (var i = 0; i < n; i++) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      var r = seed / 0x7fffffff;
      var c = r < .42 ? 'var(--heat)' : r < .6 ? 'rgba(224,177,90,.38)' : r < .8 ? 'rgba(224,177,90,.7)' : 'var(--amb)';
      out += '<i style="background:' + c + '"></i>';
    }
    return out;
  }
  function chev(c) { return sv('<path d="M9 6l6 6-6 6"/>', 'width="14" height="14" style="color:' + (c || 'var(--at3)') + ';flex:none"'); }
  function round(icon, act, label) {
    return '<button class="a-round"' + (act ? ' data-a="' + act + '"' : '') + ' aria-label="' + (label || '') + '">' + icon + '</button>';
  }
  var IC = {
    share: sv('<circle cx="18" cy="5" r="2.5"/><circle cx="6" cy="12" r="2.5"/><circle cx="18" cy="19" r="2.5"/><path d="M8.2 10.9l7.6-4.3M8.2 13.1l7.6 4.3"/>', 'width="16" height="16"'),
    plus: sv('<path d="M12 5v14M5 12h14"/>', 'width="17" height="17"'),
    back: sv('<path d="M15 18l-6-6 6-6"/>', 'width="16" height="16"'),
    gear: phos('gearSix', false, 19),
    star: '<path d="M12 4l2.4 5 5.6.6-4 3.9 1 5.5-5-2.7-5 2.7 1-5.5-4-3.9 5.6-.6z"/>'
  };

  function aHome() {
    var d = new Date();
    var day = d.toLocaleDateString(lang === 'es' ? 'es-ES' : 'en-GB', { weekday: 'long', day: 'numeric', month: 'short' });
    day = day.charAt(0).toUpperCase() + day.slice(1).replace('.', '');
    var days = lang === 'es' ? ['L', 'M', 'X', 'J', 'V', 'S', 'D'] : ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    var doneW = A.week.filter(Boolean).length;
    return '<div class="a-scroll">' +
      '<div style="display:flex;align-items:center;justify-content:space-between">' +
        '<div><div class="a-lbl">' + ta('today') + '</div>' +
        '<div class="a-dsp" style="font-size:21px;margin-top:1px">' + day + '</div></div>' +
        '<span class="a-pill"><svg viewBox="0 0 24 24" width="14" height="14" fill="currentColor">' + ICON.flame + '</svg>' +
        '<b style="font-size:13px">' + (A.saved ? 5 : 4) + '</b></span>' +
      '</div>' +

      '<div class="a-card big a-focus">' +
        '<img src="assets/runner.webp" alt="" class="a-runner" />' +
        '<div style="position:relative">' +
          '<div class="a-kick">' + ta('routine') + '</div>' +
          '<div class="a-dsp" style="font-size:30px;line-height:1.05;margin-top:4px">Push</div>' +
          '<div style="font-size:12.5px;color:var(--at2);margin-top:3px">4 ' + ta('exs') + '</div>' +
          '<button class="a-btn" style="margin-top:18px" data-a="start">' +
            '<svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor">' + ICON.play + '</svg>' + ta('startWorkout') + '</button>' +
        '</div>' +
      '</div>' +

      '<div class="a-card"><div class="a-week">' + days.map(function (l, i) {
        var on = !!A.week[i];
        return '<button class="d" data-a="day:' + i + '" aria-pressed="' + on + '" aria-label="' + l + '">' +
          '<i>' + l + '</i><span class="o' + (on ? ' on' : '') + (i === A.today ? ' today' : '') + '">' +
          (on ? '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#0A0A0A" stroke-width="3.4" stroke-linecap="round">' + ICON.check + '</svg>' : '') +
          '</span></button>';
      }).join('') + '</div></div>' +

      '<div><div class="a-h">' + ta('thisWeek') + '</div>' +
        '<div class="a-card a-wk">' +
          '<div><div class="a-lbl">' + ta('volume') + '</div><div class="v">' + (A.saved ? '31.2' : '28.8') + '<small> t</small></div></div>' +
          '<div><div class="a-lbl">' + ta('setsToday') + '</div><div class="v">' + (A.saved ? 12 : 10) + '</div></div>' +
          '<div><div class="a-lbl">' + ta('prs') + '</div><div class="v">3</div></div>' +
          '<div class="ring"><svg width="44" height="44" viewBox="0 0 40 40">' +
            '<circle cx="20" cy="20" r="16" fill="none" stroke="var(--ar2)" stroke-width="3.5"/>' +
            '<circle cx="20" cy="20" r="16" fill="none" stroke="var(--clay)" stroke-width="3.5" stroke-linecap="round" stroke-dasharray="100.5" stroke-dashoffset="' + (100.5 * (1 - Math.min(1, doneW / 4))).toFixed(1) + '" transform="rotate(-90 20 20)"/>' +
          '</svg><span>' + Math.min(doneW, 4) + '/4</span></div>' +
        '</div>' +
      '</div>' +

      '<div><div class="a-h" style="display:flex;justify-content:space-between;align-items:center">' + ta('activity') + chev() + '</div>' +
        '<div class="a-card"><div class="a-heat">' + heatCells(84, 20261001) + '</div></div>' +
      '</div>' +
      aDemoNote() +
    '</div>';
  }

  function aTrain() {
    var head = '<div style="display:flex;align-items:center;justify-content:space-between">' +
      '<button data-a="go:home" style="width:36px;height:36px;border-radius:50%;background:var(--ar);border:1px solid var(--abd);display:grid;place-items:center">' +
        sv('<path d="M6 6l12 12M18 6L6 18"/>', 'width="15" height="15"') + '</button>' +
      '<div class="a-dsp" style="font-size:17px">' + ta('train') + '</div><div style="width:36px"></div></div>';

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
      var doneSets = A.sets.filter(function (x) { return x.ok; }).length;
      var ticks = '', left = A.restOver ? 0 : A.rest / A.restTotal;
      for (var k = 0; k < 40; k++) ticks += '<i' + (k / 40 < 1 - left ? ' class="on"' : '') + '></i>';
      rest = '<div class="a-card a-rest' + (A.restOver ? ' done' : '') + '">' +
          '<div class="a-restbar"><button data-a="rest-15">–15</button><span>' + ta('resting') + '</span><button data-a="rest15">+15</button></div>' +
          '<div class="a-ticks">' + ticks + '</div>' +
          '<div class="a-restfoot">' +
            '<div><b id="aEl3">' + clock(A.elapsed) + '</b><span>' + ta('elapsed') + '</span></div>' +
            '<button data-a="skip" class="mid"><b class="n" id="aRestN">' + (A.restOver ? ta('backToIt') : restLabel()) + '</b><span>' + ta('tapSkip') + '</span></button>' +
            '<div style="text-align:right"><b>' + doneSets + '/' + A.sets.length + '</b><span>' + ta('sets') + '</span></div>' +
          '</div>' +
        '</div>';
    }
    return '<div class="a-scroll plain' + (rest ? ' dock-rest' : ' dock') + '">' +
      '<div style="display:flex;align-items:center;gap:10px">' +
        '<span class="a-pulse" style="background:#fff"></span>' +
        '<span style="font-size:12px;font-weight:700;letter-spacing:.08em;flex:1">' + ta('inProgress') + '</span>' +
        '<span class="a-dsp" id="aEl2" style="font-size:19px">' + clock(A.elapsed) + '</span>' +
        '<button data-a="pause" aria-label="' + ta('pause') + '" style="width:38px;height:38px;border-radius:50%;background:var(--ar2);display:grid;place-items:center;flex:none">' +
          (A.paused
            ? '<svg viewBox="0 0 24 24" width="15" height="15" fill="#fff"><path d="M8 5v14l11-7z"/></svg>'
            : '<svg viewBox="0 0 24 24" width="14" height="14" fill="#fff"><rect x="6" y="5" width="4" height="14" rx="1"/><rect x="14" y="5" width="4" height="14" rx="1"/></svg>') +
          '</button>' +
      '</div>' +
      '<div><div style="font-size:11.5px;font-weight:600;letter-spacing:.1em;color:var(--at2)">' +
        ta('exercise') + ' ' + (A.exIdx + 1) + ' ' + ta('of') + ' ' + A.ex.length + '</div>' +
        '<div class="a-dsp" style="font-size:25px;margin-top:4px">' + exName(m) + '</div>' +
        '<div style="margin-top:8px"><span class="a-chip" style="padding:6px 12px;font-size:12.5px">' + mus(m) + '</span></div>' +
        '<div style="margin-top:10px;font-size:12px;color:var(--at2)"><b style="color:var(--at3);font-weight:700;letter-spacing:.08em">' + ta('last') + '</b> ' + LAST[m] + '</div>' +
        '<div style="margin-top:3px;font-size:12px;color:var(--at2)"><b style="color:var(--clay);font-weight:700;letter-spacing:.08em">' + ta('nextUp') + '</b> ' + ta('nextHint') + '</div></div>' +
      '<div class="a-art"><img src="' + exGif(m) + '" width="300" height="300" alt="" /></div>' +
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
    '</div>' +
    '<div class="a-dock">' + rest +
      '<div class="a-actions">' +
        '<button class="a-round" data-a="prev" aria-label="' + ta('prevEx') + '">' + sv('<path d="M15 18l-6-6 6-6"/>', 'width="17" height="17"') + '</button>' +
        (A.exIdx < A.ex.length - 1 ? '<button class="a-btn" data-a="next">' + ta('nextEx') + '</button>' : '') +
        '<button class="a-btn' + (A.exIdx < A.ex.length - 1 ? ' dark' : '') + '" data-a="finish">' + ta('finishSession') + '</button>' +
      '</div>' +
    '</div>';
  }

  function aDone() {
    var vol = A.doneVol || 0, done = A.doneSets || 0;
    A.sets.forEach(function (s) { if (s.ok) { vol += s.r * s.w; done++; } });
    return '<div class="a-scroll plain a-done">' +
      '<svg width="62" height="62" viewBox="0 0 100 100">' +
        '<circle cx="50" cy="50" r="47" fill="none" stroke="var(--clay)" stroke-width="2"/>' +
        '<g fill="var(--clay)"><path d="M50 8 L56 26 L50 20 L44 26 Z"/><path d="M50 92 L44 74 L50 80 L56 74 Z"/>' +
        '<path d="M8 50 L26 44 L20 50 L26 56 Z"/><path d="M92 50 L74 56 L80 50 L74 44 Z"/></g>' +
        '<circle cx="50" cy="50" r="24" fill="var(--ar2)" stroke="var(--clay)" stroke-width="2"/>' +
        '<path d="M39 44 Q50 52 61 44" stroke="#fff" stroke-width="2.5" fill="none" stroke-linecap="round"/>' +
        '<circle cx="42" cy="46" r="2.5" fill="#fff"/><circle cx="58" cy="46" r="2.5" fill="#fff"/></svg>' +
      '<div><div class="a-title">' + ta('complete') + '</div>' +
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
    function spark(pts, x, y) {
      return '<svg width="100%" height="40" viewBox="0 0 140 40" style="margin-top:10px;overflow:visible">' +
        '<path d="' + pts + '" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>' +
        '<circle cx="' + x + '" cy="' + y + '" r="3.5" fill="var(--ar)" stroke="#fff" stroke-width="2"/></svg>';
    }
    var view = A.view || '7';
    return '<div class="a-scroll">' +
      '<div style="display:flex;align-items:center;justify-content:space-between"><div class="a-title">' + ta('progressT') + '</div>' + round(IC.share, '', 'share') + '</div>' +
      '<div class="a-grid2">' +
        '<div class="a-card" style="padding:15px"><div class="a-lbl" style="display:flex;justify-content:space-between">' + ta('vol30') + '<span style="color:var(--sage)">↗ 16%</span></div>' +
          '<div class="a-dsp" style="font-size:26px;margin-top:4px">98.4<small style="font-size:13px;color:var(--at2)"> t</small></div>' + spark('M4,32 L40,26 L76,22 L104,18 L132,10', 132, 10) + '</div>' +
        '<div class="a-card" style="padding:15px"><div class="a-lbl">' + ta('weight') + '</div>' +
          '<div class="a-dsp" style="font-size:26px;margin-top:4px">81.4<small style="font-size:13px;color:var(--at2)"> kg</small></div>' +
          '<div style="font-size:11px;color:var(--at3)">' + ta('weightDate') + '</div>' + spark('M4,30 L44,26 L84,22 L132,14', 132, 14) + '</div>' +
      '</div>' +
      '<div class="a-card">' +
        '<div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px">' +
          '<div class="a-lbl">' + ta('consistency') + '</div>' +
          '<span style="display:flex;gap:4px"><i class="a-dot"></i><i class="a-dot"></i><i class="a-dot" style="opacity:.4"></i></span></div>' +
        '<div class="a-heat">' + heatCells(84, 20260726) + '</div>' +
        '<div style="display:flex;align-items:center;justify-content:space-between;margin-top:14px;font-size:12.5px">' +
          '<span style="display:flex;align-items:center;gap:7px;font-weight:700"><svg viewBox="0 0 24 24" width="14" height="14" fill="var(--clay)">' + ICON.flame + '</svg>' + ta('streak') + '</span>' +
          '<span style="color:var(--at3)">' + ta('weekOf') + '</span></div>' +
      '</div>' +
      '<div class="a-grid3">' +
        [['sessions', '64', ''], ['setsT', '640', ''], ['time', '60', ' h']].map(function (s) {
          return '<div class="a-card" style="padding:13px 14px;border-radius:16px"><div class="a-lbl" style="font-size:10px">' + ta(s[0]) + '</div>' +
            '<div class="a-dsp" style="font-size:22px;margin-top:3px">' + s[1] + '<small style="font-size:12px;color:var(--at2)">' + s[2] + '</small></div></div>';
        }).join('') +
      '</div>' +
      '<div class="a-card">' +
        '<div style="display:flex;align-items:center;justify-content:space-between;gap:8px"><div class="a-lbl">' + ta('muscleMap') + '</div>' +
        '<span class="a-seg">' + [['7', '7D'], ['30', '30D'], ['rec', ta('recovery')]].map(function (o) {
          return '<button data-a="view:' + o[0] + '" class="' + (view === o[0] ? 'on' : '') + '">' + o[1] + '</button>';
        }).join('') + '</span></div>' +
        '<div class="a-map" data-v="' + view + '">' + (BODY_SVG || '') + '</div>' +
      '</div>' +
      aDemoNote() +
    '</div>';
  }

  function aExercises() {
    var groups = [['chest', ['chest']], ['back', ['back']], ['shoulders', ['shoulders']], ['legs', ['quads', 'glutes', 'hamstrings']], ['arms', ['biceps', 'triceps']]];
    return '<div class="a-scroll">' +
      '<div style="display:flex;align-items:flex-start;justify-content:space-between"><div><div class="a-title">' + ta('exercisesT') + '</div>' +
      '<div style="font-size:12.5px;color:var(--at2);margin-top:1px">551 ' + ta('inLibrary') + '</div></div>' + round(IC.plus, '', ta('newEx')) + '</div>' +
      '<div class="a-search">' + sv('<circle cx="11" cy="11" r="7"/><path d="M20 20l-4.5-4.5"/>', 'width="15" height="15"') +
        '<span>' + ta('search') + '</span></div>' +
      '<div class="a-chips">' +
        '<span class="a-chip ghost">' + ta('filters') + '</span>' +
        '<span class="a-chip ghost">' + ta('favs') + ' · 2</span>' +
        '<span class="a-chip ghost">' + ta('noKit') + '</span>' +
      '</div>' +
      groups.map(function (g, gi) {
        return '<div><div class="a-lbl" style="margin-bottom:8px">' + (DICT[lang].muscles[g[0]] || ta(g[0])) + '</div>' +
          '<div class="a-card a-list">' + g[1].map(function (m, k) {
            var fav = gi === 0 && k === 0;
            return '<div class="a-li">' +
              '<div class="a-thumb"><img src="' + exGif(m) + '" width="300" height="300" loading="lazy" alt="" /></div>' +
              '<div style="flex:1;min-width:0"><div style="font-size:13.5px;font-weight:700">' + exName(m) + '</div>' +
              '<div style="font-size:11.5px;color:var(--at2);margin-top:1px">' + ta('kit' + exKit(m)) + ' · ' + exLevel(m) + '</div></div>' +
              '<svg viewBox="0 0 24 24" width="17" height="17" fill="' + (fav ? 'var(--clay)' : 'none') + '" stroke="' + (fav ? 'var(--clay)' : 'var(--at3)') + '" stroke-width="1.8" style="flex:none">' + IC.star + '</svg></div>';
          }).join('') + '</div></div>';
      }).join('') +
      aDemoNote() +
    '</div>';
  }

  function aProfile() {
    var medals = [['firstStep', 'mStep'], ['firstWorkout', 'mWorkout'], ['firstRoutine', 'mRoutine'], ['firstRecord', 'mRecord']];
    return '<div class="a-scroll a-prof">' +
      '<div class="a-cover"><div class="a-cover-act">' + round(IC.share, '', 'share') + round(IC.gear, 'go:settings', ta('settingsT')) + '</div></div>' +
      '<div class="a-prof-head">' +
        '<img class="a-ava" src="assets/avatar.webp" alt="" />' +
        '<span class="a-edit">' + ta('editProfile') + '</span>' +
      '</div>' +
      '<div><div class="a-dsp" style="font-size:24px;display:flex;align-items:center;gap:7px">InlitX' +
        '<svg viewBox="0 0 24 24" width="18" height="18"><circle cx="12" cy="12" r="10" fill="#4C9BE8"/><path d="M7.5 12.3l3 3 6-6.3" fill="none" stroke="#fff" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/></svg></div>' +
        '<div style="font-size:12.5px;color:var(--at2)">@inlitx · 78 kg</div>' +
        '<div style="display:flex;align-items:center;gap:8px;margin-top:8px"><span class="a-lvl">' + ta('level7') + '</span>' +
        '<span style="font-size:11.5px;color:var(--at3)">' + ta('toLevel8') + '</span></div></div>' +
      '<div class="a-pstats">' +
        [['workouts', '64', ''], ['trained', '2', ' ' + ta('days')], ['setsT', '640', ''], ['lifted', '390', ' t']].map(function (s) {
          return '<div><div class="a-lbl" style="font-size:9.5px">' + ta(s[0]) + '</div><div class="a-dsp" style="font-size:21px">' + s[1] + '<small style="font-size:11px;color:var(--at2)">' + s[2] + '</small></div></div>';
        }).join('') +
      '</div>' +
      '<div><div class="a-h" style="display:flex;justify-content:space-between;align-items:center"><span>' + ta('medals') + ' <small style="color:var(--at3);font-weight:600;font-size:13px">13</small></span>' + chev() + '</div>' +
        '<div class="a-medals">' + medals.map(function (m) {
          return '<div><img src="assets/medals/' + m[0] + '.webp" width="128" height="128" alt="" /><span>' + ta(m[1]) + '</span></div>';
        }).join('') + '</div></div>' +
      '<div><div class="a-h" style="display:flex;justify-content:space-between;align-items:center">' + ta('photos') + chev() + '</div>' +
        '<div class="a-grid2">' +
          '<div class="a-card a-photo"><img src="assets/runner.webp" alt="" /><span>' + ta('yourPhotos') + ' <small>3</small></span></div>' +
          '<div class="a-card a-photo">' + sv('<path d="M4 8h3l2-3h6l2 3h3v11H4z"/><circle cx="12" cy="13" r="3.5"/>', 'width="26" height="26" style="color:var(--at2)"') + '<span>' + ta('takeOne') + '</span></div>' +
        '</div></div>' +
      aDemoNote() +
    '</div>';
  }

  function aSettings() {
    function seg(a, b) { return '<span class="a-seg sm"><button class="on">' + a + '</button><button>' + b + '</button></span>'; }
    function tog(on) { return '<span class="a-tog' + (on ? ' on' : '') + '"></span>'; }
    function val(v) { return '<span style="display:flex;align-items:center;gap:6px;font-size:12.5px;color:var(--at2)">' + v + chev() + '</span>'; }
    function row(icon, label, ctl) {
      return '<div class="a-srow">' + sv(icon, 'width="18" height="18" style="color:var(--at2);flex:none"') +
        '<span style="flex:1;font-size:13.5px">' + label + '</span>' + ctl + '</div>';
    }
    return '<div class="a-scroll">' +
      '<div style="display:flex;align-items:center;gap:12px">' + round(IC.back, 'go:profile', 'back') + '<div class="a-title" style="font-size:22px">' + ta('settingsT') + '</div></div>' +
      '<div><div class="a-lbl" style="margin-bottom:9px">' + ta('prefs') + '</div>' +
      '<div class="a-card" style="padding:2px 16px">' +
        row('<path d="M20 14a8 8 0 11-8-10 6.5 6.5 0 008 10z"/>', ta('setTheme'), val(ta('dark'))) +
        row('<path d="M4 5h10M9 3v2c0 5-2.5 8-5 9M7 12c1.5 3 4 5 7 6M14 21l4-10 4 10M15.5 18h5"/>', ta('setLang'), val(lang === 'es' ? 'Español' : 'English')) +
        row('<path d="M12 3v18M4 8h16M6 8l-2 5h4zM18 8l-2 5h4z"/>', ta('setUnits'), seg('kg', 'lb')) +
        row('<circle cx="12" cy="13" r="8"/><path d="M12 9v4M9 2h6"/>', ta('setRest'), '<span class="a-num"><button>–</button><span>90s</span><button>+</button></span>') +
        row('<path d="M18 16V11a6 6 0 10-12 0v5l-2 3h16zM10 22h4"/>', ta('setRemind'), val(ta('never'))) +
        row('<path d="M11 5L6 9H3v6h3l5 4zM15.5 8.5a5 5 0 010 7"/>', ta('setSound'), val(ta('setSoundVal'))) +
        row('<circle cx="12" cy="12" r="8"/><circle cx="12" cy="12" r="3"/>', ta('setFocus'), tog(true)) +
        row('<path d="M12 20h9M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z"/>', ta('setEffort'), val(ta('off'))) +
        row('<path d="M6 4l10 8-10 8zM19 5v14"/>', ta('setAutoNext'), tog(true)) +
        row('<rect x="7" y="2" width="10" height="20" rx="2"/><path d="M11 18h2"/>', ta('setAwake'), tog(true)) +
      '</div></div>' +
      '<div><div class="a-lbl" style="margin-bottom:9px">' + ta('data') + '</div>' +
      '<div class="a-card" style="padding:2px 16px">' +
        row('<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 10h18M9 10v10"/>', ta('setExport'), chev()) +
        row('<path d="M12 16V4M8 8l4-4 4 4M4 20h16"/>', ta('setBackup'), chev()) +
      '</div></div>' +
      '<div style="font-size:11.5px;color:var(--at3);text-align:center">GymMane · GPL-3.0</div>' +
      aDemoNote() +
    '</div>';
  }

  var SCREENS = { home: aHome, train: aTrain, session: aSession, done: aDone, progress: aProgress, exercises: aExercises, profile: aProfile, settings: aSettings };

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

  function restLabel() { return clock(A.rest).replace(/^0/, ''); }
  function paintRest() {
    var n = document.getElementById('aRestN');
    if (n) n.textContent = restLabel();
    var ticks = app.querySelectorAll('.a-ticks i');
    for (var i = 0; i < ticks.length; i++) ticks[i].classList.toggle('on', i / ticks.length < 1 - A.rest / A.restTotal);
  }

  function aTimer(on) {
    if (A.id) { clearInterval(A.id); A.id = null; }
    if (!on) return;
    A.id = setInterval(function () {
      if (!A.paused) A.elapsed++;
      ['aEl2', 'aEl3'].forEach(function (id) {
        var el = document.getElementById(id);
        if (el) el.textContent = clock(A.elapsed);
      });
      if (A.rest > 0 && !A.paused) {
        A.rest--;
        if (A.rest > 0) return paintRest();
        A.restOver = true;
        aRender(true);
        setTimeout(function () { if (A.restOver) { A.restOver = false; aRender(true); } }, 2800);
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
    begin: function () { A.elapsed = 0; A.paused = false; A.doneVol = 0; A.doneSets = 0; loadSets(); aGo('session'); },
    pause: function () { A.paused = !A.paused; aRender(true); },
    finish: function () { aTimer(false); A.screen = 'done'; aRender(); },
    save: function () { A.saved = true; A.week[A.today] = 1; A.ex = []; aGo('home'); },
    skip: function () { A.rest = 0; A.restOver = false; aRender(true); },
    rest15: function () { A.rest += 15; A.restTotal = Math.max(A.restTotal, A.rest); aRender(true); },
    prev: function () { if (A.exIdx > 0) { A.exIdx--; loadSets(); aRender(); } },
    next: function () {
      if (A.exIdx >= A.ex.length - 1) return ACTS.finish();
      A.sets.forEach(function (s) { if (s.ok) { A.doneVol += s.r * s.w; A.doneSets++; } });
      A.exIdx++; loadSets(); aRender();
    },
    addset: function () { var l = A.sets[A.sets.length - 1]; A.sets.push({ r: l.r, w: l.w, ok: false }); aRender(true); }
  };

  app.addEventListener('click', function (e) {
    var t = e.target.closest('[data-a]');
    if (!t) return;
    var a = t.dataset.a, p = a.split(':'), k = p[0], v = p[1];
    if (k === 'rest-15') { A.rest = Math.max(1, A.rest - 15); return aRender(true); }
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

  var spy = [].slice.call(document.querySelectorAll('.lnks a.lnk')).map(function (a) {
    return { a: a, sec: document.querySelector(a.getAttribute('href')) };
  }).filter(function (s) { return s.sec; });

  addEventListener('scroll', function () {
    var mark = document.documentElement.scrollTop + 140, on = null;
    spy.forEach(function (s) { if (s.sec.offsetTop <= mark) on = s.a; });
    spy.forEach(function (s) { s.a.classList.toggle('on', s.a === on); });
  }, { passive: true });

  var dlBox = document.getElementById('dlCount');
  var dlNum = document.getElementById('dlNum');
  var dlShown = 0, dlRaf = 0;
  function fmtDl(v) { return Math.round(v).toLocaleString(lang === 'es' ? 'es-ES' : 'en-GB'); }
  function fmtDlNow() { if (dlNum && dlShown) dlNum.textContent = fmtDl(dlShown); }
  function countDl(n) {
    if (!n) return;
    dlBox.hidden = false;
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
  try { dlCache = JSON.parse(localStorage.getItem('gm-dl') || 'null'); } catch (e) {}
  if (dlCache) countDl(dlCache.n);
  function saveDl(n) {
    if (!n) return;
    try { localStorage.setItem('gm-dl', JSON.stringify({ n: n, t: Date.now() })); } catch (e) {}
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
