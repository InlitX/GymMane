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
  String get tapMuscles => 'Toque nos músculos que deseja treinar, frente e costas.';

  @override
  String get continueBtn => 'CONTINUAR';

  @override
  String get nothingForFocus => 'Ainda não há nada para este foco';

  @override
  String get goBackPick => 'Volte e escolha um músculo com exercícios na sua biblioteca.';

  @override
  String pickedHint(int n) {
    return 'Escolhemos uma sessão para você. Toque para adicionar ou remover qualquer um dos $n.';
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
  String get setDone => 'SÉRIE FEITA';

  @override
  String get nextExercise => 'PRÓXIMO';

  @override
  String get dropExerciseAction => 'Remover exercício';

  @override
  String get restOff => 'Desligado';

  @override
  String get miniRest => 'Descanso em rest-pause e cluster';

  @override
  String get miniRestHint => 'Antes de séries rest-pause ou cluster';

  @override
  String get gymPass => 'Passe do ginásio';

  @override
  String get gymPassEmpty => 'Guarda aqui o código do teu ginásio e entra sem tirar o cartão';

  @override
  String get gymPassAdd => 'Adicionar passe';

  @override
  String get gymPassScan => 'Tirar foto ao código';

  @override
  String get gymPassScanHint => 'Com a câmara do telemóvel';

  @override
  String get gymPassPhoto => 'De uma foto ou captura de ecrã';

  @override
  String get gymPassPhotoHint => 'Por exemplo, uma captura da app do teu ginásio';

  @override
  String get gymPassType => 'Escrever o número';

  @override
  String get gymPassTypeHint => 'Para códigos de barras: o número impresso por baixo';

  @override
  String get gymPassNotFound => 'Não há nenhum QR nessa imagem. Tenta outra mais nítida ou escreve o número.';

  @override
  String get gymPassName => 'Nome do ginásio';

  @override
  String get gymPassDefaultName => 'O meu ginásio';

  @override
  String get gymPassCode => 'Código';

  @override
  String get gymPassFormat => 'Tipo de código';

  @override
  String get gymPassInvalid => 'Esse número não serve para este tipo de código';

  @override
  String get gymPassShowHint => 'Aproxima-o do leitor. O brilho sobe sozinho.';

  @override
  String get gymPassDeleted => 'Passe apagado';

  @override
  String get gymPassEdit => 'Editar passe';

  @override
  String get gymPassShow => 'Mostrar à entrada';

  @override
  String get gymPassPrivate => 'Fica só no teu telemóvel. Nada é enviado.';

  @override
  String get gymPassColor => 'Cor';

  @override
  String get gymPassRescan => 'Ler o código outra vez';

  @override
  String get gymPassReading => 'A ler o código…';

  @override
  String get gymPassSettingHint => 'O teu cartão do ginásio no perfil';

  @override
  String get gymPassMember => 'Sócio';

  @override
  String get widgetHintActivity => 'O teu mapa de dias treinados';

  @override
  String get widgetHintStats => 'Sequência, volume e sessões desta semana';

  @override
  String get widgetHintBody => 'Os músculos que trabalhaste';

  @override
  String get widgetHintToday => 'De relance: treinaste hoje?';

  @override
  String get widgetHintWeek => 'O plano da semana, dia a dia';

  @override
  String get supportHintBug => 'Diz-me o que falhou, no GitHub';

  @override
  String get supportHintFeature => 'Sugere uma ideia para a app';

  @override
  String get supportHintStar => 'Ajuda mais pessoas a encontrá-la';

  @override
  String get supportHintCoffee => 'Apoia o desenvolvimento. Grátis e sem anúncios';

  @override
  String get bodyweightNoteHint =>
      'Adiciona uma nota: como te sentes, o que estás a experimentar… (opcional)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Usar $unit neste exercício';
  }

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
  String get finishBodyGoal => 'Você cumpriu todas as sessões que se propôs a fazer esta semana.';

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
  String get notifRestChannelWhy => 'Avisa quando o seu descanso entre as séries terminar';

  @override
  String get notifAlertChannel => 'Temporizador de descanso (alerta)';

  @override
  String get notifAlertChannelWhy => 'Exibe um banner no momento em que o seu descanso terminar';

  @override
  String get restOverTitle => 'Descanso encerrado';

  @override
  String get restOverBody => 'De volta ao treino, a próxima série está esperando.';

  @override
  String get allTimeSessions => 'SESSÕES';

  @override
  String get allTimeTime => 'TEMPO';

  @override
  String get allTimeSets => 'SÉRIE';

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
  String get days90 => '90D';

  @override
  String get days365 => '1A';

  @override
  String get daysAll => 'Tudo';

  @override
  String get weeklyAvgTitle => 'Média por semana';

  @override
  String weekOfDate(String date) {
    return 'Semana de $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change neste período';
  }

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
  String get personalRecords => 'RECORDES PESSOAIS';

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
  String get restDay => 'Dia de descanso, nada registrado.';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteEntry => 'Excluir este registro?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" será removido deste dia, bem como de seus registros e gráficos.';
  }

  @override
  String get bodyweightHistory => 'HISTÓRICO';

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
  String get kindLabel => 'TIPO';

  @override
  String get kindStrength => 'Força';

  @override
  String get kindCalisthenics => 'Calistenia';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Alongamento';

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
  String get quickAddAmount => 'How much you had';

  @override
  String get homeCardsTitle => 'Cartões do Início';

  @override
  String get homeCardsHint => 'O que você ativar aparece no Início';

  @override
  String get homeCardFocus => 'Hoje';

  @override
  String get homeCardSteps => 'Passos';

  @override
  String get homeCardWeek => 'Esta semana';

  @override
  String get homeCardRoutines => 'Rotinas';

  @override
  String get homeCardRecommended => 'Sugeridos';

  @override
  String get textSizeSetting => 'Tamanho do texto';

  @override
  String get textSizeSmall => 'Pequeno';

  @override
  String get textSizeNormal => 'Normal';

  @override
  String get textSizeLarge => 'Grande';

  @override
  String get textSizeHint => 'Além do tamanho de texto do celular';

  @override
  String get calmMotionSetting => 'Reduzir animações';

  @override
  String get calmMotionHint => 'As telas aparecem sem deslizar';

  @override
  String get dishArchive => 'Archive';

  @override
  String get dishUnarchive => 'Restore';

  @override
  String get dishArchivedToast => 'Dish archived';

  @override
  String get filterShowLabel => 'Mostrar';

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
  String notHere(String gear, String place) {
    return 'Sem $gear no $place';
  }

  @override
  String get notHereWhy => 'Troque por algo que você realmente consiga puxar hoje.';

  @override
  String get altHere => 'O QUE VOCÊ PODE FAZER AQUI';

  @override
  String get places => 'MEUS LOCAIS';

  @override
  String get placesHint =>
      'Diga o que você tem em cada lugar e a biblioteca mostrará apenas o que você realmente pode fazer ali.';

  @override
  String get placeAll => 'Qualquer lugar';

  @override
  String get placeNew => 'Novo lugar';

  @override
  String get placeNamePlaceholder => 'Casa, academia, parque…';

  @override
  String get placeGearLabel => 'O QUE HÁ LÁ';

  @override
  String placeExercises(int n) {
    return '$n exercícios aqui';
  }

  @override
  String get placeEmptyTitle => 'Treine onde quer que você esteja';

  @override
  String get placeEmptyBody =>
      'Um lugar é uma lista dos equipamentos que você possui ali. Escolha um para começar e edite-o mais tarde.';

  @override
  String get placeDeleteTitle => 'Deletar lugar';

  @override
  String get placeDeleteBody => 'Apenas o lugar muda. Seus exercícios e sessões permanecem.';

  @override
  String get placeGym => 'Academia';

  @override
  String get placeHome => 'Casa';

  @override
  String get placeOutdoors => 'Ao ar livre';

  @override
  String get placeFilterLabel => 'LUGAR';

  @override
  String get noGearOnly => 'Sem kit';

  @override
  String placeActive(String name) {
    return 'Treinando na/em $name';
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
      zero: 'Sem notas',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Nota';

  @override
  String get noteKindPlan => 'Plano';

  @override
  String get noteKindDone => 'Vitoria';

  @override
  String get noteKindPain => 'Incômodo';

  @override
  String get noteFilterAll => 'Tudo';

  @override
  String get newNote => 'Nova nota';

  @override
  String get editNote => 'Editar nota';

  @override
  String get addNote => 'ADICIONAR NOTA';

  @override
  String get noteEmptyTitle => 'Nada escrito ainda';

  @override
  String get noteEmptyBody =>
      'Dicas, planos para a próxima vez, como foi a sessão. Com fotos ou vídeo, se desejar.';

  @override
  String get noteNoneForExercise => 'Ainda não há anotações sobre este exercício.';

  @override
  String get noteKindLabel => 'TIPO';

  @override
  String get noteTextLabel => 'NOTA';

  @override
  String get noteDateLabel => 'DATA';

  @override
  String get noteExerciseLabel => 'EXERCÍCIO';

  @override
  String get noteMediaLabel => 'FOTO & VIDEO';

  @override
  String get noteGeneral => 'Sem exercício';

  @override
  String get noteAttach => 'Anexar';

  @override
  String get noteRemoveMedia => 'Remover anexo';

  @override
  String get deleteNoteTitle => 'Deletar nota';

  @override
  String get deleteNoteBody => 'O nota e tudo o que estiver anexado a ela serão perdidos para sempre.';

  @override
  String get noteToday => 'Hoje';

  @override
  String get noteYesterday => 'Ontem';

  @override
  String get noteAllNotes => 'Todas as notas';

  @override
  String get noteCalendar => 'Calendario';

  @override
  String get noteNoneOnDay => 'Nada escrito neste dia';

  @override
  String get noteAddOnDay => 'Nota desse dia';

  @override
  String get notePrevMonth => 'Mês passado';

  @override
  String get noteNextMonth => 'Próximo mês';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notas neste mês',
      one: '1 nota esse mês',
      zero: 'Sem notas neste mês',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'MEDIDAS';

  @override
  String get measuresHint => 'Do pescoço à panturrilha: veja as mudanças no seu corpo, não apenas na barra.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n leituras',
      one: '1 leitura',
      zero: 'Nada registrado',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Nada registrado ainda';

  @override
  String get measureHistory => 'HISTÓRICO';

  @override
  String get measureNeck => 'Pescoço';

  @override
  String get measureShoulders => 'Ombros';

  @override
  String get measureChest => 'Peito';

  @override
  String get measureArm => 'Braço';

  @override
  String get measureForearm => 'Antebraço';

  @override
  String get measureWaist => 'Cintura';

  @override
  String get measureHips => 'Quadris';

  @override
  String get measureThigh => 'Coxas';

  @override
  String get measureCalf => 'Panturrilha';

  @override
  String get measureBodyfat => 'Gordura corporal';

  @override
  String get timeline => 'LINHA DO TEMPO';

  @override
  String get hidePhotos => 'Ocultar fotos';

  @override
  String get showPhotos => 'Mostrar fotos';

  @override
  String get timelineHint => 'Mesma pose, mesmo lugar, mesma luz. Daqui a um ano você não vai acreditar.';

  @override
  String get timelineEmptyTitle => 'Sua primeira foto inicia a contagem.';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotos',
      one: '1 foto',
      zero: 'Sem fotos',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Frente';

  @override
  String get poseSide => 'Lado';

  @override
  String get poseBack => 'Costas';

  @override
  String get photoEvery => 'LEMBRE-ME';

  @override
  String photoEveryDays(int n) {
    return 'A cada $n dias';
  }

  @override
  String get photoEveryOff => 'Nunca';

  @override
  String get timelineEvery => 'AGRUPAR A CADA';

  @override
  String get custom => 'Outro';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Proxima foto em $n dias',
      one: 'Proxima foto amanhã',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Devendo uma foto: tire uma hoje mesmo';

  @override
  String get addTodayPhotos => 'ADICIONAR AS FOTOS DE HOJE';

  @override
  String posePhoto(String pose) {
    return 'foto de $pose';
  }

  @override
  String get compare => 'COMPARE';

  @override
  String get compareNeedTwo => 'Fotografe a mesma pose em dois dias diferentes e compare elas aqui.';

  @override
  String dayNumber(int n) {
    return 'Dia $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n dias de diferença',
      one: '1 dia de diferença',
      zero: 'Mesmo dia',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Apague este dia';

  @override
  String get deleteDayBody => 'As fotos vão embora, para sempre.';

  @override
  String get timelinePhotos => 'Fotos';

  @override
  String get timelineBody => 'Mapa muscular';

  @override
  String get timelineBodyEmpty =>
      'Registre uma sessão e seu mapa muscular começará a ser preenchido aqui, sem precisar de fotos.';

  @override
  String get timelineBodyHint => 'Construído a partir de suas séries, nada de uploads.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões',
      one: '1 sessão',
      zero: 'Sem sessões',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Fotos de progresso';

  @override
  String get notifPhotoChannelWhy => 'Um lembrete para quando a próxima foto de progresso estiver próxima.';

  @override
  String get notifPhotoTitle => 'Chegou a hora da sua foto de progresso';

  @override
  String notifPhotoBody(int n) {
    return '$n Dias desde a última. Mesma pose, mesma luz.';
  }

  @override
  String get share => 'COMPARTILHAR';

  @override
  String get sharePick => 'O que você quer mostrar?';

  @override
  String get shareStreak => 'Sequência e consistência';

  @override
  String get shareBody => 'Músculos trabalhados';

  @override
  String get shareCompare => 'Antes e depois';

  @override
  String get shareHint =>
      'O cartão é criado no seu celular. Nada sai de lá até que você escolha para onde vai.';

  @override
  String get shareFailed => 'O cartão não pôde ser construído.';

  @override
  String get shareWeekOf => 'ÚLTIMOS 7 DIAS';

  @override
  String get shareStreakLabel => 'SEQUÊNCIA DE DIAS';

  @override
  String get shareSessionsLabel => 'SESSÕES';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get restForExercise => 'DESCANSO PARA ESTE EXERCÍCIO';

  @override
  String get restUsingDefault => 'Usando seu padrão';

  @override
  String get restCustom => 'Só para este';

  @override
  String get setType => 'TIPO DE SÉRIE';

  @override
  String get setTypeNormal => 'Trabalho';

  @override
  String get setTypeWarmup => 'Aquecimento';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'Até a falha';

  @override
  String get addWarmup => 'AQUECIMENTO';

  @override
  String platesPerSide(String plates) {
    return 'Por lado: $plates';
  }

  @override
  String get howTo => 'PASSO A PASSO';

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
  String get dragToReorder => 'Arrasta a pega de pontos para reordenar: é a ordem em que treinas.';

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
  String get resetData => 'Excluir todos os meus dados';

  @override
  String get resetTitle => 'Excluir tudo?';

  @override
  String get resetBody =>
      'Sessões, registros, rotinas, notas e perfil. Isso não pode ser desfeito: exporte um backup primeiro, caso queira mantê-lo';

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
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get lightTheme => 'Claro';

  @override
  String get amoledTheme => 'Preto AMOLED';

  @override
  String get editDuration => 'Duração do treino';

  @override
  String get sessionName => 'Nome do treino';

  @override
  String get nameWorkout => 'Dar nome';

  @override
  String get sessionNameHint => 'ex.: Pernas, Empurrar, Corpo inteiro';

  @override
  String get secondaryPickHint => 'Toque nos outros músculos que este exercício trabalha.';

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
  String get alarmSoundHint => 'Use o seu próprio som, até 15 segundos';

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
  String get importUnknownFormat => 'Esse arquivo precisa de colunas de data, exercício, repetições e peso';

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
  String get onbUnitsWhy => 'Para pesos, medidas e distâncias. Podes mudar quando quiseres nas Definições.';

  @override
  String get nameLabel => 'NOME';

  @override
  String get sexLabel => 'SEXO';

  @override
  String get macroProtein => 'PROTEÍNA';

  @override
  String get macroCarbs => 'CARBOIDRATOS';

  @override
  String get macroFat => 'GORDURA';

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
  String get backupImported => 'Backup importado';

  @override
  String get backupFailed => 'Não foi possível ler esse backup';

  @override
  String get nothingToExport => 'Ainda não há nada para exportar: registre uma sessão primeiro';

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
  String get muscleLowerBack => 'Lombar';

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
  String get equipRings => 'Argolas';

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
  String get calculatorsInside => '10 calculadoras';

  @override
  String get calculatorsInsideWhy =>
      '1RM, pesos, IMC, calorias, gordura corporal, FFMI, aquecimento, carga por RPE e pontuações de força DOTS e Wilks, tudo com fórmulas publicadas.';

  @override
  String get mathInside => 'Matemática honesta';

  @override
  String get mathInsideWhy =>
      'Volume, recordes e sequências vêm das suas próprias séries. Nada aqui é falso.';

  @override
  String get streakCaps => 'SÉRIE';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'dias', one: 'dia');
    return '$_temp0';
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
  String get onbNameTitle => 'Como podemos chamá-lo(a)?';

  @override
  String get onbNameHint => 'Seu nome';

  @override
  String get onbPhotoAdd => 'Adicionar foto';

  @override
  String get onbPhotoChange => 'Trocar foto';

  @override
  String get onbPhotoTitle => 'Coloque um rosto no seu perfil';

  @override
  String get onbPhotoWhy => 'Opcional. Fica no celular e você pode trocar quando quiser pelo perfil.';

  @override
  String get onbPhotoLater => 'MAIS TARDE';

  @override
  String get onbNameWhy => 'Usado apenas para cumprimentá-lo(a). Nunca sai do seu celular.';

  @override
  String get onbBodyTitle => 'Alguns números';

  @override
  String get onbBodyWhy =>
      'Eles alimentam as calculadoras. Você pode alterá-los a qualquer momento nas Configurações.';

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
  String get madeWithLoveBy => 'FEITO COM AMOR POR';

  @override
  String get sourceCode => 'CÓDIGO-FONTE';

  @override
  String get suggested => 'SUGERIDO';

  @override
  String get results => 'RESULTADOS';

  @override
  String get noMatches => 'Nenhum exercício corresponde a essa pesquisa.';

  @override
  String get tapToEdit => 'Toque no lápis para consertar uma entrada ou na lixeira para removê-la.';

  @override
  String get editEntry => 'Editar';

  @override
  String get editEntryHint => 'Ajuste as repetições ou o peso de qualquer série.';

  @override
  String get removeSet => 'Remover série';

  @override
  String get continueWorkout => 'CONTINUAR';

  @override
  String get continueWorkoutBody =>
      'O treino volta a ficar em andamento, com as séries já concluídas. Finalizá-lo novamente o salva no dia original.';

  @override
  String get addBodyWidget => 'Adicionar widget do mapa muscular';

  @override
  String get repsOnly => 'Somente repetições';

  @override
  String get repsOnlyHint => 'Registre este exercício sem peso.';

  @override
  String get eachSide => 'Cada lado';

  @override
  String get eachSideHint => 'O tempo corre uma vez por lado e o descanso começa depois dos dois.';

  @override
  String get useDefaultArt => 'Voltar à arte padrão';

  @override
  String daysShort(int n) {
    return '${n}d';
  }

  @override
  String get focusCard => 'O foco de hoje';

  @override
  String get autoAdvance => 'Avançar ao próximo sozinho';

  @override
  String get keepScreenOn => 'Manter a tela ligada durante o treino';

  @override
  String get lockWorkout => 'Bloquear a tela';

  @override
  String get unlockWorkout => 'Desbloquear';

  @override
  String get holdToUnlock => 'Pressione para desbloquear';

  @override
  String get liveChannel => 'Treino em andamento';

  @override
  String get liveChannelWhy => 'Mostra o exercício, a série e o descanso enquanto treina';

  @override
  String liveSet(int n, int total) {
    return 'Série $n de $total';
  }

  @override
  String get liveResting => 'Descansando';

  @override
  String get liveAllDone => 'Séries concluídas';

  @override
  String get autoAdvanceHint => 'Avança após a última série';

  @override
  String get placePlates => 'Discos e barra';

  @override
  String get platesAll => 'Tudo disponível';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n medidas', one: '$n medida');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PARES';

  @override
  String plateAchievable(String w) {
    return 'O mais perto que consegue carregar: $w';
  }

  @override
  String get autoWarmup => 'Começar com aquecimento';

  @override
  String get autoWarmupHint => 'Adiciona as séries de aquecimento ao abrir o treino.';

  @override
  String get trainReminder => 'Aviso para treinar';

  @override
  String get trainReminderHint => 'Um aviso nesta hora, só nos dias com rotina planejada.';

  @override
  String get reminderExactTime => 'Hora exata';

  @override
  String get toastSoundSetting => 'Som dos avisos';

  @override
  String get toastSoundHint => 'Um toque suave a cada aviso';

  @override
  String get notifTrainChannel => 'Aviso para treinar';

  @override
  String get notifTrainChannelWhy => 'Um toque para treinar nos dias que planejou.';

  @override
  String get notifTrainTitle => 'Hora de treinar';

  @override
  String get notifTrainBody => 'A sua rotina está te esperando.';

  @override
  String get planIntro => 'Faça-me uma rotina de treino usando só os exercícios desta lista.';

  @override
  String get planFormat => 'Responda só em JSON, seguindo este formato:';

  @override
  String get planNothing => 'Nenhum exercício desse arquivo está na sua biblioteca';

  @override
  String get planFailed => 'Esse arquivo não é formatado em uma rotina aceita';

  @override
  String get routineGroup => 'Grupo';

  @override
  String get newGroup => 'Novo grupo';

  @override
  String get noGroup => 'Sem grupo';

  @override
  String get groupNameHint => 'Empurrar / Puxar / Pernas, 5×5…';

  @override
  String get filters => 'Filtros';

  @override
  String get setsPlannedHint => 'Escolha quantas séries quer de cada um. O treino abre com elas prontas.';

  @override
  String get nextTime => 'PRÓXIMO';

  @override
  String get nextHold => 'o mesmo peso até completar todas as repetições';

  @override
  String get bgPhoto => 'A sua foto';

  @override
  String get bgPhotoPick => 'Escolher uma foto';

  @override
  String get bgPhotoChange => 'Mudar a foto';

  @override
  String get bgPhotoRemove => 'Tirar a foto';

  @override
  String get bgDim => 'QUANTO ESCURECE';

  @override
  String get dimSoft => 'Suave';

  @override
  String get dimMedium => 'Média';

  @override
  String get dimStrong => 'Forte';

  @override
  String get bgPhotoHint => 'Fica atrás de tudo, escurecida, para o app continuar legível.';

  @override
  String get reminderSmart => 'Inteligente';

  @override
  String get reminderFixed => 'Hora fixa';

  @override
  String get reminderSmartHint =>
      'Usa os dias e a hora em que você costuma treinar e não notifica se você já treinou nesse dia.';

  @override
  String get reminderSmartEmpty => 'Treine mais algumas vezes o app vai aprender a sua rotina.';

  @override
  String habitFocus(String day) {
    return 'o que costuma fazer às $day';
  }

  @override
  String get duplicateRoutine => 'Duplicar a rotina';

  @override
  String copySuffix(String name) {
    return '$name (cópiar)';
  }

  @override
  String get saveAsRoutine => 'GUARDAR COMO ROTINA';

  @override
  String get savedAsRoutine => 'Guardada como rotina';

  @override
  String get templates => 'Planos prontos';

  @override
  String get templatesHint => 'Programas clássicos, montados com a sua biblioteca. Depois Poderá mudar tudo.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rotinas adicionadas',
      one: '$n rotina adicionada',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Três dias de corpo inteiro por semana. Por onde se começa.';

  @override
  String get tplPpl => 'Empurrar, puxar e pernas. Três ou seis dias por semana.';

  @override
  String get tplArnold => 'Peito e costas, ombros e braços, pernas. O clássico split de seis dias.';

  @override
  String get tplUpperlower => 'Superior e inferior, quatro dias por semana.';

  @override
  String get tplStronglifts => 'Dois treinos, cinco séries de cinco, alternados.';

  @override
  String get tplStartingstrength => 'Agachamento em todos, dois treinos que se alternam.';

  @override
  String get tplHome => 'Só uma barra para se pendurar e o chão.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dias', one: '$n dia');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Registar o esforço (RPE)';

  @override
  String get rpeHint => '10 é não conseguir fazer mais nenhuma repetição; 8, é que sobravam duas.';

  @override
  String get superset => 'Supersérie';

  @override
  String get supersetLink => 'Encadear com o próximo';

  @override
  String get supersetUnlink => 'Separar do próximo';

  @override
  String get supersetHint => 'Sem descanso entre exercícios encadeados: passa logo ao próximo.';

  @override
  String get aiRoutine => 'Rotina com IA';

  @override
  String get aiIntro =>
      'O GymMane não fala com nenhuma IA. Você copia a sua lista de exercícios, cola no assistente que a usa e traz a resposta de volta. Do seu celular não sai nada sozinho.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n nomes não estavam na sua biblioteca',
      one: '1 nome não estava na sua biblioteca',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Quais apps lemos';

  @override
  String get importOtherCsv => 'Qualquer outro CSV com data, exercício, repetições e peso';

  @override
  String get importAskApp => 'Precisa de outro app? Peça-me';

  @override
  String get awardFirstStepName => 'Primeiro passo';

  @override
  String get awardFirstStepLine => 'Bem-vindo ao GymMane. Esta é por conta da casa.';

  @override
  String get awardFirstWorkoutName => 'Primeiro treino';

  @override
  String get awardFirstWorkoutLine => 'O primeiro já está registado. Esse é a parte difícil.';

  @override
  String get awardFirstRoutineName => 'Primeira rotina';

  @override
  String get awardFirstRoutineLine => 'Já tem um plano para voltar.';

  @override
  String get awardFirstRecordName => 'Primeiro recorde';

  @override
  String get awardFirstRecordLine => 'Superou a sua melhor marca num exercício.';

  @override
  String get awardStreak3Name => 'Três seguidos';

  @override
  String get awardStreak3Line => 'Três dias seguidos. É assim que se começa.';

  @override
  String get awardTonne1Name => 'Uma tonelada';

  @override
  String get awardTonne1Line => 'Mil quilos levantados entre todas as suas séries.';

  @override
  String get awardSets100Name => 'Cem séries';

  @override
  String get awardSets100Line => 'Cem séries concluídas, uma a uma.';

  @override
  String get awardHours10Name => 'Dez horas';

  @override
  String get awardHours10Line => 'Dez horas de treino cronometradas.';

  @override
  String get awardWorkouts50Name => 'Cinquenta treinos';

  @override
  String get awardWorkouts50Line => 'Cinquenta sessões nas suas costas.';

  @override
  String get awardHours50Name => 'Cinquenta horas';

  @override
  String get awardHours50Line => 'Cinquenta horas dentro da academia.';

  @override
  String get awardsTitle => 'Medalhas';

  @override
  String get yearTitle => 'O teu ano';

  @override
  String get yearBestMonth => 'Melhor mês';

  @override
  String get yearMonths => 'meses';

  @override
  String get awardSpinHint => 'Arraste a medalha para girá-la';

  @override
  String get awardUnlocked => 'Nova conquista desbloqueada';

  @override
  String get awardNice => 'Boa!';

  @override
  String get awardSaveImage => 'Guardar imagem';

  @override
  String get awardSaved => 'Guardada na sua galeria';

  @override
  String get awardStreak7Name => 'Sete dias';

  @override
  String get awardStreak7Line => 'Uma semana inteira sem falhar um dia.';

  @override
  String get awardStreak30Name => 'Trinta dias';

  @override
  String get awardStreak30Line => 'Um mês seguido. Agora já é hábito.';

  @override
  String get awardWorkouts100Name => 'Cem treinos';

  @override
  String get awardWorkouts100Line => 'Cem sessões registradas do início ao fim.';

  @override
  String get awardTonnes100Name => 'Cem toneladas';

  @override
  String get awardTonnes100Line => 'Tudo o que você levantou soma 100.000 kg.';

  @override
  String get awardSets1000Name => 'Mil séries';

  @override
  String get awardSets1000Line => 'Série a série, até mil.';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get pickBadge => 'Selo';

  @override
  String get statWorkouts => 'Treinos';

  @override
  String get statTrained => 'Treinada';

  @override
  String get statSets => 'Séries';

  @override
  String get statLifted => 'Levantado';

  @override
  String get statStreak => 'Sequência';

  @override
  String get statDays => 'dias';

  @override
  String get unitHours => 'h';

  @override
  String get unitDays => 'dias';

  @override
  String get snapshots => 'Fotos';

  @override
  String get snapNow => 'Tirar uma';

  @override
  String get addCover => 'Adicionar capa';

  @override
  String get addTodayWidget => 'Hoje: feito ou não';

  @override
  String get photosCard => 'Suas fotos';

  @override
  String get handleLabel => 'Nome de usuário';

  @override
  String get setupTitle => 'Preencha isto e o resto da página se preenche sozinho';

  @override
  String get setupHint => 'Cada número daqui vem do que você registra. Nada é enviado a lugar nenhum.';

  @override
  String get setupWorkout => 'Registre seu primeiro treino';

  @override
  String get setupWeight => 'Anote seu peso';

  @override
  String get setupMeasures => 'Tire suas medidas';

  @override
  String get setupPhoto => 'Tire sua primeira foto de progresso';

  @override
  String get progressTitle => 'Progresso';

  @override
  String get tileVolume30 => 'Volume · 30d';

  @override
  String get tileAddWeight => 'Anote o seu';

  @override
  String get heatToneTitle => 'Cor do mapa';

  @override
  String get heatToneHint => 'Só muda como a grade e o corpo são pintados.';

  @override
  String get thisWeekTitle => 'Esta semana';

  @override
  String get momentsEmptyTitle => 'Ainda não há nada aqui';

  @override
  String get deletePhotoTitle => 'Apagar esta foto?';

  @override
  String get deletePhotoBody => 'Vai embora para sempre.';

  @override
  String get awardsEarned => 'Conquistadas';

  @override
  String get awardsLocked => 'A conquistar';

  @override
  String get awardStreak100Name => 'Cem dias';

  @override
  String get awardWorkouts10Name => 'Dez treinos';

  @override
  String get awardWorkouts10Line => 'Os dez primeiros são os que decidem.';

  @override
  String get awardWorkouts365Name => 'Trezentos e sessenta e cinco';

  @override
  String get awardWorkouts365Line => 'Um treino para cada dia do ano, registrados um a um.';

  @override
  String get awardTonnes10Name => 'Dez toneladas';

  @override
  String get awardTonnes10Line => 'Dez mil quilos já passaram pelas suas mãos.';

  @override
  String get awardHours100Name => 'Cem horas';

  @override
  String get awardHours100Line => 'Cem horas debaixo da barra, cronômetro na mão.';

  @override
  String awardWonOn(String date) {
    return 'Conquistada em $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Dourado',
      'blue': 'Azul',
      'green': 'Verde',
      'other': 'Selo',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Desde $date';
  }

  @override
  String levelShort(int n) {
    return 'Nível $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treinos para o nível $next',
      one: '1 treino para o nível $next',
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
      'mono': 'Cinza',
      'other': 'Cor',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n séries';
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
    return '$n selecionadas';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Apagar $n fotos?';
  }

  @override
  String get momentsEmptyHint =>
      'Fotografe a academia, o quadro, como montou a barra… o que quiser lembrar. Ficam no seu celular e só você vê.';

  @override
  String get awardStreak100Line => 'Cem dias seguidos. Isso já não é motivação, é quem você é.';

  @override
  String get coverLabel => 'CAPA';

  @override
  String get removeCover => 'Tirar capa';

  @override
  String get startTitle => 'Iniciar treino';

  @override
  String get logTitle => 'Registrar um treino';

  @override
  String get logHint => 'Sem cronômetro, só preencha o que você fez.';

  @override
  String get orStartFrom => 'Ou comece por';

  @override
  String get pickExercisesOption => 'Escolher exercícios';

  @override
  String get chooseFocusOption => 'Escolher por músculos';

  @override
  String get plannedRoutine => 'PLANEJADA';

  @override
  String get logWorkoutAction => 'REGISTRAR UM TREINO';

  @override
  String get logging => 'REGISTRANDO';

  @override
  String get placesLabel => 'Meus locais';

  @override
  String get undo => 'Desfazer';

  @override
  String get deleteSet => 'Excluir série';

  @override
  String get setDeleted => 'Série excluída';

  @override
  String get removeWarmup => 'Tirar aquecimento';

  @override
  String get addWeightAction => 'Adicionar peso';

  @override
  String get workoutOverview => 'Este treino';

  @override
  String get allExercisesShort => 'Todos';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total séries';
  }

  @override
  String get nowLabel => 'Agora';

  @override
  String get deleteWorkout => 'Excluir treino';

  @override
  String get deleteWorkoutBody => 'Este treino e todas as suas séries serão removidos do histórico.';

  @override
  String get themeAuto => 'Auto';

  @override
  String get themeAutoHint => 'Segue o celular';

  @override
  String get demoSizeTitle => 'Demonstração durante o treino';

  @override
  String get demoLarge => 'Grande';

  @override
  String get demoSmall => 'Pequena';

  @override
  String get demoOff => 'Oculta';

  @override
  String get demoLoopTitle => 'Animação da demo';

  @override
  String get demoLoopAlways => 'Em loop';

  @override
  String get demoLoopShort => '10 segundos';

  @override
  String get demoLoopHint =>
      'Mexe-se durante cerca de 10 segundos e para na posição inicial. Toca na demo para a voltar a ver.';

  @override
  String get alarmStyleTitle => 'Quando o descanso acaba';

  @override
  String get alarmStyleLoud => 'Tocar sempre';

  @override
  String get alarmStyleQuiet => 'Respeitar o modo silencioso';

  @override
  String get alarmStyleVibrate => 'Só vibrar';

  @override
  String get alarmStyleHint =>
      '«Tocar sempre» usa o volume de alarme, mesmo no silencioso. «Respeitar o modo silencioso» usa o volume de notificações e, com o celular no mudo, só vibra.';

  @override
  String get suggestedPicks => 'Sugeridos para você';

  @override
  String get moreOptions => 'Mais opções';

  @override
  String get suggestInWorkouts => 'Sugerir em treinos rápidos';

  @override
  String get suggestInWorkoutsHint =>
      'Desligado, não aparece nas sugestões. Você ainda pode adicioná-los manualmente.';

  @override
  String get onbPlaceTitle => 'Onde você treina?';

  @override
  String get onbPlaceWhy =>
      'Marque todos os lugares onde você treina. Só vamos sugerir o que dá para fazer em cada um.';

  @override
  String get onbPlaceGear => 'O que você tem lá?';

  @override
  String distanceCol(String unit) {
    return 'DISTÂNCIA ($unit)';
  }

  @override
  String get timeCol => 'TEMPO';

  @override
  String get timePerSideCol => 'TEMPO / LADO';

  @override
  String get timeMinutesTitle => 'Tempo (minutos)';

  @override
  String get timeSecondsTitle => 'Tempo (segundos)';

  @override
  String distanceTitle(String unit) {
    return 'Distância ($unit)';
  }

  @override
  String get holdLabel => 'Segure';

  @override
  String get stopLabel => 'Parar';

  @override
  String startHold(String time) {
    return 'Começar · $time';
  }

  @override
  String get exerciseTypeLabel => 'Registrar por';

  @override
  String get typeReps => 'Repetições e peso';

  @override
  String get typeTime => 'Tempo';

  @override
  String get typeCardio => 'Distância e tempo';

  @override
  String get exerciseTypeHint =>
      'Cardio, como correr ou nadar, registra distância e tempo. Isometrias, como a prancha, só tempo.';

  @override
  String get howToLabel => 'Passo a passo (opcional)';

  @override
  String get howToHint => 'Um passo por linha';

  @override
  String get editExercise => 'Editar exercício';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get noStepsYet => 'Ainda não há passos. Escreva os seus para lembrar como você faz.';

  @override
  String get addSteps => 'Escrever os passos';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Uma série normal. Conta para o volume e para os recordes.';

  @override
  String get setTypeWarmupInfo => 'Séries leves para aquecer. Não contam para o volume nem para os recordes.';

  @override
  String get setTypeDropInfo => 'Logo a seguir a uma série, baixa o peso e continua sem descansar.';

  @override
  String get setTypeFailureInfo =>
      'Continua até não conseguires mais uma repetição limpa. Regista as que fizeste mesmo.';

  @override
  String get setTypeRestPauseInfo =>
      'Descansa 10 a 20 segundos depois da série e tira mais algumas repetições.';

  @override
  String get planFormatNotes =>
      'Use os nomes dos exercícios exatamente como aparecem na lista. \"sets\", \"reps\", \"weight\" (na unidade indicada), \"rest\" em segundos e \"days\" são opcionais. \"superset\": true liga um exercício ao seguinte. Para várias semanas, agrupe as rotinas dentro de \"weeks\" como no segundo exemplo.';

  @override
  String get planSets => 'Planejar séries';

  @override
  String get planSetsHint =>
      'Escolha o tipo, as repetições e o peso de cada série. Deixe o peso em Auto para partir da última sessão.';

  @override
  String get planHintReps => 'Escolha o tipo e as repetições de cada série. Auto parte da última sessão.';

  @override
  String get planHintTime => 'Escolha o tipo e o tempo de cada série. Auto parte da última sessão.';

  @override
  String get planHintTimeWeight =>
      'Escolha o tipo, o tempo e o peso de cada série. Auto parte da última sessão.';

  @override
  String get planHintCardio => 'Escolha a distância e o tempo de cada série. Auto parte da última sessão.';

  @override
  String get timeOnly => 'Somente tempo';

  @override
  String get autoValue => 'Auto';

  @override
  String get clearPlan => 'Limpar o plano';

  @override
  String get shareRoutine => 'Compartilhar rotina';

  @override
  String get shareWeek => 'Compartilhar minha semana';

  @override
  String get shareWeekHint => 'Todas as suas rotinas e o dia de cada uma.';

  @override
  String shareMessage(String name) {
    return '$name: abra o arquivo com o GymMane para adicionar.';
  }

  @override
  String get importRoutines => 'Importar rotinas';

  @override
  String get importPasteHint =>
      'Cole aqui: Uma rotina compartilhada do GymMane, a resposta de uma IA, um JSON ou CSV.';

  @override
  String get pasteAction => 'Colar';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rotinas', one: '1 rotina');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Usar também o plano semanal';

  @override
  String get useTheirScheduleHint => 'Os dias que ele traz substituem o que você tem planejado neles.';

  @override
  String get addToMyRoutines => 'Adicionar às minhas rotinas';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rotinas adicionadas',
      one: '1 rotina adicionada',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Não há nada aqui que o GymMane possa importar';

  @override
  String get aiStepCopy => 'Copie o pedido. Ele leva sua lista de exercícios e o formato que o GymMane lê.';

  @override
  String get aiStepAsk =>
      'Cole em qualquer IA e diga o que quer: dias por semana, objetivo, quantas semanas.';

  @override
  String get aiStepPaste => 'Cole a resposta aqui embaixo e importe. Sem precisar de arquivo.';

  @override
  String get copyForAi => 'Copiar para a IA';

  @override
  String get copiedDone => 'Copiado';

  @override
  String get aiPasteHint => 'Cole aqui a resposta da IA';

  @override
  String get importAction => 'Importar';

  @override
  String get showFormat => 'Ver o formato';

  @override
  String get shareAsFile => 'Compartilhar como arquivo';

  @override
  String get recoveryTab => 'Recuperação';

  @override
  String recoveryOverall(int pct) {
    return 'Corpo $pct% recuperado';
  }

  @override
  String get recoveryAllFresh => 'Tudo recuperado. Um bom dia para treinar o que quiser.';

  @override
  String recoveryStill(String muscles) {
    return 'Ainda se recuperando: $muscles';
  }

  @override
  String get recoveryTired => 'Fadigado';

  @override
  String get recoveryFresh => 'Descansado';

  @override
  String get recoveryHint =>
      'Toque num músculo para ver quanto ele se recuperou. Séries recentes pesam mais, e as mais pesadas (pelo RPE) mais ainda.';

  @override
  String recoveryPct(int pct) {
    return '$pct% recuperado';
  }

  @override
  String readyInHours(int h) {
    return 'pronto em ~$h h';
  }

  @override
  String get tplAbcd => 'Quatro dias: peito e tríceps, costas e bíceps, pernas, ombros e abdômen.';

  @override
  String get tplAbcde => 'Cinco dias, um grupo em cada: peito, costas, pernas, ombros, braços.';

  @override
  String get elapsedCaps => 'DECORRIDO';

  @override
  String get tapToChange => 'Toque para mudar';

  @override
  String get swipeToSkipHint => 'Deslize o cronômetro para o lado para pular o descanso.';

  @override
  String get screenLocked => 'Tela bloqueada';

  @override
  String get lockedHint => 'Mantenha pressionada a digital no topo para desbloquear';

  @override
  String get liveDoneSet => 'Série feita';

  @override
  String get liveSkipRest => 'Pular descanso';

  @override
  String get livePause => 'Pausar';

  @override
  String get liveResume => 'Retomar';

  @override
  String get liveNext => 'Próximo';

  @override
  String liveUpNext(String name) {
    return 'Depois: $name';
  }

  @override
  String get stickerOpen => 'Compartilhar numa foto';

  @override
  String get stickerNoPhoto => 'Sem foto';

  @override
  String get stickerWorkout => 'Treino';

  @override
  String get stickerStreak => 'Sequência';

  @override
  String get stickerDate => 'Data';

  @override
  String get stickerHint => 'Arraste para mover e pinçe a tela para mudar o tamanho ou girar';

  @override
  String get stickerSaved => 'Salva na sua galeria';

  @override
  String get stickerWeek => 'Esta semana';

  @override
  String get getReady => 'Prepare-se';

  @override
  String sideOfTwo(String n) {
    return 'Lado $n de 2';
  }

  @override
  String get switchSides => 'Troque de lado';

  @override
  String get stickerGallery => 'Galeria';

  @override
  String get stickerCamera => 'Câmera';

  @override
  String get shareIntroTitle => 'Compartilhe esta rotina';

  @override
  String get shareIntroBody =>
      'Envie para seu parceiro, um amigo ou sua família. Eles recebem um pequeno arquivo que abre no GymMane e adiciona a rotina com um toque, com séries e pesos.';

  @override
  String get removedFromRoutine => 'Removido da rotina';

  @override
  String get radarTitle => 'Últimos 30 dias';

  @override
  String get radarHint => 'Veja quais áreas precisam de mais trabalho';

  @override
  String get radarEmpty => 'Treine alguns dias para ver seu equilíbrio';

  @override
  String get radarBalanced => 'Bom equilíbrio até agora';

  @override
  String radarFocus(String list) {
    return 'Precisa de mais: $list';
  }

  @override
  String get countdownReady => 'Prepare-se';

  @override
  String get countdownSkip => 'Toque para começar já';

  @override
  String get countdownSetting => 'Contagem regressiva ao começar';

  @override
  String get effortSetting => 'Anotar o esforço';

  @override
  String get effortHint =>
      'RPE: 10 é não conseguir fazer mais nenhuma; 8, que sobravam duas. RIR conta as repetições que te sobravam. Se a série o tiver, o 1RM estimado usa a tabela de RPE.';

  @override
  String get rirHint => '0 é não conseguir fazer mais nenhuma; 2, que sobravam duas.';

  @override
  String get addWeekWidget => 'Adicionar widget da semana';

  @override
  String get gamificationSetting => 'Medalhas e níveis';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n reps.', one: '$n rep.');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Melhor série';

  @override
  String get weekStartSetting => 'A semana começa a';

  @override
  String get stepOutOfWorkout => 'Pausar e sair';

  @override
  String get saveToRoutine => 'GUARDAR ALTERAÇÕES NA ROTINA';

  @override
  String get routineUpdated => 'Rotina atualizada';

  @override
  String saveChangesTitle(String name) {
    return 'Guardar alterações em $name?';
  }

  @override
  String get saveChangesBody => 'Da próxima vez que você começar, a rotina terá essas alterações.';

  @override
  String get routineOrderChanged => 'Nova ordem dos exercícios';

  @override
  String get mineOnly => 'Criados por ti';

  @override
  String createNamed(String name) {
    return 'Não está? Criar «$name»';
  }

  @override
  String get orStartWith => 'Ou começa com';

  @override
  String get warmupFocus => 'Aquecimento';

  @override
  String get warmupFocusHint => 'Mobilidade e ativação, com ou sem material';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Corrida, bicicleta, remo ou corda, por distância e tempo';

  @override
  String get homeRecommended => 'Recomendados no início';

  @override
  String get homeRoutines => 'Rotinas no início';

  @override
  String get homeRoutinesHint => 'A última feita primeiro';

  @override
  String get homeWeekStats => 'Esta semana no início';

  @override
  String get homeWeekStatsHint => 'Volume, séries e recordes da semana';

  @override
  String get stepsSetting => 'Passos do Health Connect';

  @override
  String get stepsSettingHint => 'Os passos de hoje no Início';

  @override
  String get stepsToday => 'Passos hoje';

  @override
  String stepsOfGoal(String goal) {
    return 'de $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count passos hoje';
  }

  @override
  String get stepsGoal => 'Meta diária de passos';

  @override
  String get stepsNoAccess => 'Sem acesso aos teus passos';

  @override
  String get stepsGrant => 'Toca para permitir no Health Connect';

  @override
  String get stepsInfoRead => 'Só lê o número de passos. Nunca lê mais nada nem escreve no Health Connect.';

  @override
  String get stepsInfoLocal => 'Os teus passos ficam no telemóvel. O GymMane nunca se liga à internet.';

  @override
  String get stepsInfoOff => 'Podes desligar quando quiseres, nos Ajustes ou no Health Connect.';

  @override
  String get stepsManage => 'Gerir permissão';

  @override
  String get routineDoneToday => 'Feito por hoje · mandou bem';

  @override
  String get trainAgain => 'Treinar de novo';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Há $n dias',
      one: 'Feita ontem',
      zero: 'Feita hoje',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Arquivados';

  @override
  String get archiveExercise => 'Arquivar exercício';

  @override
  String get restoreExercise => 'Restaurar';

  @override
  String get archivedToast => 'Exercício arquivado';

  @override
  String get archivedToastHint => 'Está em Exercícios › Arquivados';

  @override
  String get archivedBanner => 'Arquivado. Não aparece em listas nem sugestões; o teu histórico mantém-se.';

  @override
  String get videoMarksHint => 'Pausa num passo e toca no alfinete para saltar para lá da próxima vez.';

  @override
  String get videoMarkHere => 'Marcar este passo aqui';

  @override
  String get sectionGeneral => 'Geral';

  @override
  String get sectionTraining => 'Treino';

  @override
  String get sectionAlerts => 'Lembretes e alarme';

  @override
  String get sectionHome => 'Início';

  @override
  String get sectionWidgets => 'Widgets';

  @override
  String get sectionData => 'Dados e cópia de segurança';

  @override
  String get multiPlanSetting => 'Várias rotinas por dia';

  @override
  String get multiPlanHint => 'Toca em cada rotina deste dia. Seguem a ordem em que as adicionas.';

  @override
  String routineOfDay(int n, int total) {
    return '$n de $total hoje';
  }

  @override
  String get nextToday => 'Próxima hoje';

  @override
  String get planAboutMe => 'Sobre mim:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age anos, $height de altura, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Quero treinar $n dias por semana.';
  }

  @override
  String get planNoHistory =>
      'Ainda não registei treinos: trata-me como principiante e sê prudente com o volume e os pesos.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treinos registados nos últimos 30 dias.',
      one: '1 treino registado nos últimos 30 dias.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Melhores séries recentes';

  @override
  String get planAskFirst =>
      'Se não souberes o meu objetivo (força, músculo, perder gordura ou forma geral) ou quanto pode durar cada sessão, pergunta-me primeiro numa mensagem curta. Depois responde só com JSON.';

  @override
  String get backToTop => 'Voltar ao topo';

  @override
  String get deleteExerciseTitle => 'Apagar este exercício?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" será removido da tua biblioteca e das tuas rotinas. As séries anteriores ficam guardadas.';
  }

  @override
  String get exportForStravaHint =>
      'Envia pelo navegador em strava.com/upload/select (a app do Strava não importa ficheiros). Aparece como treino de musculação, com as tuas séries.';

  @override
  String get manualStartTime => 'Hora de início';

  @override
  String get manualDuration => 'Duração';

  @override
  String get manualDurationUnset => 'Adicionar duração';

  @override
  String get stravaRow => 'Exportar para o Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Escolhe um treino para levar para o Strava. Recebes um ficheiro .fit: envia pelo navegador em strava.com/upload/select e aparece como treino de musculação, com as tuas séries.';

  @override
  String get stravaEmpty => 'Ainda não há treinos para exportar.';

  @override
  String get tapToPause => 'Toca para pausar';

  @override
  String get holdPausedHint => 'Em pausa · toca para continuar';

  @override
  String get finishHoldNow => 'Terminar a série já';

  @override
  String get barWeightExercise => 'Peso da barra ou do carro';

  @override
  String get barWeightHint => 'Usado pela calculadora de discos';

  @override
  String get barWeightCustom => 'Próprio · toca para repor';

  @override
  String get groupRename => 'Renomear grupo';

  @override
  String get groupUngroup => 'Remover grupo, manter rotinas';

  @override
  String get groupDeleteAll => 'Excluir grupo e rotinas';

  @override
  String groupDeleteTitle(String name) {
    return 'Excluir “$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count serão excluídas. Seu histórico de treinos é mantido.';
  }

  @override
  String get tplRr =>
      'O clássico do r/bodyweightfitness: corpo inteiro três dias por semana. Suba um nível quando ficar fácil.';

  @override
  String get levelUpKicker => 'PRÓXIMO PASSO';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps em $name dois treinos seguidos. Pronto para o próximo passo?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Trocar em $routine';
  }

  @override
  String get levelUpSee => 'Ver como se faz';

  @override
  String get levelUpLater => 'Agora não';

  @override
  String get levelUpStay => 'Fico com este';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name agora está em $routine';
  }

  @override
  String get levelUpStayed => 'Sem mais sugestões de progressão para este';

  @override
  String get levelHintsSetting => 'Sugerir o próximo passo';

  @override
  String get heatmapLabelsSetting => 'Dias e meses no mapa de atividade';

  @override
  String get rmPercent => 'PERCENTAGEM';

  @override
  String rmAtPercent(String pct) {
    return '$pct do teu máximo';
  }

  @override
  String get copyWorkout => 'Copiar como texto';

  @override
  String get goalSet => 'Definir um objetivo';

  @override
  String get goalTargetReps => 'REPETIÇÕES ALVO';

  @override
  String goalToGo(String value) {
    return 'Faltam $value';
  }

  @override
  String get goalReached => 'Objetivo atingido';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Faltam $n dias', one: 'Falta 1 dia');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Data ultrapassada';

  @override
  String get goalDeadline => 'PRAZO';

  @override
  String get goalNoDeadline => 'Sem prazo';

  @override
  String get goalRemove => 'Remover objetivo';

  @override
  String get exerciseNameMissing => 'Dê um nome';

  @override
  String get aliasesLabel => 'Também chamado (opcional)';

  @override
  String get aliasesHint => 'Outros nomes, separados por vírgulas';

  @override
  String alsoCalled(String names) {
    return 'Também: $names';
  }

  @override
  String get addToRoutine => 'Adicionar à rotina';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Em $n rotinas',
      one: 'Em 1 rotina',
      zero: 'Ainda não está em nenhuma rotina',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Já está nela';

  @override
  String get restInRoutine => 'Descanso nesta rotina';

  @override
  String get restInRoutineHint => 'O mesmo do exercício';

  @override
  String get restInRoutineReset => 'Só aqui · toque para tirar';

  @override
  String get swapExercise => 'Trocar exercício';

  @override
  String get swapShort => 'Trocar';

  @override
  String swapHint(String name) {
    return 'No lugar de $name, só hoje. No fim você pode deixar na rotina.';
  }

  @override
  String get swapKeepsDone => 'As séries que você já fez ficam; o novo segue com as que faltam.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Mesmo músculo · $muscle';
  }

  @override
  String get swapDoneBefore => 'Já fez antes';

  @override
  String get multiPlanSettingHint => 'Mais de uma rotina no mesmo dia da semana';

  @override
  String get levelHintsHint => 'Sugere a versão mais difícil';

  @override
  String get focusCardHint => 'A rotina de hoje, no topo do Início';

  @override
  String get gamificationHint => 'Medalhas, nível e comemoração';

  @override
  String get exerciseSettings => 'Ajustes deste exercício';

  @override
  String get placeActiveNow => 'Você está aqui';

  @override
  String get placeTapToUse => 'toque para treinar aqui';

  @override
  String get intervalDays => 'dias';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target dias';
  }

  @override
  String get toolNameRpe => 'Carga por RPE';

  @override
  String get toolTitleRpe => 'Carga por RPE';

  @override
  String get toolDescRpe => 'Que peso usar para o esforço que você quer';

  @override
  String get toolNameDots => 'Nível de força';

  @override
  String get toolTitleDots => 'Nível de força (DOTS)';

  @override
  String get toolDescDots => 'Sua força para o seu peso';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Para $reps reps a RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Uma série que você acabou de fazer';

  @override
  String get rpeGoal => 'O que você quer fazer';

  @override
  String rpeOneRmLine(String value) {
    return '1RM estimado: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 é não conseguir mais nenhuma; 8, que sobravam duas.';

  @override
  String get dotsBestLifts => 'Suas melhores marcas';

  @override
  String get dotsSquat => 'AGACHAMENTO';

  @override
  String get dotsBench => 'SUPINO';

  @override
  String get dotsDeadlift => 'LEVANTAMENTO TERRA';

  @override
  String dotsTotalLine(String value) {
    return 'Total: $value';
  }

  @override
  String get dotsExplain =>
      'Compara sua força com a de qualquer pessoa, seja qual for o peso. Use sua melhor marca de uma repetição ou o 1RM estimado.';

  @override
  String get dotsLevel0 => 'Iniciante';

  @override
  String get dotsLevel1 => 'Intermediário';

  @override
  String get dotsLevel2 => 'Avançado';

  @override
  String get dotsLevel3 => 'Muito avançado';

  @override
  String get dotsLevel4 => 'Elite';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Pontuação Wilks';

  @override
  String get toolDescWilks => 'A pontuação clássica do powerlifting';

  @override
  String get wilksExplain =>
      'A fórmula clássica do powerlifting. A DOTS a substituiu em 2020, mas muitas competições e rankings ainda a usam.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Índice de massa magra';

  @override
  String get toolDescFfmi => 'Quanto músculo para sua altura';

  @override
  String get ffmiBodyFat => 'GORDURA CORPORAL';

  @override
  String ffmiLeanLine(String value) {
    return 'Massa magra: $value';
  }

  @override
  String get ffmiExplain =>
      'Como o IMC, mas sem a gordura: conta só sua massa magra. Ajustado à altura para comparar altos e baixos de forma justa.';

  @override
  String get ffmiLevel0 => 'Abaixo da média';

  @override
  String get ffmiLevel1 => 'Na média';

  @override
  String get ffmiLevel2 => 'Acima da média';

  @override
  String get ffmiLevel3 => 'Excelente';

  @override
  String get ffmiLevel4 => 'Excepcional';

  @override
  String get rpeEffortLabel => 'Esforço (RPE)';

  @override
  String get restRowHint => 'Entre séries, se o exercício não tiver o seu';

  @override
  String get effortRowHint => 'Anote RPE ou RIR em cada série';

  @override
  String get countdownHint => '3, 2, 1 antes da primeira série';

  @override
  String get keepScreenOnHint => 'A tela não apaga enquanto você treina';

  @override
  String get demoSizeRowHint => 'O desenho do exercício durante o treino';

  @override
  String get demoLoopRowHint => 'Se a animação repete ou para';

  @override
  String get trainReminderRowHint => 'Um aviso nos dias de treino';

  @override
  String get alarmSoundRowHint => 'O que toca ao fim do descanso';

  @override
  String get alarmStyleRowHint => 'Se toca com o celular no silencioso';

  @override
  String get recommendedRowHint => 'Exercícios que sugerimos no Início';

  @override
  String get weightStepSetting => 'Incremento de peso';

  @override
  String get weightStepHint => 'O que os botões − e + somam';

  @override
  String get prBestWorkout => 'Melhor treino';

  @override
  String get mergeExercise => 'Mesclar';

  @override
  String mergeExerciseInto(String name) {
    return 'Mesclar $name com…';
  }

  @override
  String get mergeExerciseTitle => 'Mesclar exercícios?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Todo o histórico de “$from” passa para “$to”. “$from” continua na sua biblioteca. Não dá para desfazer.';
  }

  @override
  String get mergedToast => 'Histórico mesclado';

  @override
  String get nutrition => 'Nutrição';

  @override
  String get nutritionHomeEmpty => 'Água, proteína e calorias';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g de proteína';
  }

  @override
  String get nutritionToday => 'Hoje';

  @override
  String get nutritionYesterday => 'Ontem';

  @override
  String get nutritionGoals => 'Metas do dia';

  @override
  String get kcalLabel => 'CALORIAS';

  @override
  String get kcalOver => 'a mais';

  @override
  String get waterLabel => 'ÁGUA';

  @override
  String get waterDone => 'Meta atingida';

  @override
  String get waterCustom => 'Outra quantidade';

  @override
  String get glassSize => 'Tamanho do copo';

  @override
  String get supplementsLabel => 'SUPLEMENTOS';

  @override
  String get supplementsEmpty => 'Toque em um para adicionar, ou + para o seu.';

  @override
  String get addSupplement => 'Novo suplemento';

  @override
  String get supplementNameHint => 'Creatina, vitamina D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Remover $name?';
  }

  @override
  String get removeSupplementBody => 'Os dias em que você marcou vão junto.';

  @override
  String get suppCreatine => 'Creatina';

  @override
  String get suppVitaminD => 'Vitamina D';

  @override
  String get suppOmega3 => 'Ômega-3';

  @override
  String get suppMagnesium => 'Magnésio';

  @override
  String get suppMultivitamin => 'Multivitamínico';

  @override
  String get suppCaffeine => 'Cafeína';

  @override
  String get myFoods => 'Meus alimentos';

  @override
  String get newFood => 'Novo alimento';

  @override
  String get editFood => 'Editar alimento';

  @override
  String get foodNameHint => 'Whey, aveia, pão…';

  @override
  String get servingLabel => 'PORÇÃO';

  @override
  String get servingHint => '1 scoop · 30 g';

  @override
  String get perServing => 'POR PORÇÃO';

  @override
  String get servingsLabel => 'Porções';

  @override
  String get foodPhotoHint => 'Num fundo liso vira um sticker.';

  @override
  String get cutoutWorking => 'Recortando…';

  @override
  String get cutoutTry => 'Recortar';

  @override
  String get cutoutKeep => 'Foto inteira';

  @override
  String deleteFoodTitle(String name) {
    return 'Apagar $name?';
  }

  @override
  String get deleteFoodBody => 'Sai dos seus alimentos. O que você já registrou fica.';

  @override
  String get mealBreakfast => 'Café da manhã';

  @override
  String get mealLunch => 'Almoço';

  @override
  String get mealDinner => 'Jantar';

  @override
  String get mealSnacks => 'Lanches';

  @override
  String get nothingLogged => 'Nada registrado ainda.';

  @override
  String addToMeal(String meal) {
    return 'Adicionar ao $meal';
  }

  @override
  String get quickAdd => 'Registro rápido';

  @override
  String get quickAddHint => 'Só os números, sem salvar um alimento.';

  @override
  String get quickAddName => 'O que era? (opcional)';

  @override
  String get logFood => 'Adicionar';

  @override
  String loggedToast(String meal) {
    return 'Adicionado ao $meal';
  }

  @override
  String get entryRemoved => 'Removido';

  @override
  String get goalsFromProfile => 'Calcular pelo meu perfil';

  @override
  String get goalsFromProfileHint =>
      'Calorias do seu perfil, 1,8 g de proteína e 35 ml de água por kg de peso.';

  @override
  String get kcalEaten => 'Comido';

  @override
  String get kcalRemaining => 'Restam';

  @override
  String waterTapHint(String amount) {
    return 'Toque no copo: + $amount';
  }

  @override
  String get shakeEmpty => 'Toque para escolher seu shake';

  @override
  String shakeTapHint(String name) {
    return 'Toque: + $name';
  }

  @override
  String get shakePick => 'Seu shake';

  @override
  String get shakePickHint => 'Toque no copo e ele é registrado de uma vez.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'G';

  @override
  String get addBurnedLabel => 'Somar calorias queimadas';

  @override
  String get addBurnedHint => 'As calorias queimadas são estimadas pela duração dos treinos e pelo seu peso.';

  @override
  String get amountLabel => 'Quantidade';

  @override
  String amountIn(String unit) {
    return 'Quantidade ($unit)';
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
  String get deleteSavedMealBody => 'O que você já registrou fica como está.';

  @override
  String get fiberLabel => 'Fibras';

  @override
  String get sugarLabel => 'Açúcar';

  @override
  String get sodiumLabel => 'Sódio';

  @override
  String get foodDatabase => 'Base de alimentos';

  @override
  String get kcalBurned => 'Queimado';

  @override
  String get mealOptions => 'Opções da refeição';

  @override
  String get moreNutrients => 'Fibras, açúcar e sódio';

  @override
  String ofGoal(int goal, String unit) {
    return 'de $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'por 100 $unit';
  }

  @override
  String get perServingShort => 'por porção';

  @override
  String get foodCategory => 'CATEGORY';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unidades',
      one: '1 unidade',
    );
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count fatias', one: '1 fatia');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count scoops', one: '1 scoop');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colheres de sopa',
      one: '1 colher de sopa',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count colheres de chá',
      one: '1 colher de chá',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count xícaras',
      one: '1 xícara',
    );
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count copos', one: '1 copo');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Recentes';

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
  String get renameLabel => 'Renomear';

  @override
  String get repeatFrom => 'Repetir de';

  @override
  String get repeatNone => 'Nada registrado nesta refeição em outros dias.';

  @override
  String get restDayGoals => 'Metas diferentes nos dias de descanso';

  @override
  String get trainingDays => 'Dias de treino';

  @override
  String get restDays => 'Dias de descanso';

  @override
  String get trainingDay => 'Dia de treino';

  @override
  String get saveAsMeal => 'Salvar como refeição';

  @override
  String get savedMealNameHint => 'ex. Café da manhã de sempre';

  @override
  String get savedMealToast => 'Refeição salva';

  @override
  String get savedMeals => 'Refeições salvas';

  @override
  String get searchFoodsHint => 'Buscar alimentos';

  @override
  String get searchFoodsEmpty => 'Busque entre mais de 500 alimentos com foto, ou crie os seus.';

  @override
  String searchFoodsNone(String query) {
    return 'Nada para “$query”. Crie como alimento seu.';
  }

  @override
  String get servingWeight => 'GRAMAS';

  @override
  String get weekAverage => 'Esta semana';

  @override
  String get weekAvgEnergy => 'Média por dia';

  @override
  String get weekAvgProtein => 'Proteína por dia';

  @override
  String get weekEnergyOnTarget => 'Calorias na meta';

  @override
  String get weekProteinOnTarget => 'Proteína na meta';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g de proteína por dia';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met de $days dias na meta';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias registrados',
      one: '1 dia registrado',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Nada registrado ainda';

  @override
  String get weekOnTargetHint => 'Na meta: calorias a menos de 10 % da meta e pelo menos 90 % da proteína.';

  @override
  String get weightGoalLabel => 'Peso meta';

  @override
  String weightGoalTitle(String unit) {
    return 'Peso meta ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Meta $weight';
  }

  @override
  String get weightGoalNone => 'Segure para definir uma meta';

  @override
  String get weightGoalReached => 'Meta atingida';

  @override
  String weightToLose(String weight) {
    return 'Faltam $weight para perder';
  }

  @override
  String weightToGain(String weight) {
    return 'Faltam $weight para ganhar';
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
  String get aminoTrp => 'triptofano';

  @override
  String get aminoVal => 'valina';

  @override
  String get animalProtein => 'Proteína animal';

  @override
  String get proteinQuality => 'Qualidade da proteína';

  @override
  String get qualityComplete => 'Completa';

  @override
  String get qualityAlmost => 'Quase completa';

  @override
  String get qualityIncomplete => 'Incompleta';

  @override
  String get qualityNoData => 'Sem dados ainda';

  @override
  String get qualityNoDataHint => 'Registre alimentos da base para ver seus aminoácidos.';

  @override
  String get qualityAllCovered => 'Você cobre os nove aminoácidos essenciais.';

  @override
  String qualityLimiting(String amino) {
    return 'Falta $amino. Combine com alimentos ricos nela.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Calculado com $pct % da sua proteína: seus alimentos próprios não têm aminoácidos.';
  }

  @override
  String get fatTypes => 'Tipos de gordura';

  @override
  String get fatSaturated => 'Saturada';

  @override
  String get fatMono => 'Mono';

  @override
  String get fatPoly => 'Poli';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Saturada $grams g de no máx. $limit g (10 % das calorias)';
  }

  @override
  String get sugarSodium => 'Açúcar e sódio';

  @override
  String get shakeCard => 'Shake de proteína';

  @override
  String get mealOther => 'Refeição';

  @override
  String get mealAdd => 'Adicionar refeição';

  @override
  String get mealAddHint => 'ex. Pré-treino';

  @override
  String get mealsOfDay => 'Refeições do dia';

  @override
  String get mealsHint => 'Crie quantas quiser. Ao remover uma, o que estava nela passa para a de cima.';

  @override
  String get trackersTitle => 'Personalizar';

  @override
  String get trackersHint => 'Deixe só o que você quer acompanhar.';

  @override
  String get trackersDaily => 'Resumo do dia';

  @override
  String get trackersDetail => 'Em detalhe';

  @override
  String get trackersCards => 'Cartões';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Novo lote';

  @override
  String get prepNew => 'Novo lote';

  @override
  String get prepEdit => 'Editar lote';

  @override
  String get prepHint => 'Registre a panela inteira uma vez e vá comendo aos poucos.';

  @override
  String get prepEmpty =>
      'Cozinhou para vários dias? Registre uma vez e depois diga só quanto comeu do que sobrou.';

  @override
  String get prepNameHint => 'ex. Frango com arroz';

  @override
  String get prepDefaultName => 'Lote';

  @override
  String get prepIngredients => 'Ingredientes';

  @override
  String get prepAddIngredient => 'Adicionar ingrediente';

  @override
  String get prepCookedWeight => 'PESO COZIDO';

  @override
  String prepCookedHint(String grams) {
    return 'Pese a panela já cozida para números exatos. Vazio = peso cru total ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Informe o peso cozido: alguns ingredientes não têm gramas.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Restam $left de $total';
  }

  @override
  String get prepOfWhatsLeft => '% do que sobrou';

  @override
  String get prepAll => 'Tudo';

  @override
  String prepLogAmount(String grams) {
    return 'Registrar $grams';
  }

  @override
  String get prepWeighLeft => 'Pesar o que sobrou';

  @override
  String get prepFinished => 'Este lote acabou.';

  @override
  String get approxValues => 'Aproximado';

  @override
  String get editValues => 'Editar valores';

  @override
  String get editValuesHint =>
      'Só muda este registro. Para corrigir o alimento da próxima vez, edite em Meus alimentos.';

  @override
  String get editLibraryHint => 'Salvo como alimento seu, com a mesma foto';

  @override
  String per100Line(String energy, String unit) {
    return '$energy por 100 $unit';
  }

  @override
  String get rawLabel => 'Cru';

  @override
  String get cookedLabel => 'Cozido';

  @override
  String get rawHint => 'Peso antes de cozinhar';

  @override
  String cookedHint(String factor) {
    return 'Peso já cozido (×$factor o peso cru)';
  }

  @override
  String get servingsUnit => 'porções';

  @override
  String logAmount(String energy) {
    return 'Registrar · $energy';
  }

  @override
  String get catFruit => 'Frutas';

  @override
  String get catVeg => 'Verduras';

  @override
  String get catMeat => 'Carne';

  @override
  String get catFish => 'Peixe';

  @override
  String get catEgg => 'Ovos';

  @override
  String get catDairy => 'Laticínios';

  @override
  String get catGrain => 'Cereais';

  @override
  String get catBakery => 'Pães';

  @override
  String get catLegume => 'Leguminosas';

  @override
  String get catNut => 'Castanhas';

  @override
  String get catOil => 'Óleos';

  @override
  String get catPantry => 'Despensa';

  @override
  String get catDrink => 'Bebidas';

  @override
  String get catSauce => 'Molhos';

  @override
  String get catSpice => 'Temperos';

  @override
  String get searchFoodsPrompt => 'O que você comeu?';

  @override
  String get shelfEmpty => 'Busque um alimento ou fotografe o seu: os que você mais registra aparecem aqui.';

  @override
  String get repeatEntry => 'Repetir';

  @override
  String get notifSuppChannel => 'Suplementos';

  @override
  String get notifSuppChannelWhy => 'Lembrete diário para tomar seus suplementos';

  @override
  String get energySplit => 'De onde vêm as calorias';

  @override
  String get typicalServing => 'Porção típica';

  @override
  String cookedYieldLine(String factor) {
    return 'Pesa $factor× o peso cru';
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
  String get planDeleteBody => 'Suas rotinas ficam. Só esta semana salva é removida.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Nutrição';

  @override
  String get nutritionBetaHint => 'Refeições, água e suplementos';

  @override
  String get nutritionAboutTitle => 'Sobre a nutrição';

  @override
  String get nutritionAboutSub => 'O que é, e o que nunca vai ser.';

  @override
  String get nutritionAboutWhatTitle => 'Parte do seu treino';

  @override
  String get nutritionAboutWhat =>
      'Um jeito simples de anotar refeições, água, proteína e suplementos ao lado dos seus treinos. O GymMane é antes de tudo um app de academia: a nutrição está aqui para você ter tudo num só lugar, não para substituir um app de dieta.';

  @override
  String get nutritionAboutScanTitle => 'Sem scanner, nunca';

  @override
  String get nutritionAboutScan =>
      'Escanear um código de barras e ver tudo preenchido sozinho seria prático. Mas isso exige internet e um enorme banco de dados de alimentos online, e o que você come vai parar nos servidores de outra pessoa. Esses dados mostram quando você come, o que você come e como cuida do seu corpo, e podem ser usados para publicidade ou acabar nas mãos de grandes empresas. Por isso não há scanner, e não vai haver.';

  @override
  String get nutritionAboutLocalTitle => 'Tudo no seu celular';

  @override
  String get nutritionAboutLocal =>
      'O app já vem com mais de 500 alimentos com foto. Você pode adicionar os seus, trocar as fotos e editar os valores. Tudo fica no seu celular, como o resto do GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Ainda em beta';

  @override
  String get nutritionAboutBeta =>
      'Se sentir falta de algo, sugira no GitHub. Só não peça scanner nem um banco de alimentos maior: além da sua privacidade, isso deixaria o app muito mais pesado. Não precisa da nutrição? Desative em Configurações e seus dados continuam lá.';

  @override
  String get nutritionAboutSuggest => 'Sugerir uma ideia';

  @override
  String get nutritionAboutOk => 'Entendi';

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
  String get planNameHint => 'Verão, viagem…';

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
  String get planFixedWeek => 'Semana fixa';

  @override
  String get planRotation => 'Rotação';

  @override
  String get rotationTitle => 'ROTAÇÃO';

  @override
  String get rotationHint => 'A próxima é a que vem depois do último treino, seja qual for o dia.';

  @override
  String get rotationEmpty => 'Adicione suas rotinas na ordem em que vai fazê-las: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done de $total feitas nesta volta';
  }

  @override
  String get rotationNext => 'Próxima';

  @override
  String get rotationAdd => 'Adicionar rotinas';

  @override
  String get rotationPickHint => 'Entram na ordem em que você toca.';

  @override
  String get rotationSkip => 'Pular para a próxima';

  @override
  String get rotationRestart => 'Começar nova volta';

  @override
  String get rotationMakeNext => 'Tornar a próxima';

  @override
  String get rotationRemove => 'Tirar da rotação';

  @override
  String rotationPlace(int n, int total) {
    return '$n de $total da rotação';
  }

  @override
  String get moveToDay => 'Mover para outro dia';

  @override
  String get moveToDayHint => 'Só desta vez; seu plano semanal continua igual.';

  @override
  String get movedToast => 'Treino movido';

  @override
  String get backToPlan => 'Voltar ao plano semanal';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get untrainedTab => 'Sem treino';

  @override
  String get untrainedRecent => 'Recente';

  @override
  String get untrainedLong => 'Faz tempo';

  @override
  String untrainedWaiting(String list) {
    return 'Esperando há mais tempo: $list';
  }

  @override
  String get untrainedAllRecent => 'Todos os músculos trabalharam esta semana. Boa.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Há $n dias',
      one: 'Treinado ontem',
      zero: 'Treinado hoje',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Ainda sem treino';

  @override
  String get layoutSetting => 'Visual do treino';

  @override
  String get layoutCards => 'Cartões';

  @override
  String get layoutList => 'Lista';

  @override
  String get layoutHint =>
      'Cartões mostram um exercício por vez. Lista mostra o treino inteiro numa tela, série a série.';

  @override
  String get layoutRowHint => 'Um exercício por vez ou tudo em lista';

  @override
  String get previousCol => 'ANTERIOR';

  @override
  String get usePrevious => 'Usar os valores da última vez';

  @override
  String get skipShort => 'Pular';

  @override
  String get moveUp => 'Mover para cima';

  @override
  String get moveDown => 'Mover para baixo';

  @override
  String get widgetNutritionOff => 'Turn on Nutrition in Settings › Beta to use this widget.';

  @override
  String get widgetPickShake => 'Pick your shake';

  @override
  String get heatRangeSetting => 'Calendário de atividade';

  @override
  String get heatRangeWeeks => '12 semanas';

  @override
  String get heatRangeYear => '12 meses';

  @override
  String get heatRangeHint =>
      '12 meses mostra o ano inteiro. Deslize para o lado para voltar, até o seu primeiro treino.';

  @override
  String get pdfPlan => 'Plano em PDF';

  @override
  String get pdfPlanHint => 'Uma folha limpa com a sua semana e cada rotina, pronta para imprimir ou enviar.';

  @override
  String get pdfExport => 'Exportar em PDF';

  @override
  String get pdfFooter => 'Grátis, de código aberto e offline';

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
  String get pdfKicker => 'PLANO DE TREINO';

  @override
  String get pdfStatDays => 'DIAS / SEMANA';

  @override
  String get pdfStatMinutes => 'MIN / TREINO';

  @override
  String pdfMinutes(int n) {
    return '≈ $n min';
  }

  @override
  String get workoutNotesTitle => 'Notas do exercício';

  @override
  String get workoutNoteEvery => 'Sempre';

  @override
  String get workoutNoteNext => 'Na próxima vez';

  @override
  String get workoutNoteEveryHint =>
      'Aparece sempre que você faz este exercício. Ótimo para ajuste do banco ou da polia.';

  @override
  String get workoutNoteNextHint => 'Aparece só na próxima vez e depois some.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Da última vez · $date';
  }

  @override
  String get workoutNoteHint => 'Banco no furo 2, polia no 19…';

  @override
  String get notePinWorkout => 'Mostrar durante o treino';

  @override
  String get assistedSetting => 'Máquina assistida';

  @override
  String get assistedSettingHint =>
      'O peso ajuda você, então menos é melhor: recordes e sugestões vão diminuindo.';

  @override
  String get assistedRecordHint => 'Menos ajuda';

  @override
  String get trainAgainLabel => 'Ainda não treinou? Lembrar de novo';

  @override
  String get trainAgainOff => 'Não';

  @override
  String trainAgainAfter(int n) {
    return '+$n h';
  }

  @override
  String get trainAgainHint => 'Só uma vez, e só se você não registrou treino nesse dia.';

  @override
  String get notifTrainAgainBody => 'Ainda dá tempo de treinar hoje.';

  @override
  String nextDeload(int n) {
    return 'mais leve: $n treinos seguidos sem todas as reps';
  }

  @override
  String get historyTitle => 'Histórico';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n TREINOS', one: '1 TREINO');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Nenhum treino neste mês';

  @override
  String get historyEmptyHint => 'Deslize para o lado ou use as setas para ver outros meses.';

  @override
  String historyMore(int n) {
    return '+$n mais';
  }

  @override
  String get stopwatch => 'Cronômetro';

  @override
  String get proteinSource => 'Protein source';

  @override
  String get proteinMixedShort => 'Mixed';

  @override
  String get kcalActive => 'ativas';

  @override
  String get kcalEstimated => 'estimado';

  @override
  String get kcalYours => 'seu valor';

  @override
  String kcalTotalRest(String value) {
    return '$value no total, contando o que você gasta em repouso';
  }

  @override
  String get inclineLabel => 'Inclinação';

  @override
  String get kcalUseOwn => 'Usar meu valor';

  @override
  String get kcalBackToEstimate => 'Voltar à estimativa';

  @override
  String get kcalNeedsData => 'Adicione distância e tempo para estimar as calorias';

  @override
  String get kcalHowEstimated => 'Estimado pela distância, tempo, inclinação e seu peso (fórmula ACSM).';

  @override
  String get kcalOwnTitle => 'Calorias ativas';

  @override
  String get planMine => 'Meu plano';

  @override
  String get planNew => 'Novo plano';

  @override
  String get planSaveWeek => 'Salvar esta semana';

  @override
  String get planSaveWeekHint => 'Guarde a semana atual como um plano para voltar depois';

  @override
  String get planEmptyWeek => 'Começar uma semana vazia';

  @override
  String get planEmptyWeekHint => 'Sua semana atual fica salva como plano';

  @override
  String get planName => 'Nome do plano';

  @override
  String get planRename => 'Renomear';

  @override
  String get planDelete => 'Excluir plano';

  @override
  String get plansHint => 'As mudanças na semana são salvas no plano escolhido';

  @override
  String get progression => 'Progressão';

  @override
  String get progManual => 'Manual';

  @override
  String get progManualHint => 'Sem sugestões: você escolhe cada peso.';

  @override
  String get progLinear => 'Linear';

  @override
  String get progLinearHint => 'Cumpra todas as repetições e o peso sobe.';

  @override
  String get progDouble => 'Progressão dupla';

  @override
  String get progDoubleHint => 'Mais repetições até o topo da faixa, depois mais peso.';

  @override
  String get progVolume => 'Repetições, séries e peso';

  @override
  String get progVolumeHint => 'Repetições até o topo, depois uma série a mais, depois mais peso.';

  @override
  String get progAmrap => 'Última série no máximo';

  @override
  String get progAmrapHint =>
      'Última série: todas as repetições que conseguir. Se dobrar a meta, sobe o dobro.';

  @override
  String get progStep => 'Aumento de peso';

  @override
  String get progRange => 'Faixa de repetições';

  @override
  String get progSets => 'Séries';

  @override
  String get progDeload => 'Mais leve após';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n falhas', one: '1 falha');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Reduzir';

  @override
  String get progApply => 'Preencher o próximo treino';

  @override
  String get progApplyHint => 'Desligado, aparece só como sugestão.';

  @override
  String get nextMoreReps => 'mesmo peso, uma repetição a mais';

  @override
  String get nextAddSet => 'uma série a mais';

  @override
  String get nextAmrap => 'última série: todas que conseguir';

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
  String get byZone => 'Por região';

  @override
  String get importAlreadyHave => 'Você já tem estas rotinas. Pode adicioná-las de novo como cópia.';

  @override
  String get importAsCopy => 'Adicionar como cópia';

  @override
  String get importOwned => 'Você já tem';

  @override
  String get setDuplicated => 'Série duplicada';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Uma série dividida em pequenos blocos com 15–30 segundos entre eles. Anote o total de repetições.';

  @override
  String timesBodyweight(String value) {
    return '$value× seu peso corporal';
  }

  @override
  String get archiveRoutine => 'Arquivar rotina';

  @override
  String get routineArchived => 'Rotina arquivada';

  @override
  String get archivedRoutines => 'Arquivadas';

  @override
  String get autoBackup => 'Backup automático';

  @override
  String get autoBackupHint =>
      'Salva um ZIP com todos os seus dados na pasta que você escolher. Sincronize essa pasta com Nextcloud, Syncthing ou outro app para ter uma cópia fora do celular.';

  @override
  String get autoBackupFolder => 'Escolher pasta';

  @override
  String get autoBackupNoFolder => 'Nenhuma pasta';

  @override
  String get autoBackupOff => 'Desativado';

  @override
  String get autoBackupWorkout => 'Após cada treino';

  @override
  String get autoBackupDaily => 'Uma vez por dia';

  @override
  String get autoBackupWeekly => 'Uma vez por semana';

  @override
  String get autoBackupOnLeave => 'Ao sair do app';

  @override
  String get autoBackupKeep => 'Cópias a manter';

  @override
  String get autoBackupNow => 'Fazer backup agora';

  @override
  String autoBackupLast(String when) {
    return 'Último backup $when';
  }

  @override
  String get autoBackupNever => 'Nenhum backup ainda';

  @override
  String get autoBackupLost => 'Não deu para salvar o último backup. Escolha a pasta de novo.';

  @override
  String get autoBackupSaved => 'Backup salvo';

  @override
  String get prepPortions => 'Porções';

  @override
  String get rotationAddRest => 'Adicionar dia de descanso';

  @override
  String get rotationRestHint => 'Avança sozinho no dia seguinte';

  @override
  String get rotationRestToday => 'Hoje';

  @override
  String get rotationSkipRest => 'Pular este descanso';

  @override
  String rotationRestUpNext(String name) {
    return 'Depois: $name';
  }

  @override
  String get trainAnyway => 'Treinar mesmo assim';

  @override
  String get healthTitle => 'Saúde';

  @override
  String get healthSetting => 'Dados de saúde';

  @override
  String get healthSettingHint => 'Dados do Health Connect em Progresso';

  @override
  String get healthPickTitle => 'Dados de saúde';

  @override
  String get healthPickHint =>
      'Escolhe o que trazer do Health Connect. O Android pede uma vez para cada um. Só é lido e nunca sai do telemóvel.';

  @override
  String get healthGroupHeart => 'Coração';

  @override
  String get healthGroupVitals => 'Sinais vitais';

  @override
  String get healthGroupActivity => 'Atividade';

  @override
  String get healthRestingHr => 'Frequência cardíaca em repouso';

  @override
  String get healthHeartRate => 'Frequência cardíaca média';

  @override
  String get healthHrv => 'Variabilidade cardíaca';

  @override
  String get healthSpo2 => 'Oxigénio no sangue';

  @override
  String get healthRespiration => 'Frequência respiratória';

  @override
  String get healthBloodPressure => 'Pressão arterial';

  @override
  String get healthTemperature => 'Temperatura corporal';

  @override
  String get healthSleep => 'Sono';

  @override
  String get healthDistance => 'Distância';

  @override
  String get healthFloors => 'Andares subidos';

  @override
  String get healthElevation => 'Desnível subido';

  @override
  String get healthActiveKcal => 'Calorias ativas';

  @override
  String get healthNoData => 'Ainda sem dados';

  @override
  String get healthReadFailed => 'Não foi possível ler';

  @override
  String get healthAllow => 'Toca para permitir';

  @override
  String get healthLast7 => 'Últimos 7 dias';

  @override
  String get healthAvg30 => 'Média 30 dias';

  @override
  String get healthLow => 'Mínimo';

  @override
  String get healthHigh => 'Máximo';

  @override
  String get healthFrom => 'Do Health Connect · últimos 30 dias';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'resp/min';

  @override
  String get weekTab => 'Semana';

  @override
  String get muscleSetsList => 'Séries por músculo';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Opcional. Deixa em branco o que o rótulo não diz.';

  @override
  String get sessionPhotos => 'Fotos do treino';

  @override
  String get sessionPhotosAdd => 'Adicionar fotos';

  @override
  String get sessionPhotosHint => 'Também ficam em Suas fotos.';

  @override
  String get ladderTitle => 'Progressão';

  @override
  String get ladderHint =>
      'Ordena os passos do mais fácil ao mais difícil. Quando fizeres 3 séries de 8 duas sessões seguidas (5 nos lentos), o GymMane propõe o seguinte.';

  @override
  String get ladderBuiltIn =>
      'Parte da progressão da app. Adiciona, remove ou reordena passos e passa a ser a desta rotina.';

  @override
  String get ladderNone => 'Ainda não tem. Toca para criar uma.';

  @override
  String ladderStep(int n, int total) {
    return 'Passo $n de $total';
  }

  @override
  String get ladderAdd => 'Adicionar passo';

  @override
  String get ladderInRoutine => 'Na rotina';

  @override
  String get ladderClear => 'Usar a da app';

  @override
  String get ladderPick => 'Escolhe um passo';

  @override
  String get periodWeek => 'esta semana';

  @override
  String get periodMonth => 'este mês';

  @override
  String get periodYear => 'este ano';

  @override
  String get periodAll => 'desde sempre';

  @override
  String get settingsSearch => 'Pesquisar definições';

  @override
  String get settingsNoResults => 'Nenhuma definição com esse nome';

  @override
  String get settingsGroupApp => 'A tua app';

  @override
  String get settingsGroupHome => 'Início e extras';

  @override
  String get settingsGroupData => 'Dados e ajuda';

  @override
  String get healthAllowAll => 'Ativar tudo';

  @override
  String get healthSeeAll => 'Ver tudo';

  @override
  String get healthPinTitle => 'No cartão';

  @override
  String get healthPinHint => 'Escolhe até 3 para o cartão de Progresso.';

  @override
  String get blurSetting => 'Efeitos de desfoque';

  @override
  String get blurSettingHint => 'Desliga se o telemóvel estiver lento';

  @override
  String get lowEndTitle => 'O teu telemóvel tem pouca memória';

  @override
  String get lowEndBody =>
      'Sem desfoque tudo fica mais fluido. Podes voltar a ligá-lo em Definições → Geral.';

  @override
  String get lowEndOff => 'Desligar desfoque';

  @override
  String get lowEndKeep => 'Manter';

  @override
  String get momentsThisMonth => 'Este mês';

  @override
  String get momentsDays => 'Dias com foto';

  @override
  String get awardsPick => 'Escolher para o perfil';

  @override
  String get awardsPickHint => 'Toca nas que queres no teu perfil';

  @override
  String get gymPassPicture => 'Guardar uma foto do código';

  @override
  String get gymPassPictureHint => 'Para códigos que a app não lê: mostra a tua foto com o brilho no máximo';

  @override
  String get gymPassPictureFormat => 'Foto';

  @override
  String get gymPassUsePicture => 'Guardar a foto';

  @override
  String get gymPassChangePicture => 'Mudar a foto';

  @override
  String get cropTitle => 'Recorta o código';

  @override
  String get cropHint => 'Arrasta os cantos até ficar só o código';

  @override
  String get rotatePhoto => 'Rodar';

  @override
  String get cardioNoSets => 'O cardio não conta para as tuas séries por músculo da semana';

  @override
  String get countsAsWater => 'Counts toward water';

  @override
  String get countsAsWaterHint => 'For shakes made with water: logging it adds to your water too';

  @override
  String get waterPerServing => 'Water per serving';

  @override
  String get estOneRm => '1RM estimado';

  @override
  String get newInWorkout => 'Novo neste treino';

  @override
  String newInWorkoutHint(String routine) {
    return 'Adiciona-o a $routine com as séries que acabaste de fazer. O resto da rotina não muda.';
  }

  @override
  String get addedToRoutine => 'Adicionado';

  @override
  String get addShort => 'Adicionar';

  @override
  String get allTimeLifted => 'LEVANTADO';

  @override
  String get pctBodyweight => '% do peso';

  @override
  String get ofBodyweight => 'do teu peso';

  @override
  String get recoveryStateMid => 'A recuperar';

  @override
  String get recoveryStateReady => 'Pronto';

  @override
  String recoveringIn(String time) {
    return 'A recuperar em $time';
  }

  @override
  String readyIn(String time) {
    return 'Pronto em $time';
  }

  @override
  String get recoveryReadyNow => 'Pronto para treinar outra vez';

  @override
  String get restAfterThisSet => 'Descanso após esta série';

  @override
  String restUsual(String time) {
    return 'Habitual: $time';
  }

  @override
  String get restJustToday => 'Só para esta série, hoje';

  @override
  String get restUseUsual => 'Voltar ao descanso habitual';

  @override
  String get restChange => 'Mudar';

  @override
  String get noRestTimer => 'Sem temporizador';

  @override
  String get sessionMuscles => 'Músculos deste treino';

  @override
  String get sessionMusclesHint =>
      'Fraco ainda falta, vivo já está feito. Séries por músculo, os secundários contam metade.';

  @override
  String get miniBodySetting => 'Mapa muscular pequeno nas rotinas';

  @override
  String get miniBodySettingHint => 'Músculos de cada rotina';

  @override
  String get balanceTitle => 'Equilíbrio de força';

  @override
  String get balanceWhy => 'Como funciona';

  @override
  String get balanceGood => 'Os teus exercícios base estão equilibrados';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift está atrasado: faltam cerca de $gap';
  }

  @override
  String get balanceHint =>
      'Compara os teus 1RM estimados dos últimos 4 meses com proporções clássicas: agachamento 100 %, peso morto 120 %, supino 75 %, remada 52 %, press militar 45 %. Um exercício muito abaixo dos outros costuma ser um ponto fraco.';

  @override
  String get balanceEven => 'Equilibrado';

  @override
  String get balanceBehindShort => 'Atrás';

  @override
  String get balanceAheadShort => 'À frente';

  @override
  String get holdProgress => 'Progressão por tempo';

  @override
  String get holdProgressHint => 'Soma segundos quando aguentas todas as séries';

  @override
  String holdProgressOn(int s) {
    return '+$s s cada vez que aguentas todas as séries';
  }

  @override
  String get paceTitle => 'Ritmo semanal';

  @override
  String get paceOn => 'Bom ritmo';

  @override
  String get paceTooFast => 'Mais rápido do que o teu intervalo';

  @override
  String get paceTooSlow => 'Mais lento do que o teu intervalo';

  @override
  String get paceWrongWay => 'No sentido contrário';

  @override
  String get paceDrifting => 'Mexe-se mais do que manter permite';

  @override
  String get paceSetAim => 'Toca para escolher o objetivo';

  @override
  String get paceBasis =>
      'Tendência das tuas pesagens das últimas 3 semanas, para um jantar salgado não te enganar.';

  @override
  String get paceAimTitle => 'Qual é o teu objetivo?';

  @override
  String get paceAimHint => 'O cartão diz-te se o ritmo encaixa';

  @override
  String get paceLose => 'Perder';

  @override
  String get paceHold => 'Manter';

  @override
  String get paceGain => 'Ganhar';

  @override
  String get paceAuto => 'Automático';

  @override
  String get paceLoseRange => '0,5 a 1 % do teu peso por semana';

  @override
  String get paceHoldRange => 'Dentro de 0,25 % por semana';

  @override
  String get paceGainRange => '0,25 a 0,5 % do teu peso por semana';

  @override
  String get paceAutoHint => 'A partir do teu peso objetivo';

  @override
  String get weekShort => 'sem.';

  @override
  String get weightStack => 'Pilha de pesos';

  @override
  String get weightStackHint => 'Os pesos reais desta máquina. + e −, progressão e descargas só caem neles.';

  @override
  String get weightStackOff => 'Desligada: saltos de peso normais';

  @override
  String get stackFrom => 'De';

  @override
  String get stackTo => 'Até';

  @override
  String get stackEvery => 'A cada';

  @override
  String get stackFill => 'Preencher a pilha';

  @override
  String get stackTapToFix => 'Toca num peso para corrigir um estranho ou tirá-lo.';

  @override
  String get stackAddWeight => 'Adicionar um peso';

  @override
  String get stackEditWeight => 'Peso no pino';

  @override
  String get stackClear => 'Tirar a pilha';

  @override
  String stackCount(int n) {
    return '$n pesos';
  }

  @override
  String get healthLinksTitle => 'Com os teus treinos';

  @override
  String get healthLinkHeart => 'Frequência cardíaca do relógio';

  @override
  String get healthLinkHeartHint => 'Frequência média e máxima de cada treino, seja qual for o relógio';

  @override
  String get healthLinkWeight => 'Pesagens de outras apps';

  @override
  String get healthLinkWeightHint =>
      'As pesagens da tua balança dos últimos 30 dias. Nunca substitui uma que escreveste.';

  @override
  String get healthLinkDenied => 'O Health Connect não deu permissão';

  @override
  String get healthOpenSettings => 'Abrir';

  @override
  String hrMaxShort(int bpm) {
    return 'máx. $bpm';
  }

  @override
  String get setNote => 'Nota desta série';

  @override
  String get setNoteHint => 'Pegada, um incômodo, uma dica que funcionou…';

  @override
  String setNoteLast(String note) {
    return 'Da última vez: $note';
  }

  @override
  String get lastTimeNotes => 'Da última vez';

  @override
  String setNoteLine(int n, String note) {
    return 'Série $n · $note';
  }

  @override
  String get newMeasure => 'Nova medida';

  @override
  String get newMeasureHint => 'O que quiser acompanhar: pulso, frequência em repouso, água corporal…';

  @override
  String get measureKindLength => 'Comprimento';

  @override
  String get measureKindLengthHint => 'Em cm ou polegadas, como as outras';

  @override
  String get measureKindOther => 'Outra';

  @override
  String get measureKindOtherHint => 'Com a sua própria unidade';

  @override
  String get measureUnit => 'Unidade';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Pulso, frequência em repouso…';

  @override
  String get measureRename => 'Renomear';

  @override
  String measureDeleteTitle(String name) {
    return 'Apagar $name?';
  }

  @override
  String get measureDeleteBody => 'Todos os valores que você anotou para ela vão junto.';

  @override
  String get measureDelete => 'Apagar esta medida';

  @override
  String get measureEvery => 'Lembrar de medir';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Em $n dias',
      one: 'Amanhã',
      zero: 'Hoje',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'Hora de medir';

  @override
  String get notifMeasureChannel => 'Medidas corporais';

  @override
  String get notifMeasureChannelWhy => 'Um aviso quando for hora de medir de novo.';

  @override
  String get notifMeasureTitle => 'Hora de se medir';

  @override
  String notifMeasureBody(int n) {
    return '$n dias desde a última vez. Mesmo lugar, mesma hora do dia.';
  }

  @override
  String get healthLinkWrite => 'Salvar seus treinos';

  @override
  String get healthLinkWriteHint =>
      'Cada treino terminado vai para o Health Connect com horário e tipo, para outros apps também contarem. Envia também os últimos 30 dias.';

  @override
  String get healthWorkoutTitle => 'Treino';

  @override
  String get circuits => 'Circuitos por tempo';

  @override
  String get circuitsHint => 'Trabalho e descanso no relógio, rodada após rodada';

  @override
  String get newCircuit => 'Novo circuito';

  @override
  String get editCircuit => 'Editar circuito';

  @override
  String get circuitDefaultName => 'Circuito';

  @override
  String get circuitNameHint => 'Nome, como Finalizador de core';

  @override
  String get circuitRounds => 'Rodadas';

  @override
  String get circuitRoundRest => 'Descanso entre rodadas';

  @override
  String get circuitWork => 'Trabalho';

  @override
  String get circuitRest => 'Pausa';

  @override
  String get circuitAdd => 'Adicionar exercício';

  @override
  String get circuitEmpty =>
      'Adicione os exercícios na ordem em que vai fazê-los. Um pode aparecer duas vezes, como a prancha lateral de cada lado.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      steps,
      locale: localeName,
      other: '$steps exercícios',
      one: '1 exercício',
    );
    String _temp1 = intl.Intl.pluralLogic(
      rounds,
      locale: localeName,
      other: '$rounds rodadas',
      one: '1 rodada',
    );
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Começar';

  @override
  String get circuitGetReady => 'Prepare-se';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Rodada $n de $total';
  }

  @override
  String circuitNext(String name) {
    return 'Próximo: $name';
  }

  @override
  String get circuitFinishLine => 'O último e pronto';

  @override
  String get circuitDone => 'Circuito feito';

  @override
  String circuitDoneBody(String time) {
    return '$time · salvo no seu histórico';
  }

  @override
  String get circuitStopTitle => 'Parar o circuito?';

  @override
  String get circuitStopBody => 'O que você já fez fica salvo no histórico.';

  @override
  String get circuitStop => 'Parar';

  @override
  String get circuitKeepGoing => 'Continuar';

  @override
  String circuitDeleteTitle(String name) {
    return 'Apagar $name?';
  }

  @override
  String get circuitDeleteBody => 'Os treinos que você já fez com ele ficam no histórico.';

  @override
  String get circuitPickExercise => 'Escolha um exercício';

  @override
  String get circuitNoSteps => 'Adicione pelo menos um exercício';

  @override
  String get circuitPrevious => 'Anterior';

  @override
  String get circuitUpNext => 'Agora vem';

  @override
  String get foodGroupNew => 'New category';

  @override
  String get foodGroupHint => 'Ready meals, frozen…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n foods',
      one: '1 food',
      zero: 'No foods yet',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get foodGroupDeleteBody => 'Your foods stay, just without this category.';

  @override
  String onbHello(String name) {
    return 'Olá, $name';
  }

  @override
  String get onbPlaceHero => 'exercícios que você pode fazer';

  @override
  String get settingsRests => 'Descansos';

  @override
  String get settingsDuring => 'Durante o treino';

  @override
  String get settingsLook => 'Aparência';

  @override
  String get importCardTitle => 'Traz os teus treinos para aqui';

  @override
  String get importCardBody => 'Do Hevy, Strong, FitNotes e mais';

  @override
  String get checkInTitle => 'Como você estava?';

  @override
  String get checkInSleep => 'Sono';

  @override
  String get checkInEnergy => 'Energia';

  @override
  String get checkInSkip => 'Opcional';

  @override
  String get checkInLevel1 => 'Péssimo';

  @override
  String get checkInLevel2 => 'Fraco';

  @override
  String get checkInLevel3 => 'Ok';

  @override
  String get checkInLevel4 => 'Bom';

  @override
  String get checkInLevel5 => 'Ótimo';

  @override
  String get checkInSetting => 'Sono e energia';

  @override
  String get checkInSettingHint => 'Perguntar ao terminar cada treino';

  @override
  String get readinessTitle => 'Sono e energia';

  @override
  String get readinessWaiting => 'Continue avaliando seus treinos';

  @override
  String get readinessWaitingHint =>
      'Depois de alguns dias bons e ruins você vai ver como eles mudam suas cargas.';

  @override
  String readinessSleepLess(int n) {
    return 'Nos dias de pouco sono você levanta $n% menos';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Curioso: nos dias de pouco sono você levanta $n% mais';
  }

  @override
  String get readinessSleepNone => 'O sono quase não muda suas cargas';

  @override
  String readinessEnergyLess(int n) {
    return 'Nos dias de pouca energia você levanta $n% menos';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'Nos dias de pouca energia você ainda levanta $n% mais';
  }

  @override
  String get readinessEnergyNone => 'Sua energia quase não muda suas cargas';

  @override
  String get readinessHint => 'Compara cada 1RM estimado com o seu melhor dos 90 dias anteriores.';

  @override
  String get readinessLast30 => 'Média dos últimos 30 dias';

  @override
  String get kindSport => 'Esporte';

  @override
  String get clearWorkouts => 'Apagar só os treinos';

  @override
  String get clearWorkoutsNone => 'Não há treinos para apagar';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Apagar $n treinos?',
      one: 'Apagar 1 treino?',
    );
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Seu histórico, recordes e medalhas vão embora. Rotinas, exercícios, fotos, medidas, nutrição e ajustes ficam. Exporte um backup antes se quiser recuperá-los.';

  @override
  String get clearWorkoutsConfirm => 'Apagar treinos';

  @override
  String get clearWorkoutsDone => 'Treinos apagados';

  @override
  String get reportTitle => 'Relatório';

  @override
  String get reportHint => 'Escolha as datas e compartilhe em PDF ou CSV';

  @override
  String get reportCustom => 'Outro';

  @override
  String get reportPickRange => 'Escolher datas';

  @override
  String get reportEmpty => 'Nada registrado entre essas datas.';

  @override
  String get reportKicker => 'RELATÓRIO DE TREINO';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dias', one: '1 dia');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'TREINOS';

  @override
  String get reportPerWeek => 'POR SEMANA';

  @override
  String get reportHours => 'HORAS';

  @override
  String get reportVsPrev => 'As porcentagens comparam com o mesmo número de dias logo antes.';

  @override
  String get reportRecords => 'Novos recordes';

  @override
  String get reportLifts => 'Exercícios';

  @override
  String get reportSessionsCol => 'DIAS';

  @override
  String get reportBestCol => 'MELHOR 1RM';

  @override
  String get reportChangeCol => 'MUDANÇA';

  @override
  String get reportBestHint =>
      'O melhor 1RM é estimado a partir das suas séries. A mudança compara o primeiro e o último dia do exercício neste relatório.';

  @override
  String get reportMuscles => 'Séries por músculo';

  @override
  String get reportBody => 'Corpo e recuperação';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nutrição · média de $n dias',
      one: 'Nutrição · média de 1 dia',
    );
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n novos recordes',
      one: '1 novo recorde',
    );
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n exercícios', one: '1 exercício');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal e $protein g de proteína por dia · $days dias registrados';
  }

  @override
  String get reportSharePdf => 'Compartilhar PDF';

  @override
  String get reportShareCsv => 'Exportar CSV';

  @override
  String get reportShareCsvBoth => 'Exportar CSV (treinos e nutrição)';

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
  String get fastTracker => 'Intermittent fasting';

  @override
  String fastTitle(int fast, int eat) {
    return 'Fasting $fast:$eat';
  }

  @override
  String get fastOptions => 'Fasting options';

  @override
  String get fastWindowOpen => 'Eating window open';

  @override
  String get fastLeft => 'Left';

  @override
  String get fastDoneLabel => 'Goal reached';

  @override
  String get fastIdle => 'Start it after your last meal';

  @override
  String fastLast(String time) {
    return 'Last fast: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n in a row';
  }

  @override
  String fastReached(String time) {
    return '$time past your goal';
  }

  @override
  String fastEndsAt(String time) {
    return 'Ends at $time';
  }

  @override
  String fastSince(String time) {
    return 'Since $time';
  }

  @override
  String get fastStartedAt => 'When did you start fasting?';

  @override
  String get fastStart => 'Start fast';

  @override
  String fastFromMeal(String time) {
    return 'From $time';
  }

  @override
  String get fastEnd => 'End fast';

  @override
  String get fastCancel => 'Cancel this fast';

  @override
  String get fastPlan => 'Fasting plan';

  @override
  String get fastPlanHint => 'Hours fasting : hours to eat';

  @override
  String get fastThisWeek => 'Last 7 days';

  @override
  String get fastCount => 'Fasts';

  @override
  String get fastReachedCount => 'Reached';

  @override
  String get fastAverage => 'Average';

  @override
  String get fastHistory => 'Recent fasts';

  @override
  String get notifFastLiveChannel => 'Fasting in progress';

  @override
  String get notifFastLiveChannelWhy => 'A quiet countdown while you fast.';

  @override
  String get notifFastChannel => 'Fasting';

  @override
  String get notifFastChannelWhy => 'Tells you when your fast is done.';

  @override
  String get notifFastLiveTitle => 'Fasting';

  @override
  String notifFastLiveBody(String time) {
    return 'Your eating window opens at $time';
  }

  @override
  String get notifFastDoneTitle => 'Fast done';

  @override
  String notifFastDoneBody(int n) {
    return '$n hours. Your eating window is open.';
  }

  @override
  String get newExerciseHint => 'Só o nome é obrigatório. O resto ajuda, mas você pode adicionar depois.';

  @override
  String get supportThanksTitle => 'Obrigado por estar aqui 🤍';

  @override
  String get supportThanksBody =>
      'O GymMane é grátis e sempre será, sem anúncios e nada escondido.\n\nSe ele te ajuda a treinar, me pagar um café alegra o meu dia ☕\nE se não der, tudo bem: uma estrela no GitHub também ⭐';

  @override
  String get perfSetting => 'Performance';

  @override
  String get perfSheetHint => 'How much of your phone GymMane uses. You can change each part below.';

  @override
  String get perfLite => 'Saver';

  @override
  String get perfLiteHint => 'No blur and calmer motion. For phones that struggle.';

  @override
  String get perfBalanced => 'Balanced';

  @override
  String get perfBalancedHint => 'Blur and animations without draining the battery.';

  @override
  String get perfMax => 'Maximum';

  @override
  String perfMaxHint(int hz) {
    return 'Finer blur and the screen at $hz Hz. For high-end phones.';
  }

  @override
  String get perfMaxHintNoHz => 'Finer blur everywhere. For high-end phones.';

  @override
  String get perfCustom => 'Custom';

  @override
  String get perfTweak => 'Fine-tuning';

  @override
  String get perfFine => 'Fine blur';

  @override
  String get perfFineHint => 'Softer edges and a sharper backdrop behind sheets';

  @override
  String perfHz(int hz) {
    return 'Screen at $hz Hz';
  }

  @override
  String get perfHzHint => 'Everything scrolls smoother, at a little more battery';

  @override
  String get lowEndLiteBody =>
      'Saver mode (no blur, calmer motion) will run smoother on it. You can change it in Settings → General → Performance.';

  @override
  String get lowEndLiteOn => 'Turn on Saver';

  @override
  String get dayOffHint => 'Your streak and the reminder leave this day alone';

  @override
  String get dayOffTrained => 'I trained, just didn\'t log it';

  @override
  String get dayOffSick => 'Illness';

  @override
  String get dayOffTravel => 'Travel';

  @override
  String get dayOffInjury => 'Injury';

  @override
  String get dayOffRest => 'Rest';

  @override
  String get altsTitle => 'Backups';

  @override
  String get altsHint => 'In case the machine is taken';

  @override
  String altsPickHint(int count) {
    return 'Pick up to $count. If the machine is taken, swap in one tap.';
  }

  @override
  String get placeDumbbells => 'Dumbbells';

  @override
  String get dumbbellsHint =>
      'The weight of one dumbbell. Progression and the + and − buttons will only land on these here.';

  @override
  String get dumbbellOther => 'Another weight';

  @override
  String get tuneTitle => 'Today\'s volume';

  @override
  String get tuneHint => 'Tell me how each muscle felt and I\'ll adjust the sets for next time.';

  @override
  String get tuneLess => 'Too little';

  @override
  String get tuneRight => 'Right';

  @override
  String get tuneMore => 'Too much';

  @override
  String tuneNext(String sets, String name) {
    return 'Next time: $sets of $name';
  }

  @override
  String get tuneSame => 'Stays the same next time';

  @override
  String get tuneSetting => 'Tune sets per muscle';

  @override
  String get tuneSettingHint => 'After a routine, rate each muscle and the sets adjust';

  @override
  String insightLoad(int pct) {
    return '$pct % more sets than your usual week. Watch your recovery.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days days untouched.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'You push more than you pull: $a sets against $b in four weeks.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'You pull more than you push: $a sets against $b in four weeks.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: $pct % stronger than last month.';
  }

  @override
  String recapPull(String month) {
    return 'Continue puxando para ver seu $month';
  }

  @override
  String get recapRelease => 'Solte';

  @override
  String recapHi(String name) {
    return 'Olá, $name';
  }

  @override
  String recapReady(String month) {
    return 'Vamos ver o que você fez em $month?';
  }

  @override
  String get recapGo => 'Vamos lá';

  @override
  String recapEmpty(String month) {
    return 'Ainda não há treinos em $month. O primeiro libera tudo.';
  }

  @override
  String get recapClose => 'Fechar';

  @override
  String get recapShare => 'Compartilhar';

  @override
  String get recapWorkoutsKicker => 'Este mês você fez';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'treinos', one: 'treino');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Em $n dias diferentes',
      one: 'Em um só dia',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Tempo sob a barra';

  @override
  String recapLongest(String time, String date) {
    return 'Sessão mais longa: $time, em $date';
  }

  @override
  String get recapVolumeKicker => 'Você moveu';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Como levantar $count carros',
      one: 'Como levantar um carro',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'O que mais: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Músculo do mês';

  @override
  String get recapRecordsKicker => 'Recordes novos';

  @override
  String recapNoRecords(int n) {
    return 'Sem recordes desta vez, mas $n séries na conta.';
  }

  @override
  String get recapHabitKicker => 'Seu momento';

  @override
  String recapHabitStart(String time) {
    return 'Você costuma começar às $time';
  }

  @override
  String get recapShareKicker => 'Seu mês, pronto para compartilhar';

  @override
  String get recapTickWorkouts => 'Treinos';

  @override
  String get recapTickTime => 'Tempo';

  @override
  String get recapTickVolume => 'Carga';

  @override
  String get recapTickRecords => 'Recordes';

  @override
  String recapAvg(int n) {
    return '$n min por treino em média';
  }

  @override
  String get recapLiftKicker => 'Exercício do mês';

  @override
  String get recapBest => 'Melhor';

  @override
  String get recapTimes => 'Dias';

  @override
  String get recapDaysLabel => 'Dias';

  @override
  String get recapAvgLabel => 'Média';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts treinos em $days dias';
  }

  @override
  String get recapFavLabel => 'Seu dia';

  @override
  String get recapWatermark => 'diário de academia grátis';

  @override
  String get recapTickSteps => 'Passos';

  @override
  String get recapTickFood => 'Comida';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n treinos', one: 'um treino');
    return '$minutes min em $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treinos de cardio',
      one: 'Um treino de cardio',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Seu favorito: $name';
  }

  @override
  String get recapStepsKicker => 'Você caminhou';

  @override
  String get recapStepsWord => 'passos';

  @override
  String recapStepsAvg(String value) {
    return '$value por dia em média';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Melhor dia: $value, $date';
  }

  @override
  String get recapFoodKicker => 'No seu prato';

  @override
  String get recapLiftRest => 'Logo atrás';

  @override
  String recapSameAs(String month) {
    return 'Igual a $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value a mais que em $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value a menos que em $month';
  }

  @override
  String get recapTickMedals => 'Medalhas';

  @override
  String get recapTickSleep => 'Sono';

  @override
  String get recapMedalsKicker => 'Medalhas que você ganhou';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'E mais $n', one: 'E mais uma');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Você dormiu';

  @override
  String get recapSleepAvg => 'por noite em média';

  @override
  String recapSleepBest(String value, String date) {
    return 'Melhor noite: $value, $date';
  }

  @override
  String get recapCardSummary => 'Resumo';

  @override
  String get recapCardCalendar => 'Calendário';

  @override
  String get recapCardLift => 'Exercício';

  @override
  String get recapPeakKicker => 'Sua sessão mais dura';

  @override
  String get recapTickPeak => 'Sessão';

  @override
  String get recapFreshKicker => 'Primeira vez este mês';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'exercícios novos',
      one: 'exercício novo',
    );
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Novo';

  @override
  String recapStreak(int n) {
    return '$n dias seguidos, sua maior sequência';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n treinos', one: '1 treino');
    return 'Há um ano: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Ficou de fora este mês: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'de proteína por dia · meta $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'No seu prato $n dias',
      one: 'No seu prato 1 dia',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Proteína · g/dia';

  @override
  String get recapFoodGoalDays => 'Meta cumprida';

  @override
  String get recapFoodWaterLabel => 'Água/dia';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dias', one: '1 dia');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Sua comida do mês';

  @override
  String get onbSpeedTitle => 'Make it run smooth';

  @override
  String get onbSpeedWhy =>
      'Your phone seems to be working hard. Turn these off and everything will flow better: try them and watch the preview.';

  @override
  String get onbSpeedMotion => 'Animations';

  @override
  String get onbSpeedBlurHint => 'Frosted glass behind sheets and bars';

  @override
  String get onbSpeedMotionHint => 'Screens and sheets that slide in';

  @override
  String get onbSpeedLater => 'You can change it anytime in Settings › General › Performance.';

  @override
  String get notifSoundSetting => 'Notification sounds';

  @override
  String get notifSoundRowHint => 'How each kind of reminder sounds';

  @override
  String get notifSoundHint =>
      'Pick a sound for each kind of reminder. From phone opens your phone sounds, and on most phones you can add your own song there.';

  @override
  String get notifSoundTrain => 'Workouts';

  @override
  String get notifSoundFood => 'Food, supplements and fasting';

  @override
  String get notifSoundOther => 'Photos and measurements';

  @override
  String get notifSoundNormal => 'Normal';

  @override
  String get notifSoundPhone => 'From phone';

  @override
  String get notifSoundSilent => 'Silent';

  @override
  String get notifSoundPhoneHint => 'Tap one to hear it. It saves right away.';

  @override
  String get notifSoundMore => 'Another file…';

  @override
  String get notifSoundChange => 'Change';

  @override
  String get workoutNoteAdd => 'Pinned note: seat, grip, machine…';

  @override
  String get autoProgressSetting => 'Auto progression';

  @override
  String get autoProgressRowHint => 'What it suggests for next time';

  @override
  String get autoProgressOff => 'Off';

  @override
  String get autoProgressWeight => 'Add weight';

  @override
  String get autoProgressReps => 'Add reps';

  @override
  String get autoProgressHint =>
      'When you start a workout, GymMane fills in the next step for each exercise. With Add reps you add one rep per set up to 12, then the weight goes up and you start again at 8. You can still tune each exercise on its page.';

  @override
  String get noteFolders => 'Folders';

  @override
  String get noteFolderNew => 'New folder';

  @override
  String get noteFolderEdit => 'Edit folder';

  @override
  String get noteFolderName => 'Folder name';

  @override
  String get noteFolderLabel => 'Folder';

  @override
  String get noteFolderNone => 'No folder';

  @override
  String get noteFolderDelete => 'Delete the folder?';

  @override
  String get noteFolderDeleteBody => 'Notes are kept: they just leave the folder.';

  @override
  String get foodArchivedToast => 'Food archived';

  @override
  String get planArchivedToast => 'Plan archived';

  @override
  String get suppArchivedToast => 'Supplement archived';

  @override
  String get voiceSetting => 'Workout voice';

  @override
  String get voiceSettingHint =>
      'Says your next set and counts down the end of the rest, with the phone voice';

  @override
  String get voiceHello => 'Voice on';

  @override
  String voiceRest(String time) {
    return 'Rest $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Next: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps reps at $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps reps';
  }

  @override
  String get voiceGo => 'Let\'s go!';

  @override
  String get deloadSetting => 'Deload week';

  @override
  String get deloadOff => 'Never';

  @override
  String deloadEvery(int weeks) {
    return 'Every $weeks weeks';
  }

  @override
  String get deloadHint =>
      'Every few weeks, an easier one to recover: half the sets and 10 % less weight. That week does not count for progression.';

  @override
  String get deloadRowHint => 'An easy week every few weeks';

  @override
  String get deloadNow => 'Deload week';

  @override
  String get deloadNowHint => 'Today, half the sets and 10 % less weight';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'In $weeks weeks',
      one: 'Next week',
      zero: 'This week',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Train as usual';

  @override
  String get voiceSheetTitle => 'How the voice works';

  @override
  String get voicePointRest => 'When you tick a set, it tells you the rest time and what comes next.';

  @override
  String get voicePointCount => 'It counts 3, 2, 1 at the end of the rest and calls you back.';

  @override
  String get voicePointPhone => 'It uses your phone\'s voice and plays over your music.';

  @override
  String get voiceTry => 'Try the voice';

  @override
  String get voiceNoEngine => 'Your phone has no voice engine turned on.';

  @override
  String get voiceNoLang => 'Your language\'s voice is missing. Download it in your phone\'s voice settings.';

  @override
  String get voiceOpenSettings => 'Voice settings';

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
      other: '$count seconds',
      one: '1 second',
    );
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'and';
}
