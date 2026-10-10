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
  String get autoProgress => 'Ajouter du poids la prochaine fois';

  @override
  String autoProgressHint(String w) {
    return 'Réussis toutes les répétitions et la prochaine séance commencera avec $w de plus.';
  }

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
  String get tapToSkip => 'Touche pour passer';

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
}
