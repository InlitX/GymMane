// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get languageName => 'Español';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% vs. mes pasado';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Nivel $level · $streak';
  }

  @override
  String get save => 'GUARDAR';

  @override
  String get cancel => 'Cancelar';

  @override
  String get cancelCaps => 'CANCELAR';

  @override
  String get deleteCaps => 'BORRAR';

  @override
  String get done => 'LISTO';

  @override
  String get set => 'Fijar';

  @override
  String get home => 'INICIO';

  @override
  String get progress => 'PROGRESO';

  @override
  String get exercises => 'EJERCICIOS';

  @override
  String get settings => 'AJUSTES';

  @override
  String get today => 'HOY';

  @override
  String get thisWeek => 'ESTA SEMANA';

  @override
  String get recommended => 'RECOMENDADOS';

  @override
  String get goal => 'OBJETIVO';

  @override
  String get volume => 'VOLUMEN';

  @override
  String get setsToday => 'SERIES HOY';

  @override
  String get prs => 'RÉCORDS';

  @override
  String get todaysFocus => 'FOCO DE HOY';

  @override
  String get todaysRoutine => 'RUTINA DE HOY';

  @override
  String get startWorkout => 'EMPEZAR';

  @override
  String get routines => 'RUTINAS';

  @override
  String get tools => 'HERRAMIENTAS';

  @override
  String get firstSessionHint => 'Elige tus músculos y registra tu primera sesión';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ejercicios', one: '$n ejercicio');
    return '$_temp0';
  }

  @override
  String get pushDay => 'DÍA DE EMPUJE';

  @override
  String get pullDay => 'DÍA DE TIRÓN';

  @override
  String get legDay => 'DÍA DE PIERNA';

  @override
  String get pushFocus => 'Pecho · Hombros · Tríceps';

  @override
  String get pullFocus => 'Espalda · Bíceps · Trapecio';

  @override
  String get legFocus => 'Cuádriceps · Isquios · Glúteos';

  @override
  String get train => 'ENTRENAR';

  @override
  String get step1 => 'PASO 1 DE 2';

  @override
  String get step2 => 'PASO 2 DE 2';

  @override
  String get chooseFocus => 'ELIGE TU FOCO';

  @override
  String get buildSession => 'MONTA TU SESIÓN';

  @override
  String get tapMuscles => 'Toca los músculos que quieras entrenar — frente y espalda.';

  @override
  String get continueBtn => 'CONTINUAR';

  @override
  String get nothingForFocus => 'Aún no hay nada para este foco';

  @override
  String get goBackPick => 'Vuelve atrás y elige un músculo con ejercicios en tu biblioteca.';

  @override
  String pickedHint(int n) {
    return 'Te hemos montado una sesión — toca para añadir o quitar cualquiera de los $n.';
  }

  @override
  String get pickAnExercise => 'ELIGE UN EJERCICIO';

  @override
  String get searchAllExercises => 'Busca cualquier ejercicio…';

  @override
  String get noExercisesMatch => 'Ningún ejercicio coincide';

  @override
  String get createItInstead => 'Créalo como ejercicio propio';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n EJERCICIOS', one: '$n EJERCICIO');
    return 'EMPEZAR · $_temp0';
  }

  @override
  String get inProgress => 'EN CURSO';

  @override
  String get paused => 'EN PAUSA';

  @override
  String get last => 'ÚLTIMA';

  @override
  String get rest => 'DESCANSO';

  @override
  String get skip => 'SALTAR';

  @override
  String get addSet => '+ AÑADIR SERIE';

  @override
  String get finishSession => 'TERMINAR';

  @override
  String get setDone => 'SERIE HECHA';

  @override
  String get nextExercise => 'SIGUIENTE';

  @override
  String get dropExerciseAction => 'Quitar ejercicio';

  @override
  String get restOff => 'Apagado';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'REPS';

  @override
  String weightCol(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get repsTitle => 'REPS';

  @override
  String weightTitle(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get sessionComplete => 'ENTRENO REGISTRADO';

  @override
  String get finishHeadlinePr => 'Récord personal nuevo';

  @override
  String get finishHeadlineGoal => 'Objetivo semanal cumplido';

  @override
  String get finishHeadlineStreak => 'Racha viva';

  @override
  String get finishHeadlineDefault => 'Uno más en el saco';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs ejercicios',
      one: 'un ejercicio',
    );
    return 'Has levantado más que nunca en $_temp0. Ya está en tus récords.';
  }

  @override
  String get finishBodyGoal => 'Has hecho las sesiones que te propusiste esta semana.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak días seguidos. Lo difícil es no parar.';
  }

  @override
  String get finishBodyDefault => 'Registrado y contado. Lo que mueve los números es la constancia.';

  @override
  String get vsLastTime => 'VS. LA ÚLTIMA VEZ';

  @override
  String get firstTime => 'Primera vez registrado';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n récords nuevos',
      one: '$n récord nuevo',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'DURACIÓN';

  @override
  String get setsCaps => 'SERIES';

  @override
  String exerciseXofY(int i, int n) {
    return 'EJERCICIO $i DE $n';
  }

  @override
  String get decrease => 'Bajar';

  @override
  String get increase => 'Subir';

  @override
  String markSet(int n) {
    return 'Marcar la serie $n como hecha';
  }

  @override
  String get pauseWorkout => 'Pausar el entreno';

  @override
  String get resumeWorkout => 'Reanudar el entreno';

  @override
  String get discardTitle => '¿Descartar el entreno?';

  @override
  String get discardBody => 'Perderás las series de esta sesión.';

  @override
  String get keepTraining => 'Seguir entrenando';

  @override
  String get discard => 'Descartar';

  @override
  String get notifRestChannel => 'Temporizador de descanso';

  @override
  String get notifRestChannelWhy => 'Te avisa cuando termina el descanso entre series';

  @override
  String get notifAlertChannel => 'Temporizador de descanso (aviso)';

  @override
  String get notifAlertChannelWhy => 'Muestra un aviso en cuanto acaba el descanso';

  @override
  String get restOverTitle => 'Se acabó el descanso';

  @override
  String get restOverBody => 'A por ello — te espera la siguiente serie.';

  @override
  String get allTimeSessions => 'SESIONES';

  @override
  String get allTimeTime => 'TIEMPO';

  @override
  String get allTimeSets => 'SERIES';

  @override
  String get consistency => 'CONSTANCIA';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones registradas',
      one: '$n sesión registrada',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'días', one: 'día');
    return 'racha de $n $_temp0';
  }

  @override
  String get bodyweight => 'PESO CORPORAL';

  @override
  String get logBodyweight => 'ANOTAR PESO';

  @override
  String get trackWeight => 'Sigue tu peso en el tiempo';

  @override
  String get muscleMap => 'MAPA MUSCULAR';

  @override
  String get days7 => '7D';

  @override
  String get days30 => '30D';

  @override
  String get days90 => '90D';

  @override
  String get days365 => '1A';

  @override
  String get daysAll => 'Todo';

  @override
  String get weeklyAvgTitle => 'Media por semana';

  @override
  String weekOfDate(String date) {
    return 'Semana del $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change en este periodo';
  }

  @override
  String get heatLow => 'Sin tocar';

  @override
  String get heatHigh => 'Volumen pleno';

  @override
  String get muscleMapEmpty => 'Registra una sesión y tu cuerpo se irá encendiendo aquí.';

  @override
  String get muscleMapHint => 'Toca un músculo para ver lo que le ha tocado.';

  @override
  String muscleMapBehind(String names) {
    return 'Te estás dejando: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% del objetivo';
  }

  @override
  String get muscleSplit => 'REPARTO MUSCULAR';

  @override
  String get personalRecords => 'RÉCORDS PERSONALES';

  @override
  String get strength1rm => 'FUERZA · 1RM EST.';

  @override
  String get strengthEmpty => 'Registra un ejercicio dos veces y aquí saldrá su curva de fuerza.';

  @override
  String oneRmEst(String w) {
    return '1RM est. $w';
  }

  @override
  String get restDayShort => 'Descanso';

  @override
  String get restDay => 'Día de descanso — nada registrado.';

  @override
  String get delete => 'Borrar';

  @override
  String get deleteEntry => '¿Borrar esta anotación?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" desaparecerá de este día, y de tus récords y gráficas.';
  }

  @override
  String get bodyweightHistory => 'HISTORIAL';

  @override
  String get exercisesCaps => 'EJERCICIOS';

  @override
  String get timeCaps => 'TIEMPO';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ejercicios en tu biblioteca',
      one: '$n ejercicio en tu biblioteca',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Buscar ejercicios';

  @override
  String get muscleFilter => 'MÚSCULO';

  @override
  String get levelFilter => 'NIVEL';

  @override
  String get kindLabel => 'TIPO';

  @override
  String get kindStrength => 'Fuerza';

  @override
  String get kindCalisthenics => 'Calistenia';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Estiramientos';

  @override
  String get newExercise => 'NUEVO EJERCICIO';

  @override
  String get exerciseName => 'Nombre del ejercicio';

  @override
  String get equipmentLabel => 'MATERIAL';

  @override
  String get addExercise => 'AÑADIR EJERCICIO';

  @override
  String get advanced => 'AVANZADO';

  @override
  String get demoMedia => 'DEMOSTRACIÓN';

  @override
  String get addMedia => 'Añadir media';

  @override
  String get mediaHint => 'Imagen, GIF o vídeo';

  @override
  String get changeMedia => 'Cambiar';

  @override
  String get videoSelected => 'Vídeo seleccionado';

  @override
  String get favouritesOnly => 'Favoritos';

  @override
  String get noFavouritesYet => 'Aún no tienes favoritos';

  @override
  String get noFavouritesHint => 'Toca la estrella de un ejercicio para tenerlo aquí.';

  @override
  String get clearFilters => 'Quitar filtros';

  @override
  String get noExercisesFound => 'Sin resultados';

  @override
  String get noExercisesHint => 'Prueba otra búsqueda o quita los filtros.';

  @override
  String get personalRecord => 'RÉCORD PERSONAL';

  @override
  String get history => 'HISTORIAL';

  @override
  String get noHistory => 'Aún no hay sesiones. Entrena este ejercicio para crear historial.';

  @override
  String get notes => 'NOTAS';

  @override
  String get notePlaceholder => 'Claves, montaje, cómo te fue…';

  @override
  String notHere(String gear, String place) {
    return 'En $place no tienes $gear';
  }

  @override
  String get notHereWhy => 'Cámbialo por algo que sí puedas cargar hoy.';

  @override
  String get altHere => 'LO QUE SÍ PUEDES HACER AQUÍ';

  @override
  String get places => 'MIS SITIOS';

  @override
  String get placesHint => 'Di qué hay en cada sitio y la biblioteca te enseña solo lo que puedes hacer ahí.';

  @override
  String get placeAll => 'En cualquier sitio';

  @override
  String get placeNew => 'Nuevo sitio';

  @override
  String get placeNamePlaceholder => 'Casa, gimnasio, el parque…';

  @override
  String get placeGearLabel => 'QUÉ HAY AHÍ';

  @override
  String placeExercises(int n) {
    return '$n ejercicios aquí';
  }

  @override
  String get placeEmptyTitle => 'Entrena donde estés';

  @override
  String get placeEmptyBody =>
      'Un sitio es la lista de lo que tienes ahí. Elige uno para empezar y lo retocas luego.';

  @override
  String get placeDeleteTitle => 'Borrar sitio';

  @override
  String get placeDeleteBody => 'Se va solo el sitio — tus ejercicios y tus sesiones se quedan.';

  @override
  String get placeGym => 'Gimnasio';

  @override
  String get placeHome => 'Casa';

  @override
  String get placeOutdoors => 'Al aire libre';

  @override
  String get placeFilterLabel => 'SITIO';

  @override
  String get noGearOnly => 'Sin material';

  @override
  String placeActive(String name) {
    return 'Entrenando en $name';
  }

  @override
  String get journal => 'DIARIO';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notas',
      one: '1 nota',
      zero: 'Sin notas',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Nota';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Logro';

  @override
  String get noteKindPain => 'Molestia';

  @override
  String get noteFilterAll => 'Todas';

  @override
  String get newNote => 'Nueva nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get addNote => 'AÑADIR NOTA';

  @override
  String get noteEmptyTitle => 'Todavía no has escrito nada';

  @override
  String get noteEmptyBody =>
      'Claves, planes para la próxima, cómo te fue la sesión — con fotos o vídeo si quieres.';

  @override
  String get noteNoneForExercise => 'Aún no hay notas en este ejercicio.';

  @override
  String get noteKindLabel => 'TIPO';

  @override
  String get noteTextLabel => 'NOTA';

  @override
  String get noteDateLabel => 'FECHA';

  @override
  String get noteExerciseLabel => 'EJERCICIO';

  @override
  String get noteMediaLabel => 'FOTOS Y VÍDEO';

  @override
  String get noteGeneral => 'Sin ejercicio';

  @override
  String get noteAttach => 'Adjuntar';

  @override
  String get noteRemoveMedia => 'Quitar adjunto';

  @override
  String get deleteNoteTitle => 'Borrar nota';

  @override
  String get deleteNoteBody => 'La nota y todo lo que lleve adjunto se van para siempre.';

  @override
  String get noteToday => 'Hoy';

  @override
  String get noteYesterday => 'Ayer';

  @override
  String get noteAllNotes => 'Todas las notas';

  @override
  String get noteCalendar => 'Calendario';

  @override
  String get noteNoneOnDay => 'Nada escrito este día';

  @override
  String get noteAddOnDay => 'Nota en este día';

  @override
  String get notePrevMonth => 'Mes anterior';

  @override
  String get noteNextMonth => 'Mes siguiente';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notas este mes',
      one: '1 nota este mes',
      zero: 'Ninguna nota este mes',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MEDIDAS';

  @override
  String get measuresHint => 'Del cuello al gemelo — mira cómo cambia tu cuerpo, no solo la barra.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n medidas',
      one: '1 medida',
      zero: 'Sin anotar',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Sin anotar';

  @override
  String get measureHistory => 'HISTORIAL';

  @override
  String get measureNeck => 'Cuello';

  @override
  String get measureShoulders => 'Hombros';

  @override
  String get measureChest => 'Pecho';

  @override
  String get measureArm => 'Brazo';

  @override
  String get measureForearm => 'Antebrazo';

  @override
  String get measureWaist => 'Cintura';

  @override
  String get measureHips => 'Cadera';

  @override
  String get measureThigh => 'Muslo';

  @override
  String get measureCalf => 'Gemelo';

  @override
  String get measureBodyfat => 'Grasa corporal';

  @override
  String get timeline => 'EVOLUCIÓN';

  @override
  String get hidePhotos => 'Ocultar fotos';

  @override
  String get showPhotos => 'Mostrar fotos';

  @override
  String get timelineHint => 'Misma pose, mismo sitio, misma luz. Dentro de un año no te lo vas a creer.';

  @override
  String get timelineEmptyTitle => 'Tu primera foto pone el contador en marcha';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotos',
      one: '1 foto',
      zero: 'Sin fotos',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Frente';

  @override
  String get poseSide => 'Perfil';

  @override
  String get poseBack => 'Espalda';

  @override
  String get photoEvery => 'RECORDÁRMELO';

  @override
  String photoEveryDays(int n) {
    return 'Cada $n días';
  }

  @override
  String get photoEveryOff => 'Nunca';

  @override
  String get timelineEvery => 'AGRUPAR CADA';

  @override
  String get custom => 'Otro';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'La próxima foto en $n días',
      one: 'La próxima foto, mañana',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Toca foto — hazla hoy';

  @override
  String get addTodayPhotos => 'AÑADIR LAS DE HOY';

  @override
  String posePhoto(String pose) {
    return 'Foto de $pose';
  }

  @override
  String get compare => 'COMPARAR';

  @override
  String get compareNeedTwo => 'Con tu próxima foto verás aquí el antes y el después.';

  @override
  String dayNumber(int n) {
    return 'Día $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n días de diferencia',
      one: '1 día de diferencia',
      zero: 'El mismo día',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Borrar este día';

  @override
  String get deleteDayBody => 'Sus fotos se van con él, para siempre.';

  @override
  String get timelinePhotos => 'Fotos';

  @override
  String get timelineBody => 'Muñeco';

  @override
  String get timelineBodyEmpty => 'Entrena y tu mapa muscular se va llenando aquí, sin subir ninguna foto.';

  @override
  String get timelineBodyHint => 'Sale de tus propias series — no hay nada que subir.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones',
      one: '1 sesión',
      zero: 'Sin sesiones',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Fotos de progreso';

  @override
  String get notifPhotoChannelWhy => 'Un aviso cuando toca la siguiente foto de progreso.';

  @override
  String get notifPhotoTitle => 'Toca foto de progreso';

  @override
  String notifPhotoBody(int n) {
    return '$n días desde la última. Misma pose, misma luz.';
  }

  @override
  String get share => 'COMPARTIR';

  @override
  String get sharePick => '¿Qué quieres enseñar?';

  @override
  String get shareStreak => 'Racha y constancia';

  @override
  String get shareBody => 'Músculos trabajados';

  @override
  String get shareCompare => 'Antes y después';

  @override
  String get shareHint => 'La lámina se monta en tu móvil. No sale nada hasta que tú elijas dónde va.';

  @override
  String get shareFailed => 'No se ha podido montar la lámina';

  @override
  String get shareWeekOf => 'ÚLTIMOS 7 DÍAS';

  @override
  String get shareStreakLabel => 'DÍAS DE RACHA';

  @override
  String get shareSessionsLabel => 'SESIONES';

  @override
  String get shareVolumeLabel => 'VOLUMEN';

  @override
  String get restForExercise => 'DESCANSO DE ESTE EJERCICIO';

  @override
  String get restUsingDefault => 'El que tienes por defecto';

  @override
  String get restCustom => 'Solo para este';

  @override
  String get setType => 'TIPO DE SERIE';

  @override
  String get setTypeNormal => 'Efectiva';

  @override
  String get setTypeWarmup => 'Calentamiento';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'Al fallo';

  @override
  String get addWarmup => 'CALENTAR';

  @override
  String platesPerSide(String plates) {
    return 'Por lado: $plates';
  }

  @override
  String get howTo => 'CÓMO SE HACE';

  @override
  String get similar => 'SIMILARES';

  @override
  String get primaryLabel => 'PRINCIPAL';

  @override
  String get secondaryLabel => 'SECUNDARIOS';

  @override
  String get none => 'Ninguno';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n series', one: '$n serie');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v de volumen';
  }

  @override
  String get weeklyPlan => 'PLAN SEMANAL';

  @override
  String get yourRoutines => 'TUS RUTINAS';

  @override
  String get noRoutines => 'Aún no hay rutinas. Crea una y añade tus ejercicios.';

  @override
  String get newRoutine => 'NUEVA RUTINA';

  @override
  String get routineName => 'Nombre de la rutina';

  @override
  String get schedule => 'PROGRAMAR';

  @override
  String get addFromList => 'Añade ejercicios de la lista de abajo.';

  @override
  String get addExercises => 'Añadir ejercicios';

  @override
  String get deleteRoutine => '¿Borrar esta rutina?';

  @override
  String exercisesWithCount(int n) {
    return 'EJERCICIOS · $n';
  }

  @override
  String setDay(String day) {
    return 'PONER $day';
  }

  @override
  String get newRoutineName => 'Rutina nueva';

  @override
  String get dragToReorder => 'Arrastra el asa de puntos para reordenar: es el orden en que entrenas.';

  @override
  String reorderHandle(String name) {
    return 'Reordenar $name';
  }

  @override
  String get removeFromRoutine => 'Quitar de la rutina';

  @override
  String get dropExercise => '¿Quitar este ejercicio?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" sale de este entreno. No se pierde nada de lo anotado.';
  }

  @override
  String get drop => 'Quitar';

  @override
  String get resetData => 'Borrar todos mis datos';

  @override
  String get resetTitle => '¿Borrar todo?';

  @override
  String get resetBody =>
      'Sesiones, récords, rutinas, notas y perfil. No tiene vuelta atrás — exporta una copia antes si crees que la querrás.';

  @override
  String get resetConfirm => 'Borrar todo';

  @override
  String get resetDone => 'Todos los datos borrados';

  @override
  String get support => 'APOYO';

  @override
  String get reportBug => 'Informar de un fallo';

  @override
  String get requestFeature => 'Pedir una función';

  @override
  String get starOnGithub => 'Dar una estrella en GitHub';

  @override
  String get buyCoffee => 'Invítame a un café';

  @override
  String get cantOpenLink => 'No he podido abrir el enlace';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get lightTheme => 'Claro';

  @override
  String get amoledTheme => 'Negro AMOLED';

  @override
  String get editDuration => 'Duración del entreno';

  @override
  String get sessionName => 'Nombre del entreno';

  @override
  String get nameWorkout => 'Ponle nombre';

  @override
  String get sessionNameHint => 'Ej.: Pierna, Empuje, Cuerpo entero';

  @override
  String get secondaryPickHint => 'Toca los otros músculos que trabaja este ejercicio.';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get restTimer => 'Descanso';

  @override
  String get alarmBlockedTitle => 'Las notificaciones están apagadas';

  @override
  String get alarmBlockedBody => 'La alarma de descanso no sonará con la pantalla bloqueada';

  @override
  String get alarmBlockedAction => 'ACTIVAR';

  @override
  String get alarmSound => 'Sonido de alarma';

  @override
  String get alarmDefaultName => 'Por defecto';

  @override
  String get alarmSoundHint => 'Pon el tuyo — hasta 15 segundos';

  @override
  String get alarmChoose => 'Elegir un sonido…';

  @override
  String get alarmPreview => 'Escuchar el actual';

  @override
  String get alarmReset => 'Volver al de por defecto';

  @override
  String get alarmTooLong => 'Ese sonido dura más de 15 segundos';

  @override
  String get alarmInvalid => 'No he podido leer ese audio';

  @override
  String alarmChanged(String name) {
    return 'Sonido cambiado a «$name»';
  }

  @override
  String get alarmChangedDefault => 'De vuelta al sonido de fábrica';

  @override
  String get addActivityWidget => 'Añadir widget de actividad';

  @override
  String get addStatsWidget => 'Añadir widget de estadísticas';

  @override
  String get pinUnsupported => 'Añádelo desde el menú de widgets de tu lanzador';

  @override
  String get background => 'Fondo';

  @override
  String get bgNone => 'Ninguno';

  @override
  String get bgDots => 'Puntos';

  @override
  String get bgGrid => 'Rejilla';

  @override
  String get exportCsv => 'Exportar entrenos (CSV)';

  @override
  String get exportBackup => 'Exportar copia (ZIP)';

  @override
  String get importBackup => 'Importar copia';

  @override
  String get importHint =>
      'Elige una copia .zip (o el .json antiguo) exportada de GymMane. Reemplazará tus datos actuales, media incluido.';

  @override
  String get import => 'Importar';

  @override
  String get chooseFile => 'Elegir archivo';

  @override
  String get importFromApp => 'Importar de otra app';

  @override
  String get importUnknownFormat => 'Ese archivo necesita columnas de fecha, ejercicio, repeticiones y peso';

  @override
  String get importZipNoWeights => 'Ese zip no trae ningún fichero de peso';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pesajes importados',
      one: '$n pesaje importado',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'No he podido leer ese archivo';

  @override
  String get importUnitTitle => '¿En qué unidad está ese archivo?';

  @override
  String get importUnitBody => 'Esta exportación no dice en qué unidad están los pesos.';

  @override
  String get importNothing => 'Nada nuevo que importar';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones importadas',
      one: '$n sesión importada',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Sobre GymMane';

  @override
  String get yourProfile => 'TU PERFIL';

  @override
  String get autofills => 'Rellena las calculadoras';

  @override
  String get nameLabel => 'NOMBRE';

  @override
  String get sexLabel => 'SEXO';

  @override
  String get macroProtein => 'PROTEÍNA';

  @override
  String get macroCarbs => 'CARBOS';

  @override
  String get macroFat => 'GRASA';

  @override
  String get male => 'Hombre';

  @override
  String get female => 'Mujer';

  @override
  String get ageLabel => 'EDAD';

  @override
  String get heightLabel => 'ALTURA';

  @override
  String get weightLabel => 'PESO';

  @override
  String get weeklyGoal => 'OBJETIVO SEMANAL';

  @override
  String get activityLabel => 'ACTIVIDAD';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get takePhoto => 'Hacer una foto';

  @override
  String get chooseGallery => 'Elegir de la galería';

  @override
  String get backupImported => 'Copia importada';

  @override
  String get backupFailed => 'No he podido leer esa copia';

  @override
  String get nothingToExport => 'Nada que exportar aún — registra una sesión';

  @override
  String calculatorsCount(int n) {
    return '$n calculadoras para tu entreno';
  }

  @override
  String get result => 'RESULTADO';

  @override
  String get weightLifted => 'PESO LEVANTADO';

  @override
  String get repsPerformed => 'REPS HECHAS';

  @override
  String get neck => 'CUELLO';

  @override
  String get waist => 'CINTURA';

  @override
  String get hip => 'CADERA (mujeres)';

  @override
  String get targetWeight => 'PESO OBJETIVO';

  @override
  String get workingWeight => 'PESO DE TRABAJO';

  @override
  String get activityLevel => 'NIVEL DE ACTIVIDAD';

  @override
  String get barWeight => 'PESO DE LA BARRA';

  @override
  String get perSide => 'POR LADO';

  @override
  String get justTheBar => 'Solo la barra.';

  @override
  String perSideCount(int n) {
    return '× $n por lado';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'IMC';

  @override
  String get toolNameCal => 'Calorías';

  @override
  String get toolNameBf => 'Grasa corporal';

  @override
  String get toolNamePlate => 'Discos';

  @override
  String get toolNameWarmup => 'Calentamiento';

  @override
  String get toolTitleRm => 'Calculadora de 1RM';

  @override
  String get toolTitleBmi => 'Calculadora de IMC';

  @override
  String get toolTitleCal => 'Calorías y macros';

  @override
  String get toolTitleBf => '% de grasa corporal';

  @override
  String get toolTitlePlate => 'Calculadora de discos';

  @override
  String get toolTitleWarmup => 'Series de calentamiento';

  @override
  String get toolHintRm => 'Máximo estimado a 1 repetición (fórmula de Epley)';

  @override
  String get toolHintCal => 'Mantenimiento diario estimado';

  @override
  String get toolHintBf => 'Estimación por el método US Navy';

  @override
  String get toolHintPlate => 'Peso total de la barra';

  @override
  String get toolHintWarmup => 'Peso de trabajo objetivo';

  @override
  String get toolDescRm => 'Máximo estimado a 1 repetición';

  @override
  String get toolDescBmi => 'Índice de masa corporal';

  @override
  String get toolDescCal => 'Calorías y macros';

  @override
  String get toolDescBf => 'Porcentaje de grasa corporal';

  @override
  String get toolDescPlate => 'Qué discos poner en la barra';

  @override
  String get toolDescWarmup => 'Series de aproximación';

  @override
  String get bmiUnderweight => 'Bajo peso';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Sobrepeso';

  @override
  String get bmiObese => 'Obesidad';

  @override
  String get actSedentary => 'Sedentario';

  @override
  String get actLight => 'Ligero';

  @override
  String get actActive => 'Activo';

  @override
  String get actModerate => 'Moderado';

  @override
  String get muscleChest => 'Pecho';

  @override
  String get muscleBack => 'Espalda';

  @override
  String get muscleLowerBack => 'Lumbares';

  @override
  String get muscleShoulders => 'Hombros';

  @override
  String get muscleBiceps => 'Bíceps';

  @override
  String get muscleTriceps => 'Tríceps';

  @override
  String get muscleForearm => 'Antebrazo';

  @override
  String get muscleTrapezius => 'Trapecio';

  @override
  String get muscleAbdomen => 'Abdomen';

  @override
  String get muscleObliques => 'Oblicuos';

  @override
  String get muscleQuads => 'Cuádriceps';

  @override
  String get muscleHamstrings => 'Isquiotibiales';

  @override
  String get muscleGlutes => 'Glúteos';

  @override
  String get muscleCalves => 'Gemelos';

  @override
  String get mgChest => 'Pecho';

  @override
  String get mgBack => 'Espalda';

  @override
  String get mgLegs => 'Piernas';

  @override
  String get mgShoulders => 'Hombros';

  @override
  String get mgArms => 'Brazos';

  @override
  String get mgCore => 'Core';

  @override
  String get equipBarbell => 'Barra';

  @override
  String get equipDumbbell => 'Mancuerna';

  @override
  String get equipCable => 'Polea';

  @override
  String get equipMachine => 'Máquina';

  @override
  String get equipBodyweight => 'Peso corporal';

  @override
  String get equipWeighted => 'Con lastre';

  @override
  String get equipBand => 'Goma';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Anillas';

  @override
  String get equipOther => 'Otro';

  @override
  String get diffBeginner => 'Principiante';

  @override
  String get diffAdvanced => 'Avanzado';

  @override
  String get diffIntermediate => 'Intermedio';

  @override
  String get about => 'ACERCA DE';

  @override
  String version(String v) {
    return 'Versión $v';
  }

  @override
  String get aboutBlurb => 'Hecha por gente que entrena, para gente que entrena.';

  @override
  String get freeForever => 'Gratis para siempre';

  @override
  String get freeForeverWhy => 'Sin suscripción, sin anuncios, nada escondido tras un muro de pago.';

  @override
  String get fullyOffline => 'Totalmente sin conexión';

  @override
  String get fullyOfflineWhy => 'Sin cuenta, sin servidores. Tu entreno no sale de este móvil.';

  @override
  String get yoursToTake => 'Tus datos son tuyos';

  @override
  String get yoursToTakeWhy => 'Expórtalos a CSV cuando quieras, y bórralos todos de un toque.';

  @override
  String get whatsInside => 'QUÉ LLEVA DENTRO';

  @override
  String exercisesInside(int n) {
    return '$n ejercicios';
  }

  @override
  String get exercisesInsideWhy => 'Cada uno con su animación y sus instrucciones paso a paso.';

  @override
  String get calculatorsInside => '10 calculadoras';

  @override
  String get calculatorsInsideWhy =>
      '1RM, discos, IMC, calorías, grasa, FFMI, calentamiento, peso por RPE y puntuaciones de fuerza DOTS y Wilks — todas con fórmulas publicadas.';

  @override
  String get mathInside => 'Cuentas honestas';

  @override
  String get mathInsideWhy =>
      'El volumen, los récords y la racha salen de tus series. Aquí no hay nada decorativo.';

  @override
  String get streakCaps => 'RACHA';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'días', one: 'día');
    return '$_temp0';
  }

  @override
  String get reset => 'REINICIAR';

  @override
  String get welcomeKicker => 'TE DAMOS LA BIENVENIDA A';

  @override
  String get welcomeBlurb => 'Todo se queda en tu móvil. Sin cuenta, sin internet, sin pagar nada.';

  @override
  String get welcomeStart => 'EMPEZAR';

  @override
  String onbStep(int i, int n) {
    return 'PASO $i DE $n';
  }

  @override
  String get onbNameTitle => '¿Cómo te llamamos?';

  @override
  String get onbNameHint => 'Tu nombre';

  @override
  String get onbPhotoAdd => 'Añadir foto';

  @override
  String get onbPhotoChange => 'Cambiar foto';

  @override
  String get onbPhotoTitle => 'Ponle cara a tu perfil';

  @override
  String get onbPhotoWhy =>
      'Opcional. Se queda en el móvil y la puedes cambiar cuando quieras desde tu perfil.';

  @override
  String get onbPhotoLater => 'MÁS TARDE';

  @override
  String get onbNameWhy => 'Solo para saludarte. No sale del móvil.';

  @override
  String get onbBodyTitle => 'Cuatro números';

  @override
  String get onbBodyWhy => 'Alimentan las calculadoras. Puedes cambiarlos cuando quieras en Ajustes.';

  @override
  String get onbGoalTitle => '¿Cuántas veces entrenas?';

  @override
  String get onbGoalWhy => 'Define tu anillo de objetivo semanal. Sé sincero, no ambicioso.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones por semana',
      one: '$n sesión por semana',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => '¿Kilos o libras?';

  @override
  String get next => 'SIGUIENTE';

  @override
  String get back => 'ATRÁS';

  @override
  String get skip2 => 'Saltar';

  @override
  String get madeWithLoveBy => 'HECHO CON AMOR POR';

  @override
  String get sourceCode => 'CÓDIGO FUENTE';

  @override
  String get suggested => 'SUGERIDOS';

  @override
  String get results => 'RESULTADOS';

  @override
  String get noMatches => 'Ningún ejercicio coincide con la búsqueda.';

  @override
  String get tapToEdit => 'Toca el lápiz para corregir algo mal anotado, o la papelera para quitarlo.';

  @override
  String get editEntry => 'Editar';

  @override
  String get editEntryHint => 'Corrige las repeticiones o el peso de cualquier serie.';

  @override
  String get removeSet => 'Quitar serie';

  @override
  String get continueWorkout => 'CONTINUAR';

  @override
  String get continueWorkoutBody =>
      'El entreno vuelve a estar en curso, con sus series ya marcadas. Al terminarlo se guarda otra vez en su día.';

  @override
  String get addBodyWidget => 'Añadir widget de músculos';

  @override
  String get repsOnly => 'Solo repeticiones';

  @override
  String get repsOnlyHint => 'Anota este ejercicio sin peso.';

  @override
  String get eachSide => 'Cada lado';

  @override
  String get eachSideHint => 'El tiempo corre una vez por lado y el descanso empieza tras los dos.';

  @override
  String get useDefaultArt => 'Volver al dibujo original';

  @override
  String daysShort(int n) {
    return '${n}d';
  }

  @override
  String get focusCard => 'El foco de hoy';

  @override
  String get autoAdvance => 'Pasar al siguiente solo';

  @override
  String get keepScreenOn => 'Mantener la pantalla encendida al entrenar';

  @override
  String get lockWorkout => 'Bloquear la pantalla';

  @override
  String get unlockWorkout => 'Desbloquear';

  @override
  String get holdToUnlock => 'Mantén pulsado para desbloquear';

  @override
  String get liveChannel => 'Entreno en curso';

  @override
  String get liveChannelWhy => 'Muestra el ejercicio, la serie y el descanso mientras entrenas';

  @override
  String liveSet(int n, int total) {
    return 'Serie $n de $total';
  }

  @override
  String get liveResting => 'Descansando';

  @override
  String get liveAllDone => 'Series completadas';

  @override
  String get autoAdvanceHint => 'Al marcar la última serie de un ejercicio, el entreno pasa al siguiente.';

  @override
  String get placePlates => 'Discos y barra';

  @override
  String get platesAll => 'Todo disponible';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n medidas', one: '$n medida');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PAREJAS';

  @override
  String plateAchievable(String w) {
    return 'Lo más cerca que puedes cargar: $w';
  }

  @override
  String get autoWarmup => 'Empezar con calentamiento';

  @override
  String get autoWarmupHint => 'Añade las series de calentamiento al abrir el entreno.';

  @override
  String get trainReminder => 'Aviso para entrenar';

  @override
  String get trainReminderHint => 'Un aviso a esta hora, solo los días que tengas rutina.';

  @override
  String get reminderExactTime => 'Hora exacta';

  @override
  String get toastSoundSetting => 'Sonido de los avisos';

  @override
  String get toastSoundHint => 'Un toque suave cuando sale un aviso arriba.';

  @override
  String get notifTrainChannel => 'Aviso para entrenar';

  @override
  String get notifTrainChannelWhy => 'Un toque para entrenar los días que has planeado.';

  @override
  String get notifTrainTitle => 'Toca entrenar';

  @override
  String get notifTrainBody => 'Tu rutina te está esperando.';

  @override
  String get planIntro => 'Hazme una rutina de entrenamiento usando solo los ejercicios de esta lista.';

  @override
  String get planFormat => 'Responde solo con JSON, con esta forma:';

  @override
  String get planNothing => 'Ningún ejercicio de ese archivo está en tu biblioteca';

  @override
  String get planFailed => 'Ese archivo no es una rutina que se pueda leer';

  @override
  String get routineGroup => 'Grupo';

  @override
  String get newGroup => 'Grupo nuevo';

  @override
  String get noGroup => 'Sin grupo';

  @override
  String get groupNameHint => 'Empuje / Tirón / Pierna, 5×5…';

  @override
  String get filters => 'Filtros';

  @override
  String get setsPlannedHint =>
      'Elige cuántas series quieres de cada uno. El entreno se abre con ellas puestas.';

  @override
  String get nextTime => 'SIGUIENTE';

  @override
  String get nextHold => 'el mismo peso hasta cumplir todas las repes';

  @override
  String get bgPhoto => 'Tu foto';

  @override
  String get bgPhotoPick => 'Elegir una foto';

  @override
  String get bgPhotoChange => 'Cambiar la foto';

  @override
  String get bgPhotoRemove => 'Quitar la foto';

  @override
  String get bgDim => 'CUÁNTO OSCURECE';

  @override
  String get dimSoft => 'Suave';

  @override
  String get dimMedium => 'Media';

  @override
  String get dimStrong => 'Fuerte';

  @override
  String get bgPhotoHint => 'Va detrás de todo, oscurecida para que la app se siga leyendo.';

  @override
  String get reminderSmart => 'Inteligente';

  @override
  String get reminderFixed => 'Hora fija';

  @override
  String get reminderSmartHint =>
      'Usa los días y la hora a los que sueles entrenar, y calla si ese día ya entrenaste.';

  @override
  String get reminderSmartEmpty => 'Entrena unas cuantas veces más y aprenderá tus días.';

  @override
  String habitFocus(String day) {
    return 'lo que sueles hacer los $day';
  }

  @override
  String get duplicateRoutine => 'Duplicar la rutina';

  @override
  String copySuffix(String name) {
    return '$name (copia)';
  }

  @override
  String get saveAsRoutine => 'GUARDAR COMO RUTINA';

  @override
  String get savedAsRoutine => 'Guardada como rutina';

  @override
  String get templates => 'Planes hechos';

  @override
  String get templatesHint =>
      'Programas clásicos, montados con tu propia biblioteca. Luego puedes cambiar lo que quieras.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rutinas añadidas',
      one: '$n rutina añadida',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Tres días de cuerpo entero a la semana. Por el que se empieza.';

  @override
  String get tplPpl => 'Empuje, tirón y pierna. Tres o seis días a la semana.';

  @override
  String get tplUpperlower => 'Tren superior e inferior, cuatro días a la semana.';

  @override
  String get tplStronglifts => 'Dos entrenos, cinco series de cinco, alternando.';

  @override
  String get tplStartingstrength => 'Sentadilla todos los días, dos entrenos que se alternan.';

  @override
  String get tplHome => 'Nada más que una barra de la que colgarse y el suelo.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n días', one: '$n día');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Anotar el esfuerzo (RPE)';

  @override
  String get rpeHint => '10 es no poder con una más; 8, que te sobraban dos.';

  @override
  String get superset => 'Superserie';

  @override
  String get supersetLink => 'Encadenar con el siguiente';

  @override
  String get supersetUnlink => 'Separar del siguiente';

  @override
  String get supersetHint => 'Sin descanso entre los ejercicios encadenados: pasas directo al siguiente.';

  @override
  String get aiRoutine => 'Rutina con IA';

  @override
  String get aiIntro =>
      'GymMane no habla con ninguna IA. Tú sacas tu lista de ejercicios, la pegas en el asistente que ya uses y traes su respuesta de vuelta. Del móvil no sale nada solo.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nombres no estaban en tu biblioteca',
      one: '1 nombre no estaba en tu biblioteca',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Qué apps lee';

  @override
  String get importOtherCsv => 'Cualquier otro CSV con fecha, ejercicio, repeticiones y peso';

  @override
  String get importAskApp => '¿Necesitas otra app? Pídemela';

  @override
  String get awardFirstStepName => 'Primer paso';

  @override
  String get awardFirstStepLine => 'Bienvenido a GymMane. Esta te la regala la casa.';

  @override
  String get awardFirstWorkoutName => 'Primer entreno';

  @override
  String get awardFirstWorkoutLine => 'El primero ya está guardado. Ese es el difícil.';

  @override
  String get awardFirstRoutineName => 'Primera rutina';

  @override
  String get awardFirstRoutineLine => 'Ya tienes un plan al que volver.';

  @override
  String get awardFirstRecordName => 'Primer récord';

  @override
  String get awardFirstRecordLine => 'Has superado tu mejor marca en un ejercicio.';

  @override
  String get awardStreak3Name => 'Tres seguidos';

  @override
  String get awardStreak3Line => 'Tres días seguidos. Así empieza todo.';

  @override
  String get awardTonne1Name => 'Una tonelada';

  @override
  String get awardTonne1Line => 'Mil kilos levantados entre todas tus series.';

  @override
  String get awardSets100Name => 'Cien series';

  @override
  String get awardSets100Line => 'Cien series completadas, una a una.';

  @override
  String get awardHours10Name => 'Diez horas';

  @override
  String get awardHours10Line => 'Diez horas de entreno con el cronómetro en marcha.';

  @override
  String get awardWorkouts50Name => 'Cincuenta entrenos';

  @override
  String get awardWorkouts50Line => 'Cincuenta sesiones a tus espaldas.';

  @override
  String get awardHours50Name => 'Cincuenta horas';

  @override
  String get awardHours50Line => 'Cincuenta horas dentro del gimnasio.';

  @override
  String get awardsTitle => 'Medallas';

  @override
  String get yearTitle => 'Tu año';

  @override
  String get yearBestMonth => 'Mejor mes';

  @override
  String get yearMonths => 'meses';

  @override
  String get awardSpinHint => 'Arrastra la medalla para girarla';

  @override
  String get awardUnlocked => 'Nuevo logro desbloqueado';

  @override
  String get awardNice => '¡Genial!';

  @override
  String get awardSaveImage => 'Guardar imagen';

  @override
  String get awardSaved => 'Guardada en tu galería';

  @override
  String get awardStreak7Name => 'Siete días';

  @override
  String get awardStreak7Line => 'Una semana entera sin fallar un día.';

  @override
  String get awardStreak30Name => 'Treinta días';

  @override
  String get awardStreak30Line => 'Un mes seguido. Esto ya es costumbre.';

  @override
  String get awardWorkouts100Name => 'Cien entrenos';

  @override
  String get awardWorkouts100Line => 'Cien sesiones registradas de principio a fin.';

  @override
  String get awardTonnes100Name => 'Cien toneladas';

  @override
  String get awardTonnes100Line => 'Todo lo que has levantado suma 100.000 kg.';

  @override
  String get awardSets1000Name => 'Mil series';

  @override
  String get awardSets1000Line => 'Serie a serie, hasta mil.';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get pickBadge => 'Insignia';

  @override
  String get statWorkouts => 'Entrenos';

  @override
  String get statTrained => 'Entrenado';

  @override
  String get statSets => 'Series';

  @override
  String get statLifted => 'Levantado';

  @override
  String get statStreak => 'Racha';

  @override
  String get statDays => 'días';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'días';

  @override
  String get snapshots => 'Fotos';

  @override
  String get snapNow => 'Hacer una';

  @override
  String get addCover => 'Pon una portada';

  @override
  String get addTodayWidget => 'Hoy: hecho o no';

  @override
  String get photosCard => 'Tus fotos';

  @override
  String get handleLabel => 'Nombre de usuario';

  @override
  String get setupTitle => 'Rellena esto y el resto de la página se llena sola';

  @override
  String get setupHint => 'Cada número de aquí sale de lo que registras. Nada se envía a ningún sitio.';

  @override
  String get setupWorkout => 'Registra tu primer entreno';

  @override
  String get setupWeight => 'Apunta tu peso';

  @override
  String get setupMeasures => 'Tómate las medidas';

  @override
  String get setupPhoto => 'Hazte la primera foto de progreso';

  @override
  String get progressTitle => 'Progreso';

  @override
  String get tileVolume30 => 'Volumen · 30d';

  @override
  String get tileAddWeight => 'Apúntalo';

  @override
  String get heatToneTitle => 'Color del mapa';

  @override
  String get heatToneHint => 'Solo cambia cómo se pintan la rejilla y el cuerpo.';

  @override
  String get thisWeekTitle => 'Esta semana';

  @override
  String get momentsEmptyTitle => 'Aquí no hay nada todavía';

  @override
  String get deletePhotoTitle => '¿Borrar esta foto?';

  @override
  String get deletePhotoBody => 'Se va para siempre.';

  @override
  String get awardsEarned => 'Conseguidas';

  @override
  String get awardsLocked => 'Por conseguir';

  @override
  String get awardStreak100Name => 'Cien días';

  @override
  String get awardWorkouts10Name => 'Diez entrenos';

  @override
  String get awardWorkouts10Line => 'Los diez primeros son los que deciden.';

  @override
  String get awardWorkouts365Name => 'Trescientos sesenta y cinco';

  @override
  String get awardWorkouts365Line => 'Un entreno por cada día del año, registrados uno a uno.';

  @override
  String get awardTonnes10Name => 'Diez toneladas';

  @override
  String get awardTonnes10Line => 'Diez mil kilos te han pasado por las manos.';

  @override
  String get awardHours100Name => 'Cien horas';

  @override
  String get awardHours100Line => 'Cien horas bajo la barra, cronómetro en mano.';

  @override
  String awardWonOn(String date) {
    return 'Conseguida el $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Dorada',
      'blue': 'Azul',
      'green': 'Verde',
      'other': 'Insignia',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Desde $date';
  }

  @override
  String levelShort(int n) {
    return 'Nivel $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n entrenos para el nivel $next',
      one: '1 entreno para el nivel $next',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n cm';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'Brasa',
      'green': 'Verde',
      'blue': 'Azul',
      'mono': 'Gris',
      'other': 'Color',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n series';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n de $goal esta semana';
  }

  @override
  String momentCount(int n) {
    return '$n fotos';
  }

  @override
  String photosSelected(int n) {
    return '$n seleccionadas';
  }

  @override
  String deletePhotosTitle(int n) {
    return '¿Borrar $n fotos?';
  }

  @override
  String get momentsEmptyHint =>
      'Hazle una foto al gimnasio, a la pizarra, a cómo cargaste la barra… lo que quieras recordar. Se quedan en el móvil y solo las ves tú.';

  @override
  String get awardStreak100Line => 'Cien días seguidos. Eso ya no es motivación, eres tú.';

  @override
  String get coverLabel => 'PORTADA';

  @override
  String get removeCover => 'Quitar portada';

  @override
  String get startTitle => 'Empezar entreno';

  @override
  String get logTitle => 'Apuntar un entreno';

  @override
  String get logHint => 'Sin cronómetro: solo rellenas lo que hiciste.';

  @override
  String get orStartFrom => 'O empieza por';

  @override
  String get pickExercisesOption => 'Elegir ejercicios';

  @override
  String get chooseFocusOption => 'Elegir por músculos';

  @override
  String get plannedRoutine => 'PREVISTA';

  @override
  String get logWorkoutAction => 'APUNTAR UN ENTRENO';

  @override
  String get logging => 'APUNTANDO';

  @override
  String get placesLabel => 'Mis sitios';

  @override
  String get undo => 'Deshacer';

  @override
  String get deleteSet => 'Borrar serie';

  @override
  String get setDeleted => 'Serie borrada';

  @override
  String get removeWarmup => 'Quitar calentamiento';

  @override
  String get addWeightAction => 'Añadir peso';

  @override
  String get workoutOverview => 'Este entreno';

  @override
  String get allExercisesShort => 'Todos';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total series';
  }

  @override
  String get nowLabel => 'Ahora';

  @override
  String get deleteWorkout => 'Borrar entreno';

  @override
  String get deleteWorkoutBody => 'Se borrará este entreno con todas sus series del historial.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Sigue al móvil';

  @override
  String get demoSizeTitle => 'Demo del ejercicio al entrenar';

  @override
  String get demoLarge => 'Grande';

  @override
  String get demoSmall => 'Pequeña';

  @override
  String get demoOff => 'Oculta';

  @override
  String get demoLoopTitle => 'Animación de la demo';

  @override
  String get demoLoopAlways => 'En bucle';

  @override
  String get demoLoopShort => '10 segundos';

  @override
  String get demoLoopHint =>
      'Se mueve unos 10 segundos y se queda en la postura inicial. Toca la demo para volver a verla.';

  @override
  String get alarmStyleTitle => 'Al acabar el descanso';

  @override
  String get alarmStyleLoud => 'Sonar siempre';

  @override
  String get alarmStyleQuiet => 'Respetar silencio';

  @override
  String get alarmStyleVibrate => 'Solo vibrar';

  @override
  String get alarmStyleHint =>
      '«Sonar siempre» usa el volumen de alarma, incluso en silencio. «Respetar el modo silencio» usa el de notificaciones y, si el móvil está silenciado, solo vibra.';

  @override
  String get suggestedPicks => 'Sugeridos para ti';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get suggestInWorkouts => 'Sugerir en entrenos rápidos';

  @override
  String get suggestInWorkoutsHint =>
      'Si lo apagas, no saldrá en lo que te proponemos. Podrás seguir añadiéndolo a mano.';

  @override
  String get onbPlaceTitle => '¿Dónde entrenas?';

  @override
  String get onbPlaceWhy =>
      'Marca todos los sitios donde entrenas. Solo te propondremos lo que puedas hacer en cada uno.';

  @override
  String get onbPlaceGear => '¿Qué tienes ahí?';

  @override
  String distanceCol(String unit) {
    return 'DISTANCIA ($unit)';
  }

  @override
  String get timeCol => 'TIEMPO';

  @override
  String get timePerSideCol => 'TIEMPO / LADO';

  @override
  String get timeMinutesTitle => 'Tiempo (minutos)';

  @override
  String get timeSecondsTitle => 'Tiempo (segundos)';

  @override
  String distanceTitle(String unit) {
    return 'Distancia ($unit)';
  }

  @override
  String get holdLabel => 'Aguanta';

  @override
  String get stopLabel => 'Parar';

  @override
  String startHold(String time) {
    return 'Empezar · $time';
  }

  @override
  String get exerciseTypeLabel => 'Se apunta por';

  @override
  String get typeReps => 'Repes y peso';

  @override
  String get typeTime => 'Tiempo';

  @override
  String get typeCardio => 'Distancia y tiempo';

  @override
  String get exerciseTypeHint =>
      'El cardio, como correr o nadar, apunta distancia y tiempo. Los isométricos, como la plancha, solo tiempo.';

  @override
  String get howToLabel => 'Cómo se hace (opcional)';

  @override
  String get howToHint => 'Un paso por línea';

  @override
  String get editExercise => 'Editar ejercicio';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get noStepsYet => 'Aún no hay pasos. Escribe los tuyos para acordarte de cómo lo haces.';

  @override
  String get addSteps => 'Escribir los pasos';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Una serie normal. Cuenta para tu volumen y tus récords.';

  @override
  String get setTypeWarmupInfo =>
      'Series ligeras para entrar en calor. No cuentan para el volumen ni para los récords.';

  @override
  String get setTypeDropInfo => 'Justo al acabar una serie, bajas el peso y sigues sin descansar.';

  @override
  String get setTypeFailureInfo =>
      'Sigues hasta que no sale otra repetición limpia. Apunta las que hiciste de verdad.';

  @override
  String get setTypeRestPauseInfo =>
      'Descansas de 10 a 20 segundos tras la serie y sacas unas pocas repeticiones más.';

  @override
  String get planFormatNotes =>
      'Usa los nombres de los ejercicios tal cual aparecen en la lista. \"sets\", \"reps\", \"weight\" (en la unidad indicada), \"rest\" en segundos y \"days\" son opcionales. \"superset\": true une un ejercicio con el siguiente. Para varias semanas, agrupa las rutinas dentro de \"weeks\" como en el segundo ejemplo.';

  @override
  String get planSets => 'Planificar series';

  @override
  String get planSetsHint =>
      'Elige el tipo, las repes y el peso de cada serie. Deja el peso en Auto para partir de tu última sesión.';

  @override
  String get planHintReps => 'Elige el tipo y las repes de cada serie. Auto parte de tu última sesión.';

  @override
  String get planHintTime => 'Elige el tipo y el tiempo de cada serie. Auto parte de tu última sesión.';

  @override
  String get planHintTimeWeight =>
      'Elige el tipo, el tiempo y el peso de cada serie. Auto parte de tu última sesión.';

  @override
  String get planHintCardio =>
      'Elige la distancia y el tiempo de cada serie. Auto parte de tu última sesión.';

  @override
  String get timeOnly => 'Solo tiempo';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Quitar el plan';

  @override
  String get shareRoutine => 'Compartir rutina';

  @override
  String get shareWeek => 'Compartir mi semana';

  @override
  String get shareWeekHint => 'Todas tus rutinas y el día de cada una.';

  @override
  String shareMessage(String name) {
    return '$name — abre el archivo con GymMane para añadirlo.';
  }

  @override
  String get importRoutines => 'Importar rutinas';

  @override
  String get importPasteHint =>
      'Pega aquí una rutina: una compartida desde GymMane, la respuesta de una IA, JSON o CSV.';

  @override
  String get pasteAction => 'Pegar';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rutinas', one: '1 rutina');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Usar también su plan semanal';

  @override
  String get useTheirScheduleHint => 'Los días que traiga sustituyen lo que tengas planificado en ellos.';

  @override
  String get addToMyRoutines => 'Añadir a mis rutinas';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rutinas añadidas',
      one: '1 rutina añadida',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Aquí no hay nada que GymMane pueda importar';

  @override
  String get aiStepCopy =>
      'Copia la petición. Lleva tu lista de ejercicios y el formato que GymMane entiende.';

  @override
  String get aiStepAsk =>
      'Pégala en cualquier IA y dile lo que quieres: días por semana, objetivo, cuántas semanas.';

  @override
  String get aiStepPaste => 'Pega su respuesta aquí abajo e impórtala. Sin crear ningún archivo.';

  @override
  String get copyForAi => 'Copiar para la IA';

  @override
  String get copiedDone => 'Copiado';

  @override
  String get aiPasteHint => 'Pega aquí la respuesta de la IA';

  @override
  String get importAction => 'Importar';

  @override
  String get showFormat => 'Ver el formato';

  @override
  String get shareAsFile => 'Compartir como archivo';

  @override
  String get recoveryTab => 'Recuperación';

  @override
  String recoveryOverall(int pct) {
    return 'Cuerpo recuperado al $pct%';
  }

  @override
  String get recoveryAllFresh => 'Todo está recuperado. Buen día para entrenar lo que quieras.';

  @override
  String recoveryStill(String muscles) {
    return 'Aún se recupera: $muscles';
  }

  @override
  String get recoveryTired => 'Fatigado';

  @override
  String get recoveryFresh => 'Fresco';

  @override
  String get recoveryHint =>
      'Toca un músculo para ver cuánto se ha recuperado. Las series recientes pesan más, y las más duras (por RPE), más aún.';

  @override
  String recoveryPct(int pct) {
    return '$pct% recuperado';
  }

  @override
  String readyInHours(int h) {
    return 'listo en ~$h h';
  }

  @override
  String get tplAbcd => 'Cuatro días: pecho y tríceps, espalda y bíceps, pierna, hombro y abdomen.';

  @override
  String get tplAbcde => 'Cinco días, un grupo cada uno: pecho, espalda, pierna, hombro y brazos.';

  @override
  String get elapsedCaps => 'TRANSCURRIDO';

  @override
  String get tapToChange => 'Toca para cambiar';

  @override
  String get swipeToSkipHint => 'Desliza el reloj a un lado para saltar el descanso.';

  @override
  String get screenLocked => 'Pantalla bloqueada';

  @override
  String get lockedHint => 'Mantén pulsada la huella de arriba para desbloquear';

  @override
  String get liveDoneSet => 'Serie hecha';

  @override
  String get liveSkipRest => 'Saltar descanso';

  @override
  String get livePause => 'Pausar';

  @override
  String get liveResume => 'Reanudar';

  @override
  String get liveNext => 'Siguiente';

  @override
  String liveUpNext(String name) {
    return 'Después: $name';
  }

  @override
  String get stickerOpen => 'Compartir en una foto';

  @override
  String get stickerNoPhoto => 'Sin foto';

  @override
  String get stickerWorkout => 'Entreno';

  @override
  String get stickerStreak => 'Racha';

  @override
  String get stickerDate => 'Fecha';

  @override
  String get stickerHint => 'Arrástrala para moverla y pellizca para cambiar su tamaño o girarla';

  @override
  String get stickerSaved => 'Guardada en tu galería';

  @override
  String get stickerWeek => 'Esta semana';

  @override
  String get getReady => 'Prepárate';

  @override
  String sideOfTwo(String n) {
    return 'Lado $n de 2';
  }

  @override
  String get switchSides => 'Cambia de lado';

  @override
  String get stickerGallery => 'Galería';

  @override
  String get stickerCamera => 'Cámara';

  @override
  String get shareIntroTitle => 'Comparte esta rutina';

  @override
  String get shareIntroBody =>
      'Mándasela a tu pareja, a un amigo o a tu familia. Les llega un archivo pequeño que se abre con GymMane y la añade de un toque, con sus series y pesos.';

  @override
  String get removedFromRoutine => 'Quitado de la rutina';

  @override
  String get radarTitle => 'Últimos 30 días';

  @override
  String get radarHint => 'Mira qué zonas necesitan más trabajo';

  @override
  String get radarEmpty => 'Entrena unos días para ver tu equilibrio';

  @override
  String get radarBalanced => 'Buen equilibrio por ahora';

  @override
  String radarFocus(String list) {
    return 'Necesita más: $list';
  }

  @override
  String get countdownReady => 'Prepárate';

  @override
  String get countdownSkip => 'Toca para empezar ya';

  @override
  String get countdownSetting => 'Cuenta atrás al empezar';

  @override
  String get effortSetting => 'Anotar el esfuerzo';

  @override
  String get effortHint =>
      'RPE: 10 es no poder con una más; 8, que te sobraban dos. RIR cuenta las repeticiones que te quedaban. Si la serie lo lleva, el 1RM estimado usa la tabla de RPE.';

  @override
  String get rirHint => '0 es no poder con una más; 2, que te sobraban dos.';

  @override
  String get addWeekWidget => 'Añadir widget de la semana';

  @override
  String get gamificationSetting => 'Medallas y niveles';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n reps', one: '$n rep');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Mejor serie';

  @override
  String get weekStartSetting => 'La semana empieza el';

  @override
  String get stepOutOfWorkout => 'Pausar y salir';

  @override
  String get saveToRoutine => 'GUARDAR CAMBIOS EN LA RUTINA';

  @override
  String get routineUpdated => 'Rutina actualizada';

  @override
  String saveChangesTitle(String name) {
    return '¿Guardar cambios en $name?';
  }

  @override
  String get saveChangesBody => 'La próxima vez que la empieces, la rutina tendrá estos cambios.';

  @override
  String get routineOrderChanged => 'Nuevo orden de ejercicios';

  @override
  String get mineOnly => 'Creados por ti';

  @override
  String createNamed(String name) {
    return '¿No está? Crear «$name»';
  }

  @override
  String get orStartWith => 'O empieza con';

  @override
  String get warmupFocus => 'Calentamiento';

  @override
  String get warmupFocusHint => 'Movilidad y activación, con o sin material';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Correr, bici, remo o comba, por distancia y tiempo';

  @override
  String get homeRecommended => 'Recomendados en inicio';

  @override
  String get homeRoutines => 'Rutinas en inicio';

  @override
  String get homeRoutinesHint => 'Tus rutinas, la última que hiciste primero. Toca una para empezarla.';

  @override
  String get homeWeekStats => 'Esta semana en inicio';

  @override
  String get homeWeekStatsHint => 'Volumen, series y récords de la semana.';

  @override
  String get stepsSetting => 'Pasos de Health Connect';

  @override
  String get stepsSettingHint => 'Muestra los pasos del día en Inicio. Nada sale del móvil.';

  @override
  String get stepsToday => 'Pasos hoy';

  @override
  String stepsOfGoal(String goal) {
    return 'de $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count pasos hoy';
  }

  @override
  String get stepsGoal => 'Objetivo de pasos diario';

  @override
  String get stepsNoAccess => 'Sin acceso a tus pasos';

  @override
  String get stepsGrant => 'Toca para permitirlo en Health Connect';

  @override
  String get stepsInfoRead => 'Solo lee tu número de pasos. Nunca lee nada más ni escribe en Health Connect.';

  @override
  String get stepsInfoLocal => 'Tus pasos se quedan en el móvil. GymMane nunca se conecta a internet.';

  @override
  String get stepsInfoOff => 'Puedes quitarlo cuando quieras, en Ajustes o en Health Connect.';

  @override
  String get stepsManage => 'Gestionar permiso';

  @override
  String get routineDoneToday => 'Hecha por hoy · buen trabajo';

  @override
  String get trainAgain => 'Entrenar otra vez';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Hace $n días',
      one: 'Hecha ayer',
      zero: 'Hecha hoy',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Archivados';

  @override
  String get archiveExercise => 'Archivar ejercicio';

  @override
  String get restoreExercise => 'Restaurar';

  @override
  String get archivedToast => 'Ejercicio archivado';

  @override
  String get archivedToastHint => 'Lo tienes en Ejercicios › Archivados';

  @override
  String get archivedBanner => 'Archivado. No sale en listas ni sugerencias; tu historial se conserva.';

  @override
  String get videoMarksHint => 'Pausa en un paso y toca la chincheta para saltar ahí la próxima vez.';

  @override
  String get videoMarkHere => 'Marcar este paso aquí';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionTraining => 'Entreno';

  @override
  String get sectionAlerts => 'Avisos y alarma';

  @override
  String get sectionHome => 'Inicio';

  @override
  String get sectionWidgets => 'Widgets';

  @override
  String get sectionData => 'Datos y copia de seguridad';

  @override
  String get multiPlanSetting => 'Varias rutinas al día';

  @override
  String get multiPlanHint => 'Toca cada rutina de este día. Van en el orden en que las añadas.';

  @override
  String routineOfDay(int n, int total) {
    return '$n de $total hoy';
  }

  @override
  String get nextToday => 'Siguiente hoy';

  @override
  String get planAboutMe => 'Sobre mí:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age años, $height de altura, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Quiero entrenar $n días a la semana.';
  }

  @override
  String get planNoHistory =>
      'Aún no he registrado entrenos: trátame como principiante y sé prudente con el volumen y los pesos.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n entrenos registrados en los últimos 30 días.',
      one: '1 entreno registrado en los últimos 30 días.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Mejores series recientes';

  @override
  String get planAskFirst =>
      'Si no sabes mi objetivo (fuerza, músculo, perder grasa o forma general) o cuánto puede durar cada sesión, pregúntamelo primero en un mensaje corto. Cuando lo tengas, responde solo con JSON.';

  @override
  String get backToTop => 'Volver arriba';

  @override
  String get deleteExerciseTitle => '¿Borrar este ejercicio?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" se quitará de tu biblioteca y de tus rutinas. Tus series anteriores se conservan.';
  }

  @override
  String get exportForStravaHint =>
      'Súbelo desde el navegador en strava.com/upload/select (la app de Strava no importa archivos). Aparece como Entrenamiento con pesas, con tus series.';

  @override
  String get manualStartTime => 'Hora de inicio';

  @override
  String get manualDuration => 'Duración';

  @override
  String get manualDurationUnset => 'Añadir duración';

  @override
  String get stravaRow => 'Exportar a Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Elige un entreno para llevarlo a Strava. Te llevas un archivo .fit: súbelo desde el navegador en strava.com/upload/select y aparece como Entrenamiento con pesas, con tus series.';

  @override
  String get stravaEmpty => 'Aún no hay entrenos para exportar.';

  @override
  String get tapToPause => 'Toca para pausar';

  @override
  String get holdPausedHint => 'En pausa · toca para seguir';

  @override
  String get finishHoldNow => 'Terminar la serie ya';

  @override
  String get barWeightExercise => 'Peso de la barra o carro';

  @override
  String get barWeightHint => 'Lo usa la calculadora de discos';

  @override
  String get barWeightCustom => 'Propio · toca para quitarlo';

  @override
  String get groupRename => 'Cambiar nombre';

  @override
  String get groupUngroup => 'Quitar el grupo, mantener rutinas';

  @override
  String get groupDeleteAll => 'Borrar grupo y rutinas';

  @override
  String groupDeleteTitle(String name) {
    return '¿Borrar «$name»?';
  }

  @override
  String groupDeleteBody(String count) {
    return 'Se borrarán $count. Tu historial de entrenos se mantiene.';
  }

  @override
  String get tplRr =>
      'El clásico de r/bodyweightfitness: cuerpo entero tres días a la semana. Sube un paso cuando te resulte fácil.';

  @override
  String get levelUpKicker => 'SIGUIENTE PASO';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps en $name dos entrenos seguidos. ¿Listo para el siguiente paso?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Cambiarlo en $routine';
  }

  @override
  String get levelUpSee => 'Ver cómo se hace';

  @override
  String get levelUpLater => 'Ahora no';

  @override
  String get levelUpStay => 'Me quedo con este';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name ya está en $routine';
  }

  @override
  String get levelUpStayed => 'No te sugeriremos subir en este';

  @override
  String get levelHintsSetting => 'Sugerir el siguiente paso';

  @override
  String get heatmapLabelsSetting => 'Días y meses en el mapa de actividad';

  @override
  String get rmPercent => 'PORCENTAJE';

  @override
  String rmAtPercent(String pct) {
    return '$pct de tu máximo';
  }

  @override
  String get copyWorkout => 'Copiar como texto';

  @override
  String get goalSet => 'Ponte un objetivo';

  @override
  String get goalTargetReps => 'REPETICIONES OBJETIVO';

  @override
  String goalToGo(String value) {
    return 'Te faltan $value';
  }

  @override
  String get goalReached => 'Objetivo conseguido';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Quedan $n días', one: 'Queda 1 día');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Se pasó la fecha';

  @override
  String get goalDeadline => 'FECHA LÍMITE';

  @override
  String get goalNoDeadline => 'Sin fecha';

  @override
  String get goalRemove => 'Quitar objetivo';

  @override
  String get exerciseNameMissing => 'Ponle un nombre';

  @override
  String get aliasesLabel => 'También se llama (opcional)';

  @override
  String get aliasesHint => 'Otros nombres, separados por comas';

  @override
  String alsoCalled(String names) {
    return 'También: $names';
  }

  @override
  String get addToRoutine => 'Añadir a rutina';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'En $n rutinas',
      one: 'En 1 rutina',
      zero: 'Aún no está en ninguna rutina',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Ya está dentro';

  @override
  String get restInRoutine => 'Descanso en esta rutina';

  @override
  String get restInRoutineHint => 'El mismo que el del ejercicio';

  @override
  String get restInRoutineReset => 'Solo aquí · toca para quitar';

  @override
  String get swapExercise => 'Cambiar ejercicio';

  @override
  String get swapShort => 'Cambiar';

  @override
  String swapHint(String name) {
    return 'En lugar de $name, solo hoy. Al terminar podrás dejarlo en la rutina.';
  }

  @override
  String get swapKeepsDone => 'Las series que ya hiciste se quedan; el nuevo sigue con las que faltan.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Mismo músculo · $muscle';
  }

  @override
  String get swapDoneBefore => 'Ya lo has hecho';

  @override
  String get multiPlanSettingHint => 'Más de una rutina el mismo día de la semana.';

  @override
  String get levelHintsHint => 'Cuando un ejercicio te queda fácil, te propone la versión más difícil.';

  @override
  String get focusCardHint => 'La rutina de hoy, arriba del todo en Inicio.';

  @override
  String get gamificationHint => 'Medallas, tu nivel y la celebración al terminar.';

  @override
  String get exerciseSettings => 'Ajustes de este ejercicio';

  @override
  String get placeActiveNow => 'Estás aquí';

  @override
  String get placeTapToUse => 'toca para entrenar aquí';

  @override
  String get intervalDays => 'días';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target días';
  }

  @override
  String get toolNameRpe => 'Peso por RPE';

  @override
  String get toolTitleRpe => 'Peso por RPE';

  @override
  String get toolDescRpe => 'Qué peso poner según el esfuerzo';

  @override
  String get toolNameDots => 'Nivel de fuerza';

  @override
  String get toolTitleDots => 'Nivel de fuerza (DOTS)';

  @override
  String get toolDescDots => 'Tu fuerza según tu peso';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Para $reps repes a RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Una serie que acabas de hacer';

  @override
  String get rpeGoal => 'Lo que quieres hacer';

  @override
  String rpeOneRmLine(String value) {
    return '1RM estimado: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 es no poder con una más; 8, que te sobraban dos.';

  @override
  String get dotsBestLifts => 'Tus mejores marcas';

  @override
  String get dotsSquat => 'SENTADILLA';

  @override
  String get dotsBench => 'PRESS DE BANCA';

  @override
  String get dotsDeadlift => 'PESO MUERTO';

  @override
  String dotsTotalLine(String value) {
    return 'Total: $value';
  }

  @override
  String get dotsExplain =>
      'Compara tu fuerza con la de cualquiera, pese lo que pese. Usa tu mejor marca a una repetición o tu 1RM estimado.';

  @override
  String get dotsLevel0 => 'Principiante';

  @override
  String get dotsLevel1 => 'Intermedio';

  @override
  String get dotsLevel2 => 'Avanzado';

  @override
  String get dotsLevel3 => 'Muy avanzado';

  @override
  String get dotsLevel4 => 'Élite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Puntuación Wilks';

  @override
  String get toolDescWilks => 'La puntuación clásica del powerlifting';

  @override
  String get wilksExplain =>
      'La fórmula clásica del powerlifting. DOTS la sustituyó en 2020, pero muchas competiciones y rankings la siguen usando.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Índice de masa magra';

  @override
  String get toolDescFfmi => 'Cuánto músculo para tu altura';

  @override
  String get ffmiBodyFat => 'GRASA CORPORAL';

  @override
  String ffmiLeanLine(String value) {
    return 'Masa magra: $value';
  }

  @override
  String get ffmiExplain =>
      'Como el IMC, pero sin la grasa: solo cuenta tu masa magra. Ajustado a tu altura para comparar igual a altos y bajos.';

  @override
  String get ffmiLevel0 => 'Por debajo de la media';

  @override
  String get ffmiLevel1 => 'En la media';

  @override
  String get ffmiLevel2 => 'Por encima de la media';

  @override
  String get ffmiLevel3 => 'Excelente';

  @override
  String get ffmiLevel4 => 'Excepcional';

  @override
  String get rpeEffortLabel => 'Esfuerzo (RPE)';

  @override
  String get restRowHint => 'Entre series, si el ejercicio no tiene el suyo.';

  @override
  String get effortRowHint => 'Anota RPE o RIR en cada serie.';

  @override
  String get countdownHint => '3, 2, 1 antes de la primera serie.';

  @override
  String get keepScreenOnHint => 'La pantalla no se apaga mientras entrenas.';

  @override
  String get demoSizeRowHint => 'El dibujo del ejercicio durante el entreno.';

  @override
  String get demoLoopRowHint => 'Si la animación se repite o se para.';

  @override
  String get trainReminderRowHint => 'Un aviso los días que te toca.';

  @override
  String get alarmSoundRowHint => 'Lo que suena al acabar el descanso.';

  @override
  String get alarmStyleRowHint => 'Si suena con el móvil en silencio.';

  @override
  String get recommendedRowHint => 'Ejercicios que te proponemos en Inicio.';

  @override
  String get weightStepSetting => 'Salto de peso';

  @override
  String get weightStepHint => 'Lo que suman los botones − y +.';

  @override
  String get prBestWorkout => 'Mejor entreno';

  @override
  String get mergeExercise => 'Fusionar';

  @override
  String mergeExerciseInto(String name) {
    return 'Fusionar $name con…';
  }

  @override
  String get mergeExerciseTitle => '¿Fusionar ejercicios?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Todo el historial de «$from» pasa a «$to». «$from» se queda en tu biblioteca. No se puede deshacer.';
  }

  @override
  String get mergedToast => 'Historial fusionado';

  @override
  String get nutrition => 'Nutrición';

  @override
  String get nutritionHomeEmpty => 'Agua, proteína y calorías';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g de proteína';
  }

  @override
  String get nutritionToday => 'Hoy';

  @override
  String get nutritionYesterday => 'Ayer';

  @override
  String get nutritionGoals => 'Objetivos diarios';

  @override
  String get kcalLabel => 'CALORÍAS';

  @override
  String get kcalOver => 'de más';

  @override
  String get waterLabel => 'AGUA';

  @override
  String get waterDone => 'Objetivo cumplido';

  @override
  String get waterCustom => 'Otra cantidad';

  @override
  String get glassSize => 'Tamaño del vaso';

  @override
  String get supplementsLabel => 'SUPLEMENTOS';

  @override
  String get supplementsEmpty => 'Toca uno para añadirlo o + para el tuyo.';

  @override
  String get addSupplement => 'Nuevo suplemento';

  @override
  String get supplementNameHint => 'Creatina, vitamina D…';

  @override
  String removeSupplementTitle(String name) {
    return '¿Quitar $name?';
  }

  @override
  String get removeSupplementBody => 'Se borran también los días que lo marcaste.';

  @override
  String get suppCreatine => 'Creatina';

  @override
  String get suppVitaminD => 'Vitamina D';

  @override
  String get suppOmega3 => 'Omega 3';

  @override
  String get suppMagnesium => 'Magnesio';

  @override
  String get suppMultivitamin => 'Multivitamínico';

  @override
  String get suppCaffeine => 'Cafeína';

  @override
  String get myFoods => 'Mis alimentos';

  @override
  String get newFood => 'Nuevo alimento';

  @override
  String get editFood => 'Editar alimento';

  @override
  String get foodNameHint => 'Proteína whey, avena, pan…';

  @override
  String get servingLabel => 'RACIÓN';

  @override
  String get servingHint => '1 cacito · 30 g';

  @override
  String get perServing => 'POR RACIÓN';

  @override
  String get servingsLabel => 'Raciones';

  @override
  String get foodPhotoHint => 'Sobre un fondo liso se convierte en pegatina.';

  @override
  String get cutoutWorking => 'Recortando…';

  @override
  String get cutoutTry => 'Recortar';

  @override
  String get cutoutKeep => 'Foto entera';

  @override
  String deleteFoodTitle(String name) {
    return '¿Borrar $name?';
  }

  @override
  String get deleteFoodBody => 'Desaparece de tus alimentos. Lo que ya apuntaste se queda.';

  @override
  String get mealBreakfast => 'Desayuno';

  @override
  String get mealLunch => 'Comida';

  @override
  String get mealDinner => 'Cena';

  @override
  String get mealSnacks => 'Picoteo';

  @override
  String get nothingLogged => 'Aún no has apuntado nada.';

  @override
  String addToMeal(String meal) {
    return 'Añadir a $meal';
  }

  @override
  String get quickAdd => 'Añadido rápido';

  @override
  String get quickAddHint => 'Solo los números, sin guardar ningún alimento.';

  @override
  String get quickAddName => '¿Qué era? (opcional)';

  @override
  String get logFood => 'Añadir';

  @override
  String loggedToast(String meal) {
    return 'Añadido a $meal';
  }

  @override
  String get entryRemoved => 'Quitado';

  @override
  String get goalsFromProfile => 'Calcular con mi perfil';

  @override
  String get goalsFromProfileHint =>
      'Calorías según tu perfil, 1,8 g de proteína y 35 ml de agua por kg de peso.';

  @override
  String get kcalEaten => 'Comido';

  @override
  String get kcalRemaining => 'Quedan';

  @override
  String waterTapHint(String amount) {
    return 'Toca el vaso: + $amount';
  }

  @override
  String get shakeEmpty => 'Toca para elegir tu batido';

  @override
  String shakeTapHint(String name) {
    return 'Toca: + $name';
  }

  @override
  String get shakePick => 'Tu batido';

  @override
  String get shakePickHint => 'Tocas el shaker y se apunta de una vez.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'H';

  @override
  String get fatLetter => 'G';

  @override
  String get addBurnedLabel => 'Sumar lo quemado';

  @override
  String get addBurnedHint =>
      'Tu objetivo ya cuenta tu actividad habitual. Actívalo solo si pusiste sedentario: suma lo que quema cada entreno por encima del reposo.';

  @override
  String get amountLabel => 'Cantidad';

  @override
  String amountIn(String unit) {
    return 'Cantidad ($unit)';
  }

  @override
  String get bodyweightLabel => 'Peso';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimentos copiados',
      one: '1 alimento copiado',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Lo que ya apuntaste se queda como está.';

  @override
  String get fiberLabel => 'Fibra';

  @override
  String get sugarLabel => 'Azúcar';

  @override
  String get sodiumLabel => 'Sodio';

  @override
  String get foodDatabase => 'Base de alimentos';

  @override
  String get kcalBurned => 'Quemado';

  @override
  String get mealOptions => 'Opciones de la comida';

  @override
  String get moreNutrients => 'Fibra, azúcar y sodio';

  @override
  String ofGoal(int goal, String unit) {
    return 'de $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'por 100 $unit';
  }

  @override
  String get perServingShort => 'por ración';

  @override
  String get foodCategory => 'CATEGORÍA';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unidades',
      one: '1 unidad',
    );
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lonchas',
      one: '1 loncha',
    );
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cacitos',
      one: '1 cacito',
    );
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cucharadas',
      one: '1 cucharada',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cucharaditas',
      one: '1 cucharadita',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tazas', one: '1 taza');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count vasos', one: '1 vaso');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Recientes';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimentos',
      one: '1 alimento',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Renombrar';

  @override
  String get repeatFrom => 'Repetir de';

  @override
  String get repeatNone => 'Aún no hay nada apuntado en esta comida otros días.';

  @override
  String get restDayGoals => 'Objetivos distintos en descanso';

  @override
  String get trainingDays => 'Días de entreno';

  @override
  String get restDays => 'Días de descanso';

  @override
  String get trainingDay => 'Día de entreno';

  @override
  String get saveAsMeal => 'Guardar como comida';

  @override
  String get savedMealNameHint => 'p. ej. Desayuno de siempre';

  @override
  String get savedMealToast => 'Comida guardada';

  @override
  String get savedMeals => 'Comidas guardadas';

  @override
  String get searchFoodsHint => 'Buscar alimentos';

  @override
  String get searchFoodsEmpty => 'Busca entre más de 500 alimentos con foto o crea los tuyos.';

  @override
  String searchFoodsNone(String query) {
    return 'Nada para «$query». Créalo como alimento tuyo.';
  }

  @override
  String get servingWeight => 'GRAMOS';

  @override
  String get weekAverage => 'Esta semana';

  @override
  String get weekAvgEnergy => 'Media al día';

  @override
  String get weekAvgProtein => 'Proteína al día';

  @override
  String get weekEnergyOnTarget => 'Calorías en objetivo';

  @override
  String get weekProteinOnTarget => 'Proteína en objetivo';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g de proteína al día';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met de $days días en objetivo';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días apuntados',
      one: '1 día apuntado',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Aún sin apuntar';

  @override
  String get weekOnTargetHint =>
      'En objetivo: calorías a menos de un 10 % del objetivo y al menos un 90 % de la proteína.';

  @override
  String get weightGoalLabel => 'Peso objetivo';

  @override
  String weightGoalTitle(String unit) {
    return 'Peso objetivo ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Objetivo $weight';
  }

  @override
  String get weightGoalNone => 'Mantén para poner objetivo';

  @override
  String get weightGoalReached => 'Objetivo alcanzado';

  @override
  String weightToLose(String weight) {
    return 'Faltan $weight por bajar';
  }

  @override
  String weightToGain(String weight) {
    return 'Faltan $weight por subir';
  }

  @override
  String get aminoHis => 'histidina';

  @override
  String get aminoIle => 'isoleucina';

  @override
  String get aminoLeu => 'leucina';

  @override
  String get aminoLys => 'lisina';

  @override
  String get aminoSaa => 'metionina';

  @override
  String get aminoAaa => 'fenilalanina';

  @override
  String get aminoThr => 'treonina';

  @override
  String get aminoTrp => 'triptófano';

  @override
  String get aminoVal => 'valina';

  @override
  String get animalProtein => 'Proteína animal';

  @override
  String get proteinQuality => 'Calidad de la proteína';

  @override
  String get qualityComplete => 'Completa';

  @override
  String get qualityAlmost => 'Casi completa';

  @override
  String get qualityIncomplete => 'Incompleta';

  @override
  String get qualityNoData => 'Sin datos aún';

  @override
  String get qualityNoDataHint => 'Apunta alimentos de la base para ver tus aminoácidos.';

  @override
  String get qualityAllCovered => 'Cubres los nueve aminoácidos esenciales.';

  @override
  String qualityLimiting(String amino) {
    return 'Te falta $amino. Combínalo con alimentos que la tengan.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Calculado con el $pct % de tu proteína: tus alimentos propios no traen aminoácidos.';
  }

  @override
  String get fatTypes => 'Tipos de grasa';

  @override
  String get fatSaturated => 'Saturadas';

  @override
  String get fatMono => 'Mono';

  @override
  String get fatPoly => 'Poli';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Saturadas $grams g de $limit g máx. (10 % de las calorías)';
  }

  @override
  String get sugarSodium => 'Azúcar y sodio';

  @override
  String get shakeCard => 'Batido de proteína';

  @override
  String get mealOther => 'Comida';

  @override
  String get mealAdd => 'Añadir comida';

  @override
  String get mealAddHint => 'p. ej. Preentreno';

  @override
  String get mealsOfDay => 'Comidas del día';

  @override
  String get mealsHint => 'Crea tantas como quieras. Si quitas una, lo apuntado pasa a la de arriba.';

  @override
  String get trackersTitle => 'Personalizar';

  @override
  String get trackersHint => 'Deja solo lo que quieras seguir.';

  @override
  String get trackersDaily => 'Resumen del día';

  @override
  String get trackersDetail => 'En detalle';

  @override
  String get trackersCards => 'Tarjetas';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Nuevo lote';

  @override
  String get prepNew => 'Nuevo lote';

  @override
  String get prepEdit => 'Editar lote';

  @override
  String get prepHint => 'Apunta la olla entera una vez y ve comiendo de ella.';

  @override
  String get prepEmpty =>
      '¿Cocinaste para varios días? Apúntalo una vez y luego di cuánto comes de lo que queda.';

  @override
  String get prepNameHint => 'p. ej. Pollo con arroz';

  @override
  String get prepDefaultName => 'Lote';

  @override
  String get prepIngredients => 'Ingredientes';

  @override
  String get prepAddIngredient => 'Añadir ingrediente';

  @override
  String get prepCookedWeight => 'PESO COCINADO';

  @override
  String prepCookedHint(String grams) {
    return 'Pesa la olla ya cocinada para que salga exacto. Si lo dejas vacío se usa el total en crudo ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Pon el peso cocinado: hay ingredientes sin gramos.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Quedan $left de $total';
  }

  @override
  String get prepOfWhatsLeft => '% de lo que queda';

  @override
  String get prepAll => 'Todo';

  @override
  String prepLogAmount(String grams) {
    return 'Apuntar $grams';
  }

  @override
  String get prepWeighLeft => 'Pesar lo que queda';

  @override
  String get prepFinished => 'Este lote se ha terminado.';

  @override
  String get approxValues => 'Aproximado';

  @override
  String get editValues => 'Editar valores';

  @override
  String get editValuesHint =>
      'Solo cambia esta entrada. Para corregir el alimento la próxima vez, edítalo desde Mis alimentos.';

  @override
  String get editLibraryHint => 'Se guarda como alimento tuyo, con la misma foto';

  @override
  String per100Line(String energy, String unit) {
    return '$energy por 100 $unit';
  }

  @override
  String get rawLabel => 'Crudo';

  @override
  String get cookedLabel => 'Cocido';

  @override
  String get rawHint => 'Peso antes de cocinar';

  @override
  String cookedHint(String factor) {
    return 'Peso ya cocinado (×$factor el peso en crudo)';
  }

  @override
  String get servingsUnit => 'raciones';

  @override
  String logAmount(String energy) {
    return 'Apuntar · $energy';
  }

  @override
  String get catFruit => 'Fruta';

  @override
  String get catVeg => 'Verdura';

  @override
  String get catMeat => 'Carne';

  @override
  String get catFish => 'Pescado';

  @override
  String get catEgg => 'Huevos';

  @override
  String get catDairy => 'Lácteos';

  @override
  String get catGrain => 'Cereales';

  @override
  String get catBakery => 'Pan';

  @override
  String get catLegume => 'Legumbres';

  @override
  String get catNut => 'Frutos secos';

  @override
  String get catOil => 'Aceites';

  @override
  String get catPantry => 'Despensa';

  @override
  String get catDrink => 'Bebidas';

  @override
  String get catSauce => 'Salsas';

  @override
  String get catSpice => 'Especias';

  @override
  String get searchFoodsPrompt => '¿Qué has comido?';

  @override
  String get shelfEmpty => 'Busca un alimento o hazle una foto al tuyo: aquí saldrán los que más apuntes.';

  @override
  String get repeatEntry => 'Repetir';

  @override
  String get notifSuppChannel => 'Suplementos';

  @override
  String get notifSuppChannelWhy => 'Aviso diario para tomar tus suplementos';

  @override
  String get energySplit => 'De dónde vienen las calorías';

  @override
  String get typicalServing => 'Ración típica';

  @override
  String cookedYieldLine(String factor) {
    return 'Pesa $factor veces lo que en crudo';
  }

  @override
  String get readyDishes => 'Platos';

  @override
  String weightLastLine(String weight) {
    return 'Última pesada $weight';
  }

  @override
  String get proteinAnimalShort => 'Animal';

  @override
  String get proteinPlantShort => 'Vegetal';

  @override
  String kcalFromMacros(String value) {
    return 'Estos macros suman unos $value';
  }

  @override
  String get useValue => 'Usar';

  @override
  String get suppRowHint => 'Toca para marcar · mantén para ver';

  @override
  String get suppPhoto => 'Foto';

  @override
  String get suppDose => 'Dosis';

  @override
  String get suppDoseHint => '5 g, 2 cápsulas…';

  @override
  String get suppRemind => 'Avisarme';

  @override
  String mealPlanDefault(int n) {
    return 'Plan $n';
  }

  @override
  String get mealPlansTitle => 'Planes de comida';

  @override
  String get mealPlanNew => 'Nuevo plan';

  @override
  String fromPlan(String name) {
    return 'Del plan $name';
  }

  @override
  String get logPlan => 'Apuntar';

  @override
  String get planFromDay => 'Copiar este día';

  @override
  String get planNewHint => 'Planea tus días como tus rutinas y luego apunta una comida entera de un toque.';

  @override
  String get planLogDay => 'Apuntar las comidas vacías';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n alimentos apuntados',
      one: '1 alimento apuntado',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Sin plan';

  @override
  String get planWeekHint => 'Toca un día para darle un plan.';

  @override
  String get planDuplicate => 'Duplicar';

  @override
  String planDeleteTitle(String name) {
    return '¿Borrar $name?';
  }

  @override
  String get planDeleteBody => 'Lo que ya apuntaste se queda como está.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Nutrición';

  @override
  String get nutritionBetaHint =>
      'Comidas, agua, proteína y suplementos. Aún en construcción: tus datos se quedan aunque lo apagues.';

  @override
  String get nutritionAboutTitle => 'Sobre Nutrición';

  @override
  String get nutritionAboutSub => 'Qué es y qué no será nunca.';

  @override
  String get nutritionAboutWhatTitle => 'Parte de tu entreno';

  @override
  String get nutritionAboutWhat =>
      'Una forma sencilla de apuntar comidas, agua, proteína y suplementos junto a tus entrenos. GymMane es ante todo una app de gimnasio: Nutrición está para que lo tengas todo en un mismo sitio, no para sustituir a una app de dietas.';

  @override
  String get nutritionAboutScanTitle => 'Sin escáner, nunca';

  @override
  String get nutritionAboutScan =>
      'Escanear un código de barras y que se rellene todo solo sería cómodo. Pero necesita internet y una base de datos enorme en línea, y lo que comes acaba en servidores ajenos. Esos datos dicen cuándo comes, qué comes y cómo cuidas tu cuerpo, y pueden usarse para publicidad o acabar en manos de grandes empresas. Por eso no hay escáner, ni lo habrá.';

  @override
  String get nutritionAboutLocalTitle => 'Todo en tu móvil';

  @override
  String get nutritionAboutLocal =>
      'La app trae más de 500 alimentos con foto. Puedes añadir los tuyos, cambiarles la foto y editar sus valores. Todo se queda en tu móvil, como el resto de GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Todavía en beta';

  @override
  String get nutritionAboutBeta =>
      'Si echas algo en falta, proponlo en GitHub. Eso sí, ni escáner ni una base de datos más grande: además de tu privacidad, haría la app mucho más pesada. ¿No necesitas Nutrición? Apágala en Ajustes y tus datos se quedan.';

  @override
  String get nutritionAboutSuggest => 'Proponer una idea';

  @override
  String get nutritionAboutOk => 'Entendido';

  @override
  String get planShare => 'Compartir';

  @override
  String get planImport => 'Importar un plan';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n planes importados',
      one: '1 plan importado',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'Ese archivo no trae planes de comida.';

  @override
  String get planMoveUp => 'Subir';

  @override
  String get planMoveDown => 'Bajar';

  @override
  String get cutoutEdit => 'Retocar recorte';

  @override
  String get cutoutEditHint =>
      'Desliza para borrar o recuperar. Toca una zona para quitarla o devolverla entera. Con dos dedos, zoom.';

  @override
  String get cutoutErase => 'Borrar';

  @override
  String get cutoutRestore => 'Recuperar';

  @override
  String get cutoutReset => 'Volver al automático';

  @override
  String get cutoutByHand => 'Recortar a mano';

  @override
  String notifSuppTitleFor(String names) {
    return 'Te toca: $names';
  }

  @override
  String get notifSuppTap => 'Márcalo en GymMane cuando lo tomes.';

  @override
  String get suppNoneToday => 'Hoy no te toca ninguno.';

  @override
  String get suppOtherDays => 'Otros días';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Cada $n días', one: 'Cada día');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Cada día';

  @override
  String suppFromDate(String date) {
    return 'desde el $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'hasta el $date';
  }

  @override
  String get suppSomeDays => 'Algunos días';

  @override
  String get suppEveryShort => 'Cada X días';

  @override
  String get suppWhen => 'Cuándo';

  @override
  String get suppEveryLead => 'Cada';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'días', one: 'día');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Empieza';

  @override
  String get suppEnds => 'Termina';

  @override
  String get suppTomorrow => 'Mañana';

  @override
  String get suppPickDate => 'Elegir fecha';

  @override
  String get suppNever => 'Nunca';

  @override
  String get suppOneWeek => 'En 1 semana';

  @override
  String get suppOneMonth => 'En 1 mes';

  @override
  String get planPickHint => 'Elige el plan de este día o crea uno nuevo.';

  @override
  String planSetForDay(String day) {
    return 'Plan puesto para el $day';
  }

  @override
  String get planSaved => 'Plan guardado';

  @override
  String get planDiscardTitle => '¿Descartar los cambios?';

  @override
  String get planDiscardBody => 'Lo que has cambiado no se guardará.';

  @override
  String get planDiscard => 'Descartar';

  @override
  String get planEdit => 'Editar plan';

  @override
  String get planNameHint => 'Nombre del plan';

  @override
  String get planDaysQuestion => '¿Qué días?';

  @override
  String get planDaysHint => 'Esos días saldrá en Nutrición para apuntarlo de un toque.';

  @override
  String get planDaysNone => 'Elige al menos un día o no saldrá en ningún sitio.';

  @override
  String get planNothingToLog => 'Esas comidas ya están apuntadas';

  @override
  String get planSave => 'Guardar plan';

  @override
  String get planToday => 'Plan de hoy';

  @override
  String get planLogRest => 'Apuntar el resto';

  @override
  String get dishNew => 'Crear mi plato';

  @override
  String get dishNewHint => 'Elige ingredientes y cantidades, guárdalo y apúntalo de un toque.';

  @override
  String get dishEdit => 'Editar plato';

  @override
  String get dishNameHint => 'Ej. Lentejas de mi madre';

  @override
  String get dishIngredients => 'Ingredientes';

  @override
  String get dishEmptyHint => 'Añade lo que lleva con la cantidad que sueles comer.';

  @override
  String get dishSave => 'Guardar plato';

  @override
  String get dishNeedsName => 'Ponle un nombre';

  @override
  String get dishNeedsItems => 'Añade al menos un ingrediente';

  @override
  String get suppHistory => 'Últimos 14 días';

  @override
  String suppTakenOf(int n, int total) {
    return '$n de $total tomados';
  }

  @override
  String get suppNoReminder => 'Sin aviso';

  @override
  String get suppMarkTaken => 'Marcar como tomado';

  @override
  String get suppUnmark => 'Desmarcar';

  @override
  String get suppEdit => 'Editar';

  @override
  String get mealMoveTo => 'Mover a';

  @override
  String get mealClear => 'Vaciar comida';

  @override
  String get mealCleared => 'Comida vaciada';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimentos movidos',
      one: '1 alimento movido',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Repetir el día entero';

  @override
  String createFoodNamed(String name) {
    return 'Crear «$name»';
  }

  @override
  String get entryDay => 'Día';

  @override
  String get movedToDay => 'Movido';

  @override
  String get favFoodsHint => 'Toca ☆ en un alimento';

  @override
  String get favFoodsEmpty => 'Toca la estrella de cualquier alimento para tenerlo aquí, a un toque.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comidas',
      one: '1 comida',
    );
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Guarda una comida desde su menú ••• o crea tu propio plato.';

  @override
  String get sugarLimitLabel => 'Tope de azúcar';

  @override
  String get sodiumLimitLabel => 'Tope de sodio';

  @override
  String get waterOptions => 'Opciones del agua';

  @override
  String get waterNone => 'Aún no has apuntado agua.';

  @override
  String get waterDailyGoal => 'Agua al día';

  @override
  String get trackersScreen => 'Pantalla';

  @override
  String get vesselMotion => 'Agua y batido en movimiento';

  @override
  String get vesselMotionHint =>
      'Apágalo si notas la pantalla lenta: los vasos se siguen llenando, solo dejan de moverse.';

  @override
  String get planFixedWeek => 'Semana fija';

  @override
  String get planRotation => 'Rotación';

  @override
  String get rotationTitle => 'ROTACIÓN';

  @override
  String get rotationHint => 'Te toca la siguiente de la lista, sea el día que sea.';

  @override
  String get rotationEmpty => 'Añade tus rutinas en el orden en que las harás: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done de $total hechas en esta vuelta';
  }

  @override
  String get rotationNext => 'Siguiente';

  @override
  String get rotationAdd => 'Añadir rutinas';

  @override
  String get rotationPickHint => 'Se añaden en el orden en que las tocas.';

  @override
  String get rotationSkip => 'Saltar a la siguiente';

  @override
  String get rotationRestart => 'Empezar vuelta nueva';

  @override
  String get rotationMakeNext => 'Que sea la siguiente';

  @override
  String get rotationRemove => 'Quitar de la rotación';

  @override
  String rotationPlace(int n, int total) {
    return '$n de $total de la rotación';
  }

  @override
  String get moveToDay => 'Mover a otro día';

  @override
  String get moveToDayHint => 'Solo esta vez; tu plan semanal no cambia.';

  @override
  String get movedToast => 'Entreno movido';

  @override
  String get backToPlan => 'Volver al plan semanal';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get untrainedTab => 'Sin entrenar';

  @override
  String get untrainedRecent => 'Reciente';

  @override
  String get untrainedLong => 'Hace mucho';

  @override
  String untrainedWaiting(String list) {
    return 'Llevan más tiempo esperando: $list';
  }

  @override
  String get untrainedAllRecent => 'Todos los músculos han trabajado esta semana. Bien.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Hace $n días',
      one: 'Entrenado ayer',
      zero: 'Entrenado hoy',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Aún sin entrenar';

  @override
  String get layoutSetting => 'Vista del entreno';

  @override
  String get layoutCards => 'Tarjetas';

  @override
  String get layoutList => 'Lista';

  @override
  String get layoutHint =>
      'Tarjetas enseña un ejercicio cada vez. Lista enseña todo el entreno en una pantalla, serie a serie.';

  @override
  String get layoutRowHint => 'Un ejercicio cada vez o todo el entreno en lista';

  @override
  String get previousCol => 'ANTERIOR';

  @override
  String get usePrevious => 'Usar lo de la última vez';

  @override
  String get skipShort => 'Saltar';

  @override
  String get moveUp => 'Subir';

  @override
  String get moveDown => 'Bajar';

  @override
  String get widgetNutritionOff => 'Activa Nutrición en Ajustes › Beta para usar este widget.';

  @override
  String get widgetPickShake => 'Elige tu batido';

  @override
  String get heatRangeSetting => 'Calendario de actividad';

  @override
  String get heatRangeWeeks => '12 semanas';

  @override
  String get heatRangeYear => '12 meses';

  @override
  String get heatRangeHint =>
      '12 meses enseña el año entero. Deslízalo de lado para ir hacia atrás, hasta tu primer entreno.';

  @override
  String get pdfPlan => 'Plan en PDF';

  @override
  String get pdfPlanHint => 'Una hoja limpia con tu semana y cada rutina, lista para imprimir o enviar.';

  @override
  String get pdfExport => 'Exportar en PDF';

  @override
  String get pdfFooter => 'Gratis, de código abierto y sin conexión';

  @override
  String get shakeTag => 'Es un batido';

  @override
  String get shakeTagHint => 'Sale en «Tu batido»';

  @override
  String get shakeNone => 'Marca tus batidos y aquí saldrán solo esos.';

  @override
  String get shakeMarkLabel => 'MARCAR COMO BATIDO';

  @override
  String get shakeNew => 'Nuevo batido';

  @override
  String get shakeUntag => 'No es un batido';

  @override
  String get pdfKicker => 'PLAN DE ENTRENAMIENTO';

  @override
  String get pdfStatDays => 'DÍAS / SEMANA';

  @override
  String get pdfStatMinutes => 'MIN / ENTRENO';

  @override
  String pdfMinutes(int n) {
    return '≈ $n min';
  }

  @override
  String get workoutNotesTitle => 'Notas del ejercicio';

  @override
  String get workoutNoteEvery => 'Siempre';

  @override
  String get workoutNoteNext => 'La próxima vez';

  @override
  String get workoutNoteEveryHint =>
      'Sale cada vez que haces este ejercicio. Ideal para la altura del asiento o la polea.';

  @override
  String get workoutNoteNextHint => 'Sale solo la próxima vez y luego desaparece.';

  @override
  String workoutNoteFromLast(String date) {
    return 'De la última vez · $date';
  }

  @override
  String get workoutNoteHint => 'Asiento en el agujero 2, polea a 19…';

  @override
  String get notePinWorkout => 'Ver durante el entreno';

  @override
  String get assistedSetting => 'Máquina asistida';

  @override
  String get assistedSettingHint =>
      'El peso te ayuda, así que menos es mejor: tus récords y sugerencias van a la baja.';

  @override
  String get assistedRecordHint => 'Menos ayuda';

  @override
  String get trainAgainLabel => '¿Aún no has entrenado? Recordar otra vez';

  @override
  String get trainAgainOff => 'No';

  @override
  String trainAgainAfter(int n) {
    return '+$n h';
  }

  @override
  String get trainAgainHint => 'Solo una vez, y solo si ese día no has apuntado ningún entreno.';

  @override
  String get notifTrainAgainBody => 'Todavía estás a tiempo de entrenar hoy.';

  @override
  String nextDeload(int n) {
    return 'más ligero: $n entrenos seguidos sin todas las repes';
  }

  @override
  String get historyTitle => 'Historial';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ENTRENOS', one: '1 ENTRENO');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Ningún entreno este mes';

  @override
  String get historyEmptyHint => 'Desliza de lado o usa las flechas para ver otros meses.';

  @override
  String historyMore(int n) {
    return '+$n más';
  }

  @override
  String get stopwatch => 'Cronómetro';

  @override
  String get proteinSource => 'Origen de la proteína';

  @override
  String get proteinMixedShort => 'Mixta';

  @override
  String get kcalActive => 'activas';

  @override
  String get kcalEstimated => 'estimado';

  @override
  String get kcalYours => 'tu valor';

  @override
  String kcalTotalRest(String value) {
    return '$value en total, contando lo que gastas en reposo';
  }

  @override
  String get inclineLabel => 'Inclinación';

  @override
  String get kcalUseOwn => 'Usar mi valor';

  @override
  String get kcalBackToEstimate => 'Volver al estimado';

  @override
  String get kcalNeedsData => 'Pon distancia y tiempo para estimar las calorías';

  @override
  String get kcalHowEstimated =>
      'Estimado con la distancia, el tiempo, la inclinación y tu peso (fórmula ACSM).';

  @override
  String get kcalOwnTitle => 'Calorías activas';

  @override
  String get planMine => 'Mi plan';

  @override
  String get planNew => 'Nuevo plan';

  @override
  String get planSaveWeek => 'Guardar esta semana';

  @override
  String get planSaveWeekHint => 'Guarda la semana actual como un plan al que volver';

  @override
  String get planEmptyWeek => 'Empezar una semana vacía';

  @override
  String get planEmptyWeekHint => 'Tu semana actual se queda guardada como plan';

  @override
  String get planName => 'Nombre del plan';

  @override
  String get planRename => 'Cambiar nombre';

  @override
  String get planDelete => 'Borrar plan';

  @override
  String get plansHint => 'Los cambios en la semana se guardan en el plan elegido';

  @override
  String get progression => 'Progresión';

  @override
  String get progManual => 'Manual';

  @override
  String get progManualHint => 'Sin sugerencias: tú eliges cada peso.';

  @override
  String get progLinear => 'Lineal';

  @override
  String get progLinearHint => 'Si cumples todas las repes, sube el peso.';

  @override
  String get progDouble => 'Doble progresión';

  @override
  String get progDoubleHint => 'Más repes hasta el tope del rango y luego más peso.';

  @override
  String get progVolume => 'Repes, series y peso';

  @override
  String get progVolumeHint => 'Repes hasta el tope, luego una serie más y luego más peso.';

  @override
  String get progAmrap => 'Última serie a tope';

  @override
  String get progAmrapHint =>
      'Última serie: todas las repes que puedas. Si doblas el objetivo, sube el doble.';

  @override
  String get progStep => 'Salto de peso';

  @override
  String get progRange => 'Rango de repes';

  @override
  String get progSets => 'Series';

  @override
  String get progDeload => 'Más ligero tras';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n fallos', one: '1 fallo');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Bajar un';

  @override
  String get progApply => 'Rellenar el siguiente entreno';

  @override
  String get progApplyHint => 'Apagado, solo sale como sugerencia.';

  @override
  String get nextMoreReps => 'mismo peso, una repe más';

  @override
  String get nextAddSet => 'una serie más';

  @override
  String get nextAmrap => 'última serie: todas las que puedas';

  @override
  String fillDay(String amount) {
    return 'Completa tu día · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Te quedarán $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Te quedarán $kcal y $grams g de proteína';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal por encima de tu objetivo';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit al día';
  }

  @override
  String get byZone => 'Por zona';

  @override
  String get importAlreadyHave => 'Ya tienes estas rutinas. Puedes añadirlas otra vez como copia.';

  @override
  String get importAsCopy => 'Añadir como copia';

  @override
  String get importOwned => 'Ya la tienes';

  @override
  String get setDuplicated => 'Serie duplicada';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Una serie partida en bloques pequeños con 15–30 segundos entre ellos. Apunta las repeticiones totales.';

  @override
  String timesBodyweight(String value) {
    return '$value× tu peso corporal';
  }

  @override
  String get archiveRoutine => 'Archivar rutina';

  @override
  String get routineArchived => 'Rutina archivada';

  @override
  String get archivedRoutines => 'Archivadas';

  @override
  String get autoBackup => 'Copia automática';

  @override
  String get autoBackupHint =>
      'Guarda un ZIP con todos tus datos en la carpeta que elijas. Sincroniza esa carpeta con Nextcloud, Syncthing o la app que uses para tener la copia fuera del móvil.';

  @override
  String get autoBackupFolder => 'Elegir carpeta';

  @override
  String get autoBackupNoFolder => 'Sin carpeta';

  @override
  String get autoBackupOff => 'Desactivada';

  @override
  String get autoBackupWorkout => 'Tras cada entreno';

  @override
  String get autoBackupDaily => 'Una vez al día';

  @override
  String get autoBackupWeekly => 'Una vez a la semana';

  @override
  String get autoBackupOnLeave => 'Al salir de la app';

  @override
  String get autoBackupKeep => 'Copias a guardar';

  @override
  String get autoBackupNow => 'Hacer copia ahora';

  @override
  String autoBackupLast(String when) {
    return 'Última copia $when';
  }

  @override
  String get autoBackupNever => 'Aún no hay copias';

  @override
  String get autoBackupLost => 'No se pudo guardar la última copia. Vuelve a elegir la carpeta.';

  @override
  String get autoBackupSaved => 'Copia guardada';

  @override
  String get prepPortions => 'Raciones';
}
