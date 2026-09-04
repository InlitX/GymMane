// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get languageName => 'Português (Brasil)';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% em relação ao mês passado';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Nível $level · $streak';
  }

  @override
  String get save => 'SALVAR';

  @override
  String get cancel => 'Cancelar';

  @override
  String get cancelCaps => 'CANCELAR';

  @override
  String get deleteCaps => 'EXCLUIR';

  @override
  String get done => 'CONCLUÍDO';

  @override
  String get set => 'Definir';

  @override
  String get home => 'INÍCIO';

  @override
  String get progress => 'PROGRESSO';

  @override
  String get exercises => 'EXERCÍCIOS';

  @override
  String get settings => 'CONFIGURAÇÕES';

  @override
  String get today => 'HOJE';

  @override
  String get thisWeek => 'ESTA SEMANA';

  @override
  String get recommended => 'RECOMENDADOS';

  @override
  String get goal => 'META';

  @override
  String get volume => 'VOLUME';

  @override
  String get setsToday => 'SÉRIES DE HOJE';

  @override
  String get prs => 'RECORDES PESSOAIS';

  @override
  String get todaysFocus => 'FOCO DE HOJE';

  @override
  String get todaysRoutine => 'ROTINA DE HOJE';

  @override
  String get startWorkout => 'INICIAR TREINO';

  @override
  String get routines => 'ROTINAS';

  @override
  String get tools => 'FERRAMENTAS';

  @override
  String get firstSessionHint => 'Escolha seus músculos e registre sua primeira sessão';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercícios', one: '$n exercício');
    return '$_temp0';
  }

  @override
  String get pushDay => 'DIA DE EMPURRAR';

  @override
  String get pullDay => 'DIA DE PUXAR';

  @override
  String get legDay => 'DIA DE PERNAS';

  @override
  String get pushFocus => 'Peito · Ombros · Tríceps';

  @override
  String get pullFocus => 'Costas · Bíceps · Trapézios';

  @override
  String get legFocus => 'Quadríceps · Isquiotibiais · Glúteos';

  @override
  String get train => 'TREINAR';

  @override
  String get step1 => 'PASSO 1 DE 2';

  @override
  String get step2 => 'PASSO 2 DE 2';

  @override
  String get chooseFocus => 'ESCOLHA SEU FOCO';

  @override
  String get buildSession => 'CRIE SUA SESSÃO';

  @override
  String get tapMuscles => 'Toque nos músculos que deseja treinar — frente e costas.';

  @override
  String get noMusclesYet => 'Ainda não foram selecionados músculos — toque no corpo para começar.';

  @override
  String get continueBtn => 'CONTINUAR';

  @override
  String get nothingForFocus => 'Ainda não há nada para este foco';

  @override
  String get goBackPick => 'Volte e escolha um músculo com exercícios na sua biblioteca.';

  @override
  String pickedHint(int n) {
    return 'Escolhemos uma sessão para você — toque para adicionar ou remover qualquer um dos $n.';
  }

  @override
  String get pickAnExercise => 'ESCOLHA UM EXERCÍCIO';

  @override
  String get searchAllExercises => 'Pesquise qualquer exercício…';

  @override
  String get noExercisesMatch => 'Nenhum exercício corresponde';

  @override
  String get createItInstead => 'Crie você mesmo';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n EXERCÍCIOS', one: '$n EXERCÍCIO');
    return 'INICIAR · $_temp0';
  }

  @override
  String get inProgress => 'EM ANDAMENTO';

  @override
  String get paused => 'PAUSADO';

  @override
  String get last => 'ÚLTIMO';

  @override
  String get rest => 'DESCANSO';

  @override
  String get skip => 'PULAR';

  @override
  String get addSet => '+ ADICIONAR SÉRIE';

  @override
  String get finishSession => 'ENCERRAR SESSÃO';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'REPETIÇÕES';

  @override
  String weightCol(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get repsTitle => 'REPETIÇÕES';

  @override
  String weightTitle(String unit) {
    return 'PESO ($unit)';
  }

  @override
  String get sessionComplete => 'TREINO REGISTRADO';

  @override
  String get finishHeadlinePr => 'Novo recorde pessoal';

  @override
  String get finishHeadlineGoal => 'Meta semanal alcançada';

  @override
  String get finishHeadlineStreak => 'Sequência mantida';

  @override
  String get finishHeadlineDefault => 'Mais uma conquistada';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs exercícios',
      one: 'un exercício',
    );
    return 'Você levantou mais do que nunca em $_temp0. Agora isso faz parte dos seus recordes.';
  }

  @override
  String get finishBodyGoal => 'Você cumpriu as sessões que se propôs a fazer esta semana.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak dias seguidos. O difícil é não parar.';
  }

  @override
  String get finishBodyDefault =>
      'Registrado e contabilizado. A consistência é o que faz os números crescerem.';

  @override
  String get vsLastTime => 'EM COMPARAÇÃO À ÚLTIMA VEZ';

  @override
  String get firstTime => 'Primeiro registro';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n novos recordes',
      one: '$n novo recorde',
    );
    return '$_temp0';
  }

  @override
  String get saveAndExit => 'SALVAR E SAIR';

  @override
  String get duration => 'DURAÇÃO';

  @override
  String get setsCaps => 'SÉRIES';

  @override
  String exerciseXofY(int i, int n) {
    return 'EXERCÍCIO $i DE $n';
  }

  @override
  String get decrease => 'Diminuir';

  @override
  String get increase => 'Aumentar';

  @override
  String markSet(int n) {
    return 'Marcar a série $n como concluída';
  }

  @override
  String get pauseWorkout => 'Pausar treino';

  @override
  String get resumeWorkout => 'Retomar treino';

  @override
  String get discardTitle => 'Descartar treino?';

  @override
  String get discardBody => 'Suas séries desta sessão serão perdidas.';

  @override
  String get keepTraining => 'Manter o treino';

  @override
  String get discard => 'Descartar';

  @override
  String get notifRestChannel => 'Temporizador de descanso';

  @override
  String get notifRestChannelWhy => 'Avisa quando o seu descanso entre séries terminar';

  @override
  String get notifAlertChannel => 'Temporizador de descanso (alerta)';

  @override
  String get notifAlertChannelWhy => 'Exibe um banner no momento em que o seu descanso terminar';

  @override
  String get restOverTitle => 'Descanso encerrado';

  @override
  String get restOverBody => 'De volta ao treino — a próxima série está esperando.';

  @override
  String get totalVolume30d => 'VOLUME TOTAL · 30 DIAS';

  @override
  String get volumeCumulative => 'Running total of every kilo you moved';

  @override
  String get volumeChartEmpty => 'Log a session and the curve starts here';

  @override
  String get weekRhythm => 'WEEK RHYTHM';

  @override
  String get weekRhythmHint => 'Which days you actually show up.';

  @override
  String weekRhythmBest(String day) {
    return '$day is your day';
  }

  @override
  String get weekRhythmEmpty => 'Log a session and your week takes shape here.';

  @override
  String get allTime => 'ALL TIME';

  @override
  String get allTimeSessions => 'SESSIONS';

  @override
  String get allTimeTime => 'TIME';

  @override
  String get allTimeVolume => 'LIFTED';

  @override
  String get allTimeSets => 'SETS';

  @override
  String allTimeAvg(String time) {
    return '$time a session on average';
  }

  @override
  String hoursShort(int n) {
    return '${n}h';
  }

  @override
  String get consistency => 'CONSISTÊNCIA';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões registradas',
      one: '$n sessão registrada',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'dias', one: 'dia');
    return 'Sequência de $n $_temp0';
  }

  @override
  String get bodyweight => 'PESO CORPORAL';

  @override
  String get notLoggedYet => 'Ainda não registrado';

  @override
  String get logShort => '+ REGISTRAR';

  @override
  String get logBodyweight => 'REGISTRAR PESO CORPORAL';

  @override
  String get trackWeight => 'Acompanhe seu peso ao longo do tempo';

  @override
  String get muscleMap => 'MAPA MUSCULAR';

  @override
  String get days7 => '7D';

  @override
  String get days30 => '30D';

  @override
  String get heatLow => 'Sem treino';

  @override
  String get heatHigh => 'Volume total';

  @override
  String get muscleMapEmpty => 'Registre uma sessão e seu corpo começa a se iluminar aqui.';

  @override
  String get muscleMapHint => 'Toque em um músculo para ver quanto ele foi treinado.';

  @override
  String muscleMapBehind(String names) {
    return 'Ficando para trás: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% da meta';
  }

  @override
  String get muscleSplit => 'DIVISÃO MUSCULAR';

  @override
  String get splitEmpty => 'Treine para ver como seu volume se divide entre os grupos musculares.';

  @override
  String get personalRecords => 'RECORDES PESSOAIS';

  @override
  String get prEmpty => 'Seus recordes aparecerão aqui à medida que você registrar suas séries.';

  @override
  String get strength1rm => 'FORÇA · 1RM EST.';

  @override
  String get strengthEmpty => 'Registre um exercício duas vezes e sua curva de força aparecerá aqui.';

  @override
  String oneRmEst(String w) {
    return '1RM est. $w';
  }

  @override
  String get restDayShort => 'Dia de descanso';

  @override
  String get restDay => 'Dia de descanso — nada registrado.';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteEntry => 'Excluir esta entrada?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" será removido deste dia, bem como de seus registros e gráficos.';
  }

  @override
  String get bodyweightHistory => 'HISTÓRICO';

  @override
  String get noBodyweightYet => 'Ainda não há nada registrado.';

  @override
  String get exercisesCaps => 'EXERCÍCIOS';

  @override
  String get timeCaps => 'TEMPO';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercícios na sua biblioteca',
      one: '$n exercício na sua biblioteca',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Pesquisar exercícios';

  @override
  String get muscleFilter => 'MÚSCULOS';

  @override
  String get levelFilter => 'NÍVEL';

  @override
  String get newExercise => 'NOVO EXERCÍCIO';

  @override
  String get exerciseName => 'Nome do exercício';

  @override
  String get equipmentLabel => 'EQUIPAMENTO';

  @override
  String get addExercise => 'ADICIONAR EXERCÍCIO';

  @override
  String get advanced => 'AVANÇADO';

  @override
  String get demoMedia => 'DEMONSTRAÇÃO';

  @override
  String get addMedia => 'Adicionar mídia';

  @override
  String get mediaHint => 'Imagem, GIF ou vídeo';

  @override
  String get changeMedia => 'Alterar';

  @override
  String get videoSelected => 'Vídeo selecionado';

  @override
  String get favouritesOnly => 'Favoritos';

  @override
  String get noFavouritesYet => 'Ainda sem favoritos';

  @override
  String get noFavouritesHint => 'Toque na estrela de um exercício para salvá-lo.';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get noExercisesFound => 'Nenhum exercício encontrado';

  @override
  String get noExercisesHint => 'Tente uma busca diferente ou limpe seus filtros.';

  @override
  String get personalRecord => 'RECORDE PESSOAL';

  @override
  String get history => 'HISTÓRICO';

  @override
  String get noHistory => 'Ainda não há sessões registradas. Treine este exercício para criar um histórico.';

  @override
  String get notes => 'NOTAS';

  @override
  String get notePlaceholder => 'Dicas, preparação, como foi a sensação…';

  @override
  String showAllNotes(int n) {
    return 'Mostrar todas as $n notas';
  }

  @override
  String notHere(String gear, String place) {
    return 'No $gear at $place';
  }

  @override
  String get notHereWhy => 'Swap it for something you can actually load today.';

  @override
  String get altHere => 'WHAT YOU CAN DO HERE';

  @override
  String get places => 'MY PLACES';

  @override
  String get placesShort => 'Places';

  @override
  String get placesHint =>
      'Say what you have in each place and the library only shows what you can actually do there.';

  @override
  String get placeAll => 'Anywhere';

  @override
  String get placeNew => 'New place';

  @override
  String get placeNameLabel => 'NAME';

  @override
  String get placeNamePlaceholder => 'Home, gym, the park…';

  @override
  String get placeGearLabel => 'WHAT IS THERE';

  @override
  String placeGearCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n kinds of kit',
      one: '1 kind of kit',
      zero: 'Nothing ticked',
    );
    return '$_temp0';
  }

  @override
  String placeExercises(int n) {
    return '$n exercises here';
  }

  @override
  String get placeEmptyTitle => 'Train wherever you are';

  @override
  String get placeEmptyBody =>
      'A place is a list of the kit you have there. Pick one to start and edit it later.';

  @override
  String get placeDeleteTitle => 'Delete place';

  @override
  String get placeDeleteBody => 'Only the place goes — your exercises and sessions stay.';

  @override
  String get placeGym => 'Gym';

  @override
  String get placeHome => 'Home';

  @override
  String get placeOutdoors => 'Outdoors';

  @override
  String get placeFilterLabel => 'PLACE';

  @override
  String get noGearOnly => 'No kit';

  @override
  String placeActive(String name) {
    return 'Training at $name';
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
      zero: 'No notes',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Note';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Win';

  @override
  String get noteKindPain => 'Niggle';

  @override
  String get noteFilterAll => 'All';

  @override
  String get newNote => 'New note';

  @override
  String get editNote => 'Edit note';

  @override
  String get addNote => 'ADD NOTE';

  @override
  String get noteEmptyTitle => 'Nothing written down yet';

  @override
  String get noteEmptyBody =>
      'Cues, plans for next time, how a session felt — with photos or video if you want.';

  @override
  String get noteNoneForExercise => 'No notes on this exercise yet.';

  @override
  String get noteKindLabel => 'TYPE';

  @override
  String get noteTextLabel => 'NOTE';

  @override
  String get noteDateLabel => 'DATE';

  @override
  String get noteExerciseLabel => 'EXERCISE';

  @override
  String get noteMediaLabel => 'PHOTOS & VIDEO';

  @override
  String get noteGeneral => 'No exercise';

  @override
  String get noteAttach => 'Attach';

  @override
  String get noteRemoveMedia => 'Remove attachment';

  @override
  String get deleteNoteTitle => 'Delete note';

  @override
  String get deleteNoteBody => 'The note and anything attached to it go for good.';

  @override
  String get noteToday => 'Today';

  @override
  String get noteYesterday => 'Yesterday';

  @override
  String get noteAllNotes => 'All notes';

  @override
  String get noteCalendar => 'Calendar';

  @override
  String get noteNoneOnDay => 'Nothing written on this day';

  @override
  String get noteAddOnDay => 'Note on this day';

  @override
  String get notePrevMonth => 'Previous month';

  @override
  String get noteNextMonth => 'Next month';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes this month',
      one: '1 note this month',
      zero: 'No notes this month',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MEASUREMENTS';

  @override
  String get measuresHint => 'Neck to calf — watch your body change, not just the bar.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n readings',
      one: '1 reading',
      zero: 'Nothing logged',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Not logged yet';

  @override
  String get measureHistory => 'HISTORY';

  @override
  String get measureNeck => 'Neck';

  @override
  String get measureShoulders => 'Shoulders';

  @override
  String get measureChest => 'Chest';

  @override
  String get measureArm => 'Arm';

  @override
  String get measureForearm => 'Forearm';

  @override
  String get measureWaist => 'Waist';

  @override
  String get measureHips => 'Hips';

  @override
  String get measureThigh => 'Thigh';

  @override
  String get measureCalf => 'Calf';

  @override
  String get measureBodyfat => 'Body fat';

  @override
  String get timeline => 'TIMELINE';

  @override
  String get timelineHint => 'Same pose, same spot, same light. In a year you will not believe it.';

  @override
  String get timelineEmptyTitle => 'Your first photo starts the clock';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n photos',
      one: '1 photo',
      zero: 'No photos',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Front';

  @override
  String get poseSide => 'Side';

  @override
  String get poseBack => 'Back';

  @override
  String get photoEvery => 'REMIND ME';

  @override
  String photoEveryDays(int n) {
    return 'Every $n days';
  }

  @override
  String get photoEveryOff => 'Never';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Next photo in $n days',
      one: 'Next photo tomorrow',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Photo due — grab it today';

  @override
  String get addTodayPhotos => 'ADD TODAY\'S PHOTOS';

  @override
  String posePhoto(String pose) {
    return '$pose photo';
  }

  @override
  String get compare => 'COMPARE';

  @override
  String get compareNeedTwo => 'Shoot the same pose on two different days and you can compare them here.';

  @override
  String dayNumber(int n) {
    return 'Day $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days apart',
      one: '1 day apart',
      zero: 'Same day',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Delete this day';

  @override
  String get deleteDayBody => 'Its photos go with it, for good.';

  @override
  String get timelinePhotos => 'Photos';

  @override
  String get timelineBody => 'Muscle map';

  @override
  String get timelineBodyEmpty =>
      'Log a session and your muscle map starts filling in here, no photos needed.';

  @override
  String get timelineBodyHint => 'Built from your own sets — nothing to upload.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions',
      one: '1 session',
      zero: 'No sessions',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Progress photos';

  @override
  String get notifPhotoChannelWhy => 'A nudge when your next progress photo is due.';

  @override
  String get notifPhotoTitle => 'Time for your progress photo';

  @override
  String notifPhotoBody(int n) {
    return '$n days since the last one. Same pose, same light.';
  }

  @override
  String get share => 'SHARE';

  @override
  String get sharePick => 'What do you want to show?';

  @override
  String get shareSession => 'Last session';

  @override
  String get shareStreak => 'Streak and consistency';

  @override
  String get shareBody => 'Muscles worked';

  @override
  String get shareCompare => 'Before and after';

  @override
  String get shareHint => 'The card is built on your phone. Nothing leaves until you pick where it goes.';

  @override
  String get shareFailed => 'The card could not be built';

  @override
  String get shareWeekOf => 'LAST 7 DAYS';

  @override
  String get shareStreakLabel => 'DAY STREAK';

  @override
  String get shareSessionsLabel => 'SESSIONS';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get shareSetsLabel => 'SETS';

  @override
  String get shareNothing => 'Log a session first — there is nothing to show yet';

  @override
  String get restForExercise => 'REST FOR THIS EXERCISE';

  @override
  String get restUsingDefault => 'Using your default';

  @override
  String get restCustom => 'Only for this one';

  @override
  String get setType => 'SET TYPE';

  @override
  String get setTypeNormal => 'Working';

  @override
  String get setTypeWarmup => 'Warm-up';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'To failure';

  @override
  String get setTypeHint => 'Warm-ups stay out of your volume and your records.';

  @override
  String get addWarmup => 'WARM-UP';

  @override
  String platesPerSide(String plates) {
    return 'Per side: $plates';
  }

  @override
  String get howTo => 'COMO FAZER';

  @override
  String get similar => 'SEMELHANTE';

  @override
  String get primaryLabel => 'PRIMÁRIO';

  @override
  String get secondaryLabel => 'SECUNDÁRIO';

  @override
  String get none => 'Nenhum';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n séries', one: '$n série');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v de volume';
  }

  @override
  String get weeklyPlan => 'PLANO SEMANAL';

  @override
  String get yourRoutines => 'SUAS ROTINAS';

  @override
  String get noRoutines => 'Ainda não há rotinas. Crie uma e adicione seus exercícios.';

  @override
  String get newRoutine => 'NOVA ROTINA';

  @override
  String get routineName => 'Nome da rotina';

  @override
  String get schedule => 'PROGRAMAÇÃO';

  @override
  String get addFromList => 'Adicione exercícios da lista abaixo.';

  @override
  String get addExercises => 'Adicionar exercícios';

  @override
  String get deleteRoutine => 'Excluir esta rotina?';

  @override
  String exercisesWithCount(int n) {
    return 'EXERCÍCIOS · $n';
  }

  @override
  String setDay(String day) {
    return 'DEFINIR $day';
  }

  @override
  String get newRoutineName => 'Nova rotina';

  @override
  String get dragToReorder => 'Segure e arraste para reordenar — esta é a ordem em que você treina.';

  @override
  String reorderHandle(String name) {
    return 'Reordenar $name';
  }

  @override
  String get removeFromRoutine => 'Remover da rotina';

  @override
  String get dropExercise => 'Deseja remover este exercício?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" sai deste treino. Nenhum registro será perdido';
  }

  @override
  String get drop => 'Remover';

  @override
  String get addToWorkout => 'ADICIONAR UM EXERCÍCIO';

  @override
  String get resetData => 'Excluir todos os meus dados';

  @override
  String get resetTitle => 'Excluir tudo?';

  @override
  String get resetBody =>
      'Sessões, registros, rotinas, notas e perfil. Isso não pode ser desfeito — exporte um backup primeiro, caso queira mantê-lo';

  @override
  String get resetConfirm => 'Excluir tudo';

  @override
  String get resetDone => 'Todos os dados excluídos';

  @override
  String get support => 'SUPORTE';

  @override
  String get reportBug => 'Relatar um bug';

  @override
  String get requestFeature => 'Solicitar um recurso';

  @override
  String get starOnGithub => 'Marcar como favorito no GitHub';

  @override
  String get buyCoffee => 'Me pague um café';

  @override
  String get cantOpenLink => 'Não foi possível abrir o link';

  @override
  String get preferences => 'PREFERÊNCIAS';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get lightTheme => 'Claro';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get unitsLabel => 'Unidades';

  @override
  String get restTimer => 'Descanso';

  @override
  String get alarmBlockedTitle => 'Notificações desativadas';

  @override
  String get alarmBlockedBody => 'O alarme de descanso não tocará com a tela bloqueada';

  @override
  String get alarmBlockedAction => 'ATIVAR';

  @override
  String get alarmSound => 'Som do alarme';

  @override
  String get alarmDefaultName => 'Padrão';

  @override
  String get alarmSoundHint => 'Use o seu próprio som — até 15 segundos';

  @override
  String get alarmChoose => 'Escolha um som…';

  @override
  String get alarmPreview => 'Reproduzir som atual';

  @override
  String get alarmReset => 'Redefinir para o padrão';

  @override
  String get alarmTooLong => 'Esse som tem mais de 15 segundos';

  @override
  String get alarmInvalid => 'Não foi possível ler esse arquivo de áudio';

  @override
  String alarmChanged(String name) {
    return 'Som do alarme definido como «$name»';
  }

  @override
  String get alarmChangedDefault => 'Voltar ao som padrão';

  @override
  String get homeWidgets => 'TELA INICIAL';

  @override
  String get addActivityWidget => 'Adicionar widget de atividade';

  @override
  String get addStatsWidget => 'Adicionar widget de estatísticas';

  @override
  String get pinUnsupported => 'Adicione-o pelo menu de widgets da tela inicial';

  @override
  String get background => 'Fundo';

  @override
  String get bgNone => 'Nenhum';

  @override
  String get bgDots => 'Pontos';

  @override
  String get bgGrid => 'Grade';

  @override
  String get data => 'DADOS';

  @override
  String get exportCsv => 'Exportar treinos (CSV)';

  @override
  String get exportBackup => 'Exportar backup (JSON)';

  @override
  String get importBackup => 'Importar backup';

  @override
  String get importHint =>
      'Escolha um backup .json exportado do GymMane. Isso substituirá seus dados atuais.';

  @override
  String get import => 'Importar';

  @override
  String get chooseFile => 'Escolher arquivo';

  @override
  String get importFromApp => 'Importar de outro aplicativo';

  @override
  String get importUnknownFormat => 'Esse arquivo não é uma exportação do Hevy, Strong ou FitNotes';

  @override
  String get importZipNoWeights => 'Esse zip não contém nenhum arquivo de peso';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pesagem importadas',
      one: '$n pesagem importada',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Não foi possível ler esse arquivo';

  @override
  String get importUnitTitle => 'Em qual unidade esse arquivo está?';

  @override
  String get importUnitBody => 'Esta exportação não indica em qual unidade os pesos estão.';

  @override
  String get importNothing => 'Nada novo para importar';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões importadas',
      one: '$n sessão importada',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Sobre GymMane';

  @override
  String get yourProfile => 'SEU PERFIL';

  @override
  String get autofills => 'Preenche automaticamente as calculadoras';

  @override
  String get nameLabel => 'NOME';

  @override
  String get sexLabel => 'SEXO';

  @override
  String get macroProtein => 'PROTEIN';

  @override
  String get macroCarbs => 'CARBS';

  @override
  String get macroFat => 'FAT';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Feminino';

  @override
  String get ageLabel => 'IDADE';

  @override
  String get heightLabel => 'ALTURA';

  @override
  String get weightLabel => 'PESO';

  @override
  String get weeklyGoal => 'META SEMANAL';

  @override
  String get activityLabel => 'ATIVIDADE';

  @override
  String get addPhoto => 'Adicionar uma foto';

  @override
  String get removePhoto => 'Remover foto';

  @override
  String get takePhoto => 'Tirar uma foto';

  @override
  String get chooseGallery => 'Escolher da galeria';

  @override
  String get backupCopied => 'Backup copiado para a área de transferência';

  @override
  String get backupImported => 'Backup importado';

  @override
  String get backupFailed => 'Não foi possível ler esse backup';

  @override
  String get nothingToExport => 'Ainda não há nada para exportar — registre uma sessão primeiro';

  @override
  String get athlete => 'Atleta';

  @override
  String calculatorsCount(int n) {
    return '$n calculadoras para o seu treinamento';
  }

  @override
  String get result => 'RESULTADO';

  @override
  String get weightLifted => 'PESO LEVANTADO';

  @override
  String get repsPerformed => 'REPETIÇÕES REALIZADAS';

  @override
  String get neck => 'PESCOÇO';

  @override
  String get waist => 'CINTURA';

  @override
  String get hip => 'QUADRIL (mulheres)';

  @override
  String get targetWeight => 'PESO ALVO';

  @override
  String get workingWeight => 'PESO DE TREINO';

  @override
  String get activityLevel => 'NÍVEL DE ATIVIDADE';

  @override
  String get barWeight => 'PESO DA BARRA';

  @override
  String get perSide => 'POR LADO';

  @override
  String get justTheBar => 'Apenas a barra.';

  @override
  String perSideCount(int n) {
    return '× $n por lado';
  }

  @override
  String rampSet(String pct, int reps) {
    return '$pct · $reps repetições';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'IMC';

  @override
  String get toolNameCal => 'Calorias';

  @override
  String get toolNameBf => 'Gordura corporal';

  @override
  String get toolNamePlate => 'Discos';

  @override
  String get toolNameWarmup => 'Aquecimento';

  @override
  String get toolTitleRm => 'Calculadora de 1RM';

  @override
  String get toolTitleBmi => 'Calculadora de IMC';

  @override
  String get toolTitleCal => 'Calorias e macros';

  @override
  String get toolTitleBf => '% de gordura corporal';

  @override
  String get toolTitlePlate => 'Calculadora de pesos';

  @override
  String get toolTitleWarmup => 'Séries de aquecimento';

  @override
  String get toolHintRm => 'Máximo estimado para 1 repetição (fórmula de Epley)';

  @override
  String get toolHintCal => 'Manutenção diária estimada';

  @override
  String get toolHintBf => 'Estimativa pelo método da Marinha dos EUA';

  @override
  String get toolHintPlate => 'Peso total da barra';

  @override
  String get toolHintWarmup => 'Meta de peso de trabalho';

  @override
  String get toolDescRm => 'Máximo estimado para uma repetição';

  @override
  String get toolDescBmi => 'Índice de massa corporal';

  @override
  String get toolDescCal => 'Calorias e macros';

  @override
  String get toolDescBf => 'Porcentagem de gordura corporal';

  @override
  String get toolDescPlate => 'Calculadora de discos de barra';

  @override
  String get toolDescWarmup => 'Séries de aquecimento';

  @override
  String get bmiUnderweight => 'Abaixo do peso';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Excesso de peso';

  @override
  String get bmiObese => 'Obesidade';

  @override
  String get actSedentary => 'Sedentário';

  @override
  String get actLight => 'Leve';

  @override
  String get actActive => 'Ativo';

  @override
  String get actModerate => 'Moderado';

  @override
  String get muscleChest => 'Peito';

  @override
  String get muscleBack => 'Costas';

  @override
  String get muscleShoulders => 'Ombros';

  @override
  String get muscleBiceps => 'Bíceps';

  @override
  String get muscleTriceps => 'Tríceps';

  @override
  String get muscleForearm => 'Antebraço';

  @override
  String get muscleTrapezius => 'Trapézio';

  @override
  String get muscleAbdomen => 'Abdômen';

  @override
  String get muscleObliques => 'Oblíquos';

  @override
  String get muscleQuads => 'Quadríceps';

  @override
  String get muscleHamstrings => 'Isquiotibiais';

  @override
  String get muscleGlutes => 'Glúteos';

  @override
  String get muscleCalves => 'Panturrilhas';

  @override
  String get mgChest => 'Peito';

  @override
  String get mgBack => 'Costas';

  @override
  String get mgLegs => 'Pernas';

  @override
  String get mgShoulders => 'Ombros';

  @override
  String get mgArms => 'Braços';

  @override
  String get mgCore => 'Tronco';

  @override
  String get equipBarbell => 'Barra';

  @override
  String get equipDumbbell => 'Halteres';

  @override
  String get equipCable => 'Cabo';

  @override
  String get equipMachine => 'Aparelho';

  @override
  String get equipBodyweight => 'Peso corporal';

  @override
  String get equipWeighted => 'Com peso';

  @override
  String get equipBand => 'Faixa elástica';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipOther => 'Outros';

  @override
  String get diffBeginner => 'Iniciante';

  @override
  String get diffAdvanced => 'Avançado';

  @override
  String get diffIntermediate => 'Intermediário';

  @override
  String get about => 'SOBRE';

  @override
  String version(String v) {
    return 'Versão $v';
  }

  @override
  String get aboutBlurb => 'Feito por quem treina, para quem treina.';

  @override
  String get freeForever => 'Gratuito para sempre';

  @override
  String get freeForeverWhy => 'Sem assinatura, sem anúncios, nada bloqueado por um paywall.';

  @override
  String get fullyOffline => 'Totalmente offline';

  @override
  String get fullyOfflineWhy => 'Sem conta, sem servidores. Seu treino nunca sai deste celular.';

  @override
  String get yoursToTake => 'Seus dados são seus';

  @override
  String get yoursToTakeWhy => 'Exporte-os para CSV quando quiser e apague tudo com um único toque.';

  @override
  String get whatsInside => 'O QUE HÁ DENTRO';

  @override
  String exercisesInside(int n) {
    return '$n exercícios';
  }

  @override
  String get exercisesInsideWhy => 'Todos com animação e instruções passo a passo.';

  @override
  String get calculatorsInside => '6 calculadoras';

  @override
  String get calculatorsInsideWhy =>
      '1RM, pesos, IMC, calorias, gordura corporal e aquecimento — tudo com fórmulas publicadas.';

  @override
  String get mathInside => 'Matemática honesta';

  @override
  String get mathInsideWhy =>
      'Volume, recordes e sequências vêm das suas próprias séries. Nada aqui é decoração.';

  @override
  String get yourNumbers => 'SEUS NÚMEROS';

  @override
  String get sessionsCaps => 'SESSÕES';

  @override
  String get liftedCaps => 'LEVANTADO';

  @override
  String get streakCaps => 'SÉRIE';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'dias', one: 'dia');
    return '$_temp0';
  }

  @override
  String get restDefaultLabel => 'Descanso';

  @override
  String restDefault(int s) {
    return 'O padrão é ${s}s — altere em Configurações';
  }

  @override
  String get reset => 'REINICIAR';

  @override
  String get welcomeKicker => 'BEM-VINDO AO';

  @override
  String get welcomeBlurb => 'Tudo fica no seu celular. Sem conta, sem internet, sem nada para pagar.';

  @override
  String get welcomeStart => 'COMECE AGORA';

  @override
  String onbStep(int i, int n) {
    return 'PASSO $i DE $n';
  }

  @override
  String get onbNameTitle => 'Como podemos chamá-lo?';

  @override
  String get onbNameHint => 'Seu nome';

  @override
  String get onbNameWhy => 'Usado apenas para cumprimentá-lo. Nunca sai do celular.';

  @override
  String get onbBodyTitle => 'Alguns números';

  @override
  String get onbBodyWhy =>
      'Eles alimentam as calculadoras. Você pode alterá-los a qualquer momento em Configurações.';

  @override
  String get onbGoalTitle => 'Com que frequência você treina?';

  @override
  String get onbGoalWhy => 'Define sua meta semanal. Seja honesto, não ambicioso.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões por semana',
      one: '$n sessão por semana',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Quilos ou libras?';

  @override
  String get next => 'PRÓXIMO';

  @override
  String get back => 'VOLTAR';

  @override
  String get skip2 => 'Pular';

  @override
  String get madeWithLoveBy => 'MADE WITH LOVE BY';

  @override
  String get sourceCode => 'SOURCE CODE';

  @override
  String get suggested => 'SUGGESTED';

  @override
  String get results => 'RESULTS';

  @override
  String get noMatches => 'No exercise matches that search.';

  @override
  String get tapToEdit => 'Tap the pencil to fix an entry, or the bin to remove it.';

  @override
  String get editEntry => 'Edit';

  @override
  String get editEntryHint => 'Fix the reps or the weight of any set.';

  @override
  String get removeSet => 'Remove set';

  @override
  String get continueWorkout => 'CONTINUE';

  @override
  String get continueWorkoutBody =>
      'The workout goes back to being in progress, with its sets already ticked. Finishing it again saves it on its original day.';

  @override
  String get addBodyWidget => 'Add muscle map widget';

  @override
  String get repsOnly => 'Reps only';

  @override
  String get repsOnlyHint => 'Log this exercise without weight.';

  @override
  String get useDefaultArt => 'Back to the default art';

  @override
  String daysShort(int n) {
    return '${n}d';
  }
}
