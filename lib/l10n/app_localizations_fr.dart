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
  String get set => 'Série';

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
  String get tapMuscles => 'Touche les muscles que tu veux travailler — devant et derrière.';

  @override
  String get continueBtn => 'CONTINUER';

  @override
  String get nothingForFocus => 'Aucun exercice pour cette cible';

  @override
  String get goBackPick => 'Reviens en arrière et choisis un muscle avec des exercices dans ta bibliothèque.';

  @override
  String pickedHint(int n) {
    return 'Nous avons préparé une séance — touche pour ajouter ou retirer l’un des $n exercices.';
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
  String get restOverBody => 'C’est reparti — la prochaine série t’attend.';

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
  String get restDay => 'Jour de repos — rien d’enregistré.';

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
  String get placeDeleteBody => 'Seul le lieu sera supprimé — tes exercices et tes séances resteront.';

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
      'Conseils, plan pour la prochaine fois, ressenti d’une séance — avec photos ou vidéo si tu veux.';

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
      'Du cou aux mollets — observe l’évolution de ton corps, pas seulement celle de la barre.';

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
  String get photoDueNow => 'Photo prévue — prends-la aujourd’hui';

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
  String get timelineBodyHint => 'Créée à partir de tes propres séries — rien à envoyer.';

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
      'Séances, records, programmes, notes et profil. Cette action est irréversible — exporte d’abord une sauvegarde si tu veux pouvoir les récupérer.';

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
  String get alarmSoundHint => 'Utilise ton propre son — 15 secondes maximum';

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
  String get nothingToExport => 'Rien à exporter — enregistre d’abord une séance';

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
      '1RM, disques, IMC, calories, masse grasse, FFMI, échauffement, charge selon le RPE et scores de force DOTS et Wilks — tous basés sur des formules publiées.';

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
  String get autoAdvanceHint =>
      'Quand la dernière série d’un exercice est cochée, la séance passe automatiquement au suivant.';

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
  String get toastSoundHint => 'Un léger carillon quand une notification apparaît en haut.';

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
  String get supersetHint => 'Aucun repos entre les exercices enchaînés — tu passes directement au suivant.';

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
      'Prends une photo de la salle, du tableau, d’un montage de disques — tout ce que tu veux garder en mémoire. Elles restent sur le téléphone et toi seul les vois.';

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
  String get logHint => 'Sans minuteur — renseigne simplement ce que tu as fait.';

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
    return '$name — ouvre le fichier avec GymMane pour l\'ajouter.';
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
  String get homeRoutinesHint => 'Tes routines, la dernière faite en premier. Touche-en une pour la lancer.';

  @override
  String get homeWeekStats => 'Cette semaine sur l’accueil';

  @override
  String get homeWeekStatsHint => 'Volume, séries et records de la semaine.';

  @override
  String get stepsSetting => 'Pas depuis Health Connect';

  @override
  String get stepsSettingHint => 'Affiche les pas du jour sur l\'Accueil. Rien ne quitte ton téléphone.';

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
  String get multiPlanSettingHint => 'Plusieurs programmes le même jour de la semaine.';

  @override
  String get levelHintsHint => 'Quand un exercice devient facile, il vous propose la version plus dure.';

  @override
  String get focusCardHint => 'Le programme du jour, en haut de l’Accueil.';

  @override
  String get gamificationHint => 'Médailles, votre niveau et la fête à la fin.';

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
  String get restRowHint => 'Entre les séries, sauf si l’exercice a le sien.';

  @override
  String get effortRowHint => 'Notez le RPE ou le RIR à chaque série.';

  @override
  String get countdownHint => '3, 2, 1 avant la première série.';

  @override
  String get keepScreenOnHint => 'L’écran reste allumé pendant la séance.';

  @override
  String get demoSizeRowHint => 'Le dessin de l’exercice pendant la séance.';

  @override
  String get demoLoopRowHint => 'Si l’animation se répète ou s’arrête.';

  @override
  String get trainReminderRowHint => 'Un rappel les jours d’entraînement.';

  @override
  String get alarmSoundRowHint => 'Ce qui sonne à la fin du repos.';

  @override
  String get alarmStyleRowHint => 'S’il sonne en mode silencieux.';

  @override
  String get recommendedRowHint => 'Exercices que l’on vous propose sur l’Accueil.';

  @override
  String get weightStepSetting => 'Pas de poids';

  @override
  String get weightStepHint => 'Ce qu’ajoutent les boutons − et +.';

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
  String get foodCategory => 'CATEGORY';

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
  String get readyDishes => 'Dishes';

  @override
  String weightLastLine(String weight) {
    return 'Last weigh-in $weight';
  }

  @override
  String get proteinAnimalShort => 'Animal';

  @override
  String get proteinPlantShort => 'Plant';

  @override
  String kcalFromMacros(String value) {
    return 'These macros add up to about $value';
  }

  @override
  String get useValue => 'Use';

  @override
  String get suppRowHint => 'Tap to mark · hold for details';

  @override
  String get suppPhoto => 'Photo';

  @override
  String get suppDose => 'Dose';

  @override
  String get suppDoseHint => '5 g, 2 capsules…';

  @override
  String get suppRemind => 'Remind me';

  @override
  String mealPlanDefault(int n) {
    return 'Plan $n';
  }

  @override
  String get mealPlansTitle => 'Meal plans';

  @override
  String get mealPlanNew => 'New plan';

  @override
  String fromPlan(String name) {
    return 'From $name';
  }

  @override
  String get logPlan => 'Log';

  @override
  String get planFromDay => 'Copy this day';

  @override
  String get planNewHint => 'Plan your days like your routines, then log a whole meal with one tap.';

  @override
  String get planLogDay => 'Log the empty meals';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foods logged',
      one: '1 food logged',
    );
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'No plan';

  @override
  String get planWeekHint => 'Tap a day to give it a plan.';

  @override
  String get planDuplicate => 'Duplicate';

  @override
  String planDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get planDeleteBody => 'Tes routines restent. Seule cette semaine enregistrée est supprimée.';

  @override
  String get sectionBeta => 'Bêta';

  @override
  String get nutritionBeta => 'Nutrition';

  @override
  String get nutritionBetaHint =>
      'Repas, eau, protéines et compléments. Encore en construction : tes données restent même si tu la désactives.';

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
  String get planShare => 'Share';

  @override
  String get planImport => 'Import a plan';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n plans imported',
      one: '1 plan imported',
    );
    return '$_temp0';
  }

  @override
  String get planImportNone => 'That file has no meal plans.';

  @override
  String get planMoveUp => 'Move up';

  @override
  String get planMoveDown => 'Move down';

  @override
  String get cutoutEdit => 'Touch up cutout';

  @override
  String get cutoutEditHint =>
      'Drag to erase or restore. Tap an area to remove or bring it back whole. Pinch to zoom.';

  @override
  String get cutoutErase => 'Erase';

  @override
  String get cutoutRestore => 'Restore';

  @override
  String get cutoutReset => 'Back to automatic';

  @override
  String get cutoutByHand => 'Cut out by hand';

  @override
  String notifSuppTitleFor(String names) {
    return 'Time to take: $names';
  }

  @override
  String get notifSuppTap => 'Tick it off in GymMane once you\'ve taken it.';

  @override
  String get suppNoneToday => 'Nothing to take today.';

  @override
  String get suppOtherDays => 'Other days';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Every $n days', one: 'Every day');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Every day';

  @override
  String suppFromDate(String date) {
    return 'from $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'until $date';
  }

  @override
  String get suppSomeDays => 'Some days';

  @override
  String get suppEveryShort => 'Every X days';

  @override
  String get suppWhen => 'When';

  @override
  String get suppEveryLead => 'Every';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'days', one: 'day');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Starts';

  @override
  String get suppEnds => 'Ends';

  @override
  String get suppTomorrow => 'Tomorrow';

  @override
  String get suppPickDate => 'Pick a date';

  @override
  String get suppNever => 'Never';

  @override
  String get suppOneWeek => 'In 1 week';

  @override
  String get suppOneMonth => 'In 1 month';

  @override
  String get planPickHint => 'Pick the plan for this day, or make a new one.';

  @override
  String planSetForDay(String day) {
    return 'Plan set for $day';
  }

  @override
  String get planSaved => 'Plan saved';

  @override
  String get planDiscardTitle => 'Discard changes?';

  @override
  String get planDiscardBody => 'What you changed won\'t be saved.';

  @override
  String get planDiscard => 'Discard';

  @override
  String get planEdit => 'Edit plan';

  @override
  String get planNameHint => 'Été, voyage…';

  @override
  String get planDaysQuestion => 'Which days?';

  @override
  String get planDaysHint => 'On those days it shows up in Nutrition so you can log it in one tap.';

  @override
  String get planDaysNone => 'Pick at least one day, or it won\'t show up anywhere.';

  @override
  String get planNothingToLog => 'Those meals are already logged';

  @override
  String get planSave => 'Save plan';

  @override
  String get planToday => 'Today\'s plan';

  @override
  String get planLogRest => 'Log the rest';

  @override
  String get dishNew => 'Create my dish';

  @override
  String get dishNewHint => 'Pick ingredients and amounts, save it and log it in one tap.';

  @override
  String get dishEdit => 'Edit dish';

  @override
  String get dishNameHint => 'E.g. Mum\'s lentils';

  @override
  String get dishIngredients => 'Ingredients';

  @override
  String get dishEmptyHint => 'Add what goes in it with the amount you usually eat.';

  @override
  String get dishSave => 'Save dish';

  @override
  String get dishNeedsName => 'Give it a name';

  @override
  String get dishNeedsItems => 'Add at least one ingredient';

  @override
  String get suppHistory => 'Last 14 days';

  @override
  String suppTakenOf(int n, int total) {
    return '$n of $total taken';
  }

  @override
  String get suppNoReminder => 'No reminder';

  @override
  String get suppMarkTaken => 'Mark as taken';

  @override
  String get suppUnmark => 'Unmark';

  @override
  String get suppEdit => 'Edit';

  @override
  String get mealMoveTo => 'Move to';

  @override
  String get mealClear => 'Clear meal';

  @override
  String get mealCleared => 'Meal cleared';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foods moved',
      one: '1 food moved',
    );
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Repeat the whole day';

  @override
  String createFoodNamed(String name) {
    return 'Create “$name”';
  }

  @override
  String get entryDay => 'Day';

  @override
  String get movedToDay => 'Moved';

  @override
  String get favFoodsHint => 'Tap ☆ on a food';

  @override
  String get favFoodsEmpty => 'Tap the star on any food to keep it here, one tap away.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count meals', one: '1 meal');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Save a meal from its ••• menu, or build your own dish.';

  @override
  String get sugarLimitLabel => 'Sugar limit';

  @override
  String get sodiumLimitLabel => 'Sodium limit';

  @override
  String get waterOptions => 'Water options';

  @override
  String get waterNone => 'No water logged yet.';

  @override
  String get waterDailyGoal => 'Daily water';

  @override
  String get trackersScreen => 'Screen';

  @override
  String get vesselMotion => 'Moving water and shake';

  @override
  String get vesselMotionHint =>
      'Turn it off if the screen feels slow: the glasses still fill up, they just stop moving.';

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
  String get widgetNutritionOff => 'Turn on Nutrition in Settings › Beta to use this widget.';

  @override
  String get widgetPickShake => 'Pick your shake';

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
  String get shakeTag => 'It’s a shake';

  @override
  String get shakeTagHint => 'It shows up in Your shake';

  @override
  String get shakeNone => 'Mark your shakes and only those show up here.';

  @override
  String get shakeMarkLabel => 'MARK AS A SHAKE';

  @override
  String get shakeNew => 'New shake';

  @override
  String get shakeUntag => 'Not a shake';

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
  String get proteinSource => 'Protein source';

  @override
  String get proteinMixedShort => 'Mixed';

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
  String get progDouble => 'Double progression';

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
    return 'Fill your day · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'You\'ll have $kcal left';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'You\'ll have $kcal and $grams g protein left';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal over your goal';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit a day';
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
}
