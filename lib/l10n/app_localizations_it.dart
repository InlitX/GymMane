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
  String get tapMuscles => 'Tocca i muscoli da allenare, fronte e schiena.';

  @override
  String get continueBtn => 'CONTINUA';

  @override
  String get nothingForFocus => 'Niente per questo focus, per ora';

  @override
  String get goBackPick => 'Torna indietro e scegli un muscolo con esercizi nella libreria.';

  @override
  String pickedHint(int n) {
    return 'Ti abbiamo preparato una sessione. Tocca per aggiungere o togliere uno dei $n.';
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
  String get miniRest => 'Recupero in rest-pause e cluster';

  @override
  String get miniRestHint => 'Prima di serie rest-pause o cluster';

  @override
  String get gymPass => 'Pass palestra';

  @override
  String get gymPassEmpty => 'Tieni qui il codice della tua palestra ed entra senza tessera';

  @override
  String get gymPassAdd => 'Aggiungi pass';

  @override
  String get gymPassScan => 'Fotografa il codice';

  @override
  String get gymPassScanHint => 'Con la fotocamera del telefono';

  @override
  String get gymPassPhoto => 'Da una foto o uno screenshot';

  @override
  String get gymPassPhotoHint => 'Per esempio, uno screenshot dall\'app della tua palestra';

  @override
  String get gymPassType => 'Scrivi il numero';

  @override
  String get gymPassTypeHint => 'Per i codici a barre: il numero stampato sotto';

  @override
  String get gymPassNotFound => 'Nessun QR in quell\'immagine. Prova con una più nitida o scrivi il numero.';

  @override
  String get gymPassName => 'Nome della palestra';

  @override
  String get gymPassDefaultName => 'La mia palestra';

  @override
  String get gymPassCode => 'Codice';

  @override
  String get gymPassFormat => 'Tipo di codice';

  @override
  String get gymPassInvalid => 'Questo numero non va bene per questo tipo di codice';

  @override
  String get gymPassShowHint => 'Avvicinalo al lettore. La luminosità sale da sola.';

  @override
  String get gymPassDeleted => 'Pass eliminato';

  @override
  String get gymPassEdit => 'Modifica pass';

  @override
  String get gymPassShow => 'Mostra all\'ingresso';

  @override
  String get gymPassPrivate => 'Resta solo sul tuo telefono. Non viene caricato niente.';

  @override
  String get gymPassColor => 'Colore';

  @override
  String get gymPassRescan => 'Leggi di nuovo il codice';

  @override
  String get gymPassReading => 'Lettura del codice…';

  @override
  String get gymPassSettingHint => 'La tua tessera della palestra nel profilo';

  @override
  String get gymPassMember => 'Socio';

  @override
  String get widgetHintActivity => 'La tua mappa dei giorni di allenamento';

  @override
  String get widgetHintStats => 'Serie, volume e sessioni di questa settimana';

  @override
  String get widgetHintBody => 'I muscoli che hai allenato';

  @override
  String get widgetHintToday => 'A colpo d\'occhio: ti sei allenato oggi?';

  @override
  String get widgetHintWeek => 'Il piano della settimana, giorno per giorno';

  @override
  String get supportHintBug => 'Dimmi cosa si è rotto, su GitHub';

  @override
  String get supportHintFeature => 'Proponi un\'idea per l\'app';

  @override
  String get supportHintStar => 'Aiuta più persone a trovarla';

  @override
  String get supportHintCoffee => 'Sostiene lo sviluppo. Gratis e senza pubblicità';

  @override
  String get bodyweightNoteHint => 'Aggiungi una nota: come ti senti, cosa stai provando… (facoltativa)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Usa $unit per questo esercizio';
  }

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
  String get restOverBody => 'Dacci dentro, la prossima serie ti aspetta.';

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
  String get days90 => '90G';

  @override
  String get days365 => '1A';

  @override
  String get daysAll => 'Tutto';

  @override
  String get weeklyAvgTitle => 'Media settimanale';

  @override
  String weekOfDate(String date) {
    return 'Settimana del $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change in questo periodo';
  }

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
  String get restDay => 'Giorno di riposo, niente registrato.';

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
  String get quickAddAmount => 'Quanto ne hai preso';

  @override
  String get homeCardsTitle => 'Schede della Home';

  @override
  String get homeCardsHint => 'Ciò che attivi appare nella Home';

  @override
  String get homeCardFocus => 'Oggi';

  @override
  String get homeCardSteps => 'Passi';

  @override
  String get homeCardWeek => 'Questa settimana';

  @override
  String get homeCardRoutines => 'Routine';

  @override
  String get homeCardRecommended => 'Consigliati';

  @override
  String get textSizeSetting => 'Dimensione del testo';

  @override
  String get textSizeSmall => 'Piccolo';

  @override
  String get textSizeNormal => 'Normale';

  @override
  String get textSizeLarge => 'Grande';

  @override
  String get textSizeHint => 'Oltre alla dimensione del testo del telefono';

  @override
  String get calmMotionSetting => 'Riduci animazioni';

  @override
  String get calmMotionHint => 'Le schermate appaiono senza scorrere';

  @override
  String get dishArchive => 'Archivia';

  @override
  String get dishUnarchive => 'Ripristina';

  @override
  String get dishArchivedToast => 'Piatto archiviato';

  @override
  String get filterShowLabel => 'Mostra';

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
  String get placeDeleteBody => 'Va via solo il posto. Esercizi e sessioni restano.';

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
  String get noteEmptyBody => 'Spunti, piani per la prossima volta, come è andata. Con foto o video se vuoi.';

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
  String get measuresHint => 'Dal collo al polpaccio: guarda come cambia il corpo, non solo il bilanciere.';

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
  String get hidePhotos => 'Nascondi foto';

  @override
  String get showPhotos => 'Mostra foto';

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
  String get photoDueNow => 'Foto in scadenza: falla oggi';

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
  String get timelineBodyHint => 'Nata dalle tue serie, niente da caricare.';

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
      'Sessioni, record, routine, note e profilo. Non si può annullare: esporta prima un backup se pensi di volerlo.';

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
  String get amoledTheme => 'Nero AMOLED';

  @override
  String get editDuration => 'Durata dell’allenamento';

  @override
  String get sessionName => 'Nome dell’allenamento';

  @override
  String get nameWorkout => 'Dagli un nome';

  @override
  String get sessionNameHint => 'es. Gambe, Spinta, Total body';

  @override
  String get secondaryPickHint => 'Tocca gli altri muscoli che lavora questo esercizio.';

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
  String get alarmSoundHint => 'Usa il tuo, fino a 15 secondi';

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
  String get onbUnitsWhy => 'Per pesi, misure e distanze. Puoi cambiarlo quando vuoi nelle Impostazioni.';

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
  String get nothingToExport => 'Niente da esportare: registra prima una sessione';

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
      'Massimale, dischi, BMI, calorie, massa grassa, FFMI, riscaldamento, carico da RPE e punteggi di forza DOTS e Wilks, tutte con formule pubblicate.';

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
  String get onbPhotoAdd => 'Aggiungi una foto';

  @override
  String get onbPhotoChange => 'Cambia foto';

  @override
  String get onbPhotoTitle => 'Dai un volto al tuo profilo';

  @override
  String get onbPhotoWhy => 'Facoltativo. Resta sul telefono e puoi cambiarla quando vuoi dal profilo.';

  @override
  String get onbPhotoLater => 'PIÙ TARDI';

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
  String get eachSide => 'Ogni lato';

  @override
  String get eachSideHint => 'Il timer parte una volta per lato e il recupero inizia dopo entrambi.';

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
  String get autoAdvanceHint => 'Passa al successivo dopo l\'ultima serie';

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
  String get toastSoundHint => 'Un suono leggero a ogni avviso';

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
  String get tplArnold => 'Petto e schiena, spalle e braccia, gambe. Il classico split di sei giorni.';

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
  String get supersetUnlink => 'Separa dal prossimo';

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
  String get timePerSideCol => 'TEMPO / LATO';

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
    return '$name: apri il file con GymMane per aggiungerlo.';
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
  String get tapToChange => 'Tocca per cambiare';

  @override
  String get swipeToSkipHint => 'Scorri il timer di lato per saltare il recupero.';

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
  String sideOfTwo(String n) {
    return 'Lato $n di 2';
  }

  @override
  String get switchSides => 'Cambia lato';

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
  String get homeRoutines => 'Routine nella home';

  @override
  String get homeRoutinesHint => 'L\'ultima fatta per prima';

  @override
  String get homeWeekStats => 'Questa settimana nella home';

  @override
  String get homeWeekStatsHint => 'Volume, serie e record della settimana';

  @override
  String get stepsSetting => 'Passi da Health Connect';

  @override
  String get stepsSettingHint => 'I passi di oggi in Home';

  @override
  String get stepsToday => 'Passi oggi';

  @override
  String stepsOfGoal(String goal) {
    return 'su $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count passi oggi';
  }

  @override
  String get stepsGoal => 'Obiettivo di passi giornaliero';

  @override
  String get stepsNoAccess => 'Nessun accesso ai tuoi passi';

  @override
  String get stepsGrant => 'Tocca per consentirlo in Health Connect';

  @override
  String get stepsInfoRead =>
      'Legge solo il numero di passi. Non legge nient’altro e non scrive mai in Health Connect.';

  @override
  String get stepsInfoLocal => 'I tuoi passi restano sul telefono. GymMane non si connette mai a internet.';

  @override
  String get stepsInfoOff => 'Puoi disattivarlo quando vuoi, nelle Impostazioni o in Health Connect.';

  @override
  String get stepsManage => 'Gestisci autorizzazione';

  @override
  String get routineDoneToday => 'Fatto per oggi · ottimo lavoro';

  @override
  String get trainAgain => 'Allenati ancora';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n giorni fa',
      one: 'Fatta ieri',
      zero: 'Fatta oggi',
    );
    return '$_temp0';
  }

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
  String get multiPlanSettingHint => 'Più di una routine nello stesso giorno della settimana';

  @override
  String get levelHintsHint => 'Propone la versione più difficile';

  @override
  String get focusCardHint => 'La routine di oggi, in cima alla Home';

  @override
  String get gamificationHint => 'Medaglie, livello e festa';

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
  String get restRowHint => 'Tra le serie, se l’esercizio non ha il suo';

  @override
  String get effortRowHint => 'Segna RPE o RIR a ogni serie';

  @override
  String get countdownHint => '3, 2, 1 prima della prima serie';

  @override
  String get keepScreenOnHint => 'Lo schermo resta acceso mentre ti alleni';

  @override
  String get demoSizeRowHint => 'Il disegno dell’esercizio durante l’allenamento';

  @override
  String get demoLoopRowHint => 'Se l’animazione si ripete o si ferma';

  @override
  String get trainReminderRowHint => 'Un promemoria nei giorni di allenamento';

  @override
  String get alarmSoundRowHint => 'Cosa suona a fine recupero';

  @override
  String get alarmStyleRowHint => 'Se suona anche in silenzioso';

  @override
  String get recommendedRowHint => 'Esercizi che ti proponiamo in Home';

  @override
  String get weightStepSetting => 'Incremento del peso';

  @override
  String get weightStepHint => 'Quanto aggiungono i pulsanti − e +';

  @override
  String get prBestWorkout => 'Miglior allenamento';

  @override
  String get mergeExercise => 'Unisci';

  @override
  String mergeExerciseInto(String name) {
    return 'Unisci $name a…';
  }

  @override
  String get mergeExerciseTitle => 'Unire gli esercizi?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Tutto lo storico di «$from» passa a «$to». «$from» resta nella tua libreria. Non si può annullare.';
  }

  @override
  String get mergedToast => 'Storico unito';

  @override
  String get nutrition => 'Nutrizione';

  @override
  String get nutritionHomeEmpty => 'Acqua, proteine e calorie';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g di proteine';
  }

  @override
  String get nutritionToday => 'Oggi';

  @override
  String get nutritionYesterday => 'Ieri';

  @override
  String get nutritionGoals => 'Obiettivi del giorno';

  @override
  String get kcalLabel => 'CALORIE';

  @override
  String get kcalOver => 'in più';

  @override
  String get waterLabel => 'ACQUA';

  @override
  String get waterDone => 'Obiettivo raggiunto';

  @override
  String get waterCustom => 'Altra quantità';

  @override
  String get glassSize => 'Misura del bicchiere';

  @override
  String get supplementsLabel => 'INTEGRATORI';

  @override
  String get supplementsEmpty => 'Toccane uno per aggiungerlo, o + per il tuo.';

  @override
  String get addSupplement => 'Nuovo integratore';

  @override
  String get supplementNameHint => 'Creatina, vitamina D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Togliere $name?';
  }

  @override
  String get removeSupplementBody => 'Se ne vanno anche i giorni in cui l’hai segnato.';

  @override
  String get suppCreatine => 'Creatina';

  @override
  String get suppVitaminD => 'Vitamina D';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magnesio';

  @override
  String get suppMultivitamin => 'Multivitaminico';

  @override
  String get suppCaffeine => 'Caffeina';

  @override
  String get myFoods => 'I miei alimenti';

  @override
  String get newFood => 'Nuovo alimento';

  @override
  String get editFood => 'Modifica alimento';

  @override
  String get foodNameHint => 'Whey, fiocchi d’avena, pane…';

  @override
  String get servingLabel => 'PORZIONE';

  @override
  String get servingHint => '1 misurino · 30 g';

  @override
  String get perServing => 'PER PORZIONE';

  @override
  String get servingsLabel => 'Porzioni';

  @override
  String get foodPhotoHint => 'Su uno sfondo uniforme diventa uno sticker.';

  @override
  String get cutoutWorking => 'Ritaglio…';

  @override
  String get cutoutTry => 'Ritaglia';

  @override
  String get cutoutKeep => 'Foto intera';

  @override
  String deleteFoodTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get deleteFoodBody => 'Esce dai tuoi alimenti. Quello che hai già segnato resta.';

  @override
  String get mealBreakfast => 'Colazione';

  @override
  String get mealLunch => 'Pranzo';

  @override
  String get mealDinner => 'Cena';

  @override
  String get mealSnacks => 'Spuntini';

  @override
  String get nothingLogged => 'Ancora niente segnato.';

  @override
  String addToMeal(String meal) {
    return 'Aggiungi a $meal';
  }

  @override
  String get quickAdd => 'Aggiunta rapida';

  @override
  String get quickAddHint => 'Solo i numeri, senza salvare un alimento.';

  @override
  String get quickAddName => 'Cos’era? (facoltativo)';

  @override
  String get logFood => 'Aggiungi';

  @override
  String loggedToast(String meal) {
    return 'Aggiunto a $meal';
  }

  @override
  String get entryRemoved => 'Rimosso';

  @override
  String get goalsFromProfile => 'Calcola dal mio profilo';

  @override
  String get goalsFromProfileHint =>
      'Calorie dal tuo profilo, 1,8 g di proteine e 35 ml d’acqua per kg di peso.';

  @override
  String get kcalEaten => 'Mangiato';

  @override
  String get kcalRemaining => 'Restano';

  @override
  String waterTapHint(String amount) {
    return 'Tocca il bicchiere: + $amount';
  }

  @override
  String get shakeEmpty => 'Tocca per scegliere il tuo shake';

  @override
  String shakeTapHint(String name) {
    return 'Tocca: + $name';
  }

  @override
  String get shakePick => 'Il tuo shake';

  @override
  String get shakePickHint => 'Tocca il bicchiere e viene segnato in un colpo.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'G';

  @override
  String get addBurnedLabel => 'Somma le calorie bruciate';

  @override
  String get addBurnedHint => 'Le calorie bruciate si stimano dalla durata degli allenamenti e dal tuo peso.';

  @override
  String get amountLabel => 'Quantità';

  @override
  String amountIn(String unit) {
    return 'Quantità ($unit)';
  }

  @override
  String get bodyweightLabel => 'Peso';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimenti copiati',
      one: '1 alimento copiato',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Quello che hai già segnato resta com’è.';

  @override
  String get fiberLabel => 'Fibre';

  @override
  String get sugarLabel => 'Zuccheri';

  @override
  String get sodiumLabel => 'Sodio';

  @override
  String get foodDatabase => 'Banca alimenti';

  @override
  String get kcalBurned => 'Bruciate';

  @override
  String get mealOptions => 'Opzioni del pasto';

  @override
  String get moreNutrients => 'Fibre, zuccheri e sodio';

  @override
  String ofGoal(int goal, String unit) {
    return 'su $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'per 100 $unit';
  }

  @override
  String get perServingShort => 'per porzione';

  @override
  String get foodCategory => 'CATEGORIA';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pezzi', one: '1 pezzo');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count fette', one: '1 fetta');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count misurini',
      one: '1 misurino',
    );
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cucchiai',
      one: '1 cucchiaio',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cucchiaini',
      one: '1 cucchiaino',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tazze', one: '1 tazza');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bicchieri',
      one: '1 bicchiere',
    );
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Recenti';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimenti',
      one: '1 alimento',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Rinomina';

  @override
  String get repeatFrom => 'Ripeti da';

  @override
  String get repeatNone => 'Ancora niente segnato per questo pasto negli altri giorni.';

  @override
  String get restDayGoals => 'Obiettivi diversi nei giorni di riposo';

  @override
  String get trainingDays => 'Giorni di allenamento';

  @override
  String get restDays => 'Giorni di riposo';

  @override
  String get trainingDay => 'Giorno di allenamento';

  @override
  String get saveAsMeal => 'Salva come pasto';

  @override
  String get savedMealNameHint => 'es. Colazione solita';

  @override
  String get savedMealToast => 'Pasto salvato';

  @override
  String get savedMeals => 'Pasti salvati';

  @override
  String get searchFoodsHint => 'Cerca alimenti';

  @override
  String get searchFoodsEmpty => 'Cerca tra oltre 500 alimenti con foto, o crea i tuoi.';

  @override
  String searchFoodsNone(String query) {
    return 'Niente per «$query». Crealo come alimento tuo.';
  }

  @override
  String get servingWeight => 'GRAMMI';

  @override
  String get weekAverage => 'Questa settimana';

  @override
  String get weekAvgEnergy => 'Media al giorno';

  @override
  String get weekAvgProtein => 'Proteine al giorno';

  @override
  String get weekEnergyOnTarget => 'Calorie in obiettivo';

  @override
  String get weekProteinOnTarget => 'Proteine in obiettivo';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g di proteine al giorno';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met giorni su $days in obiettivo';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni segnati',
      one: '1 giorno segnato',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Ancora niente segnato';

  @override
  String get weekOnTargetHint =>
      'In obiettivo: calorie entro il 10 % dell’obiettivo e almeno il 90 % delle proteine.';

  @override
  String get weightGoalLabel => 'Peso obiettivo';

  @override
  String weightGoalTitle(String unit) {
    return 'Peso obiettivo ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Obiettivo $weight';
  }

  @override
  String get weightGoalNone => 'Tieni premuto per fissarlo';

  @override
  String get weightGoalReached => 'Obiettivo raggiunto';

  @override
  String weightToLose(String weight) {
    return '$weight da perdere';
  }

  @override
  String weightToGain(String weight) {
    return '$weight da prendere';
  }

  @override
  String get aminoHis => 'istidina';

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
  String get aminoTrp => 'triptofano';

  @override
  String get aminoVal => 'valina';

  @override
  String get animalProtein => 'Proteine animali';

  @override
  String get proteinQuality => 'Qualità delle proteine';

  @override
  String get qualityComplete => 'Completa';

  @override
  String get qualityAlmost => 'Quasi completa';

  @override
  String get qualityIncomplete => 'Incompleta';

  @override
  String get qualityNoData => 'Ancora nessun dato';

  @override
  String get qualityNoDataHint => 'Segna alimenti della banca per vedere i tuoi amminoacidi.';

  @override
  String get qualityAllCovered => 'Copri tutti e nove gli amminoacidi essenziali.';

  @override
  String qualityLimiting(String amino) {
    return 'Ti manca $amino. Abbinalo ad alimenti che ne sono ricchi.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Calcolato sul $pct % delle tue proteine: i tuoi alimenti non hanno dati sugli amminoacidi.';
  }

  @override
  String get fatTypes => 'Tipi di grassi';

  @override
  String get fatSaturated => 'Saturi';

  @override
  String get fatMono => 'Mono';

  @override
  String get fatPoly => 'Poli';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Saturi $grams g su max $limit g (10 % delle calorie)';
  }

  @override
  String get sugarSodium => 'Zuccheri e sodio';

  @override
  String get shakeCard => 'Shake proteico';

  @override
  String get mealOther => 'Pasto';

  @override
  String get mealAdd => 'Aggiungi un pasto';

  @override
  String get mealAddHint => 'es. Pre-allenamento';

  @override
  String get mealsOfDay => 'Pasti della giornata';

  @override
  String get mealsHint => 'Creane quanti vuoi. Se ne togli uno, quello che c’era passa a quello sopra.';

  @override
  String get trackersTitle => 'Personalizza';

  @override
  String get trackersHint => 'Lascia solo quello che vuoi seguire.';

  @override
  String get trackersDaily => 'Riepilogo del giorno';

  @override
  String get trackersDetail => 'Nel dettaglio';

  @override
  String get trackersCards => 'Schede';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Nuovo lotto';

  @override
  String get prepNew => 'Nuovo lotto';

  @override
  String get prepEdit => 'Modifica lotto';

  @override
  String get prepHint => 'Segna la pentola intera una volta, poi mangiala un po’ alla volta.';

  @override
  String get prepEmpty =>
      'Hai cucinato per più giorni? Segnalo una volta e poi di’ solo quanto hai mangiato di quel che resta.';

  @override
  String get prepNameHint => 'es. Pollo e riso';

  @override
  String get prepDefaultName => 'Lotto';

  @override
  String get prepIngredients => 'Ingredienti';

  @override
  String get prepAddIngredient => 'Aggiungi ingrediente';

  @override
  String get prepCookedWeight => 'PESO COTTO';

  @override
  String prepCookedHint(String grams) {
    return 'Pesa la pentola da cotta per numeri esatti. Vuoto = peso crudo totale ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Indica il peso cotto: alcuni ingredienti non hanno grammi.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Restano $left di $total';
  }

  @override
  String get prepOfWhatsLeft => '% di quel che resta';

  @override
  String get prepAll => 'Tutto';

  @override
  String prepLogAmount(String grams) {
    return 'Segna $grams';
  }

  @override
  String get prepWeighLeft => 'Pesa il resto';

  @override
  String get prepFinished => 'Questo lotto è finito.';

  @override
  String get approxValues => 'Approssimativo';

  @override
  String get editValues => 'Modifica valori';

  @override
  String get editValuesHint =>
      'Cambia solo questa voce. Per correggere l’alimento la prossima volta, modificalo da I miei alimenti.';

  @override
  String get editLibraryHint => 'Si salva come alimento tuo, con la stessa foto';

  @override
  String per100Line(String energy, String unit) {
    return '$energy per 100 $unit';
  }

  @override
  String get rawLabel => 'Crudo';

  @override
  String get cookedLabel => 'Cotto';

  @override
  String get rawHint => 'Peso prima della cottura';

  @override
  String cookedHint(String factor) {
    return 'Peso da cotto (×$factor il peso crudo)';
  }

  @override
  String get servingsUnit => 'porzioni';

  @override
  String logAmount(String energy) {
    return 'Segna · $energy';
  }

  @override
  String get catFruit => 'Frutta';

  @override
  String get catVeg => 'Verdura';

  @override
  String get catMeat => 'Carne';

  @override
  String get catFish => 'Pesce';

  @override
  String get catEgg => 'Uova';

  @override
  String get catDairy => 'Latticini';

  @override
  String get catGrain => 'Cereali';

  @override
  String get catBakery => 'Pane';

  @override
  String get catLegume => 'Legumi';

  @override
  String get catNut => 'Frutta secca';

  @override
  String get catOil => 'Oli';

  @override
  String get catPantry => 'Dispensa';

  @override
  String get catDrink => 'Bevande';

  @override
  String get catSauce => 'Salse';

  @override
  String get catSpice => 'Spezie';

  @override
  String get searchFoodsPrompt => 'Cosa hai mangiato?';

  @override
  String get shelfEmpty => 'Cerca un alimento o fotografa il tuo: qui compariranno quelli che segni di più.';

  @override
  String get repeatEntry => 'Ripeti';

  @override
  String get notifSuppChannel => 'Integratori';

  @override
  String get notifSuppChannelWhy => 'Promemoria quotidiano per prendere gli integratori';

  @override
  String get energySplit => 'Da dove vengono le calorie';

  @override
  String get typicalServing => 'Porzione tipica';

  @override
  String cookedYieldLine(String factor) {
    return 'Pesa $factor× il peso da crudo';
  }

  @override
  String get readyDishes => 'Piatti';

  @override
  String weightLastLine(String weight) {
    return 'Ultima pesata $weight';
  }

  @override
  String get proteinAnimalShort => 'Animale';

  @override
  String get proteinPlantShort => 'Vegetale';

  @override
  String kcalFromMacros(String value) {
    return 'Questi macro fanno circa $value';
  }

  @override
  String get useValue => 'Usa';

  @override
  String get suppRowHint => 'Tocca per segnare · tieni premuto per i dettagli';

  @override
  String get suppPhoto => 'Foto';

  @override
  String get suppDose => 'Dose';

  @override
  String get suppDoseHint => '5 g, 2 capsule…';

  @override
  String get suppRemind => 'Ricordamelo';

  @override
  String mealPlanDefault(int n) {
    return 'Piano $n';
  }

  @override
  String get mealPlansTitle => 'Piani pasto';

  @override
  String get mealPlanNew => 'Nuovo piano';

  @override
  String fromPlan(String name) {
    return 'Da $name';
  }

  @override
  String get logPlan => 'Registra';

  @override
  String get planFromDay => 'Copia questo giorno';

  @override
  String get planNewHint =>
      'Pianifica i tuoi giorni come le tue routine, poi registra un pasto intero con un tocco.';

  @override
  String get planLogDay => 'Registra i pasti vuoti';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n alimenti registrati',
      one: '1 alimento registrato',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Nessun piano';

  @override
  String get planWeekHint => 'Tocca un giorno per assegnargli un piano.';

  @override
  String get planDuplicate => 'Duplica';

  @override
  String planDeleteTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get planDeleteBody => 'Le tue routine restano. Viene rimossa solo questa settimana salvata.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Nutrizione';

  @override
  String get nutritionBetaHint => 'Pasti, acqua e integratori';

  @override
  String get nutritionAboutTitle => 'Informazioni sulla nutrizione';

  @override
  String get nutritionAboutSub => 'Cos’è, e cosa non sarà mai.';

  @override
  String get nutritionAboutWhatTitle => 'Parte del tuo allenamento';

  @override
  String get nutritionAboutWhat =>
      'Un modo semplice per segnare pasti, acqua, proteine e integratori accanto ai tuoi allenamenti. GymMane è prima di tutto un’app da palestra: la nutrizione c’è per avere tutto in un unico posto, non per sostituire un’app di diete.';

  @override
  String get nutritionAboutScanTitle => 'Niente scanner, mai';

  @override
  String get nutritionAboutScan =>
      'Scansionare un codice a barre e vedere tutto compilato da solo sarebbe comodo. Ma servono Internet e un enorme database di alimenti online, e quello che mangi finisce sui server di qualcun altro. Quei dati dicono quando mangi, cosa mangi e come ti prendi cura del tuo corpo, e possono essere usati per la pubblicità o finire nelle mani di grandi aziende. Per questo non c’è uno scanner, e non ci sarà.';

  @override
  String get nutritionAboutLocalTitle => 'Tutto sul tuo telefono';

  @override
  String get nutritionAboutLocal =>
      'L’app include più di 500 alimenti con foto. Puoi aggiungere i tuoi, cambiarne le foto e modificarne i valori. Tutto resta sul tuo telefono, come il resto di GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Ancora in beta';

  @override
  String get nutritionAboutBeta =>
      'Se ti manca qualcosa, proponilo su GitHub. Ma niente scanner né un database di alimenti più grande: oltre alla tua privacy, renderebbe l’app molto più pesante. Non ti serve la nutrizione? Disattivala nelle Impostazioni e i tuoi dati restano.';

  @override
  String get nutritionAboutSuggest => 'Proponi un’idea';

  @override
  String get nutritionAboutOk => 'Ho capito';

  @override
  String get planShare => 'Condividi';

  @override
  String get planImport => 'Importa un piano';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n piani importati',
      one: '1 piano importato',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'Questo file non contiene piani pasto.';

  @override
  String get planMoveUp => 'Sposta su';

  @override
  String get planMoveDown => 'Sposta giù';

  @override
  String get cutoutEdit => 'Ritocca il ritaglio';

  @override
  String get cutoutEditHint =>
      'Trascina per cancellare o ripristinare. Tocca un\'area per toglierla o rimetterla intera. Pizzica per ingrandire.';

  @override
  String get cutoutErase => 'Cancella';

  @override
  String get cutoutRestore => 'Ripristina';

  @override
  String get cutoutReset => 'Torna all\'automatico';

  @override
  String get cutoutByHand => 'Ritaglia a mano';

  @override
  String notifSuppTitleFor(String names) {
    return 'È ora di prendere: $names';
  }

  @override
  String get notifSuppTap => 'Segnalo in GymMane quando l\'hai preso.';

  @override
  String get suppNoneToday => 'Niente da prendere oggi.';

  @override
  String get suppOtherDays => 'Altri giorni';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Ogni $n giorni', one: 'Ogni giorno');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Ogni giorno';

  @override
  String suppFromDate(String date) {
    return 'dal $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'fino al $date';
  }

  @override
  String get suppSomeDays => 'Alcuni giorni';

  @override
  String get suppEveryShort => 'Ogni X giorni';

  @override
  String get suppWhen => 'Quando';

  @override
  String get suppEveryLead => 'Ogni';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'giorni', one: 'giorno');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Inizio';

  @override
  String get suppEnds => 'Fine';

  @override
  String get suppTomorrow => 'Domani';

  @override
  String get suppPickDate => 'Scegli una data';

  @override
  String get suppNever => 'Mai';

  @override
  String get suppOneWeek => 'Tra 1 settimana';

  @override
  String get suppOneMonth => 'Tra 1 mese';

  @override
  String get planPickHint => 'Scegli il piano per questo giorno o creane uno nuovo.';

  @override
  String planSetForDay(String day) {
    return 'Piano impostato per $day';
  }

  @override
  String get planSaved => 'Piano salvato';

  @override
  String get planDiscardTitle => 'Scartare le modifiche?';

  @override
  String get planDiscardBody => 'Quello che hai cambiato non verrà salvato.';

  @override
  String get planDiscard => 'Scarta';

  @override
  String get planEdit => 'Modifica piano';

  @override
  String get planNameHint => 'Estate, viaggio…';

  @override
  String get planDaysQuestion => 'Quali giorni?';

  @override
  String get planDaysHint => 'In quei giorni compare in Nutrizione, così lo registri con un tocco.';

  @override
  String get planDaysNone => 'Scegli almeno un giorno, o non comparirà da nessuna parte.';

  @override
  String get planNothingToLog => 'Quei pasti sono già registrati';

  @override
  String get planSave => 'Salva piano';

  @override
  String get planToday => 'Piano di oggi';

  @override
  String get planLogRest => 'Registra il resto';

  @override
  String get dishNew => 'Crea il mio piatto';

  @override
  String get dishNewHint => 'Scegli ingredienti e quantità, salvalo e registralo con un tocco.';

  @override
  String get dishEdit => 'Modifica piatto';

  @override
  String get dishNameHint => 'Es. Le lenticchie della mamma';

  @override
  String get dishIngredients => 'Ingredienti';

  @override
  String get dishEmptyHint => 'Aggiungi cosa contiene con la quantità che mangi di solito.';

  @override
  String get dishSave => 'Salva piatto';

  @override
  String get dishNeedsName => 'Dagli un nome';

  @override
  String get dishNeedsItems => 'Aggiungi almeno un ingrediente';

  @override
  String get suppHistory => 'Ultimi 14 giorni';

  @override
  String suppTakenOf(int n, int total) {
    return '$n di $total presi';
  }

  @override
  String get suppNoReminder => 'Nessun promemoria';

  @override
  String get suppMarkTaken => 'Segna come preso';

  @override
  String get suppUnmark => 'Togli il segno';

  @override
  String get suppEdit => 'Modifica';

  @override
  String get mealMoveTo => 'Sposta in';

  @override
  String get mealClear => 'Svuota pasto';

  @override
  String get mealCleared => 'Pasto svuotato';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alimenti spostati',
      one: '1 alimento spostato',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Ripeti tutto il giorno';

  @override
  String createFoodNamed(String name) {
    return 'Crea “$name”';
  }

  @override
  String get entryDay => 'Giorno';

  @override
  String get movedToDay => 'Spostato';

  @override
  String get favFoodsHint => 'Tocca ☆ su un alimento';

  @override
  String get favFoodsEmpty => 'Tocca la stella su un alimento per tenerlo qui, a portata di tocco.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pasti', one: '1 pasto');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Salva un pasto dal suo menu ••• o crea il tuo piatto.';

  @override
  String get sugarLimitLabel => 'Limite di zucchero';

  @override
  String get sodiumLimitLabel => 'Limite di sodio';

  @override
  String get waterOptions => 'Opzioni acqua';

  @override
  String get waterNone => 'Ancora nessuna acqua registrata.';

  @override
  String get waterDailyGoal => 'Acqua al giorno';

  @override
  String get trackersScreen => 'Schermo';

  @override
  String get vesselMotion => 'Acqua in movimento e shaker';

  @override
  String get vesselMotionHint =>
      'Disattivalo se lo schermo sembra lento: i bicchieri si riempiono comunque, smettono solo di muoversi.';

  @override
  String get planFixedWeek => 'Settimana fissa';

  @override
  String get planRotation => 'Rotazione';

  @override
  String get rotationTitle => 'ROTAZIONE';

  @override
  String get rotationHint => 'Tocca alla successiva dopo l’ultimo allenamento, qualunque sia il giorno.';

  @override
  String get rotationEmpty => 'Aggiungi le routine nell’ordine in cui le farai: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done di $total fatte in questo giro';
  }

  @override
  String get rotationNext => 'Prossima';

  @override
  String get rotationAdd => 'Aggiungi routine';

  @override
  String get rotationPickHint => 'Vanno nell’ordine in cui le tocchi.';

  @override
  String get rotationSkip => 'Passa alla successiva';

  @override
  String get rotationRestart => 'Nuovo giro';

  @override
  String get rotationMakeNext => 'Rendila la prossima';

  @override
  String get rotationRemove => 'Togli dalla rotazione';

  @override
  String rotationPlace(int n, int total) {
    return '$n di $total della rotazione';
  }

  @override
  String get moveToDay => 'Sposta a un altro giorno';

  @override
  String get moveToDayHint => 'Solo questa volta; il piano settimanale resta uguale.';

  @override
  String get movedToast => 'Allenamento spostato';

  @override
  String get backToPlan => 'Torna al piano settimanale';

  @override
  String get tomorrow => 'Domani';

  @override
  String get untrainedTab => 'Trascurati';

  @override
  String get untrainedRecent => 'Recente';

  @override
  String get untrainedLong => 'Tempo fa';

  @override
  String untrainedWaiting(String list) {
    return 'Fermi da più tempo: $list';
  }

  @override
  String get untrainedAllRecent => 'Tutti i muscoli hanno lavorato questa settimana. Ottimo.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n giorni fa',
      one: 'Allenato ieri',
      zero: 'Allenato oggi',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Non ancora allenato';

  @override
  String get layoutSetting => 'Vista allenamento';

  @override
  String get layoutCards => 'Schede';

  @override
  String get layoutList => 'Lista';

  @override
  String get layoutHint =>
      'Le schede mostrano un esercizio alla volta. La lista mostra tutto l’allenamento in una schermata, serie per serie.';

  @override
  String get layoutRowHint => 'Un esercizio alla volta o tutto in lista';

  @override
  String get previousCol => 'PRECEDENTE';

  @override
  String get usePrevious => 'Usa i valori dell’ultima volta';

  @override
  String get skipShort => 'Salta';

  @override
  String get moveUp => 'Sposta su';

  @override
  String get moveDown => 'Sposta giù';

  @override
  String get widgetNutritionOff => 'Attiva Nutrizione in Impostazioni › Beta per usare questo widget.';

  @override
  String get widgetPickShake => 'Scegli il tuo shake';

  @override
  String get heatRangeSetting => 'Calendario attività';

  @override
  String get heatRangeWeeks => '12 settimane';

  @override
  String get heatRangeYear => '12 mesi';

  @override
  String get heatRangeHint =>
      '12 mesi mostra tutto l’anno. Scorri di lato per tornare indietro, fino al tuo primo allenamento.';

  @override
  String get pdfPlan => 'Piano in PDF';

  @override
  String get pdfPlanHint =>
      'Un foglio pulito con la tua settimana e ogni routine, pronto da stampare o inviare.';

  @override
  String get pdfExport => 'Esporta in PDF';

  @override
  String get pdfFooter => 'Gratuita, open source e offline';

  @override
  String get shakeTag => 'È uno shake';

  @override
  String get shakeTagHint => 'Compare in Il tuo shake';

  @override
  String get shakeNone => 'Segna i tuoi shake e qui compariranno solo quelli.';

  @override
  String get shakeMarkLabel => 'SEGNA COME SHAKE';

  @override
  String get shakeNew => 'Nuovo shake';

  @override
  String get shakeUntag => 'Non è uno shake';

  @override
  String get pdfKicker => 'PIANO DI ALLENAMENTO';

  @override
  String get pdfStatDays => 'GIORNI / SETT.';

  @override
  String get pdfStatMinutes => 'MIN / ALLENAMENTO';

  @override
  String pdfMinutes(int n) {
    return '≈ $n min';
  }

  @override
  String get workoutNotesTitle => 'Note dell’esercizio';

  @override
  String get workoutNoteEvery => 'Ogni volta';

  @override
  String get workoutNoteNext => 'La prossima volta';

  @override
  String get workoutNoteEveryHint => 'Compare ogni volta che fai l’esercizio. Ideale per sedile o cavo.';

  @override
  String get workoutNoteNextHint => 'Compare solo la prossima volta, poi sparisce.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Dall’ultima volta · $date';
  }

  @override
  String get workoutNoteHint => 'Sedile al foro 2, cavo a 19…';

  @override
  String get notePinWorkout => 'Mostra durante l’allenamento';

  @override
  String get assistedSetting => 'Macchina assistita';

  @override
  String get assistedSettingHint => 'Il peso ti aiuta, quindi meno è meglio: record e suggerimenti scendono.';

  @override
  String get assistedRecordHint => 'Meno assistenza';

  @override
  String get trainAgainLabel => 'Non ti sei ancora allenato? Ricordamelo';

  @override
  String get trainAgainOff => 'No';

  @override
  String trainAgainAfter(int n) {
    return '+$n h';
  }

  @override
  String get trainAgainHint => 'Una sola volta, e solo se quel giorno non hai registrato allenamenti.';

  @override
  String get notifTrainAgainBody => 'Sei ancora in tempo per allenarti oggi.';

  @override
  String nextDeload(int n) {
    return 'più leggero: $n allenamenti di fila senza tutte le ripetizioni';
  }

  @override
  String get historyTitle => 'Cronologia';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ALLENAMENTI',
      one: '1 ALLENAMENTO',
    );
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Nessun allenamento questo mese';

  @override
  String get historyEmptyHint => 'Scorri di lato o usa le frecce per vedere altri mesi.';

  @override
  String historyMore(int n) {
    return '+$n altri';
  }

  @override
  String get stopwatch => 'Cronometro';

  @override
  String get proteinSource => 'Fonte di proteine';

  @override
  String get proteinMixedShort => 'Mista';

  @override
  String get kcalActive => 'attive';

  @override
  String get kcalEstimated => 'stimate';

  @override
  String get kcalYours => 'il tuo valore';

  @override
  String kcalTotalRest(String value) {
    return '$value in totale, contando ciò che bruci a riposo';
  }

  @override
  String get inclineLabel => 'Inclinazione';

  @override
  String get kcalUseOwn => 'Usa il mio valore';

  @override
  String get kcalBackToEstimate => 'Torna alla stima';

  @override
  String get kcalNeedsData => 'Aggiungi distanza e tempo per stimare le calorie';

  @override
  String get kcalHowEstimated => 'Stimate da distanza, tempo, inclinazione e il tuo peso (formula ACSM).';

  @override
  String get kcalOwnTitle => 'Calorie attive';

  @override
  String get planMine => 'Il mio piano';

  @override
  String get planNew => 'Nuovo piano';

  @override
  String get planSaveWeek => 'Salva questa settimana';

  @override
  String get planSaveWeekHint => 'Tieni la settimana attuale come piano a cui tornare';

  @override
  String get planEmptyWeek => 'Inizia una settimana vuota';

  @override
  String get planEmptyWeekHint => 'La settimana attuale resta salvata come piano';

  @override
  String get planName => 'Nome del piano';

  @override
  String get planRename => 'Rinomina';

  @override
  String get planDelete => 'Elimina piano';

  @override
  String get plansHint => 'Le modifiche alla settimana si salvano nel piano scelto';

  @override
  String get progression => 'Progressione';

  @override
  String get progManual => 'Manuale';

  @override
  String get progManualHint => 'Nessun suggerimento: scegli tu ogni peso.';

  @override
  String get progLinear => 'Lineare';

  @override
  String get progLinearHint => 'Completa tutte le ripetizioni e il peso sale.';

  @override
  String get progDouble => 'Doppia progressione';

  @override
  String get progDoubleHint => 'Più ripetizioni fino al massimo del range, poi più peso.';

  @override
  String get progVolume => 'Ripetizioni, serie e peso';

  @override
  String get progVolumeHint => 'Ripetizioni fino al massimo, poi una serie in più, poi più peso.';

  @override
  String get progAmrap => 'Ultima serie a cedimento';

  @override
  String get progAmrapHint =>
      'Ultima serie: tutte le ripetizioni che puoi. Se raddoppi l\'obiettivo, sale il doppio.';

  @override
  String get progStep => 'Aumento di peso';

  @override
  String get progRange => 'Range di ripetizioni';

  @override
  String get progSets => 'Serie';

  @override
  String get progDeload => 'Più leggero dopo';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n mancate', one: '1 mancata');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Riduci del';

  @override
  String get progApply => 'Compila il prossimo allenamento';

  @override
  String get progApplyHint => 'Spento, appare solo come suggerimento.';

  @override
  String get nextMoreReps => 'stesso peso, una ripetizione in più';

  @override
  String get nextAddSet => 'una serie in più';

  @override
  String get nextAmrap => 'ultima serie: tutte quelle che puoi';

  @override
  String fillDay(String amount) {
    return 'Completa la giornata · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Ti resteranno $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Ti resteranno $kcal e $grams g di proteine';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal oltre il tuo obiettivo';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit al giorno';
  }

  @override
  String get byZone => 'Per zona';

  @override
  String get importAlreadyHave => 'Hai già queste routine. Puoi aggiungerle di nuovo come copia.';

  @override
  String get importAsCopy => 'Aggiungi come copia';

  @override
  String get routineExerciseNote => 'Routine note';

  @override
  String get importRoutineNotes => 'Add missing routine notes';

  @override
  String get routineNotesAdded => 'Routine notes added';

  @override
  String get importOwned => 'Già tua';

  @override
  String get setDuplicated => 'Serie duplicata';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Una serie divisa in piccoli blocchi con 15–30 secondi tra l’uno e l’altro. Segna le ripetizioni totali.';

  @override
  String timesBodyweight(String value) {
    return '$value× il tuo peso corporeo';
  }

  @override
  String get archiveRoutine => 'Archivia routine';

  @override
  String get routineArchived => 'Routine archiviata';

  @override
  String get archivedRoutines => 'Archiviate';

  @override
  String get autoBackup => 'Backup automatico';

  @override
  String get autoBackupHint =>
      'Salva uno ZIP con tutti i tuoi dati nella cartella che scegli. Sincronizza quella cartella con Nextcloud, Syncthing o un\'altra app per avere una copia fuori dal telefono.';

  @override
  String get autoBackupFolder => 'Scegli cartella';

  @override
  String get autoBackupNoFolder => 'Nessuna cartella';

  @override
  String get autoBackupOff => 'Disattivato';

  @override
  String get autoBackupWorkout => 'Dopo ogni allenamento';

  @override
  String get autoBackupDaily => 'Una volta al giorno';

  @override
  String get autoBackupWeekly => 'Una volta a settimana';

  @override
  String get autoBackupOnLeave => 'Quando esci dall\'app';

  @override
  String get autoBackupKeep => 'Copie da tenere';

  @override
  String get autoBackupNow => 'Fai backup ora';

  @override
  String autoBackupLast(String when) {
    return 'Ultimo backup $when';
  }

  @override
  String get autoBackupNever => 'Ancora nessun backup';

  @override
  String get autoBackupLost => 'Non è stato possibile salvare l\'ultimo backup. Scegli di nuovo la cartella.';

  @override
  String get autoBackupSaved => 'Backup salvato';

  @override
  String get prepPortions => 'Porzioni';

  @override
  String get rotationAddRest => 'Aggiungi un giorno di riposo';

  @override
  String get rotationRestHint => 'Passa da sola il giorno dopo';

  @override
  String get rotationRestToday => 'Oggi';

  @override
  String get rotationSkipRest => 'Salta questo riposo';

  @override
  String rotationRestUpNext(String name) {
    return 'Poi: $name';
  }

  @override
  String get trainAnyway => 'Allenati lo stesso';

  @override
  String get healthTitle => 'Salute';

  @override
  String get healthSetting => 'Dati sulla salute';

  @override
  String get healthSettingHint => 'Dati di Health Connect in Progressi';

  @override
  String get healthPickTitle => 'Dati sulla salute';

  @override
  String get healthPickHint =>
      'Scegli cosa prendere da Health Connect. Android chiede una volta per ciascuno. Viene solo letto e non lascia mai il telefono.';

  @override
  String get healthGroupHeart => 'Cuore';

  @override
  String get healthGroupVitals => 'Parametri vitali';

  @override
  String get healthGroupActivity => 'Attività';

  @override
  String get healthRestingHr => 'Frequenza cardiaca a riposo';

  @override
  String get healthHeartRate => 'Frequenza cardiaca media';

  @override
  String get healthHrv => 'Variabilità cardiaca';

  @override
  String get healthSpo2 => 'Ossigeno nel sangue';

  @override
  String get healthRespiration => 'Frequenza respiratoria';

  @override
  String get healthBloodPressure => 'Pressione sanguigna';

  @override
  String get healthTemperature => 'Temperatura corporea';

  @override
  String get healthSleep => 'Sonno';

  @override
  String get healthDistance => 'Distanza';

  @override
  String get healthFloors => 'Piani saliti';

  @override
  String get healthElevation => 'Dislivello positivo';

  @override
  String get healthActiveKcal => 'Calorie attive';

  @override
  String get healthNoData => 'Ancora nessun dato';

  @override
  String get healthReadFailed => 'Impossibile leggere';

  @override
  String get healthAllow => 'Tocca per consentire';

  @override
  String get healthLast7 => 'Ultimi 7 giorni';

  @override
  String get healthAvg30 => 'Media 30 giorni';

  @override
  String get healthLow => 'Minimo';

  @override
  String get healthHigh => 'Massimo';

  @override
  String get healthFrom => 'Da Health Connect · ultimi 30 giorni';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'resp/min';

  @override
  String get weekTab => 'Settimana';

  @override
  String get muscleSetsList => 'Serie per muscolo';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Facoltativo. Lascia vuoto ciò che l\'etichetta non indica.';

  @override
  String get sessionPhotos => 'Foto dell\'allenamento';

  @override
  String get sessionPhotosAdd => 'Aggiungi foto';

  @override
  String get sessionPhotosHint => 'Restano anche in Le tue foto.';

  @override
  String get ladderTitle => 'Progressione';

  @override
  String get ladderHint =>
      'Ordina i passi dal più facile al più difficile. Quando fai 3 serie da 8 per due sessioni di fila (5 nei lenti), GymMane ti propone il successivo.';

  @override
  String get ladderBuiltIn =>
      'Parte dalla progressione dell\'app. Aggiungi, togli o riordina i passi e diventa quella di questa routine.';

  @override
  String get ladderNone => 'Ancora nessuna. Tocca per crearne una.';

  @override
  String ladderStep(int n, int total) {
    return 'Passo $n di $total';
  }

  @override
  String get ladderAdd => 'Aggiungi passo';

  @override
  String get ladderInRoutine => 'Nella routine';

  @override
  String get ladderClear => 'Usa quella dell\'app';

  @override
  String get ladderPick => 'Scegli un passo';

  @override
  String get periodWeek => 'questa settimana';

  @override
  String get periodMonth => 'questo mese';

  @override
  String get periodYear => 'quest\'anno';

  @override
  String get periodAll => 'da sempre';

  @override
  String get settingsSearch => 'Cerca nelle impostazioni';

  @override
  String get settingsNoResults => 'Nessuna impostazione con quel nome';

  @override
  String get settingsGroupApp => 'La tua app';

  @override
  String get settingsGroupHome => 'Home ed extra';

  @override
  String get settingsGroupData => 'Dati e aiuto';

  @override
  String get healthAllowAll => 'Attiva tutto';

  @override
  String get healthSeeAll => 'Vedi tutto';

  @override
  String get healthPinTitle => 'Sulla scheda';

  @override
  String get healthPinHint => 'Scegline fino a 3 per la scheda Progressi.';

  @override
  String get blurSetting => 'Effetti sfocatura';

  @override
  String get blurSettingHint => 'Spegnilo se il telefono è lento';

  @override
  String get lowEndTitle => 'Il tuo telefono ha poca memoria';

  @override
  String get lowEndBody =>
      'Senza sfocatura tutto scorre meglio. Puoi riattivarla in Impostazioni → Generali.';

  @override
  String get lowEndOff => 'Disattiva sfocatura';

  @override
  String get lowEndKeep => 'Tienila';

  @override
  String get momentsThisMonth => 'Questo mese';

  @override
  String get momentsDays => 'Giorni con foto';

  @override
  String get awardsPick => 'Scegli per il profilo';

  @override
  String get awardsPickHint => 'Tocca quelle che vuoi nel profilo';

  @override
  String get gymPassPicture => 'Salva una foto del codice';

  @override
  String get gymPassPictureHint =>
      'Per i codici che l\'app non legge: mostra la tua foto alla massima luminosità';

  @override
  String get gymPassPictureFormat => 'Foto';

  @override
  String get gymPassUsePicture => 'Salva la foto';

  @override
  String get gymPassChangePicture => 'Cambia foto';

  @override
  String get cropTitle => 'Ritaglia il codice';

  @override
  String get cropHint => 'Sposta gli angoli finché resta solo il codice';

  @override
  String get rotatePhoto => 'Ruota';

  @override
  String get cardioNoSets => 'Il cardio non conta nelle serie settimanali per muscolo';

  @override
  String get countsAsWater => 'Conta come acqua';

  @override
  String get countsAsWaterHint => 'Per gli shake fatti con acqua: registrarlo aggiunge anche alla tua acqua';

  @override
  String get waterPerServing => 'Acqua per porzione';

  @override
  String get estOneRm => '1RM stimato';

  @override
  String get newInWorkout => 'Nuovo in questo allenamento';

  @override
  String newInWorkoutHint(String routine) {
    return 'Aggiungilo a $routine con le serie appena fatte. Il resto della scheda non cambia.';
  }

  @override
  String get addedToRoutine => 'Aggiunto';

  @override
  String get addShort => 'Aggiungi';

  @override
  String get allTimeLifted => 'SOLLEVATO';

  @override
  String get pctBodyweight => '% del peso';

  @override
  String get ofBodyweight => 'del tuo peso';

  @override
  String get recoveryStateMid => 'In recupero';

  @override
  String get recoveryStateReady => 'Pronto';

  @override
  String recoveringIn(String time) {
    return 'In recupero tra $time';
  }

  @override
  String readyIn(String time) {
    return 'Pronto tra $time';
  }

  @override
  String get recoveryReadyNow => 'Pronto per allenarlo di nuovo';

  @override
  String get restAfterThisSet => 'Recupero dopo questa serie';

  @override
  String restUsual(String time) {
    return 'Solito: $time';
  }

  @override
  String get restJustToday => 'Solo per questa serie, oggi';

  @override
  String get restUseUsual => 'Torna al recupero solito';

  @override
  String get restChange => 'Cambia';

  @override
  String get noRestTimer => 'Senza timer';

  @override
  String get sessionMuscles => 'Muscoli di questo allenamento';

  @override
  String get sessionMusclesHint =>
      'Tenue è ancora da fare, acceso è fatto. Serie per muscolo, i secondari contano metà.';

  @override
  String get miniBodySetting => 'Piccola mappa muscolare sulle schede';

  @override
  String get miniBodySettingHint => 'Muscoli di ogni routine';

  @override
  String get balanceTitle => 'Equilibrio di forza';

  @override
  String get balanceWhy => 'Come funziona';

  @override
  String get balanceGood => 'I tuoi esercizi base sono in equilibrio';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift è indietro: mancano circa $gap';
  }

  @override
  String get balanceHint =>
      'Confronta i tuoi 1RM stimati degli ultimi 4 mesi con proporzioni classiche: squat 100%, stacco 120%, panca 75%, rematore 52%, lento avanti 45%. Un esercizio molto sotto gli altri di solito è un punto debole.';

  @override
  String get balanceEven => 'In equilibrio';

  @override
  String get balanceBehindShort => 'Indietro';

  @override
  String get balanceAheadShort => 'Avanti';

  @override
  String get holdProgress => 'Progressione a tempo';

  @override
  String get holdProgressHint => 'Aggiunge secondi quando tieni tutte le serie';

  @override
  String holdProgressOn(int s) {
    return '+$s s ogni volta che tieni tutte le serie';
  }

  @override
  String get paceTitle => 'Ritmo settimanale';

  @override
  String get paceOn => 'Ritmo giusto';

  @override
  String get paceTooFast => 'Più veloce del tuo intervallo';

  @override
  String get paceTooSlow => 'Più lento del tuo intervallo';

  @override
  String get paceWrongWay => 'Nella direzione opposta';

  @override
  String get paceDrifting => 'Ti muovi più di quanto consenta mantenere';

  @override
  String get paceSetAim => 'Tocca per scegliere l’obiettivo';

  @override
  String get paceBasis =>
      'Tendenza delle tue pesate delle ultime 3 settimane, così una cena salata non ti inganna.';

  @override
  String get paceAimTitle => 'Qual è il tuo obiettivo?';

  @override
  String get paceAimHint => 'La scheda ti dice se il ritmo va bene';

  @override
  String get paceLose => 'Perdere';

  @override
  String get paceHold => 'Mantenere';

  @override
  String get paceGain => 'Aumentare';

  @override
  String get paceAuto => 'Automatico';

  @override
  String get paceLoseRange => 'Dallo 0,5 all’1% del peso a settimana';

  @override
  String get paceHoldRange => 'Entro lo 0,25% a settimana';

  @override
  String get paceGainRange => 'Dallo 0,25 allo 0,5% del peso a settimana';

  @override
  String get paceAutoHint => 'Dal tuo peso obiettivo';

  @override
  String get weekShort => 'sett.';

  @override
  String get weightStack => 'Pacco pesi';

  @override
  String get weightStackHint =>
      'I pesi reali di questa macchina. + e −, progressione e scarichi cadono solo su questi.';

  @override
  String get weightStackOff => 'Spento: passi di peso normali';

  @override
  String get stackFrom => 'Da';

  @override
  String get stackTo => 'A';

  @override
  String get stackEvery => 'Ogni';

  @override
  String get stackFill => 'Riempi il pacco';

  @override
  String get stackTapToFix => 'Tocca un peso per correggerne uno strano o toglierlo.';

  @override
  String get stackAddWeight => 'Aggiungi un peso';

  @override
  String get stackEditWeight => 'Peso al perno';

  @override
  String get stackClear => 'Togli il pacco';

  @override
  String stackCount(int n) {
    return '$n pesi';
  }

  @override
  String get healthLinksTitle => 'Con i tuoi allenamenti';

  @override
  String get healthLinkHeart => 'Battito dal tuo orologio';

  @override
  String get healthLinkHeartHint => 'Battito medio e massimo di ogni allenamento, da qualsiasi orologio';

  @override
  String get healthLinkWeight => 'Pesate da altre app';

  @override
  String get healthLinkWeightHint =>
      'Le pesate della bilancia degli ultimi 30 giorni. Non sovrascrive mai una che hai scritto tu.';

  @override
  String get healthLinkDenied => 'Health Connect non ha dato il permesso';

  @override
  String get healthOpenSettings => 'Apri';

  @override
  String hrMaxShort(int bpm) {
    return 'max $bpm';
  }

  @override
  String get setNote => 'Nota per questa serie';

  @override
  String get setNoteHint => 'Presa, un fastidio, un consiglio che ha funzionato…';

  @override
  String setNoteLast(String note) {
    return 'L’ultima volta: $note';
  }

  @override
  String get lastTimeNotes => 'L’ultima volta';

  @override
  String setNoteLine(int n, String note) {
    return 'Serie $n · $note';
  }

  @override
  String get newMeasure => 'Nuova misura';

  @override
  String get newMeasureHint => 'Quello che vuoi seguire: polso, battito a riposo, acqua corporea…';

  @override
  String get measureKindLength => 'Lunghezza';

  @override
  String get measureKindLengthHint => 'In cm o pollici, come le altre';

  @override
  String get measureKindOther => 'Altro';

  @override
  String get measureKindOtherHint => 'Con la tua unità';

  @override
  String get measureUnit => 'Unità';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Polso, battito a riposo…';

  @override
  String get measureRename => 'Rinomina';

  @override
  String measureDeleteTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get measureDeleteBody => 'Se ne vanno anche tutti i valori che hai segnato.';

  @override
  String get measureDelete => 'Elimina questa misura';

  @override
  String get measureEvery => 'Ricordami di misurare';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Tra $n giorni',
      one: 'Domani',
      zero: 'Oggi',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'È ora di misurare';

  @override
  String get notifMeasureChannel => 'Misure corporee';

  @override
  String get notifMeasureChannelWhy => 'Un avviso quando è ora di rimisurarti.';

  @override
  String get notifMeasureTitle => 'È ora di misurarti';

  @override
  String notifMeasureBody(int n) {
    return '$n giorni dall’ultima volta. Stesso punto, stessa ora del giorno.';
  }

  @override
  String get healthLinkWrite => 'Salva i tuoi allenamenti';

  @override
  String get healthLinkWriteHint =>
      'Ogni allenamento finito va a Health Connect con orario e tipo, così lo contano anche le altre app. Invia anche gli ultimi 30 giorni.';

  @override
  String get healthWorkoutTitle => 'Allenamento';

  @override
  String get circuits => 'Circuiti a tempo';

  @override
  String get circuitsHint => 'Lavoro e pausa a cronometro, giro dopo giro';

  @override
  String get newCircuit => 'Nuovo circuito';

  @override
  String get editCircuit => 'Modifica circuito';

  @override
  String get circuitDefaultName => 'Circuito';

  @override
  String get circuitNameHint => 'Nome, tipo Finale core';

  @override
  String get circuitRounds => 'Giri';

  @override
  String get circuitRoundRest => 'Pausa tra i giri';

  @override
  String get circuitWork => 'Lavoro';

  @override
  String get circuitRest => 'Pausa';

  @override
  String get circuitAdd => 'Aggiungi esercizio';

  @override
  String get circuitEmpty =>
      'Aggiungi gli esercizi nell’ordine in cui li farai. Uno può esserci due volte, come il plank laterale per lato.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$steps esercizi',
      one: '1 esercizio',
    );
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds giri', one: '1 giro');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Inizia';

  @override
  String get circuitGetReady => 'Preparati';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Giro $n di $total';
  }

  @override
  String circuitNext(String name) {
    return 'Poi: $name';
  }

  @override
  String get circuitFinishLine => 'L’ultimo e hai finito';

  @override
  String get circuitDone => 'Circuito fatto';

  @override
  String circuitDoneBody(String time) {
    return '$time · salvato nella tua cronologia';
  }

  @override
  String get circuitStopTitle => 'Fermare il circuito?';

  @override
  String get circuitStopBody => 'Quello che hai fatto finora viene salvato nella cronologia.';

  @override
  String get circuitStop => 'Ferma';

  @override
  String get circuitKeepGoing => 'Continua';

  @override
  String circuitDeleteTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get circuitDeleteBody => 'Gli allenamenti già fatti con questo restano nella cronologia.';

  @override
  String get circuitPickExercise => 'Scegli un esercizio';

  @override
  String get circuitNoSteps => 'Aggiungi almeno un esercizio';

  @override
  String get circuitPrevious => 'Precedente';

  @override
  String get circuitUpNext => 'Ora tocca a';

  @override
  String get foodGroupNew => 'Nuova categoria';

  @override
  String get foodGroupHint => 'Piatti pronti, surgelati…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n alimenti',
      one: '1 alimento',
      zero: 'Ancora nessun alimento',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Eliminare $name?';
  }

  @override
  String get foodGroupDeleteBody => 'I tuoi alimenti restano, solo senza questa categoria.';

  @override
  String onbHello(String name) {
    return 'Ciao, $name';
  }

  @override
  String get onbPlaceHero => 'esercizi che puoi fare';

  @override
  String get settingsRests => 'Recuperi';

  @override
  String get settingsDuring => 'Durante l’allenamento';

  @override
  String get settingsLook => 'Aspetto';

  @override
  String get importCardTitle => 'Porta qui i tuoi allenamenti';

  @override
  String get importCardBody => 'Da Hevy, Strong, FitNotes e altre';

  @override
  String get checkInTitle => 'Come stavi?';

  @override
  String get checkInSleep => 'Sonno';

  @override
  String get checkInEnergy => 'Energia';

  @override
  String get checkInSkip => 'Facoltativo';

  @override
  String get checkInLevel1 => 'Pessimo';

  @override
  String get checkInLevel2 => 'Scarso';

  @override
  String get checkInLevel3 => 'Ok';

  @override
  String get checkInLevel4 => 'Bene';

  @override
  String get checkInLevel5 => 'Ottimo';

  @override
  String get checkInSetting => 'Sonno ed energia';

  @override
  String get checkInSettingHint => 'Chiedi alla fine di ogni allenamento';

  @override
  String get readinessTitle => 'Sonno ed energia';

  @override
  String get readinessWaiting => 'Continua a valutare gli allenamenti';

  @override
  String get readinessWaitingHint =>
      'Dopo qualche giorno buono e cattivo vedrai come cambiano i tuoi carichi.';

  @override
  String readinessSleepLess(int n) {
    return 'Nei giorni con poco sonno sollevi il $n% in meno';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Curioso: nei giorni con poco sonno sollevi il $n% in più';
  }

  @override
  String get readinessSleepNone => 'Il sonno cambia poco i tuoi carichi';

  @override
  String readinessEnergyLess(int n) {
    return 'Nei giorni con poca energia sollevi il $n% in meno';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'Nei giorni con poca energia sollevi comunque il $n% in più';
  }

  @override
  String get readinessEnergyNone => 'La tua energia cambia poco i tuoi carichi';

  @override
  String get readinessHint => 'Confronta ogni 1RM stimato con il tuo migliore dei 90 giorni precedenti.';

  @override
  String get readinessLast30 => 'Media degli ultimi 30 giorni';

  @override
  String get kindSport => 'Sport';

  @override
  String get clearWorkouts => 'Elimina solo gli allenamenti';

  @override
  String get clearWorkoutsNone => 'Non ci sono allenamenti da eliminare';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Eliminare $n allenamenti?',
      one: 'Eliminare 1 allenamento?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Se ne vanno storico, record e medaglie. Restano routine, esercizi, foto, misure, nutrizione e impostazioni. Esporta prima un backup se vuoi poterli recuperare.';

  @override
  String get clearWorkoutsConfirm => 'Elimina allenamenti';

  @override
  String get clearWorkoutsDone => 'Allenamenti eliminati';

  @override
  String get reportTitle => 'Report';

  @override
  String get reportHint => 'Scegli le date e condividilo in PDF o CSV';

  @override
  String get reportCustom => 'Altro';

  @override
  String get reportPickRange => 'Scegli le date';

  @override
  String get reportEmpty => 'Niente registrato tra queste date.';

  @override
  String get reportKicker => 'REPORT DI ALLENAMENTO';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giorni', one: '1 giorno');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'ALLENAMENTI';

  @override
  String get reportPerWeek => 'A SETTIMANA';

  @override
  String get reportHours => 'ORE';

  @override
  String get reportVsPrev => 'Le percentuali confrontano con lo stesso numero di giorni subito prima.';

  @override
  String get reportRecords => 'Nuovi record';

  @override
  String get reportLifts => 'Esercizi';

  @override
  String get reportSessionsCol => 'GIORNI';

  @override
  String get reportBestCol => 'MIGLIOR 1RM';

  @override
  String get reportChangeCol => 'VARIAZIONE';

  @override
  String get reportBestHint =>
      'Il miglior 1RM è stimato dalle tue serie. La variazione confronta il primo e l’ultimo giorno dell’esercizio in questo report.';

  @override
  String get reportMuscles => 'Serie per muscolo';

  @override
  String get reportBody => 'Corpo e recupero';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nutrizione · media di $n giorni',
      one: 'Nutrizione · media di 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nuovi record',
      one: '1 nuovo record',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n esercizi', one: '1 esercizio');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal e $protein g di proteine al giorno · $days giorni registrati';
  }

  @override
  String get reportSharePdf => 'Condividi PDF';

  @override
  String get reportShareCsv => 'Esporta CSV';

  @override
  String get reportShareCsvBoth => 'Esporta CSV (allenamenti e nutrizione)';

  @override
  String fastMinutes(int n) {
    return '$n min';
  }

  @override
  String fastHours(int n) {
    return '$n h';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get fastTracker => 'Digiuno intermittente';

  @override
  String fastTitle(int fast, int eat) {
    return 'Digiuno $fast:$eat';
  }

  @override
  String get fastOptions => 'Opzioni digiuno';

  @override
  String get fastWindowOpen => 'Finestra dei pasti aperta';

  @override
  String get fastLeft => 'Rimanente';

  @override
  String get fastDoneLabel => 'Obiettivo raggiunto';

  @override
  String get fastIdle => 'Avvialo dopo l\'ultimo pasto';

  @override
  String fastLast(String time) {
    return 'Ultimo digiuno: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n di fila';
  }

  @override
  String fastReached(String time) {
    return '$time oltre il tuo obiettivo';
  }

  @override
  String fastEndsAt(String time) {
    return 'Finisce alle $time';
  }

  @override
  String fastSince(String time) {
    return 'Dalle $time';
  }

  @override
  String get fastStartedAt => 'Quando hai iniziato il digiuno?';

  @override
  String get fastStart => 'Inizia digiuno';

  @override
  String fastFromMeal(String time) {
    return 'Dalle $time';
  }

  @override
  String get fastEnd => 'Termina digiuno';

  @override
  String get fastCancel => 'Annulla questo digiuno';

  @override
  String get fastPlan => 'Piano di digiuno';

  @override
  String get fastPlanHint => 'Ore di digiuno : ore per mangiare';

  @override
  String get fastThisWeek => 'Ultimi 7 giorni';

  @override
  String get fastCount => 'Digiuni';

  @override
  String get fastReachedCount => 'Raggiunti';

  @override
  String get fastAverage => 'Media';

  @override
  String get fastHistory => 'Digiuni recenti';

  @override
  String get notifFastLiveChannel => 'Digiuno in corso';

  @override
  String get notifFastLiveChannelWhy => 'Un conto alla rovescia discreto mentre digiuni.';

  @override
  String get notifFastChannel => 'Digiuno';

  @override
  String get notifFastChannelWhy => 'Ti avvisa quando il digiuno è finito.';

  @override
  String get notifFastLiveTitle => 'Digiuno';

  @override
  String notifFastLiveBody(String time) {
    return 'La finestra dei pasti si apre alle $time';
  }

  @override
  String get notifFastDoneTitle => 'Digiuno completato';

  @override
  String notifFastDoneBody(int n) {
    return '$n ore. La finestra dei pasti è aperta.';
  }

  @override
  String get newExerciseHint => 'Serve solo il nome. Il resto aiuta, ma puoi aggiungerlo dopo.';

  @override
  String get supportThanksTitle => 'Grazie di essere qui 🤍';

  @override
  String get supportThanksBody =>
      'GymMane è gratis e lo sarà sempre, senza pubblicità e niente di nascosto.\n\nSe ti aiuta ad allenarti, offrirmi un caffè mi rallegra la giornata ☕\nE se non puoi, nessun problema: anche una stella su GitHub ⭐';

  @override
  String get perfSetting => 'Prestazioni';

  @override
  String get perfSheetHint => 'Quanto del tuo telefono usa GymMane. Puoi cambiare ogni parte qui sotto.';

  @override
  String get perfLite => 'Risparmio';

  @override
  String get perfLiteHint => 'Senza sfocatura e con movimenti più calmi. Per i telefoni che faticano.';

  @override
  String get perfBalanced => 'Bilanciato';

  @override
  String get perfBalancedHint => 'Sfocatura e animazioni senza scaricare la batteria.';

  @override
  String get perfMax => 'Massimo';

  @override
  String perfMaxHint(int hz) {
    return 'Sfocatura più fine e schermo a $hz Hz. Per telefoni di fascia alta.';
  }

  @override
  String get perfMaxHintNoHz => 'Sfocatura più fine ovunque. Per telefoni di fascia alta.';

  @override
  String get perfCustom => 'Personalizzato';

  @override
  String get perfTweak => 'Regolazione fine';

  @override
  String get perfFine => 'Sfocatura fine';

  @override
  String get perfFineHint => 'Bordi più morbidi e uno sfondo più nitido dietro i pannelli';

  @override
  String perfHz(int hz) {
    return 'Schermo a $hz Hz';
  }

  @override
  String get perfHzHint => 'Tutto scorre più fluido, con un po\' più di batteria';

  @override
  String get lowEndLiteBody =>
      'La modalità Risparmio (senza sfocatura, movimenti più calmi) andrà più fluida. Puoi cambiarla in Impostazioni → Generale → Prestazioni.';

  @override
  String get lowEndLiteOn => 'Attiva Risparmio';

  @override
  String get dayOffHint => 'La tua serie e il promemoria lasciano stare questo giorno';

  @override
  String get dayOffTrained => 'Mi sono allenato, solo non l\'ho registrato';

  @override
  String get dayOffSick => 'Malattia';

  @override
  String get dayOffTravel => 'Viaggio';

  @override
  String get dayOffInjury => 'Infortunio';

  @override
  String get dayOffRest => 'Riposo';

  @override
  String get altsTitle => 'Alternative';

  @override
  String get altsHint => 'Se la macchina è occupata';

  @override
  String altsPickHint(int count) {
    return 'Scegline fino a $count. Se la macchina è occupata, cambi con un tocco.';
  }

  @override
  String get placeDumbbells => 'Manubri';

  @override
  String get dumbbellsHint =>
      'Il peso di un manubrio. La progressione e i tasti + e − cadranno solo su questi valori qui.';

  @override
  String get dumbbellOther => 'Altro peso';

  @override
  String get tuneTitle => 'Volume di oggi';

  @override
  String get tuneHint => 'Dimmi come si è sentito ogni muscolo e regolo le serie per la prossima volta.';

  @override
  String get tuneLess => 'Troppo poco';

  @override
  String get tuneRight => 'Giusto';

  @override
  String get tuneMore => 'Troppo';

  @override
  String tuneNext(String sets, String name) {
    return 'La prossima volta: $sets di $name';
  }

  @override
  String get tuneSame => 'Uguale la prossima volta';

  @override
  String get tuneSetting => 'Regola le serie per muscolo';

  @override
  String get tuneSettingHint => 'Dopo una routine, valuta ogni muscolo e le serie si regolano';

  @override
  String insightLoad(int pct) {
    return '$pct % di serie in più rispetto alla tua settimana abituale. Occhio al recupero.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: fermo da $days giorni.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'Spingi più di quanto tiri: $a serie contro $b in quattro settimane.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'Tiri più di quanto spingi: $a serie contro $b in quattro settimane.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: $pct % più forte del mese scorso.';
  }

  @override
  String recapPull(String month) {
    return 'Continua a tirare per vedere il tuo $month';
  }

  @override
  String get recapRelease => 'Lascia';

  @override
  String recapHi(String name) {
    return 'Ciao, $name';
  }

  @override
  String recapReady(String month) {
    return 'Vediamo cosa hai fatto a $month?';
  }

  @override
  String get recapGo => 'Andiamo';

  @override
  String recapEmpty(String month) {
    return 'Ancora nessun allenamento a $month. Il primo sblocca tutto.';
  }

  @override
  String get recapClose => 'Chiudi';

  @override
  String get recapShare => 'Condividi';

  @override
  String get recapWorkoutsKicker => 'Questo mese hai fatto';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'allenamenti', one: 'allenamento');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'In $n giorni diversi',
      one: 'In un solo giorno',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Tempo sotto il bilanciere';

  @override
  String recapLongest(String time, String date) {
    return 'Sessione più lunga: $time, il $date';
  }

  @override
  String get recapVolumeKicker => 'Hai sollevato';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Come sollevare $count auto',
      one: 'Come sollevare un\'auto',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Il più: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Muscolo del mese';

  @override
  String get recapRecordsKicker => 'Nuovi record';

  @override
  String recapNoRecords(int n) {
    return 'Niente record stavolta, ma $n serie in più nel conto.';
  }

  @override
  String get recapHabitKicker => 'Il tuo momento';

  @override
  String recapHabitStart(String time) {
    return 'Di solito inizi alle $time';
  }

  @override
  String get recapShareKicker => 'Il tuo mese, pronto da condividere';

  @override
  String get recapTickWorkouts => 'Allenamenti';

  @override
  String get recapTickTime => 'Tempo';

  @override
  String get recapTickVolume => 'Carico';

  @override
  String get recapTickRecords => 'Record';

  @override
  String recapAvg(int n) {
    return '$n min ad allenamento in media';
  }

  @override
  String get recapLiftKicker => 'Esercizio del mese';

  @override
  String get recapBest => 'Migliore';

  @override
  String get recapTimes => 'Giorni';

  @override
  String get recapDaysLabel => 'Giorni';

  @override
  String get recapAvgLabel => 'Media';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts allenamenti in $days giorni';
  }

  @override
  String get recapFavLabel => 'Il tuo giorno';

  @override
  String get recapWatermark => 'diario di palestra gratis';

  @override
  String get recapTickSteps => 'Passi';

  @override
  String get recapTickFood => 'Cibo';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n allenamenti',
      one: 'un allenamento',
    );
    return '$minutes min in $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n allenamenti cardio',
      one: 'Un allenamento cardio',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Il tuo preferito: $name';
  }

  @override
  String get recapStepsKicker => 'Hai camminato';

  @override
  String get recapStepsWord => 'passi';

  @override
  String recapStepsAvg(String value) {
    return '$value al giorno in media';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Giorno migliore: $value, $date';
  }

  @override
  String get recapFoodKicker => 'Nel tuo piatto';

  @override
  String get recapLiftRest => 'Subito dietro';

  @override
  String recapSameAs(String month) {
    return 'Come a $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value in più che a $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value in meno che a $month';
  }

  @override
  String get recapTickMedals => 'Medaglie';

  @override
  String get recapTickSleep => 'Sonno';

  @override
  String get recapMedalsKicker => 'Medaglie vinte';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'E altre $n', one: 'E un\'altra');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Hai dormito';

  @override
  String get recapSleepAvg => 'a notte in media';

  @override
  String recapSleepBest(String value, String date) {
    return 'Notte migliore: $value, $date';
  }

  @override
  String get recapCardSummary => 'Riepilogo';

  @override
  String get recapCardCalendar => 'Calendario';

  @override
  String get recapCardLift => 'Esercizio';

  @override
  String get recapPeakKicker => 'La tua sessione più dura';

  @override
  String get recapTickPeak => 'Sessione';

  @override
  String get recapFreshKicker => 'Prima volta questo mese';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'esercizi nuovi',
      one: 'esercizio nuovo',
    );
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Nuovo';

  @override
  String recapStreak(int n) {
    return '$n giorni di fila, la tua serie più lunga';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n allenamenti',
      one: '1 allenamento',
    );
    return 'Un anno fa: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Dimenticato questo mese: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'di proteine al giorno · obiettivo $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nel tuo piatto $n giorni',
      one: 'Nel tuo piatto 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Proteine · g/giorno';

  @override
  String get recapFoodGoalDays => 'Obiettivo raggiunto';

  @override
  String get recapFoodWaterLabel => 'Acqua/giorno';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giorni', one: '1 giorno');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Il tuo cibo del mese';

  @override
  String get onbSpeedTitle => 'Perché vada fluido';

  @override
  String get onbSpeedWhy =>
      'Il tuo telefono sembra fare fatica. Disattiva queste cose e tutto scorrerà meglio: provale e guarda l\'anteprima.';

  @override
  String get onbSpeedMotion => 'Animazioni';

  @override
  String get onbSpeedBlurHint => 'Vetro smerigliato dietro pannelli e barre';

  @override
  String get onbSpeedMotionHint => 'Schermate e pannelli che scorrono';

  @override
  String get onbSpeedLater => 'Puoi cambiarlo quando vuoi in Impostazioni › Generale › Prestazioni.';

  @override
  String get notifSoundSetting => 'Suoni delle notifiche';

  @override
  String get notifSoundRowHint => 'Come suona ogni tipo di promemoria';

  @override
  String get notifSoundHint =>
      'Scegli un suono per ogni tipo di promemoria. Dal telefono apre i suoni del tuo telefono, e sulla maggior parte dei telefoni lì puoi aggiungere una tua canzone.';

  @override
  String get notifSoundTrain => 'Allenamenti';

  @override
  String get notifSoundFood => 'Cibo, integratori e digiuno';

  @override
  String get notifSoundOther => 'Foto e misure';

  @override
  String get notifSoundNormal => 'Normale';

  @override
  String get notifSoundPhone => 'Dal telefono';

  @override
  String get notifSoundSilent => 'Silenzioso';

  @override
  String get notifSoundPhoneHint => 'Toccane uno per sentirlo. Si salva subito.';

  @override
  String get notifSoundMore => 'Altro file…';

  @override
  String get notifSoundChange => 'Cambia';

  @override
  String get workoutNoteAdd => 'Nota fissata: sedile, presa, macchina…';

  @override
  String get autoProgressSetting => 'Progressione automatica';

  @override
  String get autoProgressRowHint => 'Cosa suggerisce per la prossima volta';

  @override
  String get autoProgressOff => 'Disattivata';

  @override
  String get autoProgressWeight => 'Aggiungi peso';

  @override
  String get autoProgressReps => 'Aggiungi ripetizioni';

  @override
  String get autoProgressHint =>
      'Quando inizi un allenamento, GymMane compila il passo successivo per ogni esercizio. Con Aggiungi ripetizioni aggiungi una ripetizione per serie fino a 12, poi il peso sale e riparti da 8. Puoi comunque regolare ogni esercizio nella sua pagina.';

  @override
  String get noteFolders => 'Cartelle';

  @override
  String get noteFolderNew => 'Nuova cartella';

  @override
  String get noteFolderEdit => 'Modifica cartella';

  @override
  String get noteFolderName => 'Nome della cartella';

  @override
  String get noteFolderLabel => 'Cartella';

  @override
  String get noteFolderNone => 'Nessuna cartella';

  @override
  String get noteFolderDelete => 'Eliminare la cartella?';

  @override
  String get noteFolderDeleteBody => 'Le note restano: escono soltanto dalla cartella.';

  @override
  String get foodArchivedToast => 'Alimento archiviato';

  @override
  String get planArchivedToast => 'Piano archiviato';

  @override
  String get suppArchivedToast => 'Integratore archiviato';

  @override
  String get voiceSetting => 'Voce di allenamento';

  @override
  String get voiceSettingHint =>
      'Annuncia la prossima serie e fa il conto alla rovescia di fine recupero, con la voce del telefono';

  @override
  String get voiceHello => 'Voce attiva';

  @override
  String voiceRest(String time) {
    return 'Recupero $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Prossimo: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps ripetizioni con $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps ripetizioni';
  }

  @override
  String get voiceGo => 'Andiamo!';

  @override
  String get deloadSetting => 'Settimana di scarico';

  @override
  String get deloadOff => 'Mai';

  @override
  String deloadEvery(int weeks) {
    return 'Ogni $weeks settimane';
  }

  @override
  String get deloadHint =>
      'Ogni tot settimane, una più facile per recuperare: metà delle serie e il 10 % di peso in meno. Quella settimana non conta per la progressione.';

  @override
  String get deloadRowHint => 'Una settimana leggera ogni tanto';

  @override
  String get deloadNow => 'Settimana di scarico';

  @override
  String get deloadNowHint => 'Oggi, metà delle serie e il 10 % di peso in meno';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'Tra $weeks settimane',
      one: 'La prossima settimana',
      zero: 'Questa settimana',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Allenati come sempre';

  @override
  String get voiceSheetTitle => 'Come funziona la voce';

  @override
  String get voicePointRest => 'Quando segni una serie, ti dice il tempo di recupero e cosa viene dopo.';

  @override
  String get voicePointCount => 'Conta 3, 2, 1 alla fine del recupero e ti richiama.';

  @override
  String get voicePointPhone => 'Usa la voce del tuo telefono e suona sopra la tua musica.';

  @override
  String get voiceTry => 'Prova la voce';

  @override
  String get voiceNoEngine => 'Il tuo telefono non ha un motore vocale attivo.';

  @override
  String get voiceNoLang =>
      'Manca la voce della tua lingua. Scaricala nelle impostazioni vocali del telefono.';

  @override
  String get voiceOpenSettings => 'Impostazioni voce';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minuti', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondi',
      one: '1 secondo',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'e';

  @override
  String get repRecordsTitle => 'Miglior peso per ripetizioni';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'capsule', one: 'capsula');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'compresse', one: 'compressa');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'misurini', one: 'misurino');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'gocce', one: 'goccia');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'porzioni', one: 'porzione');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'UI';

  @override
  String get suppLeft => 'Rimanenti';

  @override
  String get suppLeftHint => 'Facoltativo';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Basta per $n giorni',
      one: 'Basta per 1 giorno',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giorni', one: '1 giorno');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Finito';

  @override
  String get lightSession => 'Sessione leggera';

  @override
  String get lightSessionHint =>
      'Salvata nella cronologia e nelle statistiche, ma non cambia i tuoi prossimi obiettivi.';

  @override
  String get lightSessionNote => 'Non conta per la progressione';

  @override
  String get lightSessionOff => 'Disattiva';

  @override
  String get eachSideRepsHint =>
      'Registra a parte le ripetizioni a sinistra e a destra. La progressione segue il lato più debole.';

  @override
  String get repsLeftCol => 'REPS SX';

  @override
  String get repsRightCol => 'REPS DX';

  @override
  String get repsLeftTitle => 'REPS SINISTRA';

  @override
  String get repsRightTitle => 'REPS DESTRA';

  @override
  String sidesReps(int l, int r) {
    return 'S$l D$r';
  }

  @override
  String get progSchemeTitle => 'Progressione del peso';

  @override
  String get groupMoveUp => 'Sposta il gruppo su';

  @override
  String get groupMoveDown => 'Sposta il gruppo giù';

  @override
  String get mealAiRow => 'Chiedi a un\'IA';

  @override
  String get mealAiRowHint => 'Copia una richiesta, incolla la risposta';

  @override
  String get mealAiTitle => 'Pasti con l\'IA';

  @override
  String get mealAiSubtitle => 'Funziona con qualsiasi chatbot. L\'app resta offline.';

  @override
  String get mealAiStepAsk => 'Chiedi';

  @override
  String get mealAiStepPaste => 'Incolla';

  @override
  String get mealAiWholeDay => 'Tutto il giorno';

  @override
  String get mealAiTarget => 'Obiettivo';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'Oggi ti restano $kcal e $protein g di proteine';
  }

  @override
  String get mealAiStyle => 'I tuoi gusti';

  @override
  String get mealAiTagProtein => 'Ricco di proteine';

  @override
  String get mealAiTagVeggie => 'Vegetariano';

  @override
  String get mealAiTagVegan => 'Vegano';

  @override
  String get mealAiTagNoGluten => 'Senza glutine';

  @override
  String get mealAiTagNoLactose => 'Senza lattosio';

  @override
  String get mealAiTagQuick => 'Veloce';

  @override
  String get mealAiTagNoCook => 'Senza cottura';

  @override
  String get mealAiTagCheap => 'Economico';

  @override
  String get mealAiNotesHint => 'Ho in casa… Non mi piace… allergie…';

  @override
  String get mealAiOptions => 'Opzioni';

  @override
  String get mealAiCopy => 'Copia richiesta';

  @override
  String get mealAiCopied => 'Richiesta copiata';

  @override
  String get mealAiCopiedHint => 'Incollala nella tua IA e torna qui con la risposta';

  @override
  String get mealAiShowText => 'Vedi la richiesta';

  @override
  String get mealAiHideText => 'Nascondi la richiesta';

  @override
  String get mealAiPasteHint => 'Incolla qui la risposta dell\'IA';

  @override
  String get mealAiReview => 'Controlla la risposta';

  @override
  String get mealAiUnreadable => 'Non ho trovato nessun alimento in quel testo';

  @override
  String get mealAiUnreadableHint =>
      'Chiedi all\'IA di mandare solo il JSON, in un unico blocco di codice, nel formato della richiesta.';

  @override
  String get mealAiCopyFix => 'Copia quella frase';

  @override
  String mealAiOption(int n) {
    return 'Opzione $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Aggiungi a $meal';
  }

  @override
  String get mealAiAddDay => 'Aggiungi a oggi';

  @override
  String get mealAiAddPick => 'Aggiungi';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n alimenti aggiunti',
      one: '1 alimento aggiunto',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Salva come ricetta';

  @override
  String get mealAiSavePlan => 'Salva come piano';

  @override
  String get mealAiRecipeSaved => 'Ricetta salvata';

  @override
  String get mealAiPlanSaved => 'Piano salvato';

  @override
  String get mealAiFlagEstimated => 'Stimato dall\'IA';

  @override
  String get mealAiFlagAdjusted => 'Calorie corrette in base ai macro';

  @override
  String get mealAiFlagDoubtful => 'I conti non tornano, controlla';

  @override
  String get mealAiFlagNoValues => 'Nessun valore nutrizionale';

  @override
  String get mealAiFlagNoAmount => 'Nessuna quantità indicata';

  @override
  String get mealAiTruncated => 'La risposta sembra tagliata. Ho tenuto gli alimenti completi.';

  @override
  String get mealAiAmount => 'Quantità';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Obiettivo $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Attiva almeno un alimento';

  @override
  String get cholesterolLabel => 'Colesterolo';

  @override
  String get mealAiFlagMatched => 'Uguale a un alimento che hai salvato';

  @override
  String get mealAiNotSame => 'Non è lo stesso';

  @override
  String get homeOrderRow => 'Ordine delle sezioni';

  @override
  String get homeOrderHint => 'Tieni premuto e trascina per cambiare l\'ordine della Home.';

  @override
  String get homeOrderFolders => 'Scorciatoie';

  @override
  String get equipNew => 'Nuovo';

  @override
  String get equipNewTitle => 'Nuova attrezzatura';

  @override
  String get equipNewHint => 'es. Cintura da sollevamento';

  @override
  String get homeOrderWeekdays => 'Spunte della settimana';

  @override
  String get repsMaxTitle => 'Ripetizioni fino a';

  @override
  String get repsRangeHint => 'Tieni premute le ripetizioni per impostare un intervallo come 8-12.';

  @override
  String get repsRangeClear => 'Togli l\'intervallo';

  @override
  String get noteLinksLabel => 'LINK';

  @override
  String get noteLinkAdd => 'Aggiungi link';

  @override
  String get noteLinkEdit => 'Modifica link';

  @override
  String get noteLinkNameHint => 'Nome';

  @override
  String get noteLinkUrlHint => 'Indirizzo web';

  @override
  String get noteLinkInvalid => 'Quell\'indirizzo non sembra corretto';

  @override
  String get changeRest => 'Recupero tra esercizi';

  @override
  String get changeRestHint => 'Dopo l\'ultima serie, prima dell\'esercizio successivo';

  @override
  String get notifSuppTake => 'Preso';

  @override
  String get sideRest => 'Recupero tra i lati';

  @override
  String get sideRestHint => 'Esercizi per lato: la prima ✓ chiude un lato';

  @override
  String get gfxCompat => 'Grafica compatibile';

  @override
  String get gfxCompatHint =>
      'Per i telefoni in cui le lettere si vedono rotte. La sfocatura resta, qualche effetto diventa più semplice';

  @override
  String get gfxRestartTitle => 'Riavviare GymMane?';

  @override
  String get gfxRestartBody =>
      'Si chiude e si riapre per cambiare il modo in cui disegna lo schermo. Non perdi nulla di quello che hai salvato.';

  @override
  String get gfxRestart => 'Riavvia';

  @override
  String get webSynced => 'Aggiornato con le modifiche di un altro dispositivo';

  @override
  String get webSyncedPhone => 'Sono arrivate le modifiche del tuo telefono';

  @override
  String get webWelcomeBlurb => 'Tutto resta sul tuo server. Niente account, niente cloud, niente da pagare.';

  @override
  String get webOwnServer => 'Il tuo server, le tue regole';

  @override
  String get webOwnServerWhy => 'Niente account né cloud di terzi. I tuoi dati vivono dove lo fai girare.';

  @override
  String get webServerSaved => 'Salvato sul tuo server';

  @override
  String get webServerOffline => 'Impossibile raggiungere il tuo server';

  @override
  String get webServerLocal => 'Salvato in questo browser';

  @override
  String get webServerTitle => 'Il tuo server';

  @override
  String webPhoneLast(String date) {
    return 'Ultima copia dal tuo telefono: $date';
  }

  @override
  String get webPhoneNone => 'Ancora nessuna copia dal tuo telefono';

  @override
  String get webPhoneScan => 'Prendi dal telefono';

  @override
  String get webPhoneExport => 'Manda al telefono';

  @override
  String get webPhoneExportDone =>
      'Lasciato nella cartella condivisa. Il telefono lo prende quando sincronizza';

  @override
  String get webPhoneImported => 'Sono arrivate le modifiche del tuo telefono';

  @override
  String get webPhoneNothing => 'Niente di nuovo dal tuo telefono';

  @override
  String get webPhoneHow =>
      'Attiva sul telefono il backup automatico in una cartella che sincronizzi con Syncthing. Il server e il telefono si prendono da soli le modifiche dell\'altro, e unire non cancella mai nulla.';

  @override
  String get webPhoneGuide => 'Come configurarlo';

  @override
  String get webPhoneOff => 'La sincronizzazione con il telefono è disattivata su questo server';

  @override
  String get toolGroupBody => 'Corpo';

  @override
  String get toolNameProtein => 'Proteine';

  @override
  String get toolTitleProtein => 'Proteine al giorno';

  @override
  String get toolDescProtein => 'Quante proteine al giorno';

  @override
  String get toolHintProtein => 'Grammi al giorno, divisi tra i pasti';

  @override
  String get proteinGoalLabel => 'Obiettivo';

  @override
  String get proteinExplain =>
      'Basato sull\'intervallo su cui concorda la maggior parte degli studi per chi si allena: di più quando perdi peso, per mantenere il muscolo. Superarlo è sicuro, aggiunge solo poco.';

  @override
  String get toolNameWater => 'Acqua';

  @override
  String get toolTitleWater => 'Acqua al giorno';

  @override
  String get toolDescWater => 'Quanto bere al giorno';

  @override
  String get toolHintWater => 'Litri al giorno, cibo compreso';

  @override
  String get waterTrainingLabel => 'Allenamento al giorno';

  @override
  String get waterExplain =>
      'Circa 35 ml per chilo di peso corporeo, più un po\' per ogni minuto di allenamento. Bevi di più nei giorni caldi.';

  @override
  String get autoBackupSync => 'Sincronizza ora';

  @override
  String get autoBackupMerged => 'Sono arrivate le modifiche dei tuoi altri dispositivi';

  @override
  String get autoBackupSyncHint =>
      'Condividi questa cartella con Syncthing e ogni dispositivo prende quello che gli altri lasciano qui. Unire non cancella mai nulla.';

  @override
  String get webPhoneFolder => 'Cartella condivisa';

  @override
  String get webPhoneFolderHow =>
      'Si sceglie quando installi il server. Per cambiarla, imposta GYMMANE_SYNC nel file .env del server e riavvialo.';

  @override
  String get webPhoneOffHow => 'Per attivarla, togli GYMMANE_SYNC=off dal file .env del server e riavvialo.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n telefoni sincronizzati',
      one: '1 telefono sincronizzato',
      zero: 'Nessun telefono ha ancora sincronizzato',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Impossibile leggere la cartella: $error';
  }

  @override
  String get duplicateExercise => 'Duplica';

  @override
  String exerciseCopyName(String name) {
    return '$name (copia)';
  }
}
