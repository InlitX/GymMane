// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get languageName => 'Français';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% vs le mois dernier';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Niveau $level · $streak';
  }

  @override
  String get save => 'ENREGISTRER';

  @override
  String get cancel => 'Annuler';

  @override
  String get cancelCaps => 'ANNULER';

  @override
  String get deleteCaps => 'SUPPRIMER';

  @override
  String get done => 'TERMINÉ';

  @override
  String get set => 'Valider';

  @override
  String get home => 'ACCUEIL';

  @override
  String get progress => 'PROGRÈS';

  @override
  String get exercises => 'EXERCICES';

  @override
  String get settings => 'PARAMÈTRES';

  @override
  String get today => 'AUJOURD’HUI';

  @override
  String get thisWeek => 'CETTE SEMAINE';

  @override
  String get recommended => 'RECOMMANDÉ';

  @override
  String get goal => 'OBJECTIF';

  @override
  String get volume => 'VOLUME';

  @override
  String get setsToday => 'SÉRIES AUJOURD’HUI';

  @override
  String get prs => 'RECORDS';

  @override
  String get todaysFocus => 'OBJECTIF DU JOUR';

  @override
  String get todaysRoutine => 'PROGRAMME DU JOUR';

  @override
  String get startWorkout => 'COMMENCER LA SÉANCE';

  @override
  String get routines => 'PROGRAMMES';

  @override
  String get tools => 'OUTILS';

  @override
  String get firstSessionHint => 'Choisis tes muscles et enregistre ta première séance';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercices', one: '$n exercice');
    return '$_temp0';
  }

  @override
  String get pushDay => 'JOUR PUSH';

  @override
  String get pullDay => 'JOUR PULL';

  @override
  String get legDay => 'JAMBES';

  @override
  String get pushFocus => 'Pectoraux · Épaules · Triceps';

  @override
  String get pullFocus => 'Dos · Biceps · Trapèzes';

  @override
  String get legFocus => 'Quadriceps · Ischio-jambiers · Fessiers';

  @override
  String get train => 'S’ENTRAÎNER';

  @override
  String get step1 => 'ÉTAPE 1 SUR 2';

  @override
  String get step2 => 'ÉTAPE 2 SUR 2';

  @override
  String get chooseFocus => 'CHOISIS TA CIBLE';

  @override
  String get buildSession => 'CRÉE TA SÉANCE';

  @override
  String get tapMuscles => 'Touche les muscles que tu veux travailler, devant et derrière.';

  @override
  String get continueBtn => 'CONTINUER';

  @override
  String get nothingForFocus => 'Aucun exercice pour cette cible';

  @override
  String get goBackPick => 'Reviens en arrière et choisis un muscle avec des exercices dans ta bibliothèque.';

  @override
  String pickedHint(int n) {
    return 'Nous avons préparé une séance. Touche pour ajouter ou retirer l’un des $n exercices.';
  }

  @override
  String get pickAnExercise => 'CHOISIR UN EXERCICE';

  @override
  String get searchAllExercises => 'Rechercher un exercice…';

  @override
  String get noExercisesMatch => 'Aucun exercice correspondant';

  @override
  String get createItInstead => 'Créer ton propre exercice à la place';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n EXERCICES', one: '$n EXERCICE');
    return 'COMMENCER · $_temp0';
  }

  @override
  String get inProgress => 'EN COURS';

  @override
  String get paused => 'EN PAUSE';

  @override
  String get last => 'DERNIÈRE';

  @override
  String get rest => 'REPOS';

  @override
  String get skip => 'PASSER';

  @override
  String get addSet => '+ AJOUTER UNE SÉRIE';

  @override
  String get finishSession => 'TERMINER LA SÉANCE';

  @override
  String get setDone => 'SÉRIE TERMINÉE';

  @override
  String get nextExercise => 'EXERCICE SUIVANT';

  @override
  String get dropExerciseAction => 'Retirer l’exercice';

  @override
  String get restOff => 'Désactivé';

  @override
  String get miniRest => 'Repos en rest-pause et cluster';

  @override
  String get miniRestHint => 'Avant les séries rest-pause ou cluster';

  @override
  String get gymPass => 'Pass salle';

  @override
  String get gymPassEmpty => 'Garde ici le code de ta salle et entre sans sortir ta carte';

  @override
  String get gymPassAdd => 'Ajouter un pass';

  @override
  String get gymPassScan => 'Prendre le code en photo';

  @override
  String get gymPassScanHint => 'Avec l\'appareil photo du téléphone';

  @override
  String get gymPassPhoto => 'Depuis une photo ou une capture';

  @override
  String get gymPassPhotoHint => 'Par exemple, une capture de l\'appli de ta salle';

  @override
  String get gymPassType => 'Saisir le numéro';

  @override
  String get gymPassTypeHint => 'Pour les codes-barres : le numéro imprimé dessous';

  @override
  String get gymPassNotFound =>
      'Aucun QR code sur cette image. Essaie une photo plus nette ou saisis le numéro.';

  @override
  String get gymPassName => 'Nom de la salle';

  @override
  String get gymPassDefaultName => 'Ma salle';

  @override
  String get gymPassCode => 'Code';

  @override
  String get gymPassFormat => 'Type de code';

  @override
  String get gymPassInvalid => 'Ce numéro ne correspond pas à ce type de code';

  @override
  String get gymPassShowHint => 'Approche-le du lecteur. La luminosité monte toute seule.';

  @override
  String get gymPassDeleted => 'Pass supprimé';

  @override
  String get gymPassEdit => 'Modifier le pass';

  @override
  String get gymPassShow => 'Montrer à l\'entrée';

  @override
  String get gymPassPrivate => 'Reste uniquement sur ton téléphone. Rien n\'est envoyé.';

  @override
  String get gymPassColor => 'Couleur';

  @override
  String get gymPassRescan => 'Relire le code';

  @override
  String get gymPassReading => 'Lecture du code…';

  @override
  String get gymPassSettingHint => 'Ta carte de salle dans le profil';

  @override
  String get gymPassMember => 'Membre';

  @override
  String get widgetHintActivity => 'Ta carte des jours d\'entraînement';

  @override
  String get widgetHintStats => 'Série, volume et séances de la semaine';

  @override
  String get widgetHintBody => 'Les muscles que tu as travaillés';

  @override
  String get widgetHintToday => 'D\'un coup d\'œil : tu t\'es entraîné aujourd\'hui ?';

  @override
  String get widgetHintWeek => 'Ton plan de la semaine, jour par jour';

  @override
  String get supportHintBug => 'Dis-moi ce qui a planté, sur GitHub';

  @override
  String get supportHintFeature => 'Propose une idée pour l\'appli';

  @override
  String get supportHintStar => 'Aide plus de monde à la trouver';

  @override
  String get supportHintCoffee => 'Soutient le développement. Gratuit et sans pub';

  @override
  String get bodyweightNoteHint => 'Ajoute une note : comment tu te sens, ce que tu essaies… (facultatif)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Utiliser $unit pour cet exercice';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'RÉPÉTITIONS';

  @override
  String weightCol(String unit) {
    return 'POIDS ($unit)';
  }

  @override
  String get repsTitle => 'RÉPÉTITIONS';

  @override
  String weightTitle(String unit) {
    return 'POIDS ($unit)';
  }

  @override
  String get sessionComplete => 'SÉANCE ENREGISTRÉE';

  @override
  String get finishHeadlinePr => 'Nouveau record personnel';

  @override
  String get finishHeadlineGoal => 'Objectif hebdomadaire atteint';

  @override
  String get finishHeadlineStreak => 'Série maintenue';

  @override
  String get finishHeadlineDefault => 'Une séance de plus';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs exercices',
      one: 'un exercice',
    );
    return 'Tu as soulevé plus que jamais sur $_temp0. C’est maintenant enregistré.';
  }

  @override
  String get finishBodyGoal => 'Tu as atteint le nombre de séances prévu cette semaine.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak jours d’affilée. Le plus dur, c’est de ne pas s’arrêter.';
  }

  @override
  String get finishBodyDefault => 'Enregistré et comptabilisé. C’est la régularité qui fait progresser.';

  @override
  String get vsLastTime => 'VS LA DERNIÈRE FOIS';

  @override
  String get firstTime => 'Premier enregistrement';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nouveaux records',
      one: '$n nouveau record',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'DURÉE';

  @override
  String get setsCaps => 'SÉRIES';

  @override
  String exerciseXofY(int i, int n) {
    return 'EXERCICE $i SUR $n';
  }

  @override
  String get decrease => 'Diminuer';

  @override
  String get increase => 'Augmenter';

  @override
  String markSet(int n) {
    return 'Marquer la série $n comme terminée';
  }

  @override
  String get pauseWorkout => 'Mettre la séance en pause';

  @override
  String get resumeWorkout => 'Reprendre la séance';

  @override
  String get discardTitle => 'Abandonner la séance ?';

  @override
  String get discardBody => 'Les séries de cette séance seront perdues.';

  @override
  String get keepTraining => 'Continuer la séance';

  @override
  String get discard => 'Abandonner';

  @override
  String get notifRestChannel => 'Minuteur de repos';

  @override
  String get notifRestChannelWhy => 'T’avertit lorsque ton temps de repos entre les séries est terminé';

  @override
  String get notifAlertChannel => 'Minuteur de repos (alerte)';

  @override
  String get notifAlertChannelWhy => 'Affiche une bannière dès que ton temps de repos est terminé';

  @override
  String get restOverTitle => 'Repos terminé';

  @override
  String get restOverBody => 'C’est reparti, la prochaine série t’attend.';

  @override
  String get allTimeSessions => 'SÉANCES';

  @override
  String get allTimeTime => 'TEMPS';

  @override
  String get allTimeSets => 'SÉRIES';

  @override
  String get consistency => 'RÉGULARITÉ';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances enregistrées',
      one: '$n séance enregistrée',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'Série de $n jours';
  }

  @override
  String get bodyweight => 'POIDS CORPOREL';

  @override
  String get logBodyweight => 'ENREGISTRER LE POIDS';

  @override
  String get trackWeight => 'Suis l’évolution de ton poids';

  @override
  String get muscleMap => 'CARTE MUSCULAIRE';

  @override
  String get days7 => '7 J';

  @override
  String get days30 => '30 J';

  @override
  String get days90 => '90 J';

  @override
  String get days365 => '1 A';

  @override
  String get daysAll => 'Tout';

  @override
  String get weeklyAvgTitle => 'Moyenne par semaine';

  @override
  String weekOfDate(String date) {
    return 'Semaine du $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change sur la période';
  }

  @override
  String get heatLow => 'Non travaillé';

  @override
  String get heatHigh => 'Volume maximal';

  @override
  String get muscleMapEmpty => 'Enregistre une séance et ton corps commencera à s’illuminer ici.';

  @override
  String get muscleMapHint => 'Touche un muscle pour voir ce qu’il a travaillé.';

  @override
  String muscleMapBehind(String names) {
    return 'En retard : $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% de l’objectif';
  }

  @override
  String get muscleSplit => 'RÉPARTITION MUSCULAIRE';

  @override
  String get personalRecords => 'RECORDS PERSONNELS';

  @override
  String get strength1rm => 'FORCE · 1RM ESTIMÉ';

  @override
  String get strengthEmpty => 'Enregistre deux fois un exercice pour afficher ici sa courbe de force.';

  @override
  String oneRmEst(String w) {
    return '1RM estimé : $w';
  }

  @override
  String get restDayShort => 'Jour de repos';

  @override
  String get restDay => 'Jour de repos, rien d’enregistré.';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteEntry => 'Supprimer cette entrée ?';

  @override
  String deleteEntryBody(String name) {
    return '« $name » sera supprimé de cette journée, ainsi que de tes records et graphiques.';
  }

  @override
  String get bodyweightHistory => 'HISTORIQUE';

  @override
  String get exercisesCaps => 'EXERCICES';

  @override
  String get timeCaps => 'TEMPS';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercices dans ta bibliothèque',
      one: '$n exercice dans ta bibliothèque',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Rechercher des exercices';

  @override
  String get muscleFilter => 'MUSCLE';

  @override
  String get levelFilter => 'NIVEAU';

  @override
  String get kindLabel => 'TYPE';

  @override
  String get kindStrength => 'Force';

  @override
  String get kindCalisthenics => 'Callisthénie';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Étirements';

  @override
  String get newExercise => 'NOUVEL EXERCICE';

  @override
  String get exerciseName => 'Nom de l’exercice';

  @override
  String get equipmentLabel => 'MATÉRIEL';

  @override
  String get addExercise => 'AJOUTER L’EXERCICE';

  @override
  String get advanced => 'AVANCÉ';

  @override
  String get demoMedia => 'DÉMO';

  @override
  String get addMedia => 'Ajouter un média';

  @override
  String get mediaHint => 'Image, GIF ou vidéo';

  @override
  String get changeMedia => 'Modifier';

  @override
  String get videoSelected => 'Vidéo sélectionnée';

  @override
  String get favouritesOnly => 'Favoris';

  @override
  String get noFavouritesYet => 'Aucun favori';

  @override
  String get noFavouritesHint => 'Touche l’étoile d’un exercice pour le garder ici.';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get quickAddAmount => 'Combien tu en as pris';

  @override
  String get homeCardsTitle => 'Cartes de l’accueil';

  @override
  String get homeCardsHint => 'Ce que tu actives apparaît sur l’accueil';

  @override
  String get homeCardFocus => 'Aujourd’hui';

  @override
  String get homeCardSteps => 'Pas';

  @override
  String get homeCardWeek => 'Cette semaine';

  @override
  String get homeCardRoutines => 'Routines';

  @override
  String get homeCardRecommended => 'Suggestions';

  @override
  String get textSizeSetting => 'Taille du texte';

  @override
  String get textSizeSmall => 'Petit';

  @override
  String get textSizeNormal => 'Normal';

  @override
  String get textSizeLarge => 'Grand';

  @override
  String get textSizeHint => 'En plus de la taille de texte de ton téléphone';

  @override
  String get calmMotionSetting => 'Réduire les animations';

  @override
  String get calmMotionHint => 'Les écrans apparaissent sans glisser';

  @override
  String get dishArchive => 'Archiver';

  @override
  String get dishUnarchive => 'Restaurer';

  @override
  String get dishArchivedToast => 'Plat archivé';

  @override
  String get filterShowLabel => 'Afficher';

  @override
  String get noExercisesFound => 'Aucun exercice trouvé';

  @override
  String get noExercisesHint => 'Essaie une autre recherche ou efface les filtres.';

  @override
  String get personalRecord => 'RECORD PERSONNEL';

  @override
  String get history => 'HISTORIQUE';

  @override
  String get noHistory => 'Aucune séance enregistrée. Fais cet exercice pour créer un historique.';

  @override
  String get notes => 'NOTES';

  @override
  String get notePlaceholder => 'Conseils, placement, ressenti…';

  @override
  String notHere(String gear, String place) {
    return 'Pas de $gear à $place';
  }

  @override
  String get notHereWhy => 'Remplace-le par quelque chose que tu peux vraiment utiliser aujourd’hui.';

  @override
  String get altHere => 'CE QUE TU PEUX FAIRE ICI';

  @override
  String get places => 'MES LIEUX';

  @override
  String get placesHint =>
      'Indique le matériel disponible à chaque endroit et la bibliothèque n’affichera que ce que tu peux réellement y faire.';

  @override
  String get placeAll => 'Partout';

  @override
  String get placeNew => 'Nouveau lieu';

  @override
  String get placeNamePlaceholder => 'Maison, salle, parc…';

  @override
  String get placeGearLabel => 'MATÉRIEL DISPONIBLE';

  @override
  String placeExercises(int n) {
    return '$n exercices ici';
  }

  @override
  String get placeEmptyTitle => 'Entraîne-toi où que tu sois';

  @override
  String get placeEmptyBody =>
      'Un lieu correspond à la liste du matériel que tu y as. Choisis-en un pour commencer et modifie-le plus tard.';

  @override
  String get placeDeleteTitle => 'Supprimer le lieu';

  @override
  String get placeDeleteBody => 'Seul le lieu sera supprimé. Tes exercices et tes séances resteront.';

  @override
  String get placeGym => 'Salle de sport';

  @override
  String get placeHome => 'Maison';

  @override
  String get placeOutdoors => 'Extérieur';

  @override
  String get placeFilterLabel => 'LIEU';

  @override
  String get noGearOnly => 'Sans matériel';

  @override
  String placeActive(String name) {
    return 'Entraînement à $name';
  }

  @override
  String get journal => 'JOURNAL';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes',
      one: '1 note',
      zero: 'Aucune note',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Note';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Réussite';

  @override
  String get noteKindPain => 'Gêne';

  @override
  String get noteFilterAll => 'Toutes';

  @override
  String get newNote => 'Nouvelle note';

  @override
  String get editNote => 'Modifier la note';

  @override
  String get addNote => 'AJOUTER UNE NOTE';

  @override
  String get noteEmptyTitle => 'Rien d’écrit pour l’instant';

  @override
  String get noteEmptyBody =>
      'Conseils, plan pour la prochaine fois, ressenti d’une séance. Avec photos ou vidéo si tu veux.';

  @override
  String get noteNoneForExercise => 'Aucune note sur cet exercice pour l’instant.';

  @override
  String get noteKindLabel => 'TYPE';

  @override
  String get noteTextLabel => 'NOTE';

  @override
  String get noteDateLabel => 'DATE';

  @override
  String get noteExerciseLabel => 'EXERCICE';

  @override
  String get noteMediaLabel => 'PHOTOS ET VIDÉOS';

  @override
  String get noteGeneral => 'Aucun exercice';

  @override
  String get noteAttach => 'Joindre';

  @override
  String get noteRemoveMedia => 'Supprimer la pièce jointe';

  @override
  String get deleteNoteTitle => 'Supprimer la note';

  @override
  String get deleteNoteBody => 'La note et toutes ses pièces jointes seront définitivement supprimées.';

  @override
  String get noteToday => 'Aujourd’hui';

  @override
  String get noteYesterday => 'Hier';

  @override
  String get noteAllNotes => 'Toutes les notes';

  @override
  String get noteCalendar => 'Calendrier';

  @override
  String get noteNoneOnDay => 'Rien d’écrit ce jour-là';

  @override
  String get noteAddOnDay => 'Ajouter une note ce jour-là';

  @override
  String get notePrevMonth => 'Mois précédent';

  @override
  String get noteNextMonth => 'Mois suivant';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes ce mois-ci',
      one: '1 note ce mois-ci',
      zero: 'Aucune note ce mois-ci',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MENSURATIONS';

  @override
  String get measuresHint =>
      'Du cou aux mollets: observe l’évolution de ton corps, pas seulement celle de la barre.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n mesures',
      one: '1 mesure',
      zero: 'Aucune mesure',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Pas encore mesuré';

  @override
  String get measureHistory => 'HISTORIQUE';

  @override
  String get measureNeck => 'Cou';

  @override
  String get measureShoulders => 'Épaules';

  @override
  String get measureChest => 'Poitrine';

  @override
  String get measureArm => 'Bras';

  @override
  String get measureForearm => 'Avant-bras';

  @override
  String get measureWaist => 'Taille';

  @override
  String get measureHips => 'Hanches';

  @override
  String get measureThigh => 'Cuisse';

  @override
  String get measureCalf => 'Mollet';

  @override
  String get measureBodyfat => 'Masse grasse';

  @override
  String get timeline => 'CHRONOLOGIE';

  @override
  String get hidePhotos => 'Masquer les photos';

  @override
  String get showPhotos => 'Afficher les photos';

  @override
  String get timelineHint => 'Même pose, même endroit, même lumière. Dans un an, tu n’en reviendras pas.';

  @override
  String get timelineEmptyTitle => 'Ta première photo lance le suivi';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n photos',
      one: '1 photo',
      zero: 'Aucune photo',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Face';

  @override
  String get poseSide => 'Profil';

  @override
  String get poseBack => 'Dos';

  @override
  String get photoEvery => 'ME LE RAPPELER';

  @override
  String photoEveryDays(int n) {
    return 'Tous les $n jours';
  }

  @override
  String get photoEveryOff => 'Jamais';

  @override
  String get timelineEvery => 'REGROUPER TOUS LES';

  @override
  String get custom => 'Personnalisé';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Prochaine photo dans $n jours',
      one: 'Prochaine photo demain',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Photo prévue: prends-la aujourd’hui';

  @override
  String get addTodayPhotos => 'AJOUTER LES PHOTOS DU JOUR';

  @override
  String posePhoto(String pose) {
    return 'Photo de $pose';
  }

  @override
  String get compare => 'COMPARER';

  @override
  String get compareNeedTwo => 'Prends la même pose à deux dates différentes pour pouvoir les comparer ici.';

  @override
  String dayNumber(int n) {
    return 'Jour $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'À $n jours d’intervalle',
      one: 'À 1 jour d’intervalle',
      zero: 'Le même jour',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Supprimer cette journée';

  @override
  String get deleteDayBody => 'Ses photos seront définitivement supprimées avec elle.';

  @override
  String get timelinePhotos => 'Photos';

  @override
  String get timelineBody => 'Carte musculaire';

  @override
  String get timelineBodyEmpty =>
      'Enregistre une séance et ta carte musculaire commencera à se remplir ici, sans photo nécessaire.';

  @override
  String get timelineBodyHint => 'Créée à partir de tes propres séries, rien à envoyer.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances',
      one: '1 séance',
      zero: 'Aucune séance',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Photos de progression';

  @override
  String get notifPhotoChannelWhy =>
      'Un rappel quand il est temps de prendre ta prochaine photo de progression.';

  @override
  String get notifPhotoTitle => 'C’est l’heure de ta photo de progression';

  @override
  String notifPhotoBody(int n) {
    return '$n jours depuis la dernière. Même pose, même lumière.';
  }

  @override
  String get share => 'PARTAGER';

  @override
  String get sharePick => 'Que veux-tu montrer ?';

  @override
  String get shareStreak => 'Série et régularité';

  @override
  String get shareBody => 'Muscles travaillés';

  @override
  String get shareCompare => 'Avant / après';

  @override
  String get shareHint =>
      'La carte est créée sur ton téléphone. Rien ne sort tant que tu ne choisis pas où l’envoyer.';

  @override
  String get shareFailed => 'Impossible de créer la carte';

  @override
  String get shareWeekOf => '7 DERNIERS JOURS';

  @override
  String get shareStreakLabel => 'JOURS D’AFFILÉE';

  @override
  String get shareSessionsLabel => 'SÉANCES';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get restForExercise => 'REPOS POUR CET EXERCICE';

  @override
  String get restUsingDefault => 'Utilise la durée par défaut';

  @override
  String get restCustom => 'Uniquement pour celui-ci';

  @override
  String get setType => 'TYPE DE SÉRIE';

  @override
  String get setTypeNormal => 'Travail';

  @override
  String get setTypeWarmup => 'Échauffement';

  @override
  String get setTypeDrop => 'Dégressive';

  @override
  String get setTypeFailure => 'À l’échec';

  @override
  String get addWarmup => 'ÉCHAUFFEMENT';

  @override
  String platesPerSide(String plates) {
    return 'Par côté : $plates';
  }

  @override
  String get howTo => 'COMMENT FAIRE';

  @override
  String get similar => 'SIMILAIRES';

  @override
  String get primaryLabel => 'PRINCIPAL';

  @override
  String get secondaryLabel => 'SECONDAIRE';

  @override
  String get none => 'Aucun';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n séries', one: '$n série');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'volume $v';
  }

  @override
  String get weeklyPlan => 'PROGRAMME HEBDOMADAIRE';

  @override
  String get yourRoutines => 'TES PROGRAMMES';

  @override
  String get noRoutines => 'Aucun programme. Crée-en un et ajoute tes exercices.';

  @override
  String get newRoutine => 'NOUVEAU PROGRAMME';

  @override
  String get routineName => 'Nom du programme';

  @override
  String get schedule => 'PLANNING';

  @override
  String get addFromList => 'Ajoute des exercices depuis la liste ci-dessous.';

  @override
  String get addExercises => 'Ajouter des exercices';

  @override
  String get deleteRoutine => 'Supprimer ce programme ?';

  @override
  String exercisesWithCount(int n) {
    return 'EXERCICES · $n';
  }

  @override
  String setDay(String day) {
    return 'DÉFINIR $day';
  }

  @override
  String get newRoutineName => 'Nouveau programme';

  @override
  String get dragToReorder =>
      'Fais glisser la poignée à points pour réordonner : c’est l’ordre de ta séance.';

  @override
  String reorderHandle(String name) {
    return 'Réorganiser $name';
  }

  @override
  String get removeFromRoutine => 'Retirer du programme';

  @override
  String get dropExercise => 'Retirer cet exercice ?';

  @override
  String dropExerciseBody(String name) {
    return '« $name » sera retiré de cette séance. Rien de déjà enregistré ne sera perdu.';
  }

  @override
  String get drop => 'Retirer';

  @override
  String get resetData => 'Supprimer toutes mes données';

  @override
  String get resetTitle => 'Tout supprimer ?';

  @override
  String get resetBody =>
      'Séances, records, programmes, notes et profil. Cette action est irréversible: exporte d’abord une sauvegarde si tu veux pouvoir les récupérer.';

  @override
  String get resetConfirm => 'Tout supprimer';

  @override
  String get resetDone => 'Toutes les données ont été supprimées';

  @override
  String get support => 'ASSISTANCE';

  @override
  String get reportBug => 'Signaler un bug';

  @override
  String get requestFeature => 'Proposer une fonctionnalité';

  @override
  String get starOnGithub => 'Mettre une étoile sur GitHub';

  @override
  String get buyCoffee => 'M’offrir un café';

  @override
  String get cantOpenLink => 'Impossible d’ouvrir le lien';

  @override
  String get theme => 'Thème';

  @override
  String get darkTheme => 'Sombre';

  @override
  String get lightTheme => 'Clair';

  @override
  String get amoledTheme => 'Noir AMOLED';

  @override
  String get editDuration => 'Durée de la séance';

  @override
  String get sessionName => 'Nom de la séance';

  @override
  String get nameWorkout => 'Nommer';

  @override
  String get sessionNameHint => 'ex. : Jambes, Push, Full body';

  @override
  String get secondaryPickHint => 'Touche les autres muscles que travaille cet exercice.';

  @override
  String get languageLabel => 'Langue';

  @override
  String get unitsLabel => 'Unités';

  @override
  String get restTimer => 'Minuteur de repos';

  @override
  String get alarmBlockedTitle => 'Les notifications sont désactivées';

  @override
  String get alarmBlockedBody => 'L’alarme de repos ne sonnera pas lorsque l’écran est verrouillé';

  @override
  String get alarmBlockedAction => 'ACTIVER';

  @override
  String get alarmSound => 'Son de l’alarme';

  @override
  String get alarmDefaultName => 'Par défaut';

  @override
  String get alarmSoundHint => 'Utilise ton propre son, 15 secondes maximum';

  @override
  String get alarmChoose => 'Choisir un son…';

  @override
  String get alarmPreview => 'Écouter le son actuel';

  @override
  String get alarmReset => 'Rétablir le son par défaut';

  @override
  String get alarmTooLong => 'Ce son dure plus de 15 secondes';

  @override
  String get alarmInvalid => 'Impossible de lire ce fichier audio';

  @override
  String alarmChanged(String name) {
    return 'Son de l’alarme défini sur « $name »';
  }

  @override
  String get alarmChangedDefault => 'Son par défaut rétabli';

  @override
  String get addActivityWidget => 'Ajouter le widget d’activité';

  @override
  String get addStatsWidget => 'Ajouter le widget de statistiques';

  @override
  String get pinUnsupported => 'Ajoute-le depuis le menu des widgets de ton lanceur';

  @override
  String get background => 'Arrière-plan';

  @override
  String get bgNone => 'Aucun';

  @override
  String get bgDots => 'Points';

  @override
  String get bgGrid => 'Grille';

  @override
  String get exportCsv => 'Exporter les séances (CSV)';

  @override
  String get exportBackup => 'Exporter une sauvegarde (ZIP)';

  @override
  String get importBackup => 'Importer une sauvegarde';

  @override
  String get importHint =>
      'Choisis une sauvegarde .zip (ou un ancien .json) exportée depuis GymMane. Cela remplace tes données actuelles, médias compris.';

  @override
  String get import => 'Importer';

  @override
  String get chooseFile => 'Choisir un fichier';

  @override
  String get importFromApp => 'Importer depuis une autre application';

  @override
  String get importUnknownFormat =>
      'Ce fichier doit contenir les colonnes date, exercice, répétitions et poids';

  @override
  String get importZipNoWeights => 'Ce fichier zip ne contient aucun fichier de poids';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n mesures de poids importées',
      one: '$n mesure de poids importée',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Impossible de lire ce fichier';

  @override
  String get importUnitTitle => 'Quelle unité utilise ce fichier ?';

  @override
  String get importUnitBody => 'Cet export n’indique pas l’unité utilisée pour les poids.';

  @override
  String get importNothing => 'Rien de nouveau à importer';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances importées',
      one: '$n séance importée',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'À propos de GymMane';

  @override
  String get yourProfile => 'TON PROFIL';

  @override
  String get autofills => 'Remplit automatiquement les calculateurs';

  @override
  String get onbUnitsWhy =>
      'Pour les poids, les mensurations et les distances. Tu peux changer quand tu veux dans Réglages.';

  @override
  String get nameLabel => 'NOM';

  @override
  String get sexLabel => 'SEXE';

  @override
  String get macroProtein => 'PROTÉINES';

  @override
  String get macroCarbs => 'GLUCIDES';

  @override
  String get macroFat => 'LIPIDES';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get ageLabel => 'ÂGE';

  @override
  String get heightLabel => 'TAILLE';

  @override
  String get weightLabel => 'POIDS';

  @override
  String get weeklyGoal => 'OBJECTIF HEBDOMADAIRE';

  @override
  String get activityLabel => 'ACTIVITÉ';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseGallery => 'Choisir dans la galerie';

  @override
  String get backupImported => 'Sauvegarde importée';

  @override
  String get backupFailed => 'Impossible de lire cette sauvegarde';

  @override
  String get nothingToExport => 'Rien à exporter: enregistre d’abord une séance';

  @override
  String calculatorsCount(int n) {
    return '$n calculateurs pour ton entraînement';
  }

  @override
  String get result => 'RÉSULTAT';

  @override
  String get weightLifted => 'POIDS SOULEVÉ';

  @override
  String get repsPerformed => 'RÉPÉTITIONS EFFECTUÉES';

  @override
  String get neck => 'COU';

  @override
  String get waist => 'TOUR DE TAILLE';

  @override
  String get hip => 'HANCHES (femmes)';

  @override
  String get targetWeight => 'POIDS CIBLE';

  @override
  String get workingWeight => 'CHARGE DE TRAVAIL';

  @override
  String get activityLevel => 'NIVEAU D’ACTIVITÉ';

  @override
  String get barWeight => 'POIDS DE LA BARRE';

  @override
  String get perSide => 'PAR CÔTÉ';

  @override
  String get justTheBar => 'Barre seule.';

  @override
  String perSideCount(int n) {
    return '× $n par côté';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'IMC';

  @override
  String get toolNameCal => 'Calories';

  @override
  String get toolNameBf => 'Masse grasse';

  @override
  String get toolNamePlate => 'Disques';

  @override
  String get toolNameWarmup => 'Échauffement';

  @override
  String get toolTitleRm => 'Calculateur de 1RM';

  @override
  String get toolTitleBmi => 'Calculateur d’IMC';

  @override
  String get toolTitleCal => 'Calories et macros';

  @override
  String get toolTitleBf => '% de masse grasse';

  @override
  String get toolTitlePlate => 'Calculateur de disques';

  @override
  String get toolTitleWarmup => 'Séries d’échauffement';

  @override
  String get toolHintRm => 'Maximum estimé sur 1 répétition (formule d’Epley)';

  @override
  String get toolHintCal => 'Estimation des besoins quotidiens de maintien';

  @override
  String get toolHintBf => 'Estimation selon la méthode de l’US Navy';

  @override
  String get toolHintPlate => 'Poids total de la barre';

  @override
  String get toolHintWarmup => 'Charge de travail cible';

  @override
  String get toolDescRm => 'Maximum estimé sur une répétition';

  @override
  String get toolDescBmi => 'Indice de masse corporelle';

  @override
  String get toolDescCal => 'Calories et macros';

  @override
  String get toolDescBf => 'Pourcentage de masse grasse';

  @override
  String get toolDescPlate => 'Calculateur de disques de musculation';

  @override
  String get toolDescWarmup => 'Séries de montée en charge';

  @override
  String get bmiUnderweight => 'Insuffisance pondérale';

  @override
  String get bmiNormal => 'Corpulence normale';

  @override
  String get bmiOverweight => 'Surpoids';

  @override
  String get bmiObese => 'Obésité';

  @override
  String get actSedentary => 'Sédentaire';

  @override
  String get actLight => 'Faible';

  @override
  String get actActive => 'Actif';

  @override
  String get actModerate => 'Modéré';

  @override
  String get muscleChest => 'Pectoraux';

  @override
  String get muscleBack => 'Dos';

  @override
  String get muscleLowerBack => 'Lombaires';

  @override
  String get muscleShoulders => 'Épaules';

  @override
  String get muscleBiceps => 'Biceps';

  @override
  String get muscleTriceps => 'Triceps';

  @override
  String get muscleForearm => 'Avant-bras';

  @override
  String get muscleTrapezius => 'Trapèzes';

  @override
  String get muscleAbdomen => 'Abdominaux';

  @override
  String get muscleObliques => 'Obliques';

  @override
  String get muscleQuads => 'Quadriceps';

  @override
  String get muscleHamstrings => 'Ischio-jambiers';

  @override
  String get muscleGlutes => 'Fessiers';

  @override
  String get muscleCalves => 'Mollets';

  @override
  String get mgChest => 'Pectoraux';

  @override
  String get mgBack => 'Dos';

  @override
  String get mgLegs => 'Jambes';

  @override
  String get mgShoulders => 'Épaules';

  @override
  String get mgArms => 'Bras';

  @override
  String get mgCore => 'Ceinture abdominale';

  @override
  String get equipBarbell => 'Barre';

  @override
  String get equipDumbbell => 'Haltère';

  @override
  String get equipCable => 'Poulie';

  @override
  String get equipMachine => 'Machine';

  @override
  String get equipBodyweight => 'Poids du corps';

  @override
  String get equipWeighted => 'Lesté';

  @override
  String get equipBand => 'Élastique';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Anneaux';

  @override
  String get equipOther => 'Autre';

  @override
  String get diffBeginner => 'Débutant';

  @override
  String get diffAdvanced => 'Avancé';

  @override
  String get diffIntermediate => 'Intermédiaire';

  @override
  String get about => 'À PROPOS';

  @override
  String version(String v) {
    return 'Version $v';
  }

  @override
  String get aboutBlurb => 'Créé par des pratiquants, pour des pratiquants.';

  @override
  String get freeForever => 'Gratuit pour toujours';

  @override
  String get freeForeverWhy => 'Pas d’abonnement, pas de pub, rien de bloqué derrière un paiement.';

  @override
  String get fullyOffline => '100 % hors ligne';

  @override
  String get fullyOfflineWhy =>
      'Aucun compte, aucun serveur. Tes entraînements ne quittent jamais ce téléphone.';

  @override
  String get yoursToTake => 'Tes données t’appartiennent';

  @override
  String get yoursToTakeWhy => 'Exporte-les en CSV quand tu veux et supprime tout en un geste.';

  @override
  String get whatsInside => 'CONTENU';

  @override
  String exercisesInside(int n) {
    return '$n exercices';
  }

  @override
  String get exercisesInsideWhy => 'Chacun avec une animation et des instructions étape par étape.';

  @override
  String get calculatorsInside => '10 calculateurs';

  @override
  String get calculatorsInsideWhy =>
      '1RM, disques, IMC, calories, masse grasse, FFMI, échauffement, charge selon le RPE et scores de force DOTS et Wilks, tous basés sur des formules publiées.';

  @override
  String get mathInside => 'Des calculs transparents';

  @override
  String get mathInsideWhy =>
      'Volume, records et séries sont calculés à partir de tes propres données. Rien n’est là pour faire joli.';

  @override
  String get streakCaps => 'SÉRIE';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'jours', one: 'jour');
    return '$_temp0';
  }

  @override
  String get reset => 'RÉINITIALISER';

  @override
  String get welcomeKicker => 'BIENVENUE SUR';

  @override
  String get welcomeBlurb => 'Tout reste sur ton téléphone. Aucun compte, pas d’Internet, rien à payer.';

  @override
  String get welcomeStart => 'COMMENCER';

  @override
  String onbStep(int i, int n) {
    return 'ÉTAPE $i SUR $n';
  }

  @override
  String get onbNameTitle => 'Comment doit-on t’appeler ?';

  @override
  String get onbNameHint => 'Ton prénom';

  @override
  String get onbPhotoAdd => 'Ajouter une photo';

  @override
  String get onbPhotoChange => 'Changer la photo';

  @override
  String get onbPhotoTitle => 'Mets un visage sur ton profil';

  @override
  String get onbPhotoWhy =>
      'Facultatif. Elle reste sur ton téléphone et tu peux la changer quand tu veux depuis ton profil.';

  @override
  String get onbPhotoLater => 'PLUS TARD';

  @override
  String get onbNameWhy => 'Utilisé uniquement pour t’accueillir. Il ne quitte jamais ton téléphone.';

  @override
  String get onbBodyTitle => 'Quelques chiffres';

  @override
  String get onbBodyWhy =>
      'Ils servent aux calculateurs. Tu peux les modifier à tout moment dans les Paramètres.';

  @override
  String get onbGoalTitle => 'À quelle fréquence t’entraînes-tu ?';

  @override
  String get onbGoalWhy => 'Définit ton objectif hebdomadaire. Sois réaliste, pas trop ambitieux.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances par semaine',
      one: '$n séance par semaine',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilos ou livres ?';

  @override
  String get next => 'SUIVANT';

  @override
  String get back => 'RETOUR';

  @override
  String get skip2 => 'Passer';

  @override
  String get madeWithLoveBy => 'FAIT AVEC AMOUR PAR';

  @override
  String get sourceCode => 'CODE SOURCE';

  @override
  String get suggested => 'SUGGÉRÉ';

  @override
  String get results => 'RÉSULTATS';

  @override
  String get noMatches => 'Aucun exercice ne correspond à cette recherche.';

  @override
  String get tapToEdit => 'Touche le crayon pour corriger une entrée ou la corbeille pour la supprimer.';

  @override
  String get editEntry => 'Modifier';

  @override
  String get editEntryHint => 'Corrige les répétitions ou le poids de n’importe quelle série.';

  @override
  String get removeSet => 'Supprimer la série';

  @override
  String get continueWorkout => 'CONTINUER';

  @override
  String get continueWorkoutBody =>
      'La séance repasse en cours avec les séries déjà cochées. En la terminant à nouveau, elle sera enregistrée à sa date d’origine.';

  @override
  String get addBodyWidget => 'Ajouter le widget de carte musculaire';

  @override
  String get repsOnly => 'Répétitions uniquement';

  @override
  String get repsOnlyHint => 'Enregistre cet exercice sans poids.';

  @override
  String get eachSide => 'Chaque côté';

  @override
  String get eachSideHint => 'Le minuteur tourne une fois par côté, le repos commence après les deux.';

  @override
  String get useDefaultArt => 'Revenir à l’illustration par défaut';

  @override
  String daysShort(int n) {
    return '$n j';
  }

  @override
  String get focusCard => 'Objectif du jour';

  @override
  String get autoAdvance => 'Passer automatiquement au suivant';

  @override
  String get keepScreenOn => 'Garder l\'écran allumé pendant l\'entraînement';

  @override
  String get lockWorkout => 'Verrouiller l\'écran';

  @override
  String get unlockWorkout => 'Déverrouiller';

  @override
  String get holdToUnlock => 'Maintenir pour déverrouiller';

  @override
  String get liveChannel => 'Séance en cours';

  @override
  String get liveChannelWhy => 'Affiche l\'exercice, la série et le repos en cours pendant l\'entraînement';

  @override
  String liveSet(int n, int total) {
    return 'Série $n sur $total';
  }

  @override
  String get liveResting => 'Repos';

  @override
  String get liveAllDone => 'Toutes les séries sont faites';

  @override
  String get autoAdvanceHint => 'Passe au suivant après la dernière série';

  @override
  String get placePlates => 'Disques et barre';

  @override
  String get platesAll => 'Tout est disponible';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n tailles', one: '$n taille');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PAIRES';

  @override
  String plateAchievable(String w) {
    return 'Charge la plus proche possible : $w';
  }

  @override
  String get autoWarmup => 'Commencer par des séries d’échauffement';

  @override
  String get autoWarmupHint => 'Ajoute les séries de montée en charge à l’ouverture de la séance.';

  @override
  String get trainReminder => 'Rappel d’entraînement';

  @override
  String get trainReminderHint => 'Un rappel à cette heure, uniquement les jours où ton programme est prévu.';

  @override
  String get reminderExactTime => 'Heure exacte';

  @override
  String get toastSoundSetting => 'Son des notifications';

  @override
  String get toastSoundHint => 'Un son doux à chaque notification';

  @override
  String get notifTrainChannel => 'Rappel d’entraînement';

  @override
  String get notifTrainChannelWhy => 'Un rappel pour t’entraîner les jours que tu as prévus.';

  @override
  String get notifTrainTitle => 'C’est l’heure de s’entraîner';

  @override
  String get notifTrainBody => 'Ton programme t’attend.';

  @override
  String get planIntro =>
      'Crée-moi un programme d’entraînement en utilisant uniquement les exercices de cette liste.';

  @override
  String get planFormat => 'Réponds uniquement en JSON, sous cette forme :';

  @override
  String get planNothing => 'Aucun exercice de ce fichier ne correspond à ta bibliothèque';

  @override
  String get planFailed => 'Ce fichier n’est pas un programme que GymMane peut lire';

  @override
  String get routineGroup => 'Groupe';

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String get noGroup => 'Aucun groupe';

  @override
  String get groupNameHint => 'Push / Pull / Jambes, 5×5…';

  @override
  String get filters => 'Filtres';

  @override
  String get setsPlannedHint =>
      'Choisis le nombre de séries voulu pour chacun. La séance s’ouvrira avec tout prêt.';

  @override
  String get nextTime => 'PROCHAINE FOIS';

  @override
  String get nextHold => 'garde le même poids jusqu’à réussir toutes les répétitions';

  @override
  String get bgPhoto => 'Ta photo';

  @override
  String get bgPhotoPick => 'Choisir une photo';

  @override
  String get bgPhotoChange => 'Changer la photo';

  @override
  String get bgPhotoRemove => 'Supprimer la photo';

  @override
  String get bgDim => 'ASSOMBRISSEMENT';

  @override
  String get dimSoft => 'Léger';

  @override
  String get dimMedium => 'Moyen';

  @override
  String get dimStrong => 'Fort';

  @override
  String get bgPhotoHint =>
      'Elle apparaît derrière toute l’interface, assombrie pour garder l’application lisible.';

  @override
  String get reminderSmart => 'Intelligent';

  @override
  String get reminderFixed => 'Heure fixe';

  @override
  String get reminderSmartHint =>
      'Il utilise les jours et l’heure auxquels tu t’entraînes réellement et reste silencieux si tu t’es déjà entraîné ce jour-là.';

  @override
  String get reminderSmartEmpty => 'Enregistre encore quelques séances pour qu’il apprenne tes habitudes.';

  @override
  String habitFocus(String day) {
    return 'ce que tu entraînes habituellement le $day';
  }

  @override
  String get duplicateRoutine => 'Dupliquer le programme';

  @override
  String copySuffix(String name) {
    return '$name (copie)';
  }

  @override
  String get saveAsRoutine => 'ENREGISTRER COMME PROGRAMME';

  @override
  String get savedAsRoutine => 'Enregistré comme programme';

  @override
  String get templates => 'Programmes prêts à l’emploi';

  @override
  String get templatesHint =>
      'Des programmes classiques construits à partir de ta propre bibliothèque. Tu peux tout modifier ensuite.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n programmes ajoutés',
      one: '$n programme ajouté',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Trois séances corps entier par semaine. Idéal pour commencer.';

  @override
  String get tplPpl => 'Push, pull et jambes. Trois ou six jours par semaine.';

  @override
  String get tplArnold => 'Pecs et dos, épaules et bras, jambes. Le split classique sur six jours.';

  @override
  String get tplUpperlower => 'Haut et bas du corps, quatre jours par semaine.';

  @override
  String get tplStronglifts => 'Deux séances de cinq séries de cinq, en alternance.';

  @override
  String get tplStartingstrength => 'Squat à chaque séance, avec deux séances en alternance.';

  @override
  String get tplHome => 'Rien d’autre qu’une barre de traction et le sol.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jours', one: '$n jour');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Enregistrer l’effort (RPE)';

  @override
  String get rpeHint => '10 = plus aucune répétition possible ; 8 = environ deux répétitions en réserve.';

  @override
  String get superset => 'Superset';

  @override
  String get supersetLink => 'Enchaîner avec le suivant';

  @override
  String get supersetUnlink => 'Séparer du suivant';

  @override
  String get supersetHint => 'Aucun repos entre les exercices enchaînés, tu passes directement au suivant.';

  @override
  String get aiRoutine => 'Programme avec une IA';

  @override
  String get aiIntro =>
      'GymMane ne communique jamais directement avec une IA. Tu exportes ta liste d’exercices, tu la colles dans l’assistant que tu utilises déjà, puis tu réimportes sa réponse. Rien ne quitte le téléphone tout seul.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n noms n’étaient pas dans ta bibliothèque',
      one: '1 nom n’était pas dans ta bibliothèque',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Applications prises en charge';

  @override
  String get importOtherCsv => 'Tout autre CSV contenant date, exercice, répétitions et poids';

  @override
  String get importAskApp => 'Besoin d’une autre application ? Demande son ajout';

  @override
  String get awardFirstStepName => 'Premier pas';

  @override
  String get awardFirstStepLine => 'Bienvenue sur GymMane. Celle-ci est offerte.';

  @override
  String get awardFirstWorkoutName => 'Première séance';

  @override
  String get awardFirstWorkoutLine => 'La première est enregistrée. C’est la plus difficile.';

  @override
  String get awardFirstRoutineName => 'Premier programme';

  @override
  String get awardFirstRoutineLine => 'Tu as maintenant un plan auquel revenir.';

  @override
  String get awardFirstRecordName => 'Premier record';

  @override
  String get awardFirstRecordLine => 'Tu as battu ton meilleur résultat sur un exercice.';

  @override
  String get awardStreak3Name => 'Trois d’affilée';

  @override
  String get awardStreak3Line => 'Trois jours de suite. C’est comme ça que ça commence.';

  @override
  String get awardTonne1Name => 'Une tonne';

  @override
  String get awardTonne1Line => 'Mille kilos soulevés au total sur tes séries.';

  @override
  String get awardSets100Name => 'Cent séries';

  @override
  String get awardSets100Line => 'Cent séries terminées, une à la fois.';

  @override
  String get awardHours10Name => 'Dix heures';

  @override
  String get awardHours10Line => 'Dix heures d’entraînement au compteur.';

  @override
  String get awardWorkouts50Name => 'Cinquante séances';

  @override
  String get awardWorkouts50Line => 'Cinquante séances derrière toi.';

  @override
  String get awardHours50Name => 'Cinquante heures';

  @override
  String get awardHours50Line => 'Cinquante heures passées à t’entraîner.';

  @override
  String get awardsTitle => 'Médailles';

  @override
  String get yearTitle => 'Ton année';

  @override
  String get yearBestMonth => 'Meilleur mois';

  @override
  String get yearMonths => 'mois';

  @override
  String get awardSpinHint => 'Fais glisser la médaille pour la faire tourner';

  @override
  String get awardUnlocked => 'Nouveau succès débloqué';

  @override
  String get awardNice => 'Bravo !';

  @override
  String get awardSaveImage => 'Enregistrer l’image';

  @override
  String get awardSaved => 'Enregistrée dans ta galerie';

  @override
  String get awardStreak7Name => 'Sept jours';

  @override
  String get awardStreak7Line => 'Une semaine complète sans manquer un jour.';

  @override
  String get awardStreak30Name => 'Trente jours';

  @override
  String get awardStreak30Line => 'Un mois d’affilée. C’est maintenant une habitude.';

  @override
  String get awardWorkouts100Name => 'Cent séances';

  @override
  String get awardWorkouts100Line => 'Cent séances enregistrées du début à la fin.';

  @override
  String get awardTonnes100Name => 'Cent tonnes';

  @override
  String get awardTonnes100Line => 'Tout ce que tu as soulevé atteint 100 000 kg.';

  @override
  String get awardSets1000Name => 'Mille séries';

  @override
  String get awardSets1000Line => 'Une série à la fois, jusqu’à mille.';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get pickBadge => 'Badge';

  @override
  String get statWorkouts => 'Séances';

  @override
  String get statTrained => 'Entraînement';

  @override
  String get statSets => 'Séries';

  @override
  String get statLifted => 'Soulevé';

  @override
  String get statStreak => 'Série';

  @override
  String get statDays => 'jours';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'jours';

  @override
  String get snapshots => 'Photos';

  @override
  String get snapNow => 'En prendre une';

  @override
  String get addCover => 'Ajouter une couverture';

  @override
  String get addTodayWidget => 'Séance du jour faite ou non';

  @override
  String get photosCard => 'Tes photos';

  @override
  String get handleLabel => 'Nom d’utilisateur';

  @override
  String get setupTitle => 'Renseigne ces éléments et le reste de la page se remplira automatiquement';

  @override
  String get setupHint => 'Chaque chiffre ici vient de ce que tu enregistres. Rien n’est envoyé nulle part.';

  @override
  String get setupWorkout => 'Enregistre ta première séance';

  @override
  String get setupWeight => 'Note ton poids corporel';

  @override
  String get setupMeasures => 'Prends tes mensurations';

  @override
  String get setupPhoto => 'Prends ta première photo de progression';

  @override
  String get progressTitle => 'Progression';

  @override
  String get tileVolume30 => 'Volume · 30 j';

  @override
  String get tileAddWeight => 'Ajouter le tien';

  @override
  String get heatToneTitle => 'Couleur de chaleur';

  @override
  String get heatToneHint => 'Modifie uniquement la couleur de la grille et du corps.';

  @override
  String get thisWeekTitle => 'Cette semaine';

  @override
  String get momentsEmptyTitle => 'Rien ici pour l’instant';

  @override
  String get deletePhotoTitle => 'Supprimer cette photo ?';

  @override
  String get deletePhotoBody => 'Elle sera définitivement supprimée.';

  @override
  String get awardsEarned => 'Obtenues';

  @override
  String get awardsLocked => 'Verrouillées';

  @override
  String get awardStreak100Name => 'Cent jours';

  @override
  String get awardWorkouts10Name => 'Dix séances';

  @override
  String get awardWorkouts10Line => 'Les dix premières sont celles qui font la différence.';

  @override
  String get awardWorkouts365Name => 'Trois cent soixante-cinq';

  @override
  String get awardWorkouts365Line => 'Une séance pour chaque jour d’une année, enregistrée une par une.';

  @override
  String get awardTonnes10Name => 'Dix tonnes';

  @override
  String get awardTonnes10Line => 'Dix mille kilos sont passés entre tes mains.';

  @override
  String get awardHours100Name => 'Cent heures';

  @override
  String get awardHours100Line => 'Cent heures sous la barre, chronomètre en main.';

  @override
  String awardWonOn(String date) {
    return 'Obtenue le $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Or',
      'blue': 'Bleu',
      'green': 'Vert',
      'other': 'Badge',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Depuis $date';
  }

  @override
  String levelShort(int n) {
    return 'Niveau $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances avant le niveau $next',
      one: '1 séance avant le niveau $next',
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
      'ember': 'Braise',
      'green': 'Vert',
      'blue': 'Bleu',
      'mono': 'Gris',
      'other': 'Couleur',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n séries';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n sur $goal cette semaine';
  }

  @override
  String momentCount(int n) {
    return '$n photos';
  }

  @override
  String photosSelected(int n) {
    return '$n sélectionnées';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Supprimer $n photos ?';
  }

  @override
  String get momentsEmptyHint =>
      'Prends une photo de la salle, du tableau, d’un montage de disques. Tout ce que tu veux garder en mémoire. Elles restent sur le téléphone et toi seul les vois.';

  @override
  String get awardStreak100Line =>
      'Cent jours d’affilée. Ce n’est plus de la motivation, c’est devenu une habitude.';

  @override
  String get coverLabel => 'COUVERTURE';

  @override
  String get removeCover => 'Supprimer la couverture';

  @override
  String get startTitle => 'Commencer une séance';

  @override
  String get logTitle => 'Enregistrer une séance';

  @override
  String get logHint => 'Sans minuteur, renseigne simplement ce que tu as fait.';

  @override
  String get orStartFrom => 'Ou commencer par';

  @override
  String get pickExercisesOption => 'Choisir des exercices';

  @override
  String get chooseFocusOption => 'Choisir une cible';

  @override
  String get plannedRoutine => 'PRÉVU';

  @override
  String get logWorkoutAction => 'ENREGISTRER UNE SÉANCE';

  @override
  String get logging => 'ENREGISTREMENT';

  @override
  String get placesLabel => 'Mes lieux';

  @override
  String get undo => 'Annuler';

  @override
  String get deleteSet => 'Supprimer la série';

  @override
  String get setDeleted => 'Série supprimée';

  @override
  String get removeWarmup => 'Retirer l\'échauffement';

  @override
  String get addWeightAction => 'Ajouter du poids';

  @override
  String get workoutOverview => 'Cette séance';

  @override
  String get allExercisesShort => 'Tous';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total séries';
  }

  @override
  String get nowLabel => 'Maintenant';

  @override
  String get deleteWorkout => 'Supprimer la séance';

  @override
  String get deleteWorkoutBody => 'Cette séance et toutes ses séries seront retirées de ton historique.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Suit ton téléphone';

  @override
  String get demoSizeTitle => 'Démo de l\'exercice pendant la séance';

  @override
  String get demoLarge => 'Grande';

  @override
  String get demoSmall => 'Petite';

  @override
  String get demoOff => 'Masquée';

  @override
  String get demoLoopTitle => 'Animation de la démo';

  @override
  String get demoLoopAlways => 'En boucle';

  @override
  String get demoLoopShort => '10 secondes';

  @override
  String get demoLoopHint =>
      'Tourne une dizaine de secondes puis s’arrête sur la position de départ. Touchez la démo pour la revoir.';

  @override
  String get alarmStyleTitle => 'À la fin du repos';

  @override
  String get alarmStyleLoud => 'Toujours sonner';

  @override
  String get alarmStyleQuiet => 'Respecter le mode silencieux';

  @override
  String get alarmStyleVibrate => 'Vibrer seulement';

  @override
  String get alarmStyleHint =>
      '« Toujours sonner » utilise le volume de l\'alarme, même en silencieux. « Respecter le mode silencieux » utilise le volume des notifications et vibre seulement quand le téléphone est muet.';

  @override
  String get suggestedPicks => 'Suggérés pour toi';

  @override
  String get moreOptions => 'Plus d\'options';

  @override
  String get suggestInWorkouts => 'Suggérer dans les séances rapides';

  @override
  String get suggestInWorkoutsHint =>
      'Désactivé, il n\'apparaît plus dans les suggestions. Tu peux toujours l\'ajouter à la main.';

  @override
  String get onbPlaceTitle => 'Où t\'entraînes-tu ?';

  @override
  String get onbPlaceWhy =>
      'Choisis tous les lieux où tu t\'entraînes. On ne te proposera que ce que tu peux faire dans chacun.';

  @override
  String get onbPlaceGear => 'Qu\'as-tu sur place ?';

  @override
  String distanceCol(String unit) {
    return 'DISTANCE ($unit)';
  }

  @override
  String get timeCol => 'TEMPS';

  @override
  String get timePerSideCol => 'TEMPS / CÔTÉ';

  @override
  String get timeMinutesTitle => 'Temps (minutes)';

  @override
  String get timeSecondsTitle => 'Temps (secondes)';

  @override
  String distanceTitle(String unit) {
    return 'Distance ($unit)';
  }

  @override
  String get holdLabel => 'Tenir';

  @override
  String get stopLabel => 'Arrêter';

  @override
  String startHold(String time) {
    return 'Démarrer · $time';
  }

  @override
  String get exerciseTypeLabel => 'Enregistrer par';

  @override
  String get typeReps => 'Répétitions et poids';

  @override
  String get typeTime => 'Temps';

  @override
  String get typeCardio => 'Distance et temps';

  @override
  String get exerciseTypeHint =>
      'Le cardio comme la course ou la natation enregistre distance et temps. Les gainages comme la planche enregistrent le temps.';

  @override
  String get howToLabel => 'Comment faire (facultatif)';

  @override
  String get howToHint => 'Une étape par ligne';

  @override
  String get editExercise => 'Modifier l\'exercice';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get noStepsYet => 'Pas encore d\'étapes. Écris les tiennes pour te rappeler comment tu le fais.';

  @override
  String get addSteps => 'Écrire les étapes';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Une série classique. Elle compte pour le volume et les records.';

  @override
  String get setTypeWarmupInfo =>
      'Séries légères pour se préparer. Elles ne comptent ni pour le volume ni pour les records.';

  @override
  String get setTypeDropInfo => 'Juste après une série, baissez la charge et continuez sans repos.';

  @override
  String get setTypeFailureInfo =>
      'Continuez jusqu’à ne plus pouvoir faire une répétition propre. Notez celles réellement faites.';

  @override
  String get setTypeRestPauseInfo =>
      'Reposez-vous 10 à 20 secondes après la série, puis arrachez quelques répétitions de plus.';

  @override
  String get planFormatNotes =>
      'Utilise les noms d\'exercices exactement comme dans la liste. « sets », « reps », « weight » (dans l\'unité indiquée), « rest » en secondes et « days » sont facultatifs. « superset »: true relie un exercice au suivant. Pour plusieurs semaines, regroupe les routines dans « weeks » comme dans le deuxième exemple.';

  @override
  String get planSets => 'Planifier les séries';

  @override
  String get planSetsHint =>
      'Choisis le type, les répétitions et le poids de chaque série. Laisse le poids sur Auto pour partir de ta dernière séance.';

  @override
  String get planHintReps =>
      'Choisis le type et les répétitions de chaque série. Auto part de ta dernière séance.';

  @override
  String get planHintTime => 'Choisis le type et la durée de chaque série. Auto part de ta dernière séance.';

  @override
  String get planHintTimeWeight =>
      'Choisis le type, la durée et le poids de chaque série. Auto part de ta dernière séance.';

  @override
  String get planHintCardio =>
      'Choisis la distance et la durée de chaque série. Auto part de ta dernière séance.';

  @override
  String get timeOnly => 'Durée uniquement';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Effacer le plan';

  @override
  String get shareRoutine => 'Partager la routine';

  @override
  String get shareWeek => 'Partager ma semaine';

  @override
  String get shareWeekHint => 'Toutes tes routines et le jour de chacune.';

  @override
  String shareMessage(String name) {
    return '$name: ouvre le fichier avec GymMane pour l\'ajouter.';
  }

  @override
  String get importRoutines => 'Importer des routines';

  @override
  String get importPasteHint =>
      'Colle une routine ici : partagée depuis GymMane, une réponse d\'IA, du JSON ou du CSV.';

  @override
  String get pasteAction => 'Coller';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n routines', one: '1 routine');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Utiliser aussi son planning hebdo';

  @override
  String get useTheirScheduleHint =>
      'Les jours qu\'elle apporte remplacent ce que tu avais prévu ces jours-là.';

  @override
  String get addToMyRoutines => 'Ajouter à mes routines';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n routines ajoutées',
      one: '1 routine ajoutée',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Rien à importer ici pour GymMane';

  @override
  String get aiStepCopy =>
      'Copie la demande. Elle contient ta liste d\'exercices et le format que GymMane lit.';

  @override
  String get aiStepAsk =>
      'Colle-la dans n\'importe quelle IA et dis ce que tu veux : jours par semaine, objectif, nombre de semaines.';

  @override
  String get aiStepPaste => 'Colle sa réponse ci-dessous et importe-la. Aucun fichier nécessaire.';

  @override
  String get copyForAi => 'Copier pour l\'IA';

  @override
  String get copiedDone => 'Copié';

  @override
  String get aiPasteHint => 'Colle ici la réponse de l\'IA';

  @override
  String get importAction => 'Importer';

  @override
  String get showFormat => 'Voir le format';

  @override
  String get shareAsFile => 'Partager en fichier';

  @override
  String get recoveryTab => 'Récupération';

  @override
  String recoveryOverall(int pct) {
    return 'Corps récupéré à $pct %';
  }

  @override
  String get recoveryAllFresh => 'Tout est récupéré. Bon jour pour entraîner n\'importe quoi.';

  @override
  String recoveryStill(String muscles) {
    return 'Encore en récupération : $muscles';
  }

  @override
  String get recoveryTired => 'Fatigué';

  @override
  String get recoveryFresh => 'Frais';

  @override
  String get recoveryHint =>
      'Touche un muscle pour voir s\'il est récupéré. Les séries récentes comptent plus, et les plus dures (selon le RPE) encore plus.';

  @override
  String recoveryPct(int pct) {
    return '$pct % récupéré';
  }

  @override
  String readyInHours(int h) {
    return 'prêt dans ~$h h';
  }

  @override
  String get tplAbcd => 'Quatre jours : pecs et triceps, dos et biceps, jambes, épaules et abdos.';

  @override
  String get tplAbcde => 'Cinq jours, un groupe par jour : pecs, dos, jambes, épaules, bras.';

  @override
  String get elapsedCaps => 'ÉCOULÉ';

  @override
  String get tapToChange => 'Touche pour modifier';

  @override
  String get swipeToSkipHint => 'Fais glisser le minuteur sur le côté pour passer le repos.';

  @override
  String get screenLocked => 'Écran verrouillé';

  @override
  String get lockedHint => 'Maintiens l\'empreinte en haut pour déverrouiller';

  @override
  String get liveDoneSet => 'Série faite';

  @override
  String get liveSkipRest => 'Passer le repos';

  @override
  String get livePause => 'Pause';

  @override
  String get liveResume => 'Reprendre';

  @override
  String get liveNext => 'Suivant';

  @override
  String liveUpNext(String name) {
    return 'Ensuite : $name';
  }

  @override
  String get stickerOpen => 'Partager sur une photo';

  @override
  String get stickerNoPhoto => 'Sans photo';

  @override
  String get stickerWorkout => 'Séance';

  @override
  String get stickerStreak => 'Série';

  @override
  String get stickerDate => 'Date';

  @override
  String get stickerHint => 'Fais-la glisser pour la déplacer, pince pour la redimensionner ou la tourner';

  @override
  String get stickerSaved => 'Enregistrée dans ta galerie';

  @override
  String get stickerWeek => 'Cette semaine';

  @override
  String get getReady => 'Prépare-toi';

  @override
  String sideOfTwo(String n) {
    return 'Côté $n sur 2';
  }

  @override
  String get switchSides => 'Change de côté';

  @override
  String get stickerGallery => 'Galerie';

  @override
  String get stickerCamera => 'Appareil photo';

  @override
  String get shareIntroTitle => 'Partage cette routine';

  @override
  String get shareIntroBody =>
      'Envoie-la à ton ou ta partenaire, à un ami ou à ta famille. Ils reçoivent un petit fichier qui s\'ouvre avec GymMane et l\'ajoute en un geste, avec ses séries et ses poids.';

  @override
  String get removedFromRoutine => 'Retiré de la routine';

  @override
  String get radarTitle => '30 derniers jours';

  @override
  String get radarHint => 'Vois quelles zones ont besoin de plus de travail';

  @override
  String get radarEmpty => 'Entraînez-vous quelques jours pour voir votre équilibre';

  @override
  String get radarBalanced => 'Bon équilibre pour l\'instant';

  @override
  String radarFocus(String list) {
    return 'À travailler : $list';
  }

  @override
  String get countdownReady => 'Prépare-toi';

  @override
  String get countdownSkip => 'Touche pour commencer tout de suite';

  @override
  String get countdownSetting => 'Compte à rebours avant de commencer';

  @override
  String get effortSetting => 'Noter l\'effort';

  @override
  String get effortHint =>
      'RPE : 10, c\'est ne plus pouvoir en faire une ; 8, qu\'il en restait deux. Le RIR compte les répétitions qu\'il te restait. Si la série en a un, le 1RM estimé utilise la table RPE.';

  @override
  String get rirHint => '0, c\'est ne plus pouvoir en faire une ; 2, qu\'il en restait deux.';

  @override
  String get addWeekWidget => 'Ajouter le widget de la semaine';

  @override
  String get gamificationSetting => 'Médailles et niveaux';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rép.', one: '$n rép.');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Meilleure série';

  @override
  String get weekStartSetting => 'La semaine commence le';

  @override
  String get stepOutOfWorkout => 'Mettre en pause et quitter';

  @override
  String get saveToRoutine => 'ENREGISTRER DANS LE PROGRAMME';

  @override
  String get routineUpdated => 'Programme mis à jour';

  @override
  String saveChangesTitle(String name) {
    return 'Enregistrer les modifications dans $name ?';
  }

  @override
  String get saveChangesBody => 'La prochaine fois que tu le lanceras, le programme aura ces modifications.';

  @override
  String get routineOrderChanged => 'Nouvel ordre des exercices';

  @override
  String get mineOnly => 'Créés par toi';

  @override
  String createNamed(String name) {
    return 'Introuvable ? Créer « $name »';
  }

  @override
  String get orStartWith => 'Ou commence par';

  @override
  String get warmupFocus => 'Échauffement';

  @override
  String get warmupFocusHint => 'Mobilité et activation, avec ou sans matériel';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Course, vélo, rameur ou corde, en distance et en temps';

  @override
  String get homeRecommended => 'Recommandations sur l’accueil';

  @override
  String get homeRoutines => 'Routines sur l’accueil';

  @override
  String get homeRoutinesHint => 'La dernière faite d\'abord';

  @override
  String get homeWeekStats => 'Cette semaine sur l’accueil';

  @override
  String get homeWeekStatsHint => 'Volume, séries et records de la semaine';

  @override
  String get stepsSetting => 'Pas depuis Health Connect';

  @override
  String get stepsSettingHint => 'Les pas du jour sur l\'Accueil';

  @override
  String get stepsToday => 'Pas aujourd\'hui';

  @override
  String stepsOfGoal(String goal) {
    return 'sur $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count pas aujourd\'hui';
  }

  @override
  String get stepsGoal => 'Objectif de pas quotidien';

  @override
  String get stepsNoAccess => 'Pas d’accès à tes pas';

  @override
  String get stepsGrant => 'Touche pour l’autoriser dans Health Connect';

  @override
  String get stepsInfoRead =>
      'Lit seulement ton nombre de pas. Ne lit rien d’autre et n’écrit jamais dans Health Connect.';

  @override
  String get stepsInfoLocal => 'Tes pas restent sur ton téléphone. GymMane ne se connecte jamais à internet.';

  @override
  String get stepsInfoOff => 'Désactivable à tout moment dans les Réglages ou dans Health Connect.';

  @override
  String get stepsManage => 'Gérer l’autorisation';

  @override
  String get routineDoneToday => 'Fini pour aujourd’hui · bien joué';

  @override
  String get trainAgain => 'S’entraîner encore';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Il y a $n jours',
      one: 'Faite hier',
      zero: 'Faite aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Archivés';

  @override
  String get archiveExercise => 'Archiver l’exercice';

  @override
  String get restoreExercise => 'Restaurer';

  @override
  String get archivedToast => 'Exercice archivé';

  @override
  String get archivedToastHint => 'Retrouve-le dans Exercices › Archivés';

  @override
  String get archivedBanner =>
      'Archivé. Il n’apparaît plus dans les listes ni les suggestions ; ton historique est conservé.';

  @override
  String get videoMarksHint =>
      'Mets en pause sur une étape et touche l’épingle pour y revenir la prochaine fois.';

  @override
  String get videoMarkHere => 'Marquer cette étape ici';

  @override
  String get sectionGeneral => 'Général';

  @override
  String get sectionTraining => 'Entraînement';

  @override
  String get sectionAlerts => 'Rappels et alarme';

  @override
  String get sectionHome => 'Accueil';

  @override
  String get sectionWidgets => 'Widgets';

  @override
  String get sectionData => 'Données et sauvegarde';

  @override
  String get multiPlanSetting => 'Plusieurs programmes par jour';

  @override
  String get multiPlanHint =>
      'Touche chaque programme de ce jour. Ils suivent l’ordre dans lequel tu les ajoutes.';

  @override
  String routineOfDay(int n, int total) {
    return '$n sur $total aujourd’hui';
  }

  @override
  String get nextToday => 'Ensuite aujourd’hui';

  @override
  String get planAboutMe => 'À propos de moi :';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age ans, $height, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Je veux m’entraîner $n jours par semaine.';
  }

  @override
  String get planNoHistory =>
      'Aucune séance enregistrée : considère-moi comme débutant et reste prudent sur le volume et les charges.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances enregistrées ces 30 derniers jours.',
      one: '1 séance enregistrée ces 30 derniers jours.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Meilleures séries récentes';

  @override
  String get planAskFirst =>
      'Si tu ne connais pas mon objectif (force, muscle, perte de gras ou forme générale) ou la durée possible d’une séance, demande-le-moi d’abord en un court message. Ensuite, réponds uniquement en JSON.';

  @override
  String get backToTop => 'Revenir en haut';

  @override
  String get deleteExerciseTitle => 'Supprimer cet exercice ?';

  @override
  String deleteExerciseBody(String name) {
    return '« $name » sera retiré de ta bibliothèque et de tes programmes. Tes séries passées sont conservées.';
  }

  @override
  String get exportForStravaHint =>
      'Importe-le depuis un navigateur sur strava.com/upload/select (l’app Strava n’importe pas de fichiers). Il apparaît comme musculation avec tes séries.';

  @override
  String get manualStartTime => 'Heure de début';

  @override
  String get manualDuration => 'Durée';

  @override
  String get manualDurationUnset => 'Ajouter la durée';

  @override
  String get stravaRow => 'Exporter vers Strava (bêta)';

  @override
  String get stravaBeta => 'BÊTA';

  @override
  String get stravaIntro =>
      'Choisis une séance à envoyer sur Strava. Tu obtiens un fichier .fit : importe-le depuis un navigateur sur strava.com/upload/select, il apparaît comme musculation avec tes séries.';

  @override
  String get stravaEmpty => 'Aucune séance à exporter pour l’instant.';

  @override
  String get tapToPause => 'Touche pour mettre en pause';

  @override
  String get holdPausedHint => 'En pause · touche pour reprendre';

  @override
  String get finishHoldNow => 'Finir la série maintenant';

  @override
  String get barWeightExercise => 'Poids de la barre ou du chariot';

  @override
  String get barWeightHint => 'Utilisé par le calculateur de disques';

  @override
  String get barWeightCustom => 'Personnalisé · touche pour réinitialiser';

  @override
  String get groupRename => 'Renommer le groupe';

  @override
  String get groupUngroup => 'Retirer le groupe, garder les routines';

  @override
  String get groupDeleteAll => 'Supprimer le groupe et ses routines';

  @override
  String groupDeleteTitle(String name) {
    return 'Supprimer « $name » ?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count seront supprimées. Ton historique d’entraînement est conservé.';
  }

  @override
  String get tplRr =>
      'Le classique de r/bodyweightfitness : tout le corps trois jours par semaine. Passe à l’étape suivante quand ça devient facile.';

  @override
  String get levelUpKicker => 'ÉTAPE SUIVANTE';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps sur $name deux séances d’affilée. Prêt pour l’étape suivante ?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Le remplacer dans $routine';
  }

  @override
  String get levelUpSee => 'Voir comment faire';

  @override
  String get levelUpLater => 'Pas maintenant';

  @override
  String get levelUpStay => 'Je garde celui-ci';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name est maintenant dans $routine';
  }

  @override
  String get levelUpStayed => 'Plus de suggestion de progression pour celui-ci';

  @override
  String get levelHintsSetting => 'Suggérer l’étape suivante';

  @override
  String get heatmapLabelsSetting => 'Jours et mois sur la carte d\'activité';

  @override
  String get rmPercent => 'POURCENTAGE';

  @override
  String rmAtPercent(String pct) {
    return '$pct de ton max';
  }

  @override
  String get copyWorkout => 'Copier en texte';

  @override
  String get goalSet => 'Fixer un objectif';

  @override
  String get goalTargetReps => 'RÉPÉTITIONS VISÉES';

  @override
  String goalToGo(String value) {
    return 'Encore $value';
  }

  @override
  String get goalReached => 'Objectif atteint';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n jours restants',
      one: '1 jour restant',
    );
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Date dépassée';

  @override
  String get goalDeadline => 'ÉCHÉANCE';

  @override
  String get goalNoDeadline => 'Sans échéance';

  @override
  String get goalRemove => 'Supprimer l\'objectif';

  @override
  String get exerciseNameMissing => 'Donnez-lui un nom';

  @override
  String get aliasesLabel => 'Autres noms (facultatif)';

  @override
  String get aliasesHint => 'Autres noms, séparés par des virgules';

  @override
  String alsoCalled(String names) {
    return 'Aussi : $names';
  }

  @override
  String get addToRoutine => 'Ajouter au programme';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dans $n programmes',
      one: 'Dans 1 programme',
      zero: 'Dans aucun programme pour l’instant',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Déjà dedans';

  @override
  String get restInRoutine => 'Repos dans ce programme';

  @override
  String get restInRoutineHint => 'Le même que pour l’exercice';

  @override
  String get restInRoutineReset => 'Ici seulement · touchez pour annuler';

  @override
  String get swapExercise => 'Changer d’exercice';

  @override
  String get swapShort => 'Changer';

  @override
  String swapHint(String name) {
    return 'À la place de $name, juste aujourd’hui. À la fin, vous pourrez le garder dans le programme.';
  }

  @override
  String get swapKeepsDone => 'Les séries déjà faites restent ; le nouveau reprend celles qui restent.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Même muscle · $muscle';
  }

  @override
  String get swapDoneBefore => 'Déjà fait';

  @override
  String get multiPlanSettingHint => 'Plusieurs programmes le même jour de la semaine';

  @override
  String get levelHintsHint => 'Propose la version plus dure';

  @override
  String get focusCardHint => 'Le programme du jour, en haut de l’Accueil';

  @override
  String get gamificationHint => 'Médailles, niveau et célébration';

  @override
  String get exerciseSettings => 'Réglages de cet exercice';

  @override
  String get placeActiveNow => 'Vous êtes ici';

  @override
  String get placeTapToUse => 'touchez pour vous entraîner ici';

  @override
  String get intervalDays => 'jours';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target jours';
  }

  @override
  String get toolNameRpe => 'Charge selon RPE';

  @override
  String get toolTitleRpe => 'Charge selon RPE';

  @override
  String get toolDescRpe => 'Quel poids pour l’effort voulu';

  @override
  String get toolNameDots => 'Niveau de force';

  @override
  String get toolTitleDots => 'Niveau de force (DOTS)';

  @override
  String get toolDescDots => 'Votre force selon votre poids';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Pour $reps reps à RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Une série que vous venez de faire';

  @override
  String get rpeGoal => 'Ce que vous voulez faire';

  @override
  String rpeOneRmLine(String value) {
    return '1RM estimé : $value';
  }

  @override
  String get rpeExplain => 'RPE 10 : impossible d’en faire une de plus ; 8 : il en restait deux.';

  @override
  String get dotsBestLifts => 'Vos meilleures barres';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'DÉVELOPPÉ COUCHÉ';

  @override
  String get dotsDeadlift => 'SOULEVÉ DE TERRE';

  @override
  String dotsTotalLine(String value) {
    return 'Total : $value';
  }

  @override
  String get dotsExplain =>
      'Compare votre force à celle de n’importe qui, quel que soit son poids. Utilisez votre meilleure répétition ou votre 1RM estimé.';

  @override
  String get dotsLevel0 => 'Débutant';

  @override
  String get dotsLevel1 => 'Intermédiaire';

  @override
  String get dotsLevel2 => 'Avancé';

  @override
  String get dotsLevel3 => 'Très avancé';

  @override
  String get dotsLevel4 => 'Élite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Score Wilks';

  @override
  String get toolDescWilks => 'Le score classique du powerlifting';

  @override
  String get wilksExplain =>
      'La formule classique du powerlifting. DOTS l’a remplacée en 2020, mais beaucoup de compétitions et de classements l’utilisent encore.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Indice de masse maigre';

  @override
  String get toolDescFfmi => 'Ta masse musculaire pour ta taille';

  @override
  String get ffmiBodyFat => 'MASSE GRASSE';

  @override
  String ffmiLeanLine(String value) {
    return 'Masse maigre : $value';
  }

  @override
  String get ffmiExplain =>
      'Comme l’IMC, mais sans la graisse : seule ta masse maigre compte. Ajusté à ta taille pour comparer équitablement grands et petits.';

  @override
  String get ffmiLevel0 => 'Sous la moyenne';

  @override
  String get ffmiLevel1 => 'Dans la moyenne';

  @override
  String get ffmiLevel2 => 'Au-dessus de la moyenne';

  @override
  String get ffmiLevel3 => 'Excellent';

  @override
  String get ffmiLevel4 => 'Exceptionnel';

  @override
  String get rpeEffortLabel => 'Effort (RPE)';

  @override
  String get restRowHint => 'Entre les séries, sauf si l’exercice a le sien';

  @override
  String get effortRowHint => 'Notez le RPE ou le RIR à chaque série';

  @override
  String get countdownHint => '3, 2, 1 avant la première série';

  @override
  String get keepScreenOnHint => 'L’écran reste allumé pendant la séance';

  @override
  String get demoSizeRowHint => 'Le dessin de l’exercice pendant la séance';

  @override
  String get demoLoopRowHint => 'Si l’animation se répète ou s’arrête';

  @override
  String get trainReminderRowHint => 'Un rappel les jours d’entraînement';

  @override
  String get alarmSoundRowHint => 'Ce qui sonne à la fin du repos';

  @override
  String get alarmStyleRowHint => 'S’il sonne en mode silencieux';

  @override
  String get recommendedRowHint => 'Exercices que l’on vous propose sur l’Accueil';

  @override
  String get weightStepSetting => 'Pas de poids';

  @override
  String get weightStepHint => 'Ce qu’ajoutent les boutons − et +';

  @override
  String get prBestWorkout => 'Meilleure séance';

  @override
  String get mergeExercise => 'Fusionner';

  @override
  String mergeExerciseInto(String name) {
    return 'Fusionner $name avec…';
  }

  @override
  String get mergeExerciseTitle => 'Fusionner les exercices ?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Tout l’historique de « $from » passe à « $to ». « $from » reste dans ta bibliothèque. C’est irréversible.';
  }

  @override
  String get mergedToast => 'Historique fusionné';

  @override
  String get nutrition => 'Nutrition';

  @override
  String get nutritionHomeEmpty => 'Eau, protéines et calories';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g de protéines';
  }

  @override
  String get nutritionToday => 'Aujourd’hui';

  @override
  String get nutritionYesterday => 'Hier';

  @override
  String get nutritionGoals => 'Objectifs du jour';

  @override
  String get kcalLabel => 'CALORIES';

  @override
  String get kcalOver => 'en trop';

  @override
  String get waterLabel => 'EAU';

  @override
  String get waterDone => 'Objectif atteint';

  @override
  String get waterCustom => 'Autre quantité';

  @override
  String get glassSize => 'Taille du verre';

  @override
  String get supplementsLabel => 'COMPLÉMENTS';

  @override
  String get supplementsEmpty => 'Touche-en un pour l’ajouter, ou + pour le tien.';

  @override
  String get addSupplement => 'Nouveau complément';

  @override
  String get supplementNameHint => 'Créatine, vitamine D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get removeSupplementBody => 'Les jours où tu l’as coché partent avec.';

  @override
  String get suppCreatine => 'Créatine';

  @override
  String get suppVitaminD => 'Vitamine D';

  @override
  String get suppOmega3 => 'Oméga-3';

  @override
  String get suppMagnesium => 'Magnésium';

  @override
  String get suppMultivitamin => 'Multivitamines';

  @override
  String get suppCaffeine => 'Caféine';

  @override
  String get myFoods => 'Mes aliments';

  @override
  String get newFood => 'Nouvel aliment';

  @override
  String get editFood => 'Modifier l’aliment';

  @override
  String get foodNameHint => 'Whey, flocons d’avoine, pain…';

  @override
  String get servingLabel => 'PORTION';

  @override
  String get servingHint => '1 dose · 30 g';

  @override
  String get perServing => 'PAR PORTION';

  @override
  String get servingsLabel => 'Portions';

  @override
  String get foodPhotoHint => 'Sur un fond uni, il devient un sticker.';

  @override
  String get cutoutWorking => 'Détourage…';

  @override
  String get cutoutTry => 'Détourer';

  @override
  String get cutoutKeep => 'Photo entière';

  @override
  String deleteFoodTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get deleteFoodBody => 'Il quitte tes aliments. Ce que tu as déjà noté reste.';

  @override
  String get mealBreakfast => 'Petit-déjeuner';

  @override
  String get mealLunch => 'Déjeuner';

  @override
  String get mealDinner => 'Dîner';

  @override
  String get mealSnacks => 'En-cas';

  @override
  String get nothingLogged => 'Rien de noté pour l’instant.';

  @override
  String addToMeal(String meal) {
    return 'Ajouter au $meal';
  }

  @override
  String get quickAdd => 'Ajout rapide';

  @override
  String get quickAddHint => 'Juste les chiffres, sans enregistrer d’aliment.';

  @override
  String get quickAddName => 'C’était quoi ? (facultatif)';

  @override
  String get logFood => 'Ajouter';

  @override
  String loggedToast(String meal) {
    return 'Ajouté au $meal';
  }

  @override
  String get entryRemoved => 'Supprimé';

  @override
  String get goalsFromProfile => 'Calculer depuis mon profil';

  @override
  String get goalsFromProfileHint =>
      'Calories de ton profil, 1,8 g de protéines et 35 ml d’eau par kg de poids corporel.';

  @override
  String get kcalEaten => 'Mangé';

  @override
  String get kcalRemaining => 'Reste';

  @override
  String waterTapHint(String amount) {
    return 'Touche le verre : + $amount';
  }

  @override
  String get shakeEmpty => 'Touche pour choisir ton shake';

  @override
  String shakeTapHint(String name) {
    return 'Touche : + $name';
  }

  @override
  String get shakePick => 'Ton shake';

  @override
  String get shakePickHint => 'Touche le verre et il est noté d’un coup.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'G';

  @override
  String get fatLetter => 'L';

  @override
  String get addBurnedLabel => 'Ajouter les calories brûlées';

  @override
  String get addBurnedHint =>
      'Les calories brûlées sont estimées à partir de la durée de tes séances et de ton poids.';

  @override
  String get amountLabel => 'Quantité';

  @override
  String amountIn(String unit) {
    return 'Quantité ($unit)';
  }

  @override
  String get bodyweightLabel => 'Poids';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aliments copiés',
      one: '1 aliment copié',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Ce que tu as déjà noté reste tel quel.';

  @override
  String get fiberLabel => 'Fibres';

  @override
  String get sugarLabel => 'Sucre';

  @override
  String get sodiumLabel => 'Sodium';

  @override
  String get foodDatabase => 'Base d’aliments';

  @override
  String get kcalBurned => 'Brûlé';

  @override
  String get mealOptions => 'Options du repas';

  @override
  String get moreNutrients => 'Fibres, sucre et sodium';

  @override
  String ofGoal(int goal, String unit) {
    return 'sur $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'pour 100 $unit';
  }

  @override
  String get perServingShort => 'par portion';

  @override
  String get foodCategory => 'CATÉGORIE';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count pièces', one: '1 pièce');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tranches',
      one: '1 tranche',
    );
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count doses', one: '1 dose');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count c. à soupe',
      one: '1 c. à soupe',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count c. à café',
      one: '1 c. à café',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count tasses', one: '1 tasse');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count verres', one: '1 verre');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Récents';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aliments',
      one: '1 aliment',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Renommer';

  @override
  String get repeatFrom => 'Reprendre de';

  @override
  String get repeatNone => 'Rien de noté pour ce repas les autres jours.';

  @override
  String get restDayGoals => 'Objectifs différents les jours de repos';

  @override
  String get trainingDays => 'Jours d’entraînement';

  @override
  String get restDays => 'Jours de repos';

  @override
  String get trainingDay => 'Jour d’entraînement';

  @override
  String get saveAsMeal => 'Enregistrer comme repas';

  @override
  String get savedMealNameHint => 'ex. Petit-déj habituel';

  @override
  String get savedMealToast => 'Repas enregistré';

  @override
  String get savedMeals => 'Repas enregistrés';

  @override
  String get searchFoodsHint => 'Chercher un aliment';

  @override
  String get searchFoodsEmpty => 'Cherche parmi plus de 500 aliments en photo, ou crée les tiens.';

  @override
  String searchFoodsNone(String query) {
    return 'Rien pour « $query ». Crée-le comme aliment perso.';
  }

  @override
  String get servingWeight => 'GRAMMES';

  @override
  String get weekAverage => 'Cette semaine';

  @override
  String get weekAvgEnergy => 'Moyenne par jour';

  @override
  String get weekAvgProtein => 'Protéines par jour';

  @override
  String get weekEnergyOnTarget => 'Calories dans l’objectif';

  @override
  String get weekProteinOnTarget => 'Protéines dans l’objectif';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g de protéines par jour';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met jours sur $days dans l’objectif';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours notés',
      one: '1 jour noté',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Rien de noté pour l’instant';

  @override
  String get weekOnTargetHint =>
      'Dans l’objectif : calories à moins de 10 % de l’objectif et au moins 90 % des protéines.';

  @override
  String get weightGoalLabel => 'Poids cible';

  @override
  String weightGoalTitle(String unit) {
    return 'Poids cible ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Objectif $weight';
  }

  @override
  String get weightGoalNone => 'Maintiens pour fixer un objectif';

  @override
  String get weightGoalReached => 'Objectif atteint';

  @override
  String weightToLose(String weight) {
    return '$weight à perdre';
  }

  @override
  String weightToGain(String weight) {
    return '$weight à prendre';
  }

  @override
  String get aminoHis => 'histidine';

  @override
  String get aminoIle => 'isoleucine';

  @override
  String get aminoLeu => 'leucine';

  @override
  String get aminoLys => 'lysine';

  @override
  String get aminoSaa => 'méthionine';

  @override
  String get aminoAaa => 'phénylalanine';

  @override
  String get aminoThr => 'thréonine';

  @override
  String get aminoTrp => 'tryptophane';

  @override
  String get aminoVal => 'valine';

  @override
  String get animalProtein => 'Protéines animales';

  @override
  String get proteinQuality => 'Qualité des protéines';

  @override
  String get qualityComplete => 'Complète';

  @override
  String get qualityAlmost => 'Presque complète';

  @override
  String get qualityIncomplete => 'Incomplète';

  @override
  String get qualityNoData => 'Pas encore de données';

  @override
  String get qualityNoDataHint => 'Note des aliments de la base pour voir tes acides aminés.';

  @override
  String get qualityAllCovered => 'Les neuf acides aminés essentiels sont couverts.';

  @override
  String qualityLimiting(String amino) {
    return 'Il te manque de la $amino. Associe-le à des aliments qui en sont riches.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Calculé sur $pct % de tes protéines : tes aliments perso n’ont pas d’acides aminés.';
  }

  @override
  String get fatTypes => 'Types de graisses';

  @override
  String get fatSaturated => 'Saturées';

  @override
  String get fatMono => 'Mono';

  @override
  String get fatPoly => 'Poly';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Saturées $grams g sur $limit g max (10 % des calories)';
  }

  @override
  String get sugarSodium => 'Sucre et sodium';

  @override
  String get shakeCard => 'Shake protéiné';

  @override
  String get mealOther => 'Repas';

  @override
  String get mealAdd => 'Ajouter un repas';

  @override
  String get mealAddHint => 'ex. Pré-séance';

  @override
  String get mealsOfDay => 'Repas de la journée';

  @override
  String get mealsHint =>
      'Crée-en autant que tu veux. En supprimer un déplace son contenu dans celui du dessus.';

  @override
  String get trackersTitle => 'Personnaliser';

  @override
  String get trackersHint => 'Garde seulement ce que tu veux suivre.';

  @override
  String get trackersDaily => 'Résumé du jour';

  @override
  String get trackersDetail => 'En détail';

  @override
  String get trackersCards => 'Cartes';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Nouvelle fournée';

  @override
  String get prepNew => 'Nouvelle fournée';

  @override
  String get prepEdit => 'Modifier la fournée';

  @override
  String get prepHint => 'Note la marmite entière une fois, puis mange-la petit à petit.';

  @override
  String get prepEmpty =>
      'Tu as cuisiné pour plusieurs jours ? Note-le une fois, puis dis juste combien du reste tu as mangé.';

  @override
  String get prepNameHint => 'ex. Poulet riz';

  @override
  String get prepDefaultName => 'Fournée';

  @override
  String get prepIngredients => 'Ingrédients';

  @override
  String get prepAddIngredient => 'Ajouter un ingrédient';

  @override
  String get prepCookedWeight => 'POIDS CUIT';

  @override
  String prepCookedHint(String grams) {
    return 'Pèse la marmite une fois cuite pour des chiffres exacts. Vide = poids cru total ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Indique le poids cuit : certains ingrédients n’ont pas de grammes.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Il reste $left sur $total';
  }

  @override
  String get prepOfWhatsLeft => '% de ce qui reste';

  @override
  String get prepAll => 'Tout';

  @override
  String prepLogAmount(String grams) {
    return 'Noter $grams';
  }

  @override
  String get prepWeighLeft => 'Peser le reste';

  @override
  String get prepFinished => 'Cette fournée est terminée.';

  @override
  String get approxValues => 'Approximatif';

  @override
  String get editValues => 'Modifier les valeurs';

  @override
  String get editValuesHint =>
      'Ne change que cette entrée. Pour corriger l’aliment la prochaine fois, modifie-le dans Mes aliments.';

  @override
  String get editLibraryHint => 'Enregistré comme aliment perso, avec la même photo';

  @override
  String per100Line(String energy, String unit) {
    return '$energy pour 100 $unit';
  }

  @override
  String get rawLabel => 'Cru';

  @override
  String get cookedLabel => 'Cuit';

  @override
  String get rawHint => 'Poids avant cuisson';

  @override
  String cookedHint(String factor) {
    return 'Poids une fois cuit (×$factor le poids cru)';
  }

  @override
  String get servingsUnit => 'portions';

  @override
  String logAmount(String energy) {
    return 'Noter · $energy';
  }

  @override
  String get catFruit => 'Fruits';

  @override
  String get catVeg => 'Légumes';

  @override
  String get catMeat => 'Viande';

  @override
  String get catFish => 'Poisson';

  @override
  String get catEgg => 'Œufs';

  @override
  String get catDairy => 'Laitages';

  @override
  String get catGrain => 'Céréales';

  @override
  String get catBakery => 'Pain';

  @override
  String get catLegume => 'Légumineuses';

  @override
  String get catNut => 'Fruits secs';

  @override
  String get catOil => 'Huiles';

  @override
  String get catPantry => 'Épicerie';

  @override
  String get catDrink => 'Boissons';

  @override
  String get catSauce => 'Sauces';

  @override
  String get catSpice => 'Épices';

  @override
  String get searchFoodsPrompt => 'Qu’as-tu mangé ?';

  @override
  String get shelfEmpty =>
      'Cherche un aliment ou prends le tien en photo : ceux que tu notes le plus apparaîtront ici.';

  @override
  String get repeatEntry => 'Refaire';

  @override
  String get notifSuppChannel => 'Compléments';

  @override
  String get notifSuppChannelWhy => 'Rappel quotidien pour prendre tes compléments';

  @override
  String get energySplit => 'D’où viennent les calories';

  @override
  String get typicalServing => 'Portion type';

  @override
  String cookedYieldLine(String factor) {
    return 'Pèse $factor× son poids cru';
  }

  @override
  String get readyDishes => 'Plats';

  @override
  String weightLastLine(String weight) {
    return 'Dernière pesée $weight';
  }

  @override
  String get proteinAnimalShort => 'Animale';

  @override
  String get proteinPlantShort => 'Végétale';

  @override
  String kcalFromMacros(String value) {
    return 'Ces macros font environ $value';
  }

  @override
  String get useValue => 'Utiliser';

  @override
  String get suppRowHint => 'Touche pour cocher · maintiens pour les détails';

  @override
  String get suppPhoto => 'Photo';

  @override
  String get suppDose => 'Dose';

  @override
  String get suppDoseHint => '5 g, 2 gélules…';

  @override
  String get suppRemind => 'Me le rappeler';

  @override
  String mealPlanDefault(int n) {
    return 'Plan $n';
  }

  @override
  String get mealPlansTitle => 'Plans de repas';

  @override
  String get mealPlanNew => 'Nouveau plan';

  @override
  String fromPlan(String name) {
    return 'Depuis $name';
  }

  @override
  String get logPlan => 'Noter';

  @override
  String get planFromDay => 'Copier ce jour';

  @override
  String get planNewHint =>
      'Planifie tes journées comme tes programmes, puis note un repas entier d’une seule touche.';

  @override
  String get planLogDay => 'Noter les repas vides';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n aliments notés',
      one: '1 aliment noté',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Aucun plan';

  @override
  String get planWeekHint => 'Touche un jour pour lui donner un plan.';

  @override
  String get planDuplicate => 'Dupliquer';

  @override
  String planDeleteTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get planDeleteBody => 'Tes routines restent. Seule cette semaine enregistrée est supprimée.';

  @override
  String get sectionBeta => 'Bêta';

  @override
  String get nutritionBeta => 'Nutrition';

  @override
  String get nutritionBetaHint => 'Repas, eau et compléments';

  @override
  String get nutritionAboutTitle => 'À propos de la nutrition';

  @override
  String get nutritionAboutSub => 'Ce que c’est, et ce que ce ne sera jamais.';

  @override
  String get nutritionAboutWhatTitle => 'Une partie de ton entraînement';

  @override
  String get nutritionAboutWhat =>
      'Une façon simple de noter tes repas, ton eau, tes protéines et tes compléments juste à côté de tes séances. GymMane est d’abord une app de musculation : la nutrition est là pour que tout soit au même endroit, pas pour remplacer une vraie app de régime.';

  @override
  String get nutritionAboutScanTitle => 'Pas de scanner, jamais';

  @override
  String get nutritionAboutScan =>
      'Scanner un code-barres et voir tout se remplir tout seul serait pratique. Mais cela demande Internet et une énorme base de données d’aliments en ligne, et ce que tu manges finit sur les serveurs de quelqu’un d’autre. Ces données montrent quand tu manges, ce que tu manges et comment tu prends soin de ton corps, et elles peuvent servir à la publicité ou finir entre les mains de grandes entreprises. C’est pour ça qu’il n’y a pas de scanner, et qu’il n’y en aura pas.';

  @override
  String get nutritionAboutLocalTitle => 'Tout sur ton téléphone';

  @override
  String get nutritionAboutLocal =>
      'Plus de 500 aliments avec photo sont inclus dans l’app. Tu peux ajouter les tiens, changer leurs photos et modifier leurs valeurs. Tout reste sur ton téléphone, comme le reste de GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Encore en bêta';

  @override
  String get nutritionAboutBeta =>
      'S’il te manque quelque chose, propose-le sur GitHub. Sauf un scanner ou une base d’aliments plus grande : en plus de ta vie privée, l’app deviendrait beaucoup plus lourde. Pas besoin de la nutrition ? Désactive-la dans les Paramètres, tes données restent.';

  @override
  String get nutritionAboutSuggest => 'Proposer une idée';

  @override
  String get nutritionAboutOk => 'Compris';

  @override
  String get planShare => 'Partager';

  @override
  String get planImport => 'Importer un plan';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n plans importés',
      one: '1 plan importé',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'Ce fichier ne contient aucun plan de repas.';

  @override
  String get planMoveUp => 'Monter';

  @override
  String get planMoveDown => 'Descendre';

  @override
  String get cutoutEdit => 'Retoucher le détourage';

  @override
  String get cutoutEditHint =>
      'Glisse pour effacer ou restaurer. Touche une zone pour la retirer ou la remettre en entier. Pince pour zoomer.';

  @override
  String get cutoutErase => 'Effacer';

  @override
  String get cutoutRestore => 'Restaurer';

  @override
  String get cutoutReset => 'Revenir à l’automatique';

  @override
  String get cutoutByHand => 'Détourer à la main';

  @override
  String notifSuppTitleFor(String names) {
    return 'C’est l’heure de prendre : $names';
  }

  @override
  String get notifSuppTap => 'Coche-le dans GymMane une fois que tu l’as pris.';

  @override
  String get suppNoneToday => 'Rien à prendre aujourd’hui.';

  @override
  String get suppOtherDays => 'Autres jours';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Tous les $n jours',
      one: 'Tous les jours',
    );
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Tous les jours';

  @override
  String suppFromDate(String date) {
    return 'à partir du $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'jusqu’au $date';
  }

  @override
  String get suppSomeDays => 'Certains jours';

  @override
  String get suppEveryShort => 'Tous les X jours';

  @override
  String get suppWhen => 'Quand';

  @override
  String get suppEveryLead => 'Tous les';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'jours', one: 'jour');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Début';

  @override
  String get suppEnds => 'Fin';

  @override
  String get suppTomorrow => 'Demain';

  @override
  String get suppPickDate => 'Choisir une date';

  @override
  String get suppNever => 'Jamais';

  @override
  String get suppOneWeek => 'Dans 1 semaine';

  @override
  String get suppOneMonth => 'Dans 1 mois';

  @override
  String get planPickHint => 'Choisis le plan de ce jour, ou crées-en un nouveau.';

  @override
  String planSetForDay(String day) {
    return 'Plan défini pour $day';
  }

  @override
  String get planSaved => 'Plan enregistré';

  @override
  String get planDiscardTitle => 'Abandonner les modifications ?';

  @override
  String get planDiscardBody => 'Ce que tu as changé ne sera pas enregistré.';

  @override
  String get planDiscard => 'Abandonner';

  @override
  String get planEdit => 'Modifier le plan';

  @override
  String get planNameHint => 'Été, voyage…';

  @override
  String get planDaysQuestion => 'Quels jours ?';

  @override
  String get planDaysHint => 'Ces jours-là, il apparaît dans Nutrition pour que tu le notes d’une touche.';

  @override
  String get planDaysNone => 'Choisis au moins un jour, sinon il n’apparaîtra nulle part.';

  @override
  String get planNothingToLog => 'Ces repas sont déjà notés';

  @override
  String get planSave => 'Enregistrer le plan';

  @override
  String get planToday => 'Plan du jour';

  @override
  String get planLogRest => 'Noter le reste';

  @override
  String get dishNew => 'Créer mon plat';

  @override
  String get dishNewHint =>
      'Choisis les ingrédients et les quantités, enregistre-le et note-le d’une touche.';

  @override
  String get dishEdit => 'Modifier le plat';

  @override
  String get dishNameHint => 'Ex. Les lentilles de maman';

  @override
  String get dishIngredients => 'Ingrédients';

  @override
  String get dishEmptyHint => 'Ajoute ce qu’il contient avec la quantité que tu manges d’habitude.';

  @override
  String get dishSave => 'Enregistrer le plat';

  @override
  String get dishNeedsName => 'Donne-lui un nom';

  @override
  String get dishNeedsItems => 'Ajoute au moins un ingrédient';

  @override
  String get suppHistory => '14 derniers jours';

  @override
  String suppTakenOf(int n, int total) {
    return '$n sur $total pris';
  }

  @override
  String get suppNoReminder => 'Pas de rappel';

  @override
  String get suppMarkTaken => 'Marquer comme pris';

  @override
  String get suppUnmark => 'Décocher';

  @override
  String get suppEdit => 'Modifier';

  @override
  String get mealMoveTo => 'Déplacer vers';

  @override
  String get mealClear => 'Vider le repas';

  @override
  String get mealCleared => 'Repas vidé';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aliments déplacés',
      one: '1 aliment déplacé',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Répéter toute la journée';

  @override
  String createFoodNamed(String name) {
    return 'Créer « $name »';
  }

  @override
  String get entryDay => 'Jour';

  @override
  String get movedToDay => 'Déplacé';

  @override
  String get favFoodsHint => 'Touche ☆ sur un aliment';

  @override
  String get favFoodsEmpty => 'Touche l’étoile d’un aliment pour le garder ici, à portée de main.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count repas', one: '1 repas');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Enregistre un repas depuis son menu •••, ou compose ton propre plat.';

  @override
  String get sugarLimitLabel => 'Limite de sucre';

  @override
  String get sodiumLimitLabel => 'Limite de sodium';

  @override
  String get waterOptions => 'Options de l’eau';

  @override
  String get waterNone => 'Pas encore d’eau notée.';

  @override
  String get waterDailyGoal => 'Eau par jour';

  @override
  String get trackersScreen => 'Écran';

  @override
  String get vesselMotion => 'Eau en mouvement et shaker';

  @override
  String get vesselMotionHint =>
      'Désactive-le si l’écran semble lent : les verres se remplissent toujours, ils ne bougent plus, c’est tout.';

  @override
  String get planFixedWeek => 'Semaine fixe';

  @override
  String get planRotation => 'Rotation';

  @override
  String get rotationTitle => 'ROTATION';

  @override
  String get rotationHint => 'La suivante est celle qui suit ta dernière séance, quel que soit le jour.';

  @override
  String get rotationEmpty => 'Ajoute tes routines dans l’ordre où tu les feras : A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done sur $total faites ce tour-ci';
  }

  @override
  String get rotationNext => 'Suivante';

  @override
  String get rotationAdd => 'Ajouter des routines';

  @override
  String get rotationPickHint => 'Elles s’ajoutent dans l’ordre où tu les touches.';

  @override
  String get rotationSkip => 'Passer à la suivante';

  @override
  String get rotationRestart => 'Nouveau tour';

  @override
  String get rotationMakeNext => 'En faire la suivante';

  @override
  String get rotationRemove => 'Retirer de la rotation';

  @override
  String rotationPlace(int n, int total) {
    return '$n sur $total de la rotation';
  }

  @override
  String get moveToDay => 'Déplacer à un autre jour';

  @override
  String get moveToDayHint => 'Juste cette fois ; ton programme de la semaine ne change pas.';

  @override
  String get movedToast => 'Séance déplacée';

  @override
  String get backToPlan => 'Revenir au programme';

  @override
  String get tomorrow => 'Demain';

  @override
  String get untrainedTab => 'Négligés';

  @override
  String get untrainedRecent => 'Récent';

  @override
  String get untrainedLong => 'Il y a longtemps';

  @override
  String untrainedWaiting(String list) {
    return 'En attente depuis le plus longtemps : $list';
  }

  @override
  String get untrainedAllRecent => 'Tous les muscles ont travaillé cette semaine. Bien joué.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Il y a $n jours',
      one: 'Travaillé hier',
      zero: 'Travaillé aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Pas encore travaillé';

  @override
  String get layoutSetting => 'Affichage de la séance';

  @override
  String get layoutCards => 'Cartes';

  @override
  String get layoutList => 'Liste';

  @override
  String get layoutHint =>
      'Les cartes montrent un exercice à la fois. La liste montre toute la séance sur un écran, série par série.';

  @override
  String get layoutRowHint => 'Un exercice à la fois ou toute la séance en liste';

  @override
  String get previousCol => 'PRÉCÉDENT';

  @override
  String get usePrevious => 'Reprendre les valeurs de la dernière fois';

  @override
  String get skipShort => 'Passer';

  @override
  String get moveUp => 'Monter';

  @override
  String get moveDown => 'Descendre';

  @override
  String get widgetNutritionOff => 'Active Nutrition dans Paramètres › Bêta pour utiliser ce widget.';

  @override
  String get widgetPickShake => 'Choisis ton shake';

  @override
  String get heatRangeSetting => 'Calendrier d’activité';

  @override
  String get heatRangeWeeks => '12 semaines';

  @override
  String get heatRangeYear => '12 mois';

  @override
  String get heatRangeHint =>
      '12 mois affiche toute l’année. Fais glisser sur le côté pour remonter jusqu’à ta première séance.';

  @override
  String get pdfPlan => 'Programme en PDF';

  @override
  String get pdfPlanHint => 'Une fiche nette avec ta semaine et chaque routine, prête à imprimer ou envoyer.';

  @override
  String get pdfExport => 'Exporter en PDF';

  @override
  String get pdfFooter => 'Gratuite, open source et hors ligne';

  @override
  String get shakeTag => 'C’est un shake';

  @override
  String get shakeTagHint => 'Il apparaît dans Ton shake';

  @override
  String get shakeNone => 'Marque tes shakes et seuls ceux-là apparaissent ici.';

  @override
  String get shakeMarkLabel => 'MARQUER COMME SHAKE';

  @override
  String get shakeNew => 'Nouveau shake';

  @override
  String get shakeUntag => 'Pas un shake';

  @override
  String get pdfKicker => 'PROGRAMME D’ENTRAÎNEMENT';

  @override
  String get pdfStatDays => 'JOURS / SEM.';

  @override
  String get pdfStatMinutes => 'MIN / SÉANCE';

  @override
  String pdfMinutes(int n) {
    return '≈ $n min';
  }

  @override
  String get workoutNotesTitle => 'Notes de l’exercice';

  @override
  String get workoutNoteEvery => 'À chaque fois';

  @override
  String get workoutNoteNext => 'La prochaine fois';

  @override
  String get workoutNoteEveryHint =>
      'S’affiche à chaque fois. Idéal pour le réglage du siège ou de la poulie.';

  @override
  String get workoutNoteNextHint => 'S’affiche la prochaine fois seulement, puis disparaît.';

  @override
  String workoutNoteFromLast(String date) {
    return 'De la dernière fois · $date';
  }

  @override
  String get workoutNoteHint => 'Siège au trou 2, poulie à 19…';

  @override
  String get notePinWorkout => 'Afficher pendant la séance';

  @override
  String get assistedSetting => 'Machine assistée';

  @override
  String get assistedSettingHint =>
      'Le poids t’aide, donc moins c’est mieux : records et suggestions vont vers le bas.';

  @override
  String get assistedRecordHint => 'Moins d’assistance';

  @override
  String get trainAgainLabel => 'Pas encore entraîné ? Me le rappeler';

  @override
  String get trainAgainOff => 'Non';

  @override
  String trainAgainAfter(int n) {
    return '+$n h';
  }

  @override
  String get trainAgainHint => 'Une seule fois, et seulement si tu n’as noté aucune séance ce jour-là.';

  @override
  String get notifTrainAgainBody => 'Il est encore temps de t’entraîner aujourd’hui.';

  @override
  String nextDeload(int n) {
    return 'plus léger : $n séances d’affilée sans toutes les reps';
  }

  @override
  String get historyTitle => 'Historique';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n SÉANCES', one: '1 SÉANCE');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Aucune séance ce mois-ci';

  @override
  String get historyEmptyHint => 'Fais glisser sur le côté ou utilise les flèches pour voir d’autres mois.';

  @override
  String historyMore(int n) {
    return '+$n de plus';
  }

  @override
  String get stopwatch => 'Chronomètre';

  @override
  String get proteinSource => 'Source de protéines';

  @override
  String get proteinMixedShort => 'Mixte';

  @override
  String get kcalActive => 'actives';

  @override
  String get kcalEstimated => 'estimé';

  @override
  String get kcalYours => 'ta valeur';

  @override
  String kcalTotalRest(String value) {
    return '$value au total, en comptant ce que tu brûles au repos';
  }

  @override
  String get inclineLabel => 'Inclinaison';

  @override
  String get kcalUseOwn => 'Utiliser ma valeur';

  @override
  String get kcalBackToEstimate => 'Revenir à l’estimation';

  @override
  String get kcalNeedsData => 'Ajoute distance et durée pour estimer les calories';

  @override
  String get kcalHowEstimated =>
      'Estimé à partir de la distance, la durée, l’inclinaison et ton poids (formule ACSM).';

  @override
  String get kcalOwnTitle => 'Calories actives';

  @override
  String get planMine => 'Mon plan';

  @override
  String get planNew => 'Nouveau plan';

  @override
  String get planSaveWeek => 'Enregistrer cette semaine';

  @override
  String get planSaveWeekHint => 'Garde la semaine actuelle comme un plan où revenir';

  @override
  String get planEmptyWeek => 'Commencer une semaine vide';

  @override
  String get planEmptyWeekHint => 'Ta semaine actuelle reste enregistrée comme plan';

  @override
  String get planName => 'Nom du plan';

  @override
  String get planRename => 'Renommer';

  @override
  String get planDelete => 'Supprimer le plan';

  @override
  String get plansHint => 'Les changements de la semaine sont enregistrés dans le plan choisi';

  @override
  String get progression => 'Progression';

  @override
  String get progManual => 'Manuelle';

  @override
  String get progManualHint => 'Aucune suggestion : tu choisis chaque charge.';

  @override
  String get progLinear => 'Linéaire';

  @override
  String get progLinearHint => 'Fais toutes les reps et la charge augmente.';

  @override
  String get progDouble => 'Progression double';

  @override
  String get progDoubleHint => 'Plus de reps jusqu\'au haut de la fourchette, puis plus de charge.';

  @override
  String get progVolume => 'Reps, séries et charge';

  @override
  String get progVolumeHint => 'Reps jusqu\'au maximum, puis une série de plus, puis plus de charge.';

  @override
  String get progAmrap => 'Dernière série à fond';

  @override
  String get progAmrapHint =>
      'Dernière série : autant de reps que possible. Double l\'objectif et ça monte deux fois.';

  @override
  String get progStep => 'Saut de charge';

  @override
  String get progRange => 'Fourchette de reps';

  @override
  String get progSets => 'Séries';

  @override
  String get progDeload => 'Plus léger après';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n échecs', one: '1 échec');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Alléger de';

  @override
  String get progApply => 'Remplir la prochaine séance';

  @override
  String get progApplyHint => 'Désactivé, ce n\'est qu\'une suggestion.';

  @override
  String get nextMoreReps => 'même charge, une rep de plus';

  @override
  String get nextAddSet => 'une série de plus';

  @override
  String get nextAmrap => 'dernière série : autant que possible';

  @override
  String fillDay(String amount) {
    return 'Complète ta journée · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Il te restera $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Il te restera $kcal et $grams g de protéines';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal au-dessus de ton objectif';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit par jour';
  }

  @override
  String get byZone => 'Par zone';

  @override
  String get importAlreadyHave => 'Vous avez déjà ces routines. Vous pouvez les ajouter à nouveau en copie.';

  @override
  String get importAsCopy => 'Ajouter en copie';

  @override
  String get importOwned => 'Déjà là';

  @override
  String get setDuplicated => 'Série dupliquée';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Une série découpée en petits blocs avec 15 à 30 secondes entre eux. Notez le total de répétitions.';

  @override
  String timesBodyweight(String value) {
    return '$value× votre poids de corps';
  }

  @override
  String get archiveRoutine => 'Archiver la routine';

  @override
  String get routineArchived => 'Routine archivée';

  @override
  String get archivedRoutines => 'Archivées';

  @override
  String get autoBackup => 'Sauvegarde auto';

  @override
  String get autoBackupHint =>
      'Enregistre un ZIP avec toutes tes données dans le dossier de ton choix. Synchronise ce dossier avec Nextcloud, Syncthing ou une autre appli pour garder une copie hors du téléphone.';

  @override
  String get autoBackupFolder => 'Choisir un dossier';

  @override
  String get autoBackupNoFolder => 'Aucun dossier';

  @override
  String get autoBackupOff => 'Désactivée';

  @override
  String get autoBackupWorkout => 'Après chaque séance';

  @override
  String get autoBackupDaily => 'Une fois par jour';

  @override
  String get autoBackupWeekly => 'Une fois par semaine';

  @override
  String get autoBackupOnLeave => 'En quittant l\'appli';

  @override
  String get autoBackupKeep => 'Copies à garder';

  @override
  String get autoBackupNow => 'Sauvegarder maintenant';

  @override
  String autoBackupLast(String when) {
    return 'Dernière sauvegarde $when';
  }

  @override
  String get autoBackupNever => 'Aucune sauvegarde';

  @override
  String get autoBackupLost => 'La dernière sauvegarde a échoué. Choisis à nouveau le dossier.';

  @override
  String get autoBackupSaved => 'Sauvegarde enregistrée';

  @override
  String get prepPortions => 'Portions';

  @override
  String get rotationAddRest => 'Ajouter un jour de repos';

  @override
  String get rotationRestHint => 'Passe toute seule le lendemain';

  @override
  String get rotationRestToday => 'Aujourd’hui';

  @override
  String get rotationSkipRest => 'Sauter ce jour de repos';

  @override
  String rotationRestUpNext(String name) {
    return 'Ensuite : $name';
  }

  @override
  String get trainAnyway => 'M’entraîner quand même';

  @override
  String get healthTitle => 'Santé';

  @override
  String get healthSetting => 'Données de santé';

  @override
  String get healthSettingHint => 'Données Health Connect dans Progrès';

  @override
  String get healthPickTitle => 'Données de santé';

  @override
  String get healthPickHint =>
      'Choisis ce que tu importes de Health Connect. Android demande une fois pour chacun. C\'est seulement lu et ça ne quitte jamais ton téléphone.';

  @override
  String get healthGroupHeart => 'Cœur';

  @override
  String get healthGroupVitals => 'Constantes';

  @override
  String get healthGroupActivity => 'Activité';

  @override
  String get healthRestingHr => 'Fréquence cardiaque au repos';

  @override
  String get healthHeartRate => 'Fréquence cardiaque moyenne';

  @override
  String get healthHrv => 'Variabilité cardiaque';

  @override
  String get healthSpo2 => 'Oxygène sanguin';

  @override
  String get healthRespiration => 'Fréquence respiratoire';

  @override
  String get healthBloodPressure => 'Tension artérielle';

  @override
  String get healthTemperature => 'Température corporelle';

  @override
  String get healthSleep => 'Sommeil';

  @override
  String get healthDistance => 'Distance';

  @override
  String get healthFloors => 'Étages montés';

  @override
  String get healthElevation => 'Dénivelé positif';

  @override
  String get healthActiveKcal => 'Calories actives';

  @override
  String get healthNoData => 'Pas encore de données';

  @override
  String get healthReadFailed => 'Lecture impossible';

  @override
  String get healthAllow => 'Touche pour autoriser';

  @override
  String get healthLast7 => '7 derniers jours';

  @override
  String get healthAvg30 => 'Moy. 30 jours';

  @override
  String get healthLow => 'Minimum';

  @override
  String get healthHigh => 'Maximum';

  @override
  String get healthFrom => 'Depuis Health Connect · 30 derniers jours';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'resp/min';

  @override
  String get weekTab => 'Semaine';

  @override
  String get muscleSetsList => 'Séries par muscle';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Facultatif. Laisse vide ce que l\'étiquette n\'indique pas.';

  @override
  String get sessionPhotos => 'Photos de la séance';

  @override
  String get sessionPhotosAdd => 'Ajouter des photos';

  @override
  String get sessionPhotosHint => 'Elles restent aussi dans Tes photos.';

  @override
  String get ladderTitle => 'Progression';

  @override
  String get ladderHint =>
      'Classe les étapes de la plus facile à la plus dure. Quand tu fais 3 séries de 8 deux séances d\'affilée (5 pour les lentes), GymMane te propose la suivante.';

  @override
  String get ladderBuiltIn =>
      'Part de la progression de l\'app. Ajoute, retire ou réordonne des étapes et elle devient celle de cette routine.';

  @override
  String get ladderNone => 'Aucune pour l\'instant. Touche pour en créer une.';

  @override
  String ladderStep(int n, int total) {
    return 'Étape $n sur $total';
  }

  @override
  String get ladderAdd => 'Ajouter une étape';

  @override
  String get ladderInRoutine => 'Dans la routine';

  @override
  String get ladderClear => 'Utiliser celle de l\'app';

  @override
  String get ladderPick => 'Choisis une étape';

  @override
  String get periodWeek => 'cette semaine';

  @override
  String get periodMonth => 'ce mois-ci';

  @override
  String get periodYear => 'cette année';

  @override
  String get periodAll => 'depuis le début';

  @override
  String get settingsSearch => 'Rechercher dans les réglages';

  @override
  String get settingsNoResults => 'Aucun réglage avec ce nom';

  @override
  String get settingsGroupApp => 'Ton appli';

  @override
  String get settingsGroupHome => 'Accueil et extras';

  @override
  String get settingsGroupData => 'Données et aide';

  @override
  String get healthAllowAll => 'Tout activer';

  @override
  String get healthSeeAll => 'Tout voir';

  @override
  String get healthPinTitle => 'Sur la carte';

  @override
  String get healthPinHint => 'Choisis-en jusqu\'à 3 pour la carte Progrès.';

  @override
  String get blurSetting => 'Effets de flou';

  @override
  String get blurSettingHint => 'Coupe-le si ton téléphone rame';

  @override
  String get lowEndTitle => 'Ton téléphone manque de mémoire';

  @override
  String get lowEndBody =>
      'Sans le flou, tout sera plus fluide. Tu peux le remettre dans Réglages → Général.';

  @override
  String get lowEndOff => 'Désactiver le flou';

  @override
  String get lowEndKeep => 'Le garder';

  @override
  String get momentsThisMonth => 'Ce mois-ci';

  @override
  String get momentsDays => 'Jours avec photo';

  @override
  String get awardsPick => 'Choisir pour ton profil';

  @override
  String get awardsPickHint => 'Touche celles que tu veux sur ton profil';

  @override
  String get gymPassPicture => 'Enregistrer une photo du code';

  @override
  String get gymPassPictureHint =>
      'Pour les codes que l\'app ne lit pas : elle affiche ta photo à pleine luminosité';

  @override
  String get gymPassPictureFormat => 'Photo';

  @override
  String get gymPassUsePicture => 'Enregistrer la photo';

  @override
  String get gymPassChangePicture => 'Changer la photo';

  @override
  String get cropTitle => 'Recadre le code';

  @override
  String get cropHint => 'Déplace les coins pour ne garder que le code';

  @override
  String get rotatePhoto => 'Pivoter';

  @override
  String get cardioNoSets => 'Le cardio ne compte pas dans tes séries par muscle de la semaine';

  @override
  String get countsAsWater => 'Compte comme de l’eau';

  @override
  String get countsAsWaterHint => 'Pour les shakes à l’eau : le noter ajoute aussi à ton eau';

  @override
  String get waterPerServing => 'Eau par portion';

  @override
  String get estOneRm => '1RM estimé';

  @override
  String get newInWorkout => 'Nouveau dans cette séance';

  @override
  String newInWorkoutHint(String routine) {
    return 'Ajoute-le à $routine avec les séries que tu viens de faire. Le reste de la routine ne change pas.';
  }

  @override
  String get addedToRoutine => 'Ajouté';

  @override
  String get addShort => 'Ajouter';

  @override
  String get allTimeLifted => 'SOULEVÉ';

  @override
  String get pctBodyweight => '% du poids';

  @override
  String get ofBodyweight => 'de ton poids';

  @override
  String get recoveryStateMid => 'Récupère';

  @override
  String get recoveryStateReady => 'Prêt';

  @override
  String recoveringIn(String time) {
    return 'Récupère dans $time';
  }

  @override
  String readyIn(String time) {
    return 'Prêt dans $time';
  }

  @override
  String get recoveryReadyNow => 'Prêt à le retravailler';

  @override
  String get restAfterThisSet => 'Repos après cette série';

  @override
  String restUsual(String time) {
    return 'Habituel : $time';
  }

  @override
  String get restJustToday => 'Seulement pour cette série, aujourd’hui';

  @override
  String get restUseUsual => 'Revenir au repos habituel';

  @override
  String get restChange => 'Modifier';

  @override
  String get noRestTimer => 'Sans minuteur';

  @override
  String get sessionMuscles => 'Muscles de cette séance';

  @override
  String get sessionMusclesHint =>
      'Pâle reste à faire, vif est fait. Séries par muscle, les secondaires comptent pour moitié.';

  @override
  String get miniBodySetting => 'Petite carte musculaire sur les routines';

  @override
  String get miniBodySettingHint => 'Muscles de chaque routine';

  @override
  String get balanceTitle => 'Équilibre de force';

  @override
  String get balanceWhy => 'Comment ça marche';

  @override
  String get balanceGood => 'Tes mouvements de base sont équilibrés';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift est en retard : il manque environ $gap';
  }

  @override
  String get balanceHint =>
      'Compare tes 1RM estimés des 4 derniers mois avec des proportions classiques : squat 100 %, soulevé de terre 120 %, développé couché 75 %, rowing 52 %, développé militaire 45 %. Un mouvement bien en dessous des autres est souvent un point faible.';

  @override
  String get balanceEven => 'Équilibré';

  @override
  String get balanceBehindShort => 'En retard';

  @override
  String get balanceAheadShort => 'En avance';

  @override
  String get holdProgress => 'Progression au temps';

  @override
  String get holdProgressHint => 'Ajoute des secondes quand tu tiens toutes les séries';

  @override
  String holdProgressOn(int s) {
    return '+$s s chaque fois que tu tiens toutes les séries';
  }

  @override
  String get paceTitle => 'Rythme hebdomadaire';

  @override
  String get paceOn => 'Bon rythme';

  @override
  String get paceTooFast => 'Plus rapide que ta fourchette';

  @override
  String get paceTooSlow => 'Plus lent que ta fourchette';

  @override
  String get paceWrongWay => 'Dans le mauvais sens';

  @override
  String get paceDrifting => 'Tu bouges plus que pour maintenir';

  @override
  String get paceSetAim => 'Touche pour choisir ton objectif';

  @override
  String get paceBasis =>
      'Tendance de tes pesées des 3 dernières semaines, pour qu’un dîner salé ne te trompe pas.';

  @override
  String get paceAimTitle => 'Quel est ton objectif ?';

  @override
  String get paceAimHint => 'La carte te dit si ton rythme convient';

  @override
  String get paceLose => 'Perdre';

  @override
  String get paceHold => 'Maintenir';

  @override
  String get paceGain => 'Prendre';

  @override
  String get paceAuto => 'Automatique';

  @override
  String get paceLoseRange => '0,5 à 1 % de ton poids par semaine';

  @override
  String get paceHoldRange => 'À 0,25 % près par semaine';

  @override
  String get paceGainRange => '0,25 à 0,5 % de ton poids par semaine';

  @override
  String get paceAutoHint => 'Selon ton objectif de poids';

  @override
  String get weekShort => 'sem.';

  @override
  String get weightStack => 'Pile de poids';

  @override
  String get weightStackHint =>
      'Les poids réels de cette machine. + et −, la progression et les décharges ne tombent que dessus.';

  @override
  String get weightStackOff => 'Désactivée : paliers normaux';

  @override
  String get stackFrom => 'De';

  @override
  String get stackTo => 'À';

  @override
  String get stackEvery => 'Tous les';

  @override
  String get stackFill => 'Remplir la pile';

  @override
  String get stackTapToFix => 'Touche un poids pour corriger un poids bizarre ou le retirer.';

  @override
  String get stackAddWeight => 'Ajouter un poids';

  @override
  String get stackEditWeight => 'Poids à la goupille';

  @override
  String get stackClear => 'Retirer la pile';

  @override
  String stackCount(int n) {
    return '$n poids';
  }

  @override
  String get healthLinksTitle => 'Avec tes séances';

  @override
  String get healthLinkHeart => 'Fréquence cardiaque de ta montre';

  @override
  String get healthLinkHeartHint =>
      'Fréquence moyenne et maximale de chaque séance, quelle que soit la montre';

  @override
  String get healthLinkWeight => 'Pesées d’autres apps';

  @override
  String get healthLinkWeightHint =>
      'Les pesées de ta balance des 30 derniers jours. N’écrase jamais une pesée saisie par toi.';

  @override
  String get healthLinkDenied => 'Health Connect n’a pas donné l’autorisation';

  @override
  String get healthOpenSettings => 'Ouvrir';

  @override
  String hrMaxShort(int bpm) {
    return 'max $bpm';
  }

  @override
  String get setNote => 'Note pour cette série';

  @override
  String get setNoteHint => 'Prise, une gêne, un repère qui a marché…';

  @override
  String setNoteLast(String note) {
    return 'La dernière fois : $note';
  }

  @override
  String get lastTimeNotes => 'La dernière fois';

  @override
  String setNoteLine(int n, String note) {
    return 'Série $n · $note';
  }

  @override
  String get newMeasure => 'Nouvelle mesure';

  @override
  String get newMeasureHint => 'Ce que tu veux suivre : poignet, pouls au repos, eau corporelle…';

  @override
  String get measureKindLength => 'Longueur';

  @override
  String get measureKindLengthHint => 'En cm ou en pouces, comme les autres';

  @override
  String get measureKindOther => 'Autre';

  @override
  String get measureKindOtherHint => 'Avec ta propre unité';

  @override
  String get measureUnit => 'Unité';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Poignet, pouls au repos…';

  @override
  String get measureRename => 'Renommer';

  @override
  String measureDeleteTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get measureDeleteBody => 'Toutes les valeurs notées pour elle partent aussi.';

  @override
  String get measureDelete => 'Supprimer cette mesure';

  @override
  String get measureEvery => 'Me rappeler de mesurer';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dans $n jours',
      one: 'Demain',
      zero: 'Aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'C’est l’heure de mesurer';

  @override
  String get notifMeasureChannel => 'Mensurations';

  @override
  String get notifMeasureChannelWhy => 'Un rappel quand il est temps de te remesurer.';

  @override
  String get notifMeasureTitle => 'C’est l’heure de te mesurer';

  @override
  String notifMeasureBody(int n) {
    return '$n jours depuis la dernière fois. Même endroit, même moment de la journée.';
  }

  @override
  String get healthLinkWrite => 'Enregistrer tes séances';

  @override
  String get healthLinkWriteHint =>
      'Chaque séance terminée part vers Health Connect avec son heure et son type, pour que les autres apps la comptent aussi. Envoie aussi les 30 derniers jours.';

  @override
  String get healthWorkoutTitle => 'Séance';

  @override
  String get circuits => 'Circuits chronométrés';

  @override
  String get circuitsHint => 'Effort et repos au chrono, tour après tour';

  @override
  String get newCircuit => 'Nouveau circuit';

  @override
  String get editCircuit => 'Modifier le circuit';

  @override
  String get circuitDefaultName => 'Circuit';

  @override
  String get circuitNameHint => 'Nom, comme Finisher gainage';

  @override
  String get circuitRounds => 'Tours';

  @override
  String get circuitRoundRest => 'Repos entre les tours';

  @override
  String get circuitWork => 'Effort';

  @override
  String get circuitRest => 'Repos';

  @override
  String get circuitAdd => 'Ajouter un exercice';

  @override
  String get circuitEmpty =>
      'Ajoute les exercices dans l’ordre où tu les feras. Un même exercice peut revenir, comme la planche latérale de chaque côté.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$steps exercices',
      one: '1 exercice',
    );
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds tours', one: '1 tour');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Démarrer';

  @override
  String get circuitGetReady => 'Prépare-toi';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Tour $n sur $total';
  }

  @override
  String circuitNext(String name) {
    return 'Ensuite : $name';
  }

  @override
  String get circuitFinishLine => 'Le dernier, et c’est fini';

  @override
  String get circuitDone => 'Circuit terminé';

  @override
  String circuitDoneBody(String time) {
    return '$time · enregistré dans ton historique';
  }

  @override
  String get circuitStopTitle => 'Arrêter le circuit ?';

  @override
  String get circuitStopBody => 'Ce que tu as déjà fait est enregistré dans ton historique.';

  @override
  String get circuitStop => 'Arrêter';

  @override
  String get circuitKeepGoing => 'Continuer';

  @override
  String circuitDeleteTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get circuitDeleteBody => 'Les séances déjà faites avec lui restent dans ton historique.';

  @override
  String get circuitPickExercise => 'Choisis un exercice';

  @override
  String get circuitNoSteps => 'Ajoute au moins un exercice';

  @override
  String get circuitPrevious => 'Précédent';

  @override
  String get circuitUpNext => 'Ensuite';

  @override
  String get foodGroupNew => 'Nouvelle catégorie';

  @override
  String get foodGroupHint => 'Plats préparés, surgelés…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n aliments',
      one: '1 aliment',
      zero: 'Pas encore d’aliments',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get foodGroupDeleteBody => 'Tes aliments restent, simplement sans cette catégorie.';

  @override
  String onbHello(String name) {
    return 'Salut, $name';
  }

  @override
  String get onbPlaceHero => 'exercices possibles';

  @override
  String get settingsRests => 'Repos';

  @override
  String get settingsDuring => 'Pendant la séance';

  @override
  String get settingsLook => 'Affichage';

  @override
  String get importCardTitle => 'Ramène tes séances ici';

  @override
  String get importCardBody => 'Depuis Hevy, Strong, FitNotes et plus';

  @override
  String get checkInTitle => 'Comment tu étais ?';

  @override
  String get checkInSleep => 'Sommeil';

  @override
  String get checkInEnergy => 'Énergie';

  @override
  String get checkInSkip => 'Facultatif';

  @override
  String get checkInLevel1 => 'Nul';

  @override
  String get checkInLevel2 => 'Faible';

  @override
  String get checkInLevel3 => 'Correct';

  @override
  String get checkInLevel4 => 'Bien';

  @override
  String get checkInLevel5 => 'Top';

  @override
  String get checkInSetting => 'Sommeil et énergie';

  @override
  String get checkInSettingHint => 'Demander à la fin de chaque séance';

  @override
  String get readinessTitle => 'Sommeil et énergie';

  @override
  String get readinessWaiting => 'Continue à noter tes séances';

  @override
  String get readinessWaitingHint =>
      'Après quelques bons et mauvais jours, tu verras comment ils changent tes charges.';

  @override
  String readinessSleepLess(int n) {
    return 'Les jours de peu de sommeil, tu soulèves $n % de moins';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Curieux : les jours de peu de sommeil, tu soulèves $n % de plus';
  }

  @override
  String get readinessSleepNone => 'Le sommeil change à peine tes charges';

  @override
  String readinessEnergyLess(int n) {
    return 'Les jours de faible énergie, tu soulèves $n % de moins';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'Les jours de faible énergie, tu soulèves quand même $n % de plus';
  }

  @override
  String get readinessEnergyNone => 'Ton énergie change à peine tes charges';

  @override
  String get readinessHint => 'Compare chaque 1RM estimé avec ton meilleur des 90 jours précédents.';

  @override
  String get readinessLast30 => 'Moyenne des 30 derniers jours';

  @override
  String get kindSport => 'Sport';

  @override
  String get clearWorkouts => 'Supprimer seulement les séances';

  @override
  String get clearWorkoutsNone => 'Aucune séance à supprimer';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Supprimer $n séances ?',
      one: 'Supprimer 1 séance ?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Ton historique, tes records et tes médailles partent. Routines, exercices, photos, mesures, nutrition et réglages restent. Exporte une sauvegarde avant si tu veux pouvoir les récupérer.';

  @override
  String get clearWorkoutsConfirm => 'Supprimer les séances';

  @override
  String get clearWorkoutsDone => 'Séances supprimées';

  @override
  String get reportTitle => 'Rapport';

  @override
  String get reportHint => 'Choisis les dates et partage-le en PDF ou CSV';

  @override
  String get reportCustom => 'Autre';

  @override
  String get reportPickRange => 'Choisir les dates';

  @override
  String get reportEmpty => 'Rien d’enregistré entre ces dates.';

  @override
  String get reportKicker => 'RAPPORT D’ENTRAÎNEMENT';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jours', one: '1 jour');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'SÉANCES';

  @override
  String get reportPerWeek => 'PAR SEMAINE';

  @override
  String get reportHours => 'HEURES';

  @override
  String get reportVsPrev => 'Les pourcentages comparent avec le même nombre de jours juste avant.';

  @override
  String get reportRecords => 'Nouveaux records';

  @override
  String get reportLifts => 'Exercices';

  @override
  String get reportSessionsCol => 'JOURS';

  @override
  String get reportBestCol => 'MEILLEUR 1RM';

  @override
  String get reportChangeCol => 'ÉVOLUTION';

  @override
  String get reportBestHint =>
      'Le meilleur 1RM est estimé à partir de tes séries. L’évolution compare le premier et le dernier jour de l’exercice dans ce rapport.';

  @override
  String get reportMuscles => 'Séries par muscle';

  @override
  String get reportBody => 'Corps et récupération';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nutrition · moyenne sur $n jours',
      one: 'Nutrition · moyenne sur 1 jour',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nouveaux records',
      one: '1 nouveau record',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercices', one: '1 exercice');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal et $protein g de protéines par jour · $days jours notés';
  }

  @override
  String get reportSharePdf => 'Partager le PDF';

  @override
  String get reportShareCsv => 'Exporter le CSV';

  @override
  String get reportExportZip => 'Export report ZIP';

  @override
  String get reportSummaryEmpty => 'No workouts, food, or weigh-ins to summarize for these dates.';

  @override
  String get reportZipHint => 'Choose what to include. Missing steps or synced sleep are left blank.';

  @override
  String get reportWeighIns => 'Weigh-ins';

  @override
  String get reportSyncedSleep => 'Synced sleep';

  @override
  String get reportSessionDetails => 'Workout session details';

  @override
  String get reportZipFailed => 'Could not export the report ZIP.';

  @override
  String get reportShareCsvBoth => 'Exporter le CSV (séances et nutrition)';

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
  String get fastTracker => 'Jeûne intermittent';

  @override
  String fastTitle(int fast, int eat) {
    return 'Jeûne $fast:$eat';
  }

  @override
  String get fastOptions => 'Options du jeûne';

  @override
  String get fastWindowOpen => 'Fenêtre alimentaire ouverte';

  @override
  String get fastLeft => 'Restant';

  @override
  String get fastDoneLabel => 'Objectif atteint';

  @override
  String get fastIdle => 'Lance-le après ton dernier repas';

  @override
  String fastLast(String time) {
    return 'Dernier jeûne : $time';
  }

  @override
  String fastStreak(int n) {
    return '$n d’affilée';
  }

  @override
  String fastReached(String time) {
    return '$time au-delà de ton objectif';
  }

  @override
  String fastEndsAt(String time) {
    return 'Se termine à $time';
  }

  @override
  String fastSince(String time) {
    return 'Depuis $time';
  }

  @override
  String get fastStartedAt => 'Quand as-tu commencé à jeûner ?';

  @override
  String get fastStart => 'Commencer le jeûne';

  @override
  String fastFromMeal(String time) {
    return 'Depuis $time';
  }

  @override
  String get fastEnd => 'Terminer le jeûne';

  @override
  String get fastCancel => 'Annuler ce jeûne';

  @override
  String get fastPlan => 'Plan de jeûne';

  @override
  String get fastPlanHint => 'Heures de jeûne : heures pour manger';

  @override
  String get fastThisWeek => '7 derniers jours';

  @override
  String get fastCount => 'Jeûnes';

  @override
  String get fastReachedCount => 'Atteints';

  @override
  String get fastAverage => 'Moyenne';

  @override
  String get fastHistory => 'Jeûnes récents';

  @override
  String get notifFastLiveChannel => 'Jeûne en cours';

  @override
  String get notifFastLiveChannelWhy => 'Un compte à rebours discret pendant que tu jeûnes.';

  @override
  String get notifFastChannel => 'Jeûne';

  @override
  String get notifFastChannelWhy => 'Te prévient quand ton jeûne est terminé.';

  @override
  String get notifFastLiveTitle => 'Jeûne';

  @override
  String notifFastLiveBody(String time) {
    return 'Ta fenêtre alimentaire s’ouvre à $time';
  }

  @override
  String get notifFastDoneTitle => 'Jeûne terminé';

  @override
  String notifFastDoneBody(int n) {
    return '$n heures. Ta fenêtre alimentaire est ouverte.';
  }

  @override
  String get newExerciseHint =>
      'Seul le nom est obligatoire. Le reste aide, mais tu peux l’ajouter plus tard.';

  @override
  String get supportThanksTitle => 'Merci d’être là 🤍';

  @override
  String get supportThanksBody =>
      'GymMane est gratuit et le restera, sans pub et sans rien de caché.\n\nS’il t’aide à t’entraîner, m’offrir un café me fait plaisir ☕\nEt sinon, pas de souci : une étoile sur GitHub aussi ⭐';

  @override
  String get perfSetting => 'Performances';

  @override
  String get perfSheetHint =>
      'La part de ton téléphone que GymMane utilise. Tu peux changer chaque élément ci-dessous.';

  @override
  String get perfLite => 'Économie';

  @override
  String get perfLiteHint => 'Sans flou et avec des animations plus calmes. Pour les téléphones qui peinent.';

  @override
  String get perfBalanced => 'Équilibré';

  @override
  String get perfBalancedHint => 'Flou et animations sans vider la batterie.';

  @override
  String get perfMax => 'Maximum';

  @override
  String perfMaxHint(int hz) {
    return 'Flou plus fin et l’écran à $hz Hz. Pour les téléphones haut de gamme.';
  }

  @override
  String get perfMaxHintNoHz => 'Flou plus fin partout. Pour les téléphones haut de gamme.';

  @override
  String get perfCustom => 'Personnalisé';

  @override
  String get perfTweak => 'Réglage fin';

  @override
  String get perfFine => 'Flou fin';

  @override
  String get perfFineHint => 'Bords plus doux et arrière-plan plus net derrière les panneaux';

  @override
  String perfHz(int hz) {
    return 'Écran à $hz Hz';
  }

  @override
  String get perfHzHint => 'Tout défile plus fluide, pour un peu plus de batterie';

  @override
  String get lowEndLiteBody =>
      'Le mode Économie (sans flou, animations plus calmes) y sera plus fluide. Tu peux le changer dans Paramètres → Général → Performances.';

  @override
  String get lowEndLiteOn => 'Activer Économie';

  @override
  String get dayOffHint => 'Ta série et le rappel laissent ce jour tranquille';

  @override
  String get dayOffTrained => 'Je me suis entraîné, je ne l’ai juste pas noté';

  @override
  String get dayOffSick => 'Maladie';

  @override
  String get dayOffTravel => 'Voyage';

  @override
  String get dayOffInjury => 'Blessure';

  @override
  String get dayOffRest => 'Repos';

  @override
  String get altsTitle => 'Alternatives';

  @override
  String get altsHint => 'Si la machine est prise';

  @override
  String altsPickHint(int count) {
    return 'Choisis-en jusqu’à $count. Si la machine est prise, change d’une touche.';
  }

  @override
  String get placeDumbbells => 'Haltères';

  @override
  String get dumbbellsHint =>
      'Le poids d’un haltère. La progression et les boutons + et − ne tomberont que sur ces valeurs ici.';

  @override
  String get dumbbellOther => 'Autre poids';

  @override
  String get tuneTitle => 'Volume du jour';

  @override
  String get tuneHint =>
      'Dis-moi comment chaque muscle s’est senti et j’ajuste les séries pour la prochaine fois.';

  @override
  String get tuneLess => 'Trop peu';

  @override
  String get tuneRight => 'Parfait';

  @override
  String get tuneMore => 'Trop';

  @override
  String tuneNext(String sets, String name) {
    return 'La prochaine fois : $sets de $name';
  }

  @override
  String get tuneSame => 'Pareil la prochaine fois';

  @override
  String get tuneSetting => 'Ajuster les séries par muscle';

  @override
  String get tuneSettingHint => 'Après un programme, note chaque muscle et les séries s’ajustent';

  @override
  String insightLoad(int pct) {
    return '$pct % de séries en plus que ta semaine habituelle. Surveille ta récupération.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle : pas travaillé depuis $days jours.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'Tu pousses plus que tu ne tires : $a séries contre $b en quatre semaines.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'Tu tires plus que tu ne pousses : $a séries contre $b en quatre semaines.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name : $pct % plus fort que le mois dernier.';
  }

  @override
  String recapPull(String month) {
    return 'Continue à tirer pour voir ton $month';
  }

  @override
  String get recapRelease => 'Lâche';

  @override
  String recapHi(String name) {
    return 'Salut, $name';
  }

  @override
  String recapReady(String month) {
    return 'On regarde ce que tu as fait en $month ?';
  }

  @override
  String get recapGo => 'C\'est parti';

  @override
  String recapEmpty(String month) {
    return 'Pas encore de séance en $month. La première débloque tout.';
  }

  @override
  String get recapClose => 'Fermer';

  @override
  String get recapShare => 'Partager';

  @override
  String get recapWorkoutsKicker => 'Ce mois-ci, tu as fait';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'séances', one: 'séance');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Sur $n jours différents',
      one: 'Sur un seul jour',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Temps sous la barre';

  @override
  String recapLongest(String time, String date) {
    return 'Séance la plus longue : $time, le $date';
  }

  @override
  String get recapVolumeKicker => 'Tu as soulevé';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Comme soulever $count voitures',
      one: 'Comme soulever une voiture',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Le plus : $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Muscle du mois';

  @override
  String get recapRecordsKicker => 'Nouveaux records';

  @override
  String recapNoRecords(int n) {
    return 'Pas de record cette fois, mais $n séries de plus au compteur.';
  }

  @override
  String get recapHabitKicker => 'Ton moment';

  @override
  String recapHabitStart(String time) {
    return 'Tu commences souvent à $time';
  }

  @override
  String get recapShareKicker => 'Ton mois, prêt à partager';

  @override
  String get recapTickWorkouts => 'Séances';

  @override
  String get recapTickTime => 'Temps';

  @override
  String get recapTickVolume => 'Charge';

  @override
  String get recapTickRecords => 'Records';

  @override
  String recapAvg(int n) {
    return '$n min par séance en moyenne';
  }

  @override
  String get recapLiftKicker => 'Exercice du mois';

  @override
  String get recapBest => 'Meilleur';

  @override
  String get recapTimes => 'Jours';

  @override
  String get recapDaysLabel => 'Jours';

  @override
  String get recapAvgLabel => 'Moyenne';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts séances en $days jours';
  }

  @override
  String get recapFavLabel => 'Ton jour';

  @override
  String get recapWatermark => 'carnet de muscu gratuit';

  @override
  String get recapTickSteps => 'Pas';

  @override
  String get recapTickFood => 'Repas';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n séances', one: 'une séance');
    return '$minutes min sur $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances de cardio',
      one: 'Une séance de cardio',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Ton préféré : $name';
  }

  @override
  String get recapStepsKicker => 'Tu as marché';

  @override
  String get recapStepsWord => 'pas';

  @override
  String recapStepsAvg(String value) {
    return '$value par jour en moyenne';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Meilleur jour : $value, le $date';
  }

  @override
  String get recapFoodKicker => 'Dans ton assiette';

  @override
  String get recapLiftRest => 'Juste derrière';

  @override
  String recapSameAs(String month) {
    return 'Comme en $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value de plus qu\'en $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value de moins qu\'en $month';
  }

  @override
  String get recapTickMedals => 'Médailles';

  @override
  String get recapTickSleep => 'Sommeil';

  @override
  String get recapMedalsKicker => 'Médailles gagnées';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Et $n de plus',
      one: 'Et une de plus',
    );
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Tu as dormi';

  @override
  String get recapSleepAvg => 'par nuit en moyenne';

  @override
  String recapSleepBest(String value, String date) {
    return 'Meilleure nuit : $value, le $date';
  }

  @override
  String get recapCardSummary => 'Résumé';

  @override
  String get recapCardCalendar => 'Calendrier';

  @override
  String get recapCardLift => 'Exercice';

  @override
  String get recapPeakKicker => 'Ta séance la plus dure';

  @override
  String get recapTickPeak => 'Séance';

  @override
  String get recapFreshKicker => 'Première fois ce mois-ci';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'nouveaux exercices',
      one: 'nouvel exercice',
    );
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Nouveau';

  @override
  String recapStreak(int n) {
    return '$n jours d\'affilée, ta plus longue série';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n séances', one: '1 séance');
    return 'Il y a un an : $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Oublié ce mois-ci : $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'de protéines par jour · objectif $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dans ton assiette $n jours',
      one: 'Dans ton assiette 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Protéines · g/jour';

  @override
  String get recapFoodGoalDays => 'Objectif atteint';

  @override
  String get recapFoodWaterLabel => 'Eau/jour';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jours', one: '1 jour');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Ton aliment du mois';

  @override
  String get onbSpeedTitle => 'Pour que ce soit fluide';

  @override
  String get onbSpeedWhy =>
      'Ton téléphone semble forcer. Désactive ceci et tout sera plus fluide : essaie et regarde l’aperçu.';

  @override
  String get onbSpeedMotion => 'Animations';

  @override
  String get onbSpeedBlurHint => 'Verre dépoli derrière les panneaux et les barres';

  @override
  String get onbSpeedMotionHint => 'Écrans et panneaux qui glissent';

  @override
  String get onbSpeedLater => 'Tu peux le changer à tout moment dans Paramètres › Général › Performances.';

  @override
  String get notifSoundSetting => 'Sons des notifications';

  @override
  String get notifSoundRowHint => 'Le son de chaque type de rappel';

  @override
  String get notifSoundHint =>
      'Choisis un son pour chaque type de rappel. Du téléphone ouvre les sons de ton téléphone, et sur la plupart des téléphones tu peux y ajouter ta propre chanson.';

  @override
  String get notifSoundTrain => 'Entraînements';

  @override
  String get notifSoundFood => 'Repas, compléments et jeûne';

  @override
  String get notifSoundOther => 'Photos et mensurations';

  @override
  String get notifSoundNormal => 'Normal';

  @override
  String get notifSoundPhone => 'Du téléphone';

  @override
  String get notifSoundSilent => 'Silencieux';

  @override
  String get notifSoundPhoneHint => 'Touche-en un pour l’écouter. Il est enregistré tout de suite.';

  @override
  String get notifSoundMore => 'Autre fichier…';

  @override
  String get notifSoundChange => 'Changer';

  @override
  String get workoutNoteAdd => 'Note épinglée : siège, prise, machine…';

  @override
  String get autoProgressSetting => 'Progression automatique';

  @override
  String get autoProgressRowHint => 'Ce qu’elle propose pour la prochaine fois';

  @override
  String get autoProgressOff => 'Désactivée';

  @override
  String get autoProgressWeight => 'Ajouter du poids';

  @override
  String get autoProgressReps => 'Ajouter des répétitions';

  @override
  String get autoProgressHint =>
      'Quand tu commences une séance, GymMane remplit l’étape suivante pour chaque exercice. Avec Ajouter des répétitions, tu ajoutes une répétition par série jusqu’à 12, puis le poids monte et tu repars à 8. Tu peux toujours ajuster chaque exercice sur sa page.';

  @override
  String get noteFolders => 'Dossiers';

  @override
  String get noteFolderNew => 'Nouveau dossier';

  @override
  String get noteFolderEdit => 'Modifier le dossier';

  @override
  String get noteFolderName => 'Nom du dossier';

  @override
  String get noteFolderLabel => 'Dossier';

  @override
  String get noteFolderNone => 'Sans dossier';

  @override
  String get noteFolderDelete => 'Supprimer le dossier ?';

  @override
  String get noteFolderDeleteBody => 'Les notes sont conservées : elles sortent simplement du dossier.';

  @override
  String get foodArchivedToast => 'Aliment archivé';

  @override
  String get planArchivedToast => 'Plan archivé';

  @override
  String get suppArchivedToast => 'Complément archivé';

  @override
  String get voiceSetting => 'Voix d’entraînement';

  @override
  String get voiceSettingHint =>
      'Annonce ta prochaine série et décompte la fin du repos, avec la voix du téléphone';

  @override
  String get voiceHello => 'Voix activée';

  @override
  String voiceRest(String time) {
    return 'Repos $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Ensuite : $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps répétitions à $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps répétitions';
  }

  @override
  String get voiceGo => 'C’est parti !';

  @override
  String get deloadSetting => 'Semaine de décharge';

  @override
  String get deloadOff => 'Jamais';

  @override
  String deloadEvery(int weeks) {
    return 'Toutes les $weeks semaines';
  }

  @override
  String get deloadHint =>
      'Toutes les quelques semaines, une plus facile pour récupérer : moitié moins de séries et 10 % de poids en moins. Cette semaine ne compte pas pour la progression.';

  @override
  String get deloadRowHint => 'Une semaine légère toutes les quelques semaines';

  @override
  String get deloadNow => 'Semaine de décharge';

  @override
  String get deloadNowHint => 'Aujourd’hui, moitié moins de séries et 10 % de poids en moins';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'Dans $weeks semaines',
      one: 'La semaine prochaine',
      zero: 'Cette semaine',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'S’entraîner normalement';

  @override
  String get voiceSheetTitle => 'Comment marche la voix';

  @override
  String get voicePointRest =>
      'Quand tu coches une série, elle t’annonce le temps de repos et ce qui vient ensuite.';

  @override
  String get voicePointCount => 'Elle compte 3, 2, 1 à la fin du repos et te rappelle.';

  @override
  String get voicePointPhone => 'Elle utilise la voix de ton téléphone et passe par-dessus ta musique.';

  @override
  String get voiceTry => 'Essayer la voix';

  @override
  String get voiceNoEngine => 'Ton téléphone n’a aucun moteur de synthèse vocale activé.';

  @override
  String get voiceNoLang =>
      'La voix de ta langue manque. Télécharge-la dans les réglages de voix de ton téléphone.';

  @override
  String get voiceOpenSettings => 'Réglages de la voix';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondes',
      one: '1 seconde',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'et';

  @override
  String get repRecordsTitle => 'Meilleur poids par répétitions';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'gélules', one: 'gélule');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'comprimés', one: 'comprimé');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'dosettes', one: 'dosette');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'gouttes', one: 'goutte');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'portions', one: 'portion');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'UI';

  @override
  String get suppLeft => 'Restant';

  @override
  String get suppLeftHint => 'Facultatif';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Reste pour $n jours',
      one: 'Reste pour 1 jour',
    );
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jours', one: '1 jour');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Épuisé';

  @override
  String get lightSession => 'Séance légère';

  @override
  String get lightSessionHint =>
      'Enregistrée dans ton historique et tes stats, mais elle ne change pas tes prochains objectifs.';

  @override
  String get lightSessionNote => 'Ne compte pas pour la progression';

  @override
  String get lightSessionOff => 'Désactiver';

  @override
  String get eachSideRepsHint =>
      'Note séparément les répétitions gauche et droite. La progression suit le côté le plus faible.';

  @override
  String get repsLeftCol => 'RÉP. G';

  @override
  String get repsRightCol => 'RÉP. D';

  @override
  String get repsLeftTitle => 'RÉPÉTITIONS GAUCHE';

  @override
  String get repsRightTitle => 'RÉPÉTITIONS DROITE';

  @override
  String sidesReps(int l, int r) {
    return 'G$l D$r';
  }

  @override
  String get progSchemeTitle => 'Progression du poids';

  @override
  String get groupMoveUp => 'Monter le groupe';

  @override
  String get groupMoveDown => 'Descendre le groupe';

  @override
  String get mealAiRow => 'Demander à une IA';

  @override
  String get mealAiRowHint => 'Copie une demande, colle la réponse';

  @override
  String get mealAiTitle => 'Repas avec l’IA';

  @override
  String get mealAiSubtitle => 'Marche avec n’importe quel chatbot. L’app reste hors ligne.';

  @override
  String get mealAiStepAsk => 'Demander';

  @override
  String get mealAiStepPaste => 'Coller';

  @override
  String get mealAiWholeDay => 'Toute la journée';

  @override
  String get mealAiTarget => 'Objectif';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'Il te reste $kcal et $protein g de protéines aujourd’hui';
  }

  @override
  String get mealAiStyle => 'Tes goûts';

  @override
  String get mealAiTagProtein => 'Riche en protéines';

  @override
  String get mealAiTagVeggie => 'Végétarien';

  @override
  String get mealAiTagVegan => 'Végan';

  @override
  String get mealAiTagNoGluten => 'Sans gluten';

  @override
  String get mealAiTagNoLactose => 'Sans lactose';

  @override
  String get mealAiTagQuick => 'Rapide';

  @override
  String get mealAiTagNoCook => 'Sans cuisson';

  @override
  String get mealAiTagCheap => 'Petit budget';

  @override
  String get mealAiNotesHint => 'J’ai à la maison… Je n’aime pas… allergies…';

  @override
  String get mealAiOptions => 'Options';

  @override
  String get mealAiCopy => 'Copier la demande';

  @override
  String get mealAiCopied => 'Demande copiée';

  @override
  String get mealAiCopiedHint => 'Colle-la dans ton IA et reviens ici avec la réponse';

  @override
  String get mealAiShowText => 'Voir la demande';

  @override
  String get mealAiHideText => 'Masquer la demande';

  @override
  String get mealAiPasteHint => 'Colle ici la réponse de l’IA';

  @override
  String get mealAiReview => 'Vérifier la réponse';

  @override
  String get mealAiUnreadable => 'Je n’ai trouvé aucun aliment dans ce texte';

  @override
  String get mealAiUnreadableHint =>
      'Demande à l’IA d’envoyer seulement le JSON, dans un seul bloc de code, au format de la demande.';

  @override
  String get mealAiCopyFix => 'Copier cette phrase';

  @override
  String mealAiOption(int n) {
    return 'Option $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Ajouter à $meal';
  }

  @override
  String get mealAiAddDay => 'Ajouter à aujourd’hui';

  @override
  String get mealAiAddPick => 'Ajouter';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n aliments ajoutés',
      one: '1 aliment ajouté',
    );
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Enregistrer comme recette';

  @override
  String get mealAiSavePlan => 'Enregistrer comme plan';

  @override
  String get mealAiRecipeSaved => 'Recette enregistrée';

  @override
  String get mealAiPlanSaved => 'Plan enregistré';

  @override
  String get mealAiFlagEstimated => 'Estimé par l’IA';

  @override
  String get mealAiFlagAdjusted => 'Calories corrigées selon les macros';

  @override
  String get mealAiFlagDoubtful => 'Les chiffres ne collent pas, vérifie';

  @override
  String get mealAiFlagNoValues => 'Pas de valeurs nutritionnelles';

  @override
  String get mealAiFlagNoAmount => 'Pas de quantité indiquée';

  @override
  String get mealAiTruncated => 'La réponse semble coupée. J’ai gardé les aliments complets.';

  @override
  String get mealAiAmount => 'Quantité';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Objectif $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Active au moins un aliment';

  @override
  String get cholesterolLabel => 'Cholestérol';

  @override
  String get mealAiFlagMatched => 'Identique à un aliment enregistré';

  @override
  String get mealAiNotSame => 'Ce n’est pas le même';

  @override
  String get homeOrderRow => 'Ordre des sections';

  @override
  String get homeOrderHint => 'Maintiens et fais glisser pour changer l’ordre de l’Accueil.';

  @override
  String get homeOrderFolders => 'Raccourcis';

  @override
  String get equipNew => 'Nouveau';

  @override
  String get equipNewTitle => 'Nouvel équipement';

  @override
  String get equipNewHint => 'ex. Ceinture de force';

  @override
  String get homeOrderWeekdays => 'Coches de la semaine';

  @override
  String get repsMaxTitle => 'Répétitions jusqu’à';

  @override
  String get repsRangeHint => 'Maintiens les répétitions pour définir une fourchette comme 8-12.';

  @override
  String get repsRangeClear => 'Retirer la fourchette';

  @override
  String get noteLinksLabel => 'LIENS';

  @override
  String get noteLinkAdd => 'Ajouter un lien';

  @override
  String get noteLinkEdit => 'Modifier le lien';

  @override
  String get noteLinkNameHint => 'Nom';

  @override
  String get noteLinkUrlHint => 'Adresse web';

  @override
  String get noteLinkInvalid => 'Cette adresse ne semble pas correcte';

  @override
  String get changeRest => 'Repos entre exercices';

  @override
  String get changeRestHint => 'Après la dernière série, avant l’exercice suivant';

  @override
  String get notifSuppTake => 'Pris';

  @override
  String get sideRest => 'Repos entre les côtés';

  @override
  String get sideRestHint => 'Exercices unilatéraux : le premier ✓ termine un côté';

  @override
  String get gfxCompat => 'Graphismes compatibles';

  @override
  String get gfxCompatHint =>
      'Pour les téléphones où les lettres s’affichent mal. Le flou reste, quelques effets sont simplifiés';

  @override
  String get gfxRestartTitle => 'Redémarrer GymMane ?';

  @override
  String get gfxRestartBody =>
      'L’app se ferme et se rouvre pour changer sa façon de dessiner l’écran. Rien de ce que tu as enregistré n’est perdu.';

  @override
  String get gfxRestart => 'Redémarrer';

  @override
  String get webSynced => 'Mis à jour avec les changements d’un autre appareil';

  @override
  String get webSyncedPhone => 'Les changements de ton téléphone sont arrivés';

  @override
  String get webWelcomeBlurb =>
      'Tout reste sur ton propre serveur. Pas de compte, pas de cloud, rien à payer.';

  @override
  String get webOwnServer => 'Ton serveur, tes règles';

  @override
  String get webOwnServerWhy => 'Pas de compte ni de cloud tiers. Tes données vivent là où tu l’héberges.';

  @override
  String get webServerSaved => 'Enregistré sur ton serveur';

  @override
  String get webServerOffline => 'Impossible de joindre ton serveur';

  @override
  String get webServerLocal => 'Enregistré dans ce navigateur';

  @override
  String get webServerTitle => 'Ton serveur';

  @override
  String webPhoneLast(String date) {
    return 'Dernière copie de ton téléphone : $date';
  }

  @override
  String get webPhoneNone => 'Aucune copie de ton téléphone pour l’instant';

  @override
  String get webPhoneScan => 'Récupérer du téléphone';

  @override
  String get webPhoneExport => 'Envoyer au téléphone';

  @override
  String get webPhoneExportDone =>
      'Déposé dans le dossier partagé. Ton téléphone le récupère à la synchronisation';

  @override
  String get webPhoneImported => 'Les changements de ton téléphone sont arrivés';

  @override
  String get webPhoneNothing => 'Rien de nouveau de ton téléphone';

  @override
  String get webPhoneHow =>
      'Active sur ton téléphone la sauvegarde automatique dans un dossier synchronisé avec Syncthing. Le serveur et le téléphone récupèrent tout seuls les changements de l’autre, et la fusion ne supprime jamais rien.';

  @override
  String get webPhoneGuide => 'Comment le configurer';

  @override
  String get webPhoneOff => 'La synchronisation avec le téléphone est désactivée sur ce serveur';

  @override
  String get toolGroupBody => 'Corps';

  @override
  String get toolNameProtein => 'Protéines';

  @override
  String get toolTitleProtein => 'Protéines par jour';

  @override
  String get toolDescProtein => 'Combien de protéines par jour';

  @override
  String get toolHintProtein => 'Grammes par jour, répartis sur tes repas';

  @override
  String get proteinGoalLabel => 'Objectif';

  @override
  String get proteinExplain =>
      'Basé sur la fourchette sur laquelle s’accordent la plupart des études pour les personnes qui s’entraînent : plus quand tu perds du poids, pour garder ton muscle. La dépasser est sans risque, cela apporte juste peu.';

  @override
  String get toolNameWater => 'Eau';

  @override
  String get toolTitleWater => 'Eau par jour';

  @override
  String get toolDescWater => 'Combien boire par jour';

  @override
  String get toolHintWater => 'Litres par jour, aliments compris';

  @override
  String get waterTrainingLabel => 'Entraînement par jour';

  @override
  String get waterExplain =>
      'Environ 35 ml par kilo de poids corporel, plus un peu pour chaque minute d’entraînement. Bois davantage les jours de chaleur.';

  @override
  String get autoBackupSync => 'Synchroniser maintenant';

  @override
  String get autoBackupMerged => 'Les changements de tes autres appareils sont arrivés';

  @override
  String get autoBackupSyncHint =>
      'Partage ce dossier avec Syncthing et chaque appareil récupère ce que les autres y déposent. La fusion ne supprime jamais rien.';

  @override
  String get webPhoneFolder => 'Dossier partagé';

  @override
  String get webPhoneFolderHow =>
      'Choisi à l’installation du serveur. Pour le changer, définis GYMMANE_SYNC dans le fichier .env du serveur et redémarre-le.';

  @override
  String get webPhoneOffHow =>
      'Pour l’activer, retire GYMMANE_SYNC=off du fichier .env du serveur et redémarre-le.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n téléphones synchronisés',
      one: '1 téléphone synchronisé',
      zero: 'Aucun téléphone synchronisé pour l’instant',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Impossible de lire le dossier : $error';
  }

  @override
  String get duplicateExercise => 'Dupliquer';

  @override
  String exerciseCopyName(String name) {
    return '$name (copie)';
  }
}
