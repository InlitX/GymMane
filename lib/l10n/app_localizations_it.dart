// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get languageName => 'Italiano';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% rispetto al mese scorso';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Livello $level · $streak';
  }

  @override
  String get save => 'SALVA';

  @override
  String get cancel => 'Annulla';

  @override
  String get cancelCaps => 'ANNULLA';

  @override
  String get deleteCaps => 'ELIMINA';

  @override
  String get done => 'FATTO';

  @override
  String get set => 'Imposta';

  @override
  String get home => 'HOME';

  @override
  String get progress => 'PROGRESSI';

  @override
  String get exercises => 'ESERCIZI';

  @override
  String get settings => 'IMPOSTAZIONI';

  @override
  String get today => 'OGGI';

  @override
  String get thisWeek => 'QUESTA SETTIMANA';

  @override
  String get recommended => 'CONSIGLIATI';

  @override
  String get goal => 'OBIETTIVO';

  @override
  String get volume => 'VOLUME';

  @override
  String get setsToday => 'SERIE OGGI';

  @override
  String get prs => 'RECORD';

  @override
  String get todaysFocus => 'FOCUS DI OGGI';

  @override
  String get todaysRoutine => 'ROUTINE DI OGGI';

  @override
  String get startWorkout => 'INIZIA ALLENAMENTO';

  @override
  String get routines => 'ROUTINE';

  @override
  String get tools => 'STRUMENTI';

  @override
  String get firstSessionHint => 'Scegli i muscoli e registra la prima sessione';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n esercizi', one: '$n esercizio');
    return '$_temp0';
  }

  @override
  String get pushDay => 'GIORNO DI SPINTA';

  @override
  String get pullDay => 'GIORNO DI TRAZIONE';

  @override
  String get legDay => 'GIORNO GAMBE';

  @override
  String get pushFocus => 'Petto · Spalle · Tricipiti';

  @override
  String get pullFocus => 'Schiena · Bicipiti · Trapezi';

  @override
  String get legFocus => 'Quadricipiti · Femorali · Glutei';

  @override
  String get train => 'ALLENATI';

  @override
  String get step1 => 'PASSO 1 DI 2';

  @override
  String get step2 => 'PASSO 2 DI 2';

  @override
  String get chooseFocus => 'SCEGLI IL FOCUS';

  @override
  String get buildSession => 'CREA LA SESSIONE';

  @override
  String get tapMuscles => 'Tocca i muscoli da allenare — fronte e schiena.';

  @override
  String get continueBtn => 'CONTINUA';

  @override
  String get nothingForFocus => 'Niente per questo focus, per ora';

  @override
  String get goBackPick => 'Torna indietro e scegli un muscolo con esercizi nella libreria.';

  @override
  String pickedHint(int n) {
    return 'Ti abbiamo preparato una sessione — tocca per aggiungere o togliere uno dei $n.';
  }

  @override
  String get pickAnExercise => 'SCEGLI UN ESERCIZIO';

  @override
  String get searchAllExercises => 'Cerca un esercizio…';

  @override
  String get noExercisesMatch => 'Nessun esercizio trovato';

  @override
  String get createItInstead => 'Crealo come esercizio personale';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ESERCIZI', one: '$n ESERCIZIO');
    return 'INIZIA · $_temp0';
  }

  @override
  String get inProgress => 'IN CORSO';

  @override
  String get paused => 'IN PAUSA';

  @override
  String get last => 'ULTIMO';

  @override
  String get rest => 'RIPOSO';

  @override
  String get skip => 'SALTA';

  @override
  String get addSet => '+ AGGIUNGI SERIE';

  @override
  String get finishSession => 'TERMINA SESSIONE';

  @override
  String get setDone => 'SERIE FATTA';

  @override
  String get nextExercise => 'PROSSIMO ESERCIZIO';

  @override
  String get dropExerciseAction => 'Togli l\'esercizio';

  @override
  String get restOff => 'Spento';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'REPS';

  @override
  String weightCol(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get repsTitle => 'RIPETIZIONI';

  @override
  String weightTitle(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get sessionComplete => 'ALLENAMENTO REGISTRATO';

  @override
  String get finishHeadlinePr => 'Nuovo record personale';

  @override
  String get finishHeadlineGoal => 'Obiettivo settimanale raggiunto';

  @override
  String get finishHeadlineStreak => 'Serie attiva';

  @override
  String get finishHeadlineDefault => 'Un altro in cascina';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs esercizi',
      one: 'un esercizio',
    );
    return 'Hai sollevato più che mai in $_temp0. Ora è nei tuoi record.';
  }

  @override
  String get finishBodyGoal => 'Hai fatto le sessioni che ti eri prefissato questa settimana.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak giorni di fila. La parte difficile è non fermarsi.';
  }

  @override
  String get finishBodyDefault => 'Registrato e contato. La costanza è ciò che fa muovere i numeri.';

  @override
  String get vsLastTime => 'RISPETTO ALL\'ULTIMA VOLTA';

  @override
  String get firstTime => 'Prima volta registrata';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nuovi record',
      one: '$n nuovo record',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'DURATA';

  @override
  String get setsCaps => 'SERIE';

  @override
  String exerciseXofY(int i, int n) {
    return 'ESERCIZIO $i DI $n';
  }

  @override
  String get decrease => 'Riduci';

  @override
  String get increase => 'Aumenta';

  @override
  String markSet(int n) {
    return 'Segna la serie $n come fatta';
  }

  @override
  String get pauseWorkout => 'Metti in pausa l\'allenamento';

  @override
  String get resumeWorkout => 'Riprendi l\'allenamento';

  @override
  String get discardTitle => 'Scartare l\'allenamento?';

  @override
  String get discardBody => 'Le serie di questa sessione andranno perse.';

  @override
  String get keepTraining => 'Continua ad allenarti';

  @override
  String get discard => 'Scarta';

  @override
  String get notifRestChannel => 'Timer di recupero';

  @override
  String get notifRestChannelWhy => 'Ti avvisa quando il recupero tra le serie è finito';

  @override
  String get notifAlertChannel => 'Timer di recupero (avviso)';

  @override
  String get notifAlertChannelWhy => 'Mostra un avviso appena finisce il recupero';

  @override
  String get restOverTitle => 'Recupero finito';

  @override
  String get restOverBody => 'Dacci dentro — la prossima serie ti aspetta.';

  @override
  String get allTimeSessions => 'SESSIONI';

  @override
  String get allTimeTime => 'TEMPO';

  @override
  String get allTimeSets => 'SERIE';

  @override
  String get consistency => 'COSTANZA';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessioni registrate',
      one: '$n sessione registrata',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'giorni', one: 'giorno');
    return 'serie di $n $_temp0';
  }

  @override
  String get bodyweight => 'PESO CORPOREO';

  @override
  String get logBodyweight => 'REGISTRA PESO';

  @override
  String get trackWeight => 'Monitora il tuo peso nel tempo';

  @override
  String get muscleMap => 'MAPPA MUSCOLARE';

  @override
  String get days7 => '7G';

  @override
  String get days30 => '30G';

  @override
  String get heatLow => 'Non toccato';

  @override
  String get heatHigh => 'Volume pieno';

  @override
  String get muscleMapEmpty => 'Registra una sessione e il tuo corpo si illumina qui.';

  @override
  String get muscleMapHint => 'Tocca un muscolo per vedere come ha lavorato.';

  @override
  String muscleMapBehind(String names) {
    return 'Stai trascurando: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% dell\'obiettivo';
  }

  @override
  String get muscleSplit => 'DISTRIBUZIONE MUSCOLARE';

  @override
  String get personalRecords => 'RECORD PERSONALI';

  @override
  String get strength1rm => 'FORZA · MASSIMALE STIMATO';

  @override
  String get strengthEmpty => 'Registra un esercizio due volte e qui vedrai la sua curva di forza.';

  @override
  String oneRmEst(String w) {
    return 'Massimale stim. $w';
  }

  @override
  String get restDayShort => 'Riposo';

  @override
  String get restDay => 'Giorno di riposo — niente registrato.';

  @override
  String get delete => 'Elimina';

  @override
  String get deleteEntry => 'Eliminare questa voce?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" verrà rimosso da questo giorno, dai record e dai grafici.';
  }

  @override
  String get bodyweightHistory => 'STORICO';

  @override
  String get exercisesCaps => 'ESERCIZI';

  @override
  String get timeCaps => 'TEMPO';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n esercizi nella libreria',
      one: '$n esercizio nella libreria',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Cerca esercizi';

  @override
  String get muscleFilter => 'MUSCOLO';

  @override
  String get levelFilter => 'LIVELLO';

  @override
  String get kindLabel => 'TIPO';

  @override
  String get kindStrength => 'Forza';

  @override
  String get kindCalisthenics => 'Calisthenics';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Stretching';

  @override
  String get newExercise => 'NUOVO ESERCIZIO';

  @override
  String get exerciseName => 'Nome esercizio';

  @override
  String get equipmentLabel => 'ATTREZZATURA';

  @override
  String get addExercise => 'AGGIUNGI ESERCIZIO';

  @override
  String get advanced => 'AVANZATO';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Aggiungi media';

  @override
  String get mediaHint => 'Immagine, GIF o video';

  @override
  String get changeMedia => 'Cambia';

  @override
  String get videoSelected => 'Video selezionato';

  @override
  String get favouritesOnly => 'Preferiti';

  @override
  String get noFavouritesYet => 'Nessun preferito, per ora';

  @override
  String get noFavouritesHint => 'Tocca la stella di un esercizio per tenerlo qui.';

  @override
  String get clearFilters => 'Cancella filtri';

  @override
  String get noExercisesFound => 'Nessun esercizio trovato';

  @override
  String get noExercisesHint => 'Prova un\'altra ricerca o cancella i filtri.';

  @override
  String get personalRecord => 'RECORD PERSONALE';

  @override
  String get history => 'STORICO';

  @override
  String get noHistory => 'Nessuna sessione registrata. Allena questo esercizio per creare lo storico.';

  @override
  String get notes => 'NOTE';

  @override
  String get notePlaceholder => 'Spunti, setup, come è andata…';

  @override
  String notHere(String gear, String place) {
    return 'Niente $gear in $place';
  }

  @override
  String get notHereWhy => 'Sostituiscilo con qualcosa che puoi caricare oggi.';

  @override
  String get altHere => 'COSA PUOI FARE QUI';

  @override
  String get places => 'I MIEI POSTI';

  @override
  String get placesHint => 'Dì cosa hai in ogni posto e la libreria mostra solo ciò che puoi fare lì.';

  @override
  String get placeAll => 'Ovunque';

  @override
  String get placeNew => 'Nuovo posto';

  @override
  String get placeNamePlaceholder => 'Casa, palestra, parco…';

  @override
  String get placeGearLabel => 'COSA C\'È LÌ';

  @override
  String placeExercises(int n) {
    return '$n esercizi qui';
  }

  @override
  String get placeEmptyTitle => 'Allenati dove sei';

  @override
  String get placeEmptyBody =>
      'Un posto è la lista degli attrezzi che hai lì. Scegline uno per iniziare e modificalo dopo.';

  @override
  String get placeDeleteTitle => 'Elimina posto';

  @override
  String get placeDeleteBody => 'Va via solo il posto — esercizi e sessioni restano.';

  @override
  String get placeGym => 'Palestra';

  @override
  String get placeHome => 'Casa';

  @override
  String get placeOutdoors => 'All\'aperto';

  @override
  String get placeFilterLabel => 'POSTO';

  @override
  String get noGearOnly => 'Senza attrezzi';

  @override
  String placeActive(String name) {
    return 'Ti alleni in $name';
  }

  @override
  String get journal => 'DIARIO';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n note',
      one: '1 nota',
      zero: 'Nessuna nota',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Nota';

  @override
  String get noteKindPlan => 'Piano';

  @override
  String get noteKindDone => 'Traguardo';

  @override
  String get noteKindPain => 'Fastidio';

  @override
  String get noteFilterAll => 'Tutte';

  @override
  String get newNote => 'Nuova nota';

  @override
  String get editNote => 'Modifica nota';

  @override
  String get addNote => 'AGGIUNGI NOTA';

  @override
  String get noteEmptyTitle => 'Non hai ancora scritto niente';

  @override
  String get noteEmptyBody =>
      'Spunti, piani per la prossima volta, come è andata — con foto o video se vuoi.';

  @override
  String get noteNoneForExercise => 'Nessuna nota su questo esercizio, per ora.';

  @override
  String get noteKindLabel => 'TIPO';

  @override
  String get noteTextLabel => 'NOTA';

  @override
  String get noteDateLabel => 'DATA';

  @override
  String get noteExerciseLabel => 'ESERCIZIO';

  @override
  String get noteMediaLabel => 'FOTO E VIDEO';

  @override
  String get noteGeneral => 'Nessun esercizio';

  @override
  String get noteAttach => 'Allega';

  @override
  String get noteRemoveMedia => 'Rimuovi allegato';

  @override
  String get deleteNoteTitle => 'Elimina nota';

  @override
  String get deleteNoteBody => 'La nota e i suoi allegati vanno via per sempre.';

  @override
  String get noteToday => 'Oggi';

  @override
  String get noteYesterday => 'Ieri';

  @override
  String get noteAllNotes => 'Tutte le note';

  @override
  String get noteCalendar => 'Calendario';

  @override
  String get noteNoneOnDay => 'Niente scritto in questo giorno';

  @override
  String get noteAddOnDay => 'Nota in questo giorno';

  @override
  String get notePrevMonth => 'Mese precedente';

  @override
  String get noteNextMonth => 'Mese successivo';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n note questo mese',
      one: '1 nota questo mese',
      zero: 'Nessuna nota questo mese',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MISURE';

  @override
  String get measuresHint => 'Dal collo al polpaccio — guarda come cambia il corpo, non solo il bilanciere.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rilevazioni',
      one: '1 rilevazione',
      zero: 'Niente registrato',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Non ancora registrato';

  @override
  String get measureHistory => 'STORICO';

  @override
  String get measureNeck => 'Collo';

  @override
  String get measureShoulders => 'Spalle';

  @override
  String get measureChest => 'Petto';

  @override
  String get measureArm => 'Braccio';

  @override
  String get measureForearm => 'Avambraccio';

  @override
  String get measureWaist => 'Vita';

  @override
  String get measureHips => 'Fianchi';

  @override
  String get measureThigh => 'Coscia';

  @override
  String get measureCalf => 'Polpaccio';

  @override
  String get measureBodyfat => 'Massa grassa';

  @override
  String get timeline => 'PROGRESSI FOTO';

  @override
  String get timelineHint => 'Stessa posa, stesso posto, stessa luce. Tra un anno non ci crederai.';

  @override
  String get timelineEmptyTitle => 'La prima foto fa partire il cronometro';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foto',
      one: '1 foto',
      zero: 'Nessuna foto',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Fronte';

  @override
  String get poseSide => 'Lato';

  @override
  String get poseBack => 'Schiena';

  @override
  String get photoEvery => 'RICORDAMELO';

  @override
  String photoEveryDays(int n) {
    return 'Ogni $n giorni';
  }

  @override
  String get photoEveryOff => 'Mai';

  @override
  String get timelineEvery => 'RAGGRUPPA OGNI';

  @override
  String get custom => 'Altro';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Prossima foto tra $n giorni',
      one: 'Prossima foto domani',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Foto in scadenza — falla oggi';

  @override
  String get addTodayPhotos => 'AGGIUNGI LE FOTO DI OGGI';

  @override
  String posePhoto(String pose) {
    return 'Foto $pose';
  }

  @override
  String get compare => 'CONFRONTA';

  @override
  String get compareNeedTwo => 'Scatta la stessa posa in due giorni diversi e potrai confrontarle qui.';

  @override
  String dayNumber(int n) {
    return 'Giorno $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n giorni di differenza',
      one: '1 giorno di differenza',
      zero: 'Stesso giorno',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Elimina questo giorno';

  @override
  String get deleteDayBody => 'Le sue foto vanno via con lui, per sempre.';

  @override
  String get timelinePhotos => 'Foto';

  @override
  String get timelineBody => 'Mappa muscolare';

  @override
  String get timelineBodyEmpty =>
      'Registra una sessione e la mappa muscolare inizia a riempirsi qui, senza foto.';

  @override
  String get timelineBodyHint => 'Nata dalle tue serie — niente da caricare.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessioni',
      one: '1 sessione',
      zero: 'Nessuna sessione',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Foto di progresso';

  @override
  String get notifPhotoChannelWhy => 'Un promemoria quando è ora della prossima foto.';

  @override
  String get notifPhotoTitle => 'Ora della foto di progresso';

  @override
  String notifPhotoBody(int n) {
    return '$n giorni dall\'ultima. Stessa posa, stessa luce.';
  }

  @override
  String get share => 'CONDIVIDI';

  @override
  String get sharePick => 'Cosa vuoi mostrare?';

  @override
  String get shareStreak => 'Serie e costanza';

  @override
  String get shareBody => 'Muscoli allenati';

  @override
  String get shareCompare => 'Prima e dopo';

  @override
  String get shareHint => 'La scheda nasce sul tuo telefono. Niente esce finché non scegli tu dove mandarla.';

  @override
  String get shareFailed => 'La scheda non si è potuta creare';

  @override
  String get shareWeekOf => 'ULTIMI 7 GIORNI';

  @override
  String get shareStreakLabel => 'GIORNI DI FILA';

  @override
  String get shareSessionsLabel => 'SESSIONI';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get restForExercise => 'RECUPERO DI QUESTO ESERCIZIO';

  @override
  String get restUsingDefault => 'Usa il tuo predefinito';

  @override
  String get restCustom => 'Solo per questo';

  @override
  String get setType => 'TIPO DI SERIE';

  @override
  String get setTypeNormal => 'Allenante';

  @override
  String get setTypeWarmup => 'Riscaldamento';

  @override
  String get setTypeDrop => 'Stripping';

  @override
  String get setTypeFailure => 'A cedimento';

  @override
  String get addWarmup => 'RISCALDAMENTO';

  @override
  String platesPerSide(String plates) {
    return 'Per lato: $plates';
  }

  @override
  String get howTo => 'COME SI FA';

  @override
  String get similar => 'SIMILI';

  @override
  String get primaryLabel => 'PRINCIPALE';

  @override
  String get secondaryLabel => 'SECONDARI';

  @override
  String get none => 'Nessuno';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n serie', one: '$n serie');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v di volume';
  }

  @override
  String get weeklyPlan => 'PIANO SETTIMANALE';

  @override
  String get yourRoutines => 'LE TUE ROUTINE';

  @override
  String get noRoutines => 'Nessuna routine, per ora. Creane una e aggiungi gli esercizi.';

  @override
  String get newRoutine => 'NUOVA ROUTINE';

  @override
  String get routineName => 'Nome routine';

  @override
  String get schedule => 'PROGRAMMA';

  @override
  String get addFromList => 'Aggiungi esercizi dalla lista qui sotto.';

  @override
  String get addExercises => 'Aggiungi esercizi';

  @override
  String get deleteRoutine => 'Eliminare questa routine?';

  @override
  String exercisesWithCount(int n) {
    return 'ESERCIZI · $n';
  }

  @override
  String setDay(String day) {
    return 'IMPOSTA $day';
  }

  @override
  String get newRoutineName => 'Nuova routine';

  @override
  String get dragToReorder => 'Trascina la maniglia a puntini per riordinare: è l’ordine in cui ti alleni.';

  @override
  String reorderHandle(String name) {
    return 'Riordina $name';
  }

  @override
  String get removeFromRoutine => 'Rimuovi dalla routine';

  @override
  String get dropExercise => 'Togliere questo esercizio?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" esce da questo allenamento. Niente di registrato va perso.';
  }

  @override
  String get drop => 'Togli';

  @override
  String get resetData => 'Elimina tutti i miei dati';

  @override
  String get resetTitle => 'Eliminare tutto?';

  @override
  String get resetBody =>
      'Sessioni, record, routine, note e profilo. Non si può annullare — esporta prima un backup se pensi di volerlo.';

  @override
  String get resetConfirm => 'Elimina tutto';

  @override
  String get resetDone => 'Tutti i dati eliminati';

  @override
  String get support => 'SUPPORTO';

  @override
  String get reportBug => 'Segnala un bug';

  @override
  String get requestFeature => 'Richiedi una funzione';

  @override
  String get starOnGithub => 'Metti una stella su GitHub';

  @override
  String get buyCoffee => 'Offrimi un caffè';

  @override
  String get cantOpenLink => 'Impossibile aprire il link';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Scuro';

  @override
  String get lightTheme => 'Chiaro';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get unitsLabel => 'Unità';

  @override
  String get restTimer => 'Recupero';

  @override
  String get alarmBlockedTitle => 'Le notifiche sono spente';

  @override
  String get alarmBlockedBody => 'L\'allarme di recupero non suonerà a schermo bloccato';

  @override
  String get alarmBlockedAction => 'ATTIVA';

  @override
  String get alarmSound => 'Suono allarme';

  @override
  String get alarmDefaultName => 'Predefinito';

  @override
  String get alarmSoundHint => 'Usa il tuo — fino a 15 secondi';

  @override
  String get alarmChoose => 'Scegli un suono…';

  @override
  String get alarmPreview => 'Ascolta il suono attuale';

  @override
  String get alarmReset => 'Torna al predefinito';

  @override
  String get alarmTooLong => 'Quel suono dura più di 15 secondi';

  @override
  String get alarmInvalid => 'Impossibile leggere quel file audio';

  @override
  String alarmChanged(String name) {
    return 'Suono impostato su \"$name\"';
  }

  @override
  String get alarmChangedDefault => 'Tornato al suono predefinito';

  @override
  String get addActivityWidget => 'Aggiungi widget attività';

  @override
  String get addStatsWidget => 'Aggiungi widget statistiche';

  @override
  String get pinUnsupported => 'Aggiungilo dal menu widget del tuo launcher';

  @override
  String get background => 'Sfondo';

  @override
  String get bgNone => 'Nessuno';

  @override
  String get bgDots => 'Puntini';

  @override
  String get bgGrid => 'Griglia';

  @override
  String get exportCsv => 'Esporta allenamenti (CSV)';

  @override
  String get exportBackup => 'Esporta backup (ZIP)';

  @override
  String get importBackup => 'Importa backup';

  @override
  String get importHint =>
      'Scegli un backup .zip (o il vecchio .json) esportato da GymMane. Sostituirà i dati attuali, media inclusi.';

  @override
  String get import => 'Importa';

  @override
  String get chooseFile => 'Scegli file';

  @override
  String get importFromApp => 'Importa da un\'altra app';

  @override
  String get importUnknownFormat => 'Quel file non è un export di Hevy, Strong o FitNotes';

  @override
  String get importZipNoWeights => 'Quello zip non contiene file di peso';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pesate importate',
      one: '$n pesata importata',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Impossibile leggere quel file';

  @override
  String get importUnitTitle => 'In che unità è quel file?';

  @override
  String get importUnitBody => 'Questo export non dice in che unità sono i pesi.';

  @override
  String get importNothing => 'Niente di nuovo da importare';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessioni importate',
      one: '$n sessione importata',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Su GymMane';

  @override
  String get yourProfile => 'IL TUO PROFILO';

  @override
  String get autofills => 'Compila in automatico le calcolatrici';

  @override
  String get nameLabel => 'NOME';

  @override
  String get sexLabel => 'SESSO';

  @override
  String get macroProtein => 'PROTEINE';

  @override
  String get macroCarbs => 'CARBOIDRATI';

  @override
  String get macroFat => 'GRASSI';

  @override
  String get male => 'Uomo';

  @override
  String get female => 'Donna';

  @override
  String get ageLabel => 'ETÀ';

  @override
  String get heightLabel => 'ALTEZZA';

  @override
  String get weightLabel => 'PESO';

  @override
  String get weeklyGoal => 'OBIETTIVO SETTIMANALE';

  @override
  String get activityLabel => 'ATTIVITÀ';

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String get removePhoto => 'Rimuovi foto';

  @override
  String get takePhoto => 'Scatta una foto';

  @override
  String get chooseGallery => 'Scegli dalla galleria';

  @override
  String get backupImported => 'Backup importato';

  @override
  String get backupFailed => 'Impossibile leggere quel backup';

  @override
  String get nothingToExport => 'Niente da esportare — registra prima una sessione';

  @override
  String calculatorsCount(int n) {
    return '$n calcolatrici per il tuo allenamento';
  }

  @override
  String get result => 'RISULTATO';

  @override
  String get weightLifted => 'PESO SOLLEVATO';

  @override
  String get repsPerformed => 'RIPETIZIONI FATTE';

  @override
  String get neck => 'COLLO';

  @override
  String get waist => 'VITA';

  @override
  String get hip => 'FIANCHI (donne)';

  @override
  String get targetWeight => 'PESO OBIETTIVO';

  @override
  String get workingWeight => 'PESO DI LAVORO';

  @override
  String get activityLevel => 'LIVELLO DI ATTIVITÀ';

  @override
  String get barWeight => 'PESO DEL BILANCIERE';

  @override
  String get perSide => 'PER LATO';

  @override
  String get justTheBar => 'Solo il bilanciere.';

  @override
  String perSideCount(int n) {
    return '× $n per lato';
  }

  @override
  String get toolNameRm => 'Massimale';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'Calorie';

  @override
  String get toolNameBf => 'Massa grassa';

  @override
  String get toolNamePlate => 'Dischi';

  @override
  String get toolNameWarmup => 'Riscaldamento';

  @override
  String get toolTitleRm => 'Calcolatrice massimale';

  @override
  String get toolTitleBmi => 'Calcolatrice BMI';

  @override
  String get toolTitleCal => 'Calorie e macro';

  @override
  String get toolTitleBf => '% di massa grassa';

  @override
  String get toolTitlePlate => 'Calcolatrice dischi';

  @override
  String get toolTitleWarmup => 'Serie di riscaldamento';

  @override
  String get toolHintRm => 'Massimale stimato a 1 ripetizione (formula di Epley)';

  @override
  String get toolHintCal => 'Mantenimento giornaliero stimato';

  @override
  String get toolHintBf => 'Stima col metodo US Navy';

  @override
  String get toolHintPlate => 'Peso totale del bilanciere';

  @override
  String get toolHintWarmup => 'Peso di lavoro obiettivo';

  @override
  String get toolDescRm => 'Massimale stimato a una ripetizione';

  @override
  String get toolDescBmi => 'Indice di massa corporea';

  @override
  String get toolDescCal => 'Calorie e macro';

  @override
  String get toolDescBf => 'Percentuale di massa grassa';

  @override
  String get toolDescPlate => 'Quali dischi caricare sul bilanciere';

  @override
  String get toolDescWarmup => 'Serie di avvicinamento';

  @override
  String get bmiUnderweight => 'Sottopeso';

  @override
  String get bmiNormal => 'Normale';

  @override
  String get bmiOverweight => 'Sovrappeso';

  @override
  String get bmiObese => 'Obeso';

  @override
  String get actSedentary => 'Sedentario';

  @override
  String get actLight => 'Leggero';

  @override
  String get actActive => 'Attivo';

  @override
  String get actModerate => 'Moderato';

  @override
  String get muscleChest => 'Petto';

  @override
  String get muscleBack => 'Schiena';

  @override
  String get muscleLowerBack => 'Lombari';

  @override
  String get muscleShoulders => 'Spalle';

  @override
  String get muscleBiceps => 'Bicipiti';

  @override
  String get muscleTriceps => 'Tricipiti';

  @override
  String get muscleForearm => 'Avambraccio';

  @override
  String get muscleTrapezius => 'Trapezio';

  @override
  String get muscleAbdomen => 'Addome';

  @override
  String get muscleObliques => 'Obliqui';

  @override
  String get muscleQuads => 'Quadricipiti';

  @override
  String get muscleHamstrings => 'Femorali';

  @override
  String get muscleGlutes => 'Glutei';

  @override
  String get muscleCalves => 'Polpacci';

  @override
  String get mgChest => 'Petto';

  @override
  String get mgBack => 'Schiena';

  @override
  String get mgLegs => 'Gambe';

  @override
  String get mgShoulders => 'Spalle';

  @override
  String get mgArms => 'Braccia';

  @override
  String get mgCore => 'Core';

  @override
  String get equipBarbell => 'Bilanciere';

  @override
  String get equipDumbbell => 'Manubrio';

  @override
  String get equipCable => 'Cavo';

  @override
  String get equipMachine => 'Macchina';

  @override
  String get equipBodyweight => 'Corpo libero';

  @override
  String get equipWeighted => 'Zavorrato';

  @override
  String get equipBand => 'Elastico';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Anelli';

  @override
  String get equipOther => 'Altro';

  @override
  String get diffBeginner => 'Principiante';

  @override
  String get diffAdvanced => 'Avanzato';

  @override
  String get diffIntermediate => 'Intermedio';

  @override
  String get about => 'INFO';

  @override
  String version(String v) {
    return 'Versione $v';
  }

  @override
  String get aboutBlurb => 'Fatta da chi si allena, per chi si allena.';

  @override
  String get freeForever => 'Gratis per sempre';

  @override
  String get freeForeverWhy => 'Nessun abbonamento, nessuna pubblicità, niente bloccato a pagamento.';

  @override
  String get fullyOffline => 'Tutto offline';

  @override
  String get fullyOfflineWhy =>
      'Nessun account, nessun server. I tuoi allenamenti non lasciano mai questo telefono.';

  @override
  String get yoursToTake => 'I tuoi dati sono tuoi';

  @override
  String get yoursToTakeWhy => 'Esportali in CSV quando vuoi, ed eliminali tutti con un tocco.';

  @override
  String get whatsInside => 'COSA C\'È DENTRO';

  @override
  String exercisesInside(int n) {
    return '$n esercizi';
  }

  @override
  String get exercisesInsideWhy => 'Ognuno con animazione e istruzioni passo passo.';

  @override
  String get calculatorsInside => '10 calcolatrici';

  @override
  String get calculatorsInsideWhy =>
      'Massimale, dischi, BMI, calorie, massa grassa, FFMI, riscaldamento, carico da RPE e punteggi di forza DOTS e Wilks — tutte con formule pubblicate.';

  @override
  String get mathInside => 'Conti onesti';

  @override
  String get mathInsideWhy => 'Volume, record e serie vengono dalle tue serie. Qui niente è decorazione.';

  @override
  String get streakCaps => 'SERIE';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'giorni', one: 'giorno');
    return '$_temp0';
  }

  @override
  String get reset => 'AZZERA';

  @override
  String get welcomeKicker => 'BENVENUTO IN';

  @override
  String get welcomeBlurb =>
      'Tutto resta sul tuo telefono. Nessun account, niente internet, niente da pagare.';

  @override
  String get welcomeStart => 'INIZIA';

  @override
  String onbStep(int i, int n) {
    return 'PASSO $i DI $n';
  }

  @override
  String get onbNameTitle => 'Come ti chiami?';

  @override
  String get onbNameHint => 'Il tuo nome';

  @override
  String get onbNameWhy => 'Serve solo per salutarti. Non lascia mai il telefono.';

  @override
  String get onbBodyTitle => 'Qualche numero';

  @override
  String get onbBodyWhy => 'Alimentano le calcolatrici. Puoi cambiarli quando vuoi in Impostazioni.';

  @override
  String get onbGoalTitle => 'Quanto ti alleni?';

  @override
  String get onbGoalWhy => 'Imposta l\'anello dell\'obiettivo settimanale. Sii onesto, non ambizioso.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessioni a settimana',
      one: '$n sessione a settimana',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Chili o libbre?';

  @override
  String get next => 'AVANTI';

  @override
  String get back => 'INDIETRO';

  @override
  String get skip2 => 'Salta';

  @override
  String get madeWithLoveBy => 'FATTO CON AMORE DA';

  @override
  String get sourceCode => 'CODICE SORGENTE';

  @override
  String get suggested => 'SUGGERITI';

  @override
  String get results => 'RISULTATI';

  @override
  String get noMatches => 'Nessun esercizio corrisponde alla ricerca.';

  @override
  String get tapToEdit => 'Tocca la matita per correggere una voce, o il cestino per rimuoverla.';

  @override
  String get editEntry => 'Modifica';

  @override
  String get editEntryHint => 'Correggi ripetizioni o peso di una serie.';

  @override
  String get removeSet => 'Rimuovi serie';

  @override
  String get continueWorkout => 'CONTINUA';

  @override
  String get continueWorkoutBody =>
      'L\'allenamento torna in corso, con le serie già spuntate. Finitolo di nuovo, viene salvato nel giorno originale.';

  @override
  String get addBodyWidget => 'Aggiungi widget mappa muscolare';

  @override
  String get repsOnly => 'Solo ripetizioni';

  @override
  String get repsOnlyHint => 'Registra questo esercizio senza peso.';

  @override
  String get useDefaultArt => 'Torna all\'immagine predefinita';

  @override
  String daysShort(int n) {
    return '${n}g';
  }

  @override
  String get focusCard => 'Il focus di oggi';

  @override
  String get autoAdvance => 'Passa al prossimo da solo';

  @override
  String get keepScreenOn => 'Tieni lo schermo acceso durante l\'allenamento';

  @override
  String get lockWorkout => 'Blocca lo schermo';

  @override
  String get unlockWorkout => 'Sblocca';

  @override
  String get holdToUnlock => 'Tieni premuto per sbloccare';

  @override
  String get liveChannel => 'Allenamento in corso';

  @override
  String get liveChannelWhy => 'Mostra esercizio, serie e recupero mentre ti alleni';

  @override
  String liveSet(int n, int total) {
    return 'Serie $n di $total';
  }

  @override
  String get liveResting => 'Recupero';

  @override
  String get liveAllDone => 'Serie completate';

  @override
  String get autoAdvanceHint =>
      'Quando segni l\'ultima serie di un esercizio, l\'allenamento passa al prossimo.';

  @override
  String get autoProgress => 'Aumenta il peso da solo';

  @override
  String autoProgressHint(String w) {
    return 'Se completi tutte le ripetizioni, la prossima volta si parte con $w in più.';
  }

  @override
  String get placePlates => 'Dischi e bilanciere';

  @override
  String get platesAll => 'Tutto disponibile';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n misure', one: '$n misura');
    return '$_temp0';
  }

  @override
  String get platePairs => 'COPPIE';

  @override
  String plateAchievable(String w) {
    return 'Il più vicino che puoi caricare: $w';
  }

  @override
  String get autoWarmup => 'Inizia con il riscaldamento';

  @override
  String get autoWarmupHint => 'Aggiunge le serie di riscaldamento all\'apertura dell\'allenamento.';

  @override
  String get trainReminder => 'Promemoria per allenarti';

  @override
  String get trainReminderHint => 'Un avviso a quest\'ora, solo nei giorni in cui hai una scheda.';

  @override
  String get reminderExactTime => 'Ora esatta';

  @override
  String get toastSoundSetting => 'Suono degli avvisi';

  @override
  String get toastSoundHint => 'Un suono leggero quando compare un avviso in alto.';

  @override
  String get notifTrainChannel => 'Promemoria per allenarti';

  @override
  String get notifTrainChannelWhy => 'Una spinta ad allenarti nei giorni che hai pianificato.';

  @override
  String get notifTrainTitle => 'È ora di allenarsi';

  @override
  String get notifTrainBody => 'La tua scheda ti aspetta.';

  @override
  String get planIntro => 'Creami una scheda di allenamento usando solo gli esercizi di questa lista.';

  @override
  String get planFormat => 'Rispondi solo con JSON, in questo formato:';

  @override
  String get planNothing => 'Nessun esercizio di quel file è nella tua libreria';

  @override
  String get planFailed => 'Quel file non è una scheda che si possa leggere';

  @override
  String get routineGroup => 'Gruppo';

  @override
  String get newGroup => 'Nuovo gruppo';

  @override
  String get noGroup => 'Senza gruppo';

  @override
  String get groupNameHint => 'Push / Pull / Gambe, 5×5…';

  @override
  String get filters => 'Filtri';

  @override
  String get setsPlannedHint => 'Scegli quante serie vuoi di ognuno. L\'allenamento si apre già con quelle.';

  @override
  String get nextTime => 'PROSSIMA';

  @override
  String get nextHold => 'stesso peso finché non completi tutte le ripetizioni';

  @override
  String get bgPhoto => 'La tua foto';

  @override
  String get bgPhotoPick => 'Scegli una foto';

  @override
  String get bgPhotoChange => 'Cambia la foto';

  @override
  String get bgPhotoRemove => 'Togli la foto';

  @override
  String get bgDim => 'QUANTO SCURA';

  @override
  String get dimSoft => 'Leggera';

  @override
  String get dimMedium => 'Media';

  @override
  String get dimStrong => 'Forte';

  @override
  String get bgPhotoHint => 'Sta dietro a tutto, scurita perché l\'app resti leggibile.';

  @override
  String get reminderSmart => 'Intelligente';

  @override
  String get reminderFixed => 'Ora fissa';

  @override
  String get reminderSmartHint =>
      'Usa i giorni e l\'ora in cui ti alleni davvero, e sta zitto se quel giorno ti sei già allenato.';

  @override
  String get reminderSmartEmpty => 'Registra ancora qualche allenamento e imparerà i tuoi giorni.';

  @override
  String habitFocus(String day) {
    return 'quello che fai di solito il $day';
  }

  @override
  String get duplicateRoutine => 'Duplica la scheda';

  @override
  String copySuffix(String name) {
    return '$name (copia)';
  }

  @override
  String get saveAsRoutine => 'SALVA COME SCHEDA';

  @override
  String get savedAsRoutine => 'Salvata come scheda';

  @override
  String get templates => 'Schede già pronte';

  @override
  String get templatesHint =>
      'Programmi classici, montati con la tua libreria. Dopo puoi cambiare quello che vuoi.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n schede aggiunte',
      one: '$n scheda aggiunta',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Tre giorni a settimana di corpo intero. Quello da cui si parte.';

  @override
  String get tplPpl => 'Spinta, tirata e gambe. Tre o sei giorni a settimana.';

  @override
  String get tplUpperlower => 'Parte alta e parte bassa, quattro giorni a settimana.';

  @override
  String get tplStronglifts => 'Due allenamenti, cinque serie da cinque, alternati.';

  @override
  String get tplStartingstrength => 'Squat a ogni seduta, due allenamenti che si alternano.';

  @override
  String get tplHome => 'Nient\'altro che una barra a cui appendersi e il pavimento.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giorni', one: '$n giorno');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Segna lo sforzo (RPE)';

  @override
  String get rpeHint => '10 è non farne un\'altra; 8, che te ne avanzavano due.';

  @override
  String get superset => 'Superserie';

  @override
  String get supersetLink => 'Concatena con il prossimo';

  @override
  String get supersetHint => 'Nessun riposo tra gli esercizi concatenati: passi dritto al prossimo.';

  @override
  String get aiRoutine => 'Scheda con l\'IA';

  @override
  String get aiIntro =>
      'GymMane non parla con nessuna IA. Sei tu che esporti la tua lista di esercizi, la incolli nell\'assistente che già usi e riporti dentro la sua risposta. Dal telefono non esce niente da solo.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nomi non erano nella tua libreria',
      one: '1 nome non era nella tua libreria',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Quali app legge';

  @override
  String get importOtherCsv => 'Qualsiasi altro CSV con data, esercizio, ripetizioni e peso';

  @override
  String get importAskApp => 'Ti serve un\'altra app? Chiedila';

  @override
  String get awardFirstStepName => 'Primo passo';

  @override
  String get awardFirstStepLine => 'Benvenuto in GymMane. Questa te la regala la casa.';

  @override
  String get awardFirstWorkoutName => 'Primo allenamento';

  @override
  String get awardFirstWorkoutLine => 'Il primo è registrato. Quello è il difficile.';

  @override
  String get awardFirstRoutineName => 'Prima scheda';

  @override
  String get awardFirstRoutineLine => 'Ora hai un piano a cui tornare.';

  @override
  String get awardFirstRecordName => 'Primo record';

  @override
  String get awardFirstRecordLine => 'Hai battuto il tuo massimo in un esercizio.';

  @override
  String get awardStreak3Name => 'Tre di fila';

  @override
  String get awardStreak3Line => 'Tre giorni di fila. È così che si comincia.';

  @override
  String get awardTonne1Name => 'Una tonnellata';

  @override
  String get awardTonne1Line => 'Mille chili sollevati tra tutte le tue serie.';

  @override
  String get awardSets100Name => 'Cento serie';

  @override
  String get awardSets100Line => 'Cento serie completate, una alla volta.';

  @override
  String get awardHours10Name => 'Dieci ore';

  @override
  String get awardHours10Line => 'Dieci ore di allenamento sul cronometro.';

  @override
  String get awardWorkouts50Name => 'Cinquanta allenamenti';

  @override
  String get awardWorkouts50Line => 'Cinquanta sedute alle spalle.';

  @override
  String get awardHours50Name => 'Cinquanta ore';

  @override
  String get awardHours50Line => 'Cinquanta ore dentro la palestra.';

  @override
  String get awardsTitle => 'Medaglie';

  @override
  String get yearTitle => 'Il tuo anno';

  @override
  String get yearBestMonth => 'Mese migliore';

  @override
  String get yearMonths => 'mesi';

  @override
  String get awardSpinHint => 'Trascina la medaglia per girarla';

  @override
  String get awardUnlocked => 'Nuovo traguardo sbloccato';

  @override
  String get awardNice => 'Grande!';

  @override
  String get awardSaveImage => 'Salva l\'immagine';

  @override
  String get awardSaved => 'Salvata nella galleria';

  @override
  String get awardStreak7Name => 'Sette giorni';

  @override
  String get awardStreak7Line => 'Una settimana intera senza saltare un giorno.';

  @override
  String get awardStreak30Name => 'Trenta giorni';

  @override
  String get awardStreak30Line => 'Un mese di fila. Ormai è un\'abitudine.';

  @override
  String get awardWorkouts100Name => 'Cento allenamenti';

  @override
  String get awardWorkouts100Line => 'Cento sedute registrate dall\'inizio alla fine.';

  @override
  String get awardTonnes100Name => 'Cento tonnellate';

  @override
  String get awardTonnes100Line => 'Tutto quello che hai sollevato fa 100.000 kg.';

  @override
  String get awardSets1000Name => 'Mille serie';

  @override
  String get awardSets1000Line => 'Una serie alla volta, fino a mille.';

  @override
  String get profile => 'Profilo';

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get pickBadge => 'Distintivo';

  @override
  String get statWorkouts => 'Allenamenti';

  @override
  String get statTrained => 'Allenato';

  @override
  String get statSets => 'Serie';

  @override
  String get statLifted => 'Sollevato';

  @override
  String get statStreak => 'Streak';

  @override
  String get statDays => 'giorni';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'giorni';

  @override
  String get snapshots => 'Foto';

  @override
  String get snapNow => 'Scattane una';

  @override
  String get addCover => 'Metti una copertina';

  @override
  String get addTodayWidget => 'Oggi: fatto o no';

  @override
  String get photosCard => 'Le tue foto';

  @override
  String get handleLabel => 'Nome utente';

  @override
  String get setupTitle => 'Riempi questi e il resto della pagina si riempie da solo';

  @override
  String get setupHint =>
      'Ogni numero qui viene da quello che registri. Niente viene inviato da nessuna parte.';

  @override
  String get setupWorkout => 'Registra il tuo primo allenamento';

  @override
  String get setupWeight => 'Segna il tuo peso';

  @override
  String get setupMeasures => 'Prendi le tue misure';

  @override
  String get setupPhoto => 'Scatta la prima foto dei progressi';

  @override
  String get progressTitle => 'Progressi';

  @override
  String get tileVolume30 => 'Volume · 30g';

  @override
  String get tileAddWeight => 'Segnalo';

  @override
  String get heatToneTitle => 'Colore della mappa';

  @override
  String get heatToneHint => 'Cambia solo come vengono dipinti la griglia e il corpo.';

  @override
  String get thisWeekTitle => 'Questa settimana';

  @override
  String get momentsEmptyTitle => 'Qui non c\'è ancora niente';

  @override
  String get deletePhotoTitle => 'Cancellare questa foto?';

  @override
  String get deletePhotoBody => 'Sparisce per sempre.';

  @override
  String get awardsEarned => 'Conquistate';

  @override
  String get awardsLocked => 'Da conquistare';

  @override
  String get awardStreak100Name => 'Cento giorni';

  @override
  String get awardWorkouts10Name => 'Dieci allenamenti';

  @override
  String get awardWorkouts10Line => 'I primi dieci sono quelli che decidono.';

  @override
  String get awardWorkouts365Name => 'Trecentosessantacinque';

  @override
  String get awardWorkouts365Line => 'Un allenamento per ogni giorno dell\'anno, registrati uno a uno.';

  @override
  String get awardTonnes10Name => 'Dieci tonnellate';

  @override
  String get awardTonnes10Line => 'Diecimila chili ti sono passati per le mani.';

  @override
  String get awardHours100Name => 'Cento ore';

  @override
  String get awardHours100Line => 'Cento ore sotto il bilanciere, cronometro alla mano.';

  @override
  String awardWonOn(String date) {
    return 'Conquistata il $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Oro',
      'blue': 'Blu',
      'green': 'Verde',
      'other': 'Distintivo',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Dal $date';
  }

  @override
  String levelShort(int n) {
    return 'Livello $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n allenamenti al livello $next',
      one: '1 allenamento al livello $next',
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
      'ember': 'Brace',
      'green': 'Verde',
      'blue': 'Blu',
      'mono': 'Grigio',
      'other': 'Colore',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n serie';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n di $goal questa settimana';
  }

  @override
  String momentCount(int n) {
    return '$n foto';
  }

  @override
  String photosSelected(int n) {
    return '$n selezionate';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Eliminare $n foto?';
  }

  @override
  String get momentsEmptyHint =>
      'Fotografa la palestra, la lavagna, come hai caricato il bilanciere… quello che vuoi ricordare. Restano sul telefono e le vedi solo tu.';

  @override
  String get awardStreak100Line => 'Cento giorni di fila. Quella non è più motivazione, quello sei tu.';

  @override
  String get coverLabel => 'COPERTINA';

  @override
  String get removeCover => 'Togli la copertina';

  @override
  String get startTitle => 'Inizia l\'allenamento';

  @override
  String get logTitle => 'Segna un allenamento';

  @override
  String get logHint => 'Senza cronometro: riempi solo quello che hai fatto.';

  @override
  String get orStartFrom => 'Oppure parti da';

  @override
  String get pickExercisesOption => 'Scegli gli esercizi';

  @override
  String get chooseFocusOption => 'Scegli per muscoli';

  @override
  String get plannedRoutine => 'PREVISTA';

  @override
  String get logWorkoutAction => 'SEGNA UN ALLENAMENTO';

  @override
  String get logging => 'SEGNANDO';

  @override
  String get placesLabel => 'I miei posti';

  @override
  String get undo => 'Annulla';

  @override
  String get deleteSet => 'Elimina serie';

  @override
  String get setDeleted => 'Serie eliminata';

  @override
  String get removeWarmup => 'Togli riscaldamento';

  @override
  String get addWeightAction => 'Aggiungi peso';

  @override
  String get workoutOverview => 'Questo allenamento';

  @override
  String get allExercisesShort => 'Tutti';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total serie';
  }

  @override
  String get nowLabel => 'Ora';

  @override
  String get deleteWorkout => 'Elimina allenamento';

  @override
  String get deleteWorkoutBody => 'Questo allenamento e tutte le sue serie verranno tolti dallo storico.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Segue il telefono';

  @override
  String get demoSizeTitle => 'Demo dell\'esercizio in allenamento';

  @override
  String get demoLarge => 'Grande';

  @override
  String get demoSmall => 'Piccola';

  @override
  String get demoOff => 'Nascosta';

  @override
  String get demoLoopTitle => 'Animazione della demo';

  @override
  String get demoLoopAlways => 'In loop';

  @override
  String get demoLoopShort => '10 secondi';

  @override
  String get demoLoopHint =>
      'Si muove per circa 10 secondi e si ferma sulla posizione iniziale. Tocca la demo per rivederla.';

  @override
  String get alarmStyleTitle => 'A fine recupero';

  @override
  String get alarmStyleLoud => 'Suona sempre';

  @override
  String get alarmStyleQuiet => 'Rispetta il silenzioso';

  @override
  String get alarmStyleVibrate => 'Solo vibrazione';

  @override
  String get alarmStyleHint =>
      '«Suona sempre» usa il volume della sveglia, anche in silenzioso. «Rispetta il silenzioso» usa quello delle notifiche e, se il telefono è muto, vibra soltanto.';

  @override
  String get suggestedPicks => 'Suggeriti per te';

  @override
  String get moreOptions => 'Altre opzioni';

  @override
  String get suggestInWorkouts => 'Suggerisci negli allenamenti rapidi';

  @override
  String get suggestInWorkoutsHint =>
      'Se lo spegni, non comparirà tra le proposte. Potrai sempre aggiungerlo a mano.';

  @override
  String get onbPlaceTitle => 'Dove ti alleni?';

  @override
  String get onbPlaceWhy =>
      'Segna tutti i posti dove ti alleni. Ti proporremo solo quello che puoi fare in ognuno.';

  @override
  String get onbPlaceGear => 'Cosa hai lì?';

  @override
  String distanceCol(String unit) {
    return 'DISTANZA ($unit)';
  }

  @override
  String get timeCol => 'TEMPO';

  @override
  String get timeMinutesTitle => 'Tempo (minuti)';

  @override
  String get timeSecondsTitle => 'Tempo (secondi)';

  @override
  String distanceTitle(String unit) {
    return 'Distanza ($unit)';
  }

  @override
  String get holdLabel => 'Tieni';

  @override
  String get stopLabel => 'Stop';

  @override
  String startHold(String time) {
    return 'Inizia · $time';
  }

  @override
  String get exerciseTypeLabel => 'Si registra per';

  @override
  String get typeReps => 'Ripetizioni e peso';

  @override
  String get typeTime => 'Tempo';

  @override
  String get typeCardio => 'Distanza e tempo';

  @override
  String get exerciseTypeHint =>
      'Il cardio, come correre o nuotare, registra distanza e tempo. Le tenute, come il plank, solo il tempo.';

  @override
  String get howToLabel => 'Come si fa (facoltativo)';

  @override
  String get howToHint => 'Un passaggio per riga';

  @override
  String get editExercise => 'Modifica esercizio';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get noStepsYet => 'Ancora nessun passaggio. Scrivi i tuoi per ricordare come lo esegui.';

  @override
  String get addSteps => 'Scrivi i passaggi';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Una serie normale. Conta per il volume e i record.';

  @override
  String get setTypeWarmupInfo => 'Serie leggere per scaldarsi. Non contano per il volume né per i record.';

  @override
  String get setTypeDropInfo => 'Subito dopo una serie, riduci il peso e continua senza riposare.';

  @override
  String get setTypeFailureInfo =>
      'Continua finché non riesci a fare un\'altra ripetizione pulita. Segna quelle fatte davvero.';

  @override
  String get setTypeRestPauseInfo =>
      'Riposa da 10 a 20 secondi dopo la serie, poi strappa qualche ripetizione in più.';

  @override
  String get planFormatNotes =>
      'Usa i nomi degli esercizi esattamente come nella lista. \"sets\", \"reps\", \"weight\" (nell\'unità indicata), \"rest\" in secondi e \"days\" sono facoltativi. \"superset\": true collega un esercizio al successivo. Per più settimane, raggruppa le routine dentro \"weeks\" come nel secondo esempio.';

  @override
  String get planSets => 'Pianifica le serie';

  @override
  String get planSetsHint =>
      'Scegli tipo, ripetizioni e peso di ogni serie. Lascia il peso su Auto per partire dall\'ultima sessione.';

  @override
  String get planHintReps =>
      'Scegli il tipo e le ripetizioni di ogni serie. Auto parte dalla tua ultima sessione.';

  @override
  String get planHintTime => 'Scegli il tipo e il tempo di ogni serie. Auto parte dalla tua ultima sessione.';

  @override
  String get planHintTimeWeight =>
      'Scegli il tipo, il tempo e il peso di ogni serie. Auto parte dalla tua ultima sessione.';

  @override
  String get planHintCardio =>
      'Scegli la distanza e il tempo di ogni serie. Auto parte dalla tua ultima sessione.';

  @override
  String get timeOnly => 'Solo tempo';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Rimuovi il piano';

  @override
  String get shareRoutine => 'Condividi routine';

  @override
  String get shareWeek => 'Condividi la mia settimana';

  @override
  String get shareWeekHint => 'Tutte le tue routine e il giorno di ciascuna.';

  @override
  String shareMessage(String name) {
    return '$name — apri il file con GymMane per aggiungerlo.';
  }

  @override
  String get importRoutines => 'Importa routine';

  @override
  String get importPasteHint =>
      'Incolla qui una routine: una condivisa da GymMane, la risposta di un\'IA, JSON o CSV.';

  @override
  String get pasteAction => 'Incolla';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n routine', one: '1 routine');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Usa anche il suo piano settimanale';

  @override
  String get useTheirScheduleHint =>
      'I giorni che porta sostituiscono quello che hai pianificato in quei giorni.';

  @override
  String get addToMyRoutines => 'Aggiungi alle mie routine';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n routine aggiunte',
      one: '1 routine aggiunta',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Qui non c\'è niente che GymMane possa importare';

  @override
  String get aiStepCopy =>
      'Copia la richiesta. Contiene la tua lista di esercizi e il formato che GymMane legge.';

  @override
  String get aiStepAsk =>
      'Incollala in una IA qualsiasi e di\' cosa vuoi: giorni a settimana, obiettivo, quante settimane.';

  @override
  String get aiStepPaste => 'Incolla qui sotto la risposta e importala. Nessun file da creare.';

  @override
  String get copyForAi => 'Copia per l\'IA';

  @override
  String get copiedDone => 'Copiato';

  @override
  String get aiPasteHint => 'Incolla qui la risposta dell\'IA';

  @override
  String get importAction => 'Importa';

  @override
  String get showFormat => 'Vedi il formato';

  @override
  String get shareAsFile => 'Condividi come file';

  @override
  String get recoveryTab => 'Recupero';

  @override
  String recoveryOverall(int pct) {
    return 'Corpo recuperato al $pct%';
  }

  @override
  String get recoveryAllFresh => 'È tutto recuperato. Buona giornata per allenare qualsiasi cosa.';

  @override
  String recoveryStill(String muscles) {
    return 'Ancora in recupero: $muscles';
  }

  @override
  String get recoveryTired => 'Affaticato';

  @override
  String get recoveryFresh => 'Fresco';

  @override
  String get recoveryHint =>
      'Tocca un muscolo per vedere quanto è recuperato. Le serie recenti pesano di più, e quelle più dure (per RPE) ancora di più.';

  @override
  String recoveryPct(int pct) {
    return '$pct% recuperato';
  }

  @override
  String readyInHours(int h) {
    return 'pronto tra ~$h h';
  }

  @override
  String get tplAbcd => 'Quattro giorni: petto e tricipiti, schiena e bicipiti, gambe, spalle e addome.';

  @override
  String get tplAbcde => 'Cinque giorni, un gruppo ciascuno: petto, schiena, gambe, spalle, braccia.';

  @override
  String get elapsedCaps => 'TRASCORSO';

  @override
  String get tapToSkip => 'Tocca per saltare';

  @override
  String get screenLocked => 'Schermo bloccato';

  @override
  String get lockedHint => 'Tieni premuta l\'impronta in alto per sbloccare';

  @override
  String get liveDoneSet => 'Serie fatta';

  @override
  String get liveSkipRest => 'Salta recupero';

  @override
  String get livePause => 'Pausa';

  @override
  String get liveResume => 'Riprendi';

  @override
  String get liveNext => 'Avanti';

  @override
  String liveUpNext(String name) {
    return 'Poi: $name';
  }

  @override
  String get stickerOpen => 'Condividi su una foto';

  @override
  String get stickerNoPhoto => 'Senza foto';

  @override
  String get stickerWorkout => 'Allenamento';

  @override
  String get stickerStreak => 'Serie';

  @override
  String get stickerDate => 'Data';

  @override
  String get stickerHint => 'Trascinalo per spostarlo, pizzica per ridimensionarlo o ruotarlo';

  @override
  String get stickerSaved => 'Salvata nella galleria';

  @override
  String get stickerWeek => 'Questa settimana';

  @override
  String get getReady => 'Preparati';

  @override
  String get stickerGallery => 'Galleria';

  @override
  String get stickerCamera => 'Fotocamera';

  @override
  String get shareIntroTitle => 'Condividi questa scheda';

  @override
  String get shareIntroBody =>
      'Mandala al partner, a un amico o alla famiglia. Riceveranno un piccolo file che si apre con GymMane e la aggiunge con un tocco, con serie e pesi.';

  @override
  String get removedFromRoutine => 'Tolto dalla scheda';

  @override
  String get radarTitle => 'Ultimi 30 giorni';

  @override
  String get radarHint => 'Guarda quali zone hanno bisogno di più lavoro';

  @override
  String get radarEmpty => 'Allenati qualche giorno per vedere il tuo equilibrio';

  @override
  String get radarBalanced => 'Finora c\'è un buon equilibrio';

  @override
  String radarFocus(String list) {
    return 'Serve di più: $list';
  }

  @override
  String get countdownReady => 'Preparati';

  @override
  String get countdownSkip => 'Tocca per iniziare subito';

  @override
  String get countdownSetting => 'Conto alla rovescia prima di iniziare';

  @override
  String get effortSetting => 'Annota lo sforzo';

  @override
  String get effortHint =>
      'RPE: 10 è non riuscire a farne un’altra; 8, che te ne restavano due. RIR conta le ripetizioni che ti restavano. Se la serie lo ha, l’1RM stimato usa la tabella RPE.';

  @override
  String get rirHint => '0 è non riuscire a farne un’altra; 2, che te ne restavano due.';

  @override
  String get addWeekWidget => 'Aggiungi widget della settimana';

  @override
  String get gamificationSetting => 'Medaglie e livelli';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rip.', one: '$n rip.');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Serie migliore';

  @override
  String get weekStartSetting => 'La settimana inizia di';

  @override
  String get stepOutOfWorkout => 'Metti in pausa ed esci';

  @override
  String get saveToRoutine => 'SALVA LE MODIFICHE NELLA SCHEDA';

  @override
  String get routineUpdated => 'Scheda aggiornata';

  @override
  String saveChangesTitle(String name) {
    return 'Salvare le modifiche in $name?';
  }

  @override
  String get saveChangesBody => 'La prossima volta che la avvii, la scheda avrà queste modifiche.';

  @override
  String get routineOrderChanged => 'Nuovo ordine degli esercizi';

  @override
  String get mineOnly => 'Creati da te';

  @override
  String createNamed(String name) {
    return 'Non c’è? Crea «$name»';
  }

  @override
  String get orStartWith => 'Oppure inizia con';

  @override
  String get warmupFocus => 'Riscaldamento';

  @override
  String get warmupFocusHint => 'Mobilità e attivazione, con o senza attrezzi';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Corsa, bici, vogatore o corda, per distanza e tempo';

  @override
  String get homeRecommended => 'Consigliati nella home';

  @override
  String get archivedFilter => 'Archiviati';

  @override
  String get archiveExercise => 'Archivia esercizio';

  @override
  String get restoreExercise => 'Ripristina';

  @override
  String get archivedToast => 'Esercizio archiviato';

  @override
  String get archivedToastHint => 'Lo trovi in Esercizi › Archiviati';

  @override
  String get archivedBanner => 'Archiviato. Non compare in elenchi e suggerimenti; lo storico resta.';

  @override
  String get videoMarksHint =>
      'Metti in pausa su un passo e tocca la puntina per saltarci la prossima volta.';

  @override
  String get videoMarkHere => 'Segna qui questo passo';

  @override
  String get sectionGeneral => 'Generale';

  @override
  String get sectionTraining => 'Allenamento';

  @override
  String get sectionAlerts => 'Promemoria e allarme';

  @override
  String get sectionHome => 'Home';

  @override
  String get sectionWidgets => 'Widget';

  @override
  String get sectionData => 'Dati e backup';

  @override
  String get multiPlanSetting => 'Più schede al giorno';

  @override
  String get multiPlanHint => 'Tocca ogni scheda di questo giorno. Seguono l’ordine in cui le aggiungi.';

  @override
  String routineOfDay(int n, int total) {
    return '$n di $total oggi';
  }

  @override
  String get nextToday => 'Prossima oggi';

  @override
  String get planAboutMe => 'Su di me:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age anni, $height di altezza, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Voglio allenarmi $n giorni a settimana.';
  }

  @override
  String get planNoHistory =>
      'Nessun allenamento registrato: trattami da principiante e resta prudente con volume e carichi.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n allenamenti negli ultimi 30 giorni.',
      one: '1 allenamento negli ultimi 30 giorni.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Migliori serie recenti';

  @override
  String get planAskFirst =>
      'Se non conosci il mio obiettivo (forza, massa, dimagrimento o forma generale) o quanto può durare una sessione, chiedimelo prima con un breve messaggio. Poi rispondi solo in JSON.';

  @override
  String get backToTop => 'Torna su';

  @override
  String get deleteExerciseTitle => 'Eliminare questo esercizio?';

  @override
  String deleteExerciseBody(String name) {
    return '«$name» verrà tolto dalla libreria e dalle schede. Le serie passate restano.';
  }

  @override
  String get exportForStravaHint =>
      'Caricalo dal browser su strava.com/upload/select (l’app di Strava non importa file). Compare come allenamento con i pesi, con le tue serie.';

  @override
  String get manualStartTime => 'Ora di inizio';

  @override
  String get manualDuration => 'Durata';

  @override
  String get manualDurationUnset => 'Aggiungi durata';

  @override
  String get stravaRow => 'Esporta su Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Scegli un allenamento da portare su Strava. Ottieni un file .fit: caricalo dal browser su strava.com/upload/select e compare come allenamento con i pesi, con le tue serie.';

  @override
  String get stravaEmpty => 'Ancora nessun allenamento da esportare.';

  @override
  String get tapToPause => 'Tocca per mettere in pausa';

  @override
  String get holdPausedHint => 'In pausa · tocca per riprendere';

  @override
  String get finishHoldNow => 'Chiudi la serie ora';

  @override
  String get barWeightExercise => 'Peso del bilanciere o della slitta';

  @override
  String get barWeightHint => 'Usato dal calcolatore dei dischi';

  @override
  String get barWeightCustom => 'Personalizzato · tocca per azzerare';

  @override
  String get groupRename => 'Rinomina gruppo';

  @override
  String get groupUngroup => 'Togli il gruppo, tieni le routine';

  @override
  String get groupDeleteAll => 'Elimina gruppo e routine';

  @override
  String groupDeleteTitle(String name) {
    return 'Eliminare «$name»?';
  }

  @override
  String groupDeleteBody(String count) {
    return 'Verranno eliminate $count. Lo storico degli allenamenti resta.';
  }

  @override
  String get tplRr =>
      'Il classico di r/bodyweightfitness: tutto il corpo tre giorni a settimana. Passa al livello successivo quando diventa facile.';

  @override
  String get levelUpKicker => 'PROSSIMO PASSO';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps su $name per due allenamenti di fila. Pronto per il passo successivo?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Sostituiscilo in $routine';
  }

  @override
  String get levelUpSee => 'Guarda come si fa';

  @override
  String get levelUpLater => 'Non ora';

  @override
  String get levelUpStay => 'Resto su questo';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name ora è in $routine';
  }

  @override
  String get levelUpStayed => 'Niente più suggerimenti di progressione per questo';

  @override
  String get levelHintsSetting => 'Suggerisci il passo successivo';

  @override
  String get heatmapLabelsSetting => 'Giorni e mesi sulla mappa attività';

  @override
  String get rmPercent => 'PERCENTUALE';

  @override
  String rmAtPercent(String pct) {
    return '$pct del tuo massimale';
  }

  @override
  String get copyWorkout => 'Copia come testo';

  @override
  String get goalSet => 'Imposta un obiettivo';

  @override
  String get goalTargetReps => 'RIPETIZIONI OBIETTIVO';

  @override
  String goalToGo(String value) {
    return 'Mancano $value';
  }

  @override
  String get goalReached => 'Obiettivo raggiunto';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mancano $n giorni',
      one: 'Manca 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Data superata';

  @override
  String get goalDeadline => 'SCADENZA';

  @override
  String get goalNoDeadline => 'Nessuna scadenza';

  @override
  String get goalRemove => 'Rimuovi obiettivo';

  @override
  String get exerciseNameMissing => 'Dagli un nome';

  @override
  String get aliasesLabel => 'Altri nomi (facoltativo)';

  @override
  String get aliasesHint => 'Altri nomi, separati da virgole';

  @override
  String alsoCalled(String names) {
    return 'Anche: $names';
  }

  @override
  String get addToRoutine => 'Aggiungi a routine';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n routine',
      one: 'In 1 routine',
      zero: 'Non è ancora in nessuna routine',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Già presente';

  @override
  String get restInRoutine => 'Recupero in questa routine';

  @override
  String get restInRoutineHint => 'Lo stesso dell’esercizio';

  @override
  String get restInRoutineReset => 'Solo qui · tocca per togliere';

  @override
  String get swapExercise => 'Cambia esercizio';

  @override
  String get swapShort => 'Cambia';

  @override
  String swapHint(String name) {
    return 'Al posto di $name, solo oggi. Alla fine potrai tenerlo nella routine.';
  }

  @override
  String get swapKeepsDone => 'Le serie già fatte restano; il nuovo continua con quelle mancanti.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Stesso muscolo · $muscle';
  }

  @override
  String get swapDoneBefore => 'Già fatto';

  @override
  String get multiPlanSettingHint => 'Più di una routine nello stesso giorno della settimana.';

  @override
  String get levelHintsHint => 'Quando un esercizio diventa facile, ti propone la versione più difficile.';

  @override
  String get focusCardHint => 'La routine di oggi, in cima alla Home.';

  @override
  String get gamificationHint => 'Medaglie, il tuo livello e la festa a fine allenamento.';

  @override
  String get exerciseSettings => 'Impostazioni di questo esercizio';

  @override
  String get placeActiveNow => 'Sei qui';

  @override
  String get placeTapToUse => 'tocca per allenarti qui';

  @override
  String get intervalDays => 'giorni';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target giorni';
  }

  @override
  String get toolNameRpe => 'Carico da RPE';

  @override
  String get toolTitleRpe => 'Carico da RPE';

  @override
  String get toolDescRpe => 'Che peso usare per lo sforzo che vuoi';

  @override
  String get toolNameDots => 'Livello di forza';

  @override
  String get toolTitleDots => 'Livello di forza (DOTS)';

  @override
  String get toolDescDots => 'La tua forza rispetto al tuo peso';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Per $reps ripetizioni a RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Una serie appena fatta';

  @override
  String get rpeGoal => 'Cosa vuoi fare';

  @override
  String rpeOneRmLine(String value) {
    return '1RM stimato: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 vuol dire che non ne facevi un’altra; 8, che te ne restavano due.';

  @override
  String get dotsBestLifts => 'I tuoi massimali';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'PANCA PIANA';

  @override
  String get dotsDeadlift => 'STACCO';

  @override
  String dotsTotalLine(String value) {
    return 'Totale: $value';
  }

  @override
  String get dotsExplain =>
      'Confronta la tua forza con quella di chiunque, a prescindere dal peso. Usa il tuo massimale o il 1RM stimato.';

  @override
  String get dotsLevel0 => 'Principiante';

  @override
  String get dotsLevel1 => 'Intermedio';

  @override
  String get dotsLevel2 => 'Avanzato';

  @override
  String get dotsLevel3 => 'Molto avanzato';

  @override
  String get dotsLevel4 => 'Élite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Punteggio Wilks';

  @override
  String get toolDescWilks => 'Il punteggio classico del powerlifting';

  @override
  String get wilksExplain =>
      'La formula classica del powerlifting. DOTS l’ha sostituita nel 2020, ma molte gare e classifiche la usano ancora.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Indice di massa magra';

  @override
  String get toolDescFfmi => 'Quanto muscolo per la tua altezza';

  @override
  String get ffmiBodyFat => 'MASSA GRASSA';

  @override
  String ffmiLeanLine(String value) {
    return 'Massa magra: $value';
  }

  @override
  String get ffmiExplain =>
      'Come il BMI, ma senza il grasso: conta solo la tua massa magra. Corretto per l’altezza, così alti e bassi si confrontano in modo equo.';

  @override
  String get ffmiLevel0 => 'Sotto la media';

  @override
  String get ffmiLevel1 => 'Nella media';

  @override
  String get ffmiLevel2 => 'Sopra la media';

  @override
  String get ffmiLevel3 => 'Eccellente';

  @override
  String get ffmiLevel4 => 'Eccezionale';

  @override
  String get rpeEffortLabel => 'Sforzo (RPE)';

  @override
  String get restRowHint => 'Tra le serie, se l’esercizio non ha il suo.';

  @override
  String get effortRowHint => 'Segna RPE o RIR a ogni serie.';

  @override
  String get countdownHint => '3, 2, 1 prima della prima serie.';

  @override
  String get keepScreenOnHint => 'Lo schermo resta acceso mentre ti alleni.';

  @override
  String get demoSizeRowHint => 'Il disegno dell’esercizio durante l’allenamento.';

  @override
  String get demoLoopRowHint => 'Se l’animazione si ripete o si ferma.';

  @override
  String get trainReminderRowHint => 'Un promemoria nei giorni di allenamento.';

  @override
  String get alarmSoundRowHint => 'Cosa suona a fine recupero.';

  @override
  String get alarmStyleRowHint => 'Se suona anche in silenzioso.';

  @override
  String get recommendedRowHint => 'Esercizi che ti proponiamo in Home.';

  @override
  String get weightStepSetting => 'Incremento del peso';

  @override
  String get weightStepHint => 'Quanto aggiungono i pulsanti − e +.';
}
