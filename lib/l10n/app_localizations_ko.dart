// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get languageName => '한국어';

  @override
  String vsLastMonthLabel(String pct) {
    return '지난달 대비 $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return '레벨 $level · $streak';
  }

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get cancelCaps => '취소';

  @override
  String get deleteCaps => '삭제';

  @override
  String get done => '완료';

  @override
  String get set => '세트';

  @override
  String get home => '홈';

  @override
  String get progress => '진행 상황';

  @override
  String get exercises => '운동';

  @override
  String get settings => '설정';

  @override
  String get today => '오늘';

  @override
  String get thisWeek => '이번 주';

  @override
  String get recommended => '추천';

  @override
  String get goal => '목표';

  @override
  String get volume => '볼륨';

  @override
  String get setsToday => '오늘의 세트';

  @override
  String get prs => '기록';

  @override
  String get todaysFocus => '오늘의 초점';

  @override
  String get todaysRoutine => '오늘의 루틴';

  @override
  String get startWorkout => '운동 시작';

  @override
  String get routines => '루틴';

  @override
  String get tools => '도구';

  @override
  String get firstSessionHint => '운동할 근육을 선택하고 첫 운동을 기록하세요';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n개 운동', one: '$n개 운동');
    return '$_temp0';
  }

  @override
  String get pushDay => '푸시 데이';

  @override
  String get pullDay => '풀 데이';

  @override
  String get legDay => '하체';

  @override
  String get pushFocus => '가슴 · 어깨 · 삼두근';

  @override
  String get pullFocus => '등 · 이두근 · 승모근';

  @override
  String get legFocus => '대퇴사두근 · 햄스트링 · 둔근';

  @override
  String get train => '운동하기';

  @override
  String get step1 => '1/2 단계';

  @override
  String get step2 => '2/2 단계';

  @override
  String get chooseFocus => '초점 선택';

  @override
  String get buildSession => '운동 구성';

  @override
  String get tapMuscles => '운동할 근육을 탭하세요 — 앞면과 뒷면.';

  @override
  String get continueBtn => '계속';

  @override
  String get nothingForFocus => '이 초점에 맞는 운동이 없습니다';

  @override
  String get goBackPick => '뒤로 가서 라이브러리에 운동이 있는 근육을 선택하세요.';

  @override
  String pickedHint(int n) {
    return '운동을 구성했어요 — $n개 운동 중 원하는 항목을 추가하거나 뺄 수 있습니다.';
  }

  @override
  String get pickAnExercise => '운동 선택';

  @override
  String get searchAllExercises => '운동 검색…';

  @override
  String get noExercisesMatch => '일치하는 운동이 없습니다';

  @override
  String get createItInstead => '대신 나만의 운동 만들기';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n개 운동', one: '$n개 운동');
    return '시작 · $_temp0';
  }

  @override
  String get inProgress => '진행 중';

  @override
  String get paused => '일시정지';

  @override
  String get last => '지난번';

  @override
  String get rest => '휴식';

  @override
  String get skip => '건너뛰기';

  @override
  String get addSet => '+ 세트 추가';

  @override
  String get finishSession => '운동 종료';

  @override
  String get setDone => '세트 완료';

  @override
  String get nextExercise => '다음 운동';

  @override
  String get dropExerciseAction => '운동 빼기';

  @override
  String get restOff => '끔';

  @override
  String get setCol => '#';

  @override
  String get repsCol => '반복';

  @override
  String weightCol(String unit) {
    return '중량 ($unit)';
  }

  @override
  String get repsTitle => '반복';

  @override
  String weightTitle(String unit) {
    return '중량 ($unit)';
  }

  @override
  String get sessionComplete => '운동 기록 완료';

  @override
  String get finishHeadlinePr => '새 개인 기록';

  @override
  String get finishHeadlineGoal => '주간 목표 달성';

  @override
  String get finishHeadlineStreak => '연속 기록 유지';

  @override
  String get finishHeadlineDefault => '운동 하나 더 완료';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs개 운동', one: '1개 운동');
    return '$_temp0에서 역대 최고 중량을 들었습니다. 기록에 저장됐습니다.';
  }

  @override
  String get finishBodyGoal => '이번 주 계획한 운동 횟수를 달성했습니다.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak일 연속. 가장 어려운 건 멈추지 않는 것입니다.';
  }

  @override
  String get finishBodyDefault => '기록하고 집계했습니다. 꾸준함이 수치를 바꿉니다.';

  @override
  String get vsLastTime => '지난번 대비';

  @override
  String get firstTime => '첫 기록';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '새 기록 $n개', one: '새 기록 $n개');
    return '$_temp0';
  }

  @override
  String get duration => '시간';

  @override
  String get setsCaps => '세트';

  @override
  String exerciseXofY(int i, int n) {
    return '운동 $i/$n';
  }

  @override
  String get decrease => '줄이기';

  @override
  String get increase => '늘리기';

  @override
  String markSet(int n) {
    return '세트 $n 완료 표시';
  }

  @override
  String get pauseWorkout => '운동 일시정지';

  @override
  String get resumeWorkout => '운동 재개';

  @override
  String get discardTitle => '운동을 취소할까요?';

  @override
  String get discardBody => '이 운동의 세트 기록이 사라집니다.';

  @override
  String get keepTraining => '계속 운동하기';

  @override
  String get discard => '취소';

  @override
  String get notifRestChannel => '휴식 타이머';

  @override
  String get notifRestChannelWhy => '세트 사이 휴식이 끝나면 알려줍니다';

  @override
  String get notifAlertChannel => '휴식 타이머(알림)';

  @override
  String get notifAlertChannelWhy => '휴식이 끝나는 즉시 배너를 표시합니다';

  @override
  String get restOverTitle => '휴식 종료';

  @override
  String get restOverBody => '다시 시작해요 — 다음 세트가 기다립니다.';

  @override
  String get allTimeSessions => '운동';

  @override
  String get allTimeTime => '시간';

  @override
  String get allTimeSets => '세트';

  @override
  String get consistency => '꾸준함';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '운동 $n회 기록', one: '운동 $n회 기록');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n일 연속';
  }

  @override
  String get bodyweight => '체중';

  @override
  String get logBodyweight => '체중 기록';

  @override
  String get trackWeight => '시간에 따른 체중 변화를 추적하세요';

  @override
  String get muscleMap => '근육 지도';

  @override
  String get days7 => '7일';

  @override
  String get days30 => '30일';

  @override
  String get heatLow => '운동 안 함';

  @override
  String get heatHigh => '최대 볼륨';

  @override
  String get muscleMapEmpty => '운동을 기록하면 여기서 몸이 색으로 채워지기 시작합니다.';

  @override
  String get muscleMapHint => '근육을 탭해 얼마나 운동했는지 확인하세요.';

  @override
  String muscleMapBehind(String names) {
    return '뒤처짐: $names';
  }

  @override
  String ofTarget(int pct) {
    return '목표의 $pct%';
  }

  @override
  String get muscleSplit => '근육 분포';

  @override
  String get personalRecords => '개인 기록';

  @override
  String get strength1rm => '근력 · 예상 1RM';

  @override
  String get strengthEmpty => '같은 운동을 두 번 기록하면 근력 곡선이 표시됩니다.';

  @override
  String oneRmEst(String w) {
    return '예상 1RM: $w';
  }

  @override
  String get restDayShort => '휴식일';

  @override
  String get restDay => '휴식일 — 기록 없음.';

  @override
  String get delete => '삭제';

  @override
  String get deleteEntry => '이 항목을 삭제할까요?';

  @override
  String deleteEntryBody(String name) {
    return '“$name”이(가) 이 날짜와 기록 및 차트에서 삭제됩니다.';
  }

  @override
  String get bodyweightHistory => '기록';

  @override
  String get exercisesCaps => '운동';

  @override
  String get timeCaps => '시간';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '라이브러리에 운동 $n개',
      one: '라이브러리에 운동 $n개',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => '운동 검색';

  @override
  String get muscleFilter => '근육';

  @override
  String get levelFilter => '레벨';

  @override
  String get kindLabel => '종류';

  @override
  String get kindStrength => '근력';

  @override
  String get kindCalisthenics => '맨몸 운동';

  @override
  String get kindCardio => '유산소';

  @override
  String get kindStretch => '스트레칭';

  @override
  String get newExercise => '새 운동';

  @override
  String get exerciseName => '운동 이름';

  @override
  String get equipmentLabel => '장비';

  @override
  String get addExercise => '운동 추가';

  @override
  String get advanced => '고급';

  @override
  String get demoMedia => '데모';

  @override
  String get addMedia => '미디어 추가';

  @override
  String get mediaHint => '이미지, GIF 또는 동영상';

  @override
  String get changeMedia => '변경';

  @override
  String get videoSelected => '동영상 선택됨';

  @override
  String get favouritesOnly => '즐겨찾기';

  @override
  String get noFavouritesYet => '아직 즐겨찾기가 없습니다';

  @override
  String get noFavouritesHint => '운동의 별을 탭해 여기에 저장하세요.';

  @override
  String get clearFilters => '필터 지우기';

  @override
  String get noExercisesFound => '운동을 찾을 수 없습니다';

  @override
  String get noExercisesHint => '다른 검색어를 시도하거나 필터를 지우세요.';

  @override
  String get personalRecord => '개인 기록';

  @override
  String get history => '기록';

  @override
  String get noHistory => '아직 기록된 운동이 없습니다. 이 운동을 수행해 기록을 쌓으세요.';

  @override
  String get notes => '메모';

  @override
  String get notePlaceholder => '팁, 세팅, 느낌…';

  @override
  String notHere(String gear, String place) {
    return '$place에 $gear 없음';
  }

  @override
  String get notHereWhy => '오늘 실제로 사용할 수 있는 것으로 바꾸세요.';

  @override
  String get altHere => '여기서 할 수 있는 운동';

  @override
  String get places => '내 장소';

  @override
  String get placesHint => '각 장소의 장비를 지정하면 그곳에서 할 수 있는 운동만 라이브러리에 표시됩니다.';

  @override
  String get placeAll => '어디서나';

  @override
  String get placeNew => '새 장소';

  @override
  String get placeNamePlaceholder => '집, 헬스장, 공원…';

  @override
  String get placeGearLabel => '사용 가능한 장비';

  @override
  String placeExercises(int n) {
    return '여기서 운동 $n개';
  }

  @override
  String get placeEmptyTitle => '어디서든 운동하세요';

  @override
  String get placeEmptyBody => '장소는 그곳에 있는 장비 목록입니다. 하나를 선택해 시작하고 나중에 수정하세요.';

  @override
  String get placeDeleteTitle => '장소 삭제';

  @override
  String get placeDeleteBody => '장소만 삭제되며 운동과 운동 기록은 유지됩니다.';

  @override
  String get placeGym => '헬스장';

  @override
  String get placeHome => '집';

  @override
  String get placeOutdoors => '야외';

  @override
  String get placeFilterLabel => '장소';

  @override
  String get noGearOnly => '장비 없음';

  @override
  String placeActive(String name) {
    return '$name에서 운동';
  }

  @override
  String get journal => '저널';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '메모 $n개',
      one: '메모 1개',
      zero: '메모 없음',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => '메모';

  @override
  String get noteKindPlan => '계획';

  @override
  String get noteKindDone => '성공';

  @override
  String get noteKindPain => '불편함';

  @override
  String get noteFilterAll => '전체';

  @override
  String get newNote => '새 메모';

  @override
  String get editNote => '메모 수정';

  @override
  String get addNote => '메모 추가';

  @override
  String get noteEmptyTitle => '아직 작성된 내용이 없습니다';

  @override
  String get noteEmptyBody => '팁, 다음 계획, 운동 느낌 등을 기록하세요 — 원하면 사진이나 동영상도 첨부할 수 있습니다.';

  @override
  String get noteNoneForExercise => '이 운동에 대한 메모가 아직 없습니다.';

  @override
  String get noteKindLabel => '유형';

  @override
  String get noteTextLabel => '메모';

  @override
  String get noteDateLabel => '날짜';

  @override
  String get noteExerciseLabel => '운동';

  @override
  String get noteMediaLabel => '사진 및 동영상';

  @override
  String get noteGeneral => '운동 없음';

  @override
  String get noteAttach => '첨부';

  @override
  String get noteRemoveMedia => '첨부 파일 제거';

  @override
  String get deleteNoteTitle => '메모 삭제';

  @override
  String get deleteNoteBody => '메모와 모든 첨부 파일이 영구적으로 삭제됩니다.';

  @override
  String get noteToday => '오늘';

  @override
  String get noteYesterday => '어제';

  @override
  String get noteAllNotes => '모든 메모';

  @override
  String get noteCalendar => '달력';

  @override
  String get noteNoneOnDay => '이 날 작성된 내용이 없습니다';

  @override
  String get noteAddOnDay => '이 날에 메모 추가';

  @override
  String get notePrevMonth => '이전 달';

  @override
  String get noteNextMonth => '다음 달';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '이번 달 메모 $n개',
      one: '이번 달 메모 1개',
      zero: '이번 달 메모 없음',
    );
    return '$_temp0';
  }

  @override
  String get measures => '신체 측정';

  @override
  String get measuresHint => '목부터 종아리까지 — 바벨 무게뿐 아니라 몸의 변화도 확인하세요.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '측정 $n개',
      one: '측정 1개',
      zero: '측정 없음',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => '아직 측정 안 함';

  @override
  String get measureHistory => '기록';

  @override
  String get measureNeck => '목';

  @override
  String get measureShoulders => '어깨';

  @override
  String get measureChest => '가슴';

  @override
  String get measureArm => '팔';

  @override
  String get measureForearm => '전완';

  @override
  String get measureWaist => '허리';

  @override
  String get measureHips => '엉덩이';

  @override
  String get measureThigh => '허벅지';

  @override
  String get measureCalf => '종아리';

  @override
  String get measureBodyfat => '체지방';

  @override
  String get timeline => '타임라인';

  @override
  String get timelineHint => '같은 포즈, 같은 장소, 같은 조명. 1년 뒤에는 믿기 어려울 거예요.';

  @override
  String get timelineEmptyTitle => '첫 사진부터 추적이 시작됩니다';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '사진 $n장',
      one: '사진 1장',
      zero: '사진 없음',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => '정면';

  @override
  String get poseSide => '측면';

  @override
  String get poseBack => '후면';

  @override
  String get photoEvery => '알림 설정';

  @override
  String photoEveryDays(int n) {
    return '$n일마다';
  }

  @override
  String get photoEveryOff => '안 함';

  @override
  String get timelineEvery => '간격별 그룹화';

  @override
  String get custom => '사용자 지정';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '다음 사진까지 $n일', one: '다음 사진은 내일');
    return '$_temp0';
  }

  @override
  String get photoDueNow => '사진 촬영일입니다 — 오늘 찍으세요';

  @override
  String get addTodayPhotos => '오늘 사진 추가';

  @override
  String posePhoto(String pose) {
    return '$pose 사진';
  }

  @override
  String get compare => '비교';

  @override
  String get compareNeedTwo => '같은 포즈를 서로 다른 두 날에 촬영하면 여기서 비교할 수 있습니다.';

  @override
  String dayNumber(int n) {
    return '$n일차';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n일 간격', one: '1일 간격', zero: '같은 날');
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => '이 날짜 삭제';

  @override
  String get deleteDayBody => '이 날의 사진도 영구적으로 삭제됩니다.';

  @override
  String get timelinePhotos => '사진';

  @override
  String get timelineBody => '근육 지도';

  @override
  String get timelineBodyEmpty => '운동을 기록하면 근육 지도가 채워지기 시작합니다 — 사진은 필요 없습니다.';

  @override
  String get timelineBodyHint => '내 세트 기록으로 생성되며 아무것도 업로드되지 않습니다.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '운동 $n회',
      one: '운동 1회',
      zero: '운동 없음',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => '진행 사진';

  @override
  String get notifPhotoChannelWhy => '다음 진행 사진 촬영 시기를 알려줍니다.';

  @override
  String get notifPhotoTitle => '진행 사진을 찍을 시간입니다';

  @override
  String notifPhotoBody(int n) {
    return '지난 사진 후 $n일. 같은 포즈, 같은 조명으로 찍으세요.';
  }

  @override
  String get share => '공유';

  @override
  String get sharePick => '무엇을 보여줄까요?';

  @override
  String get shareStreak => '연속 기록과 꾸준함';

  @override
  String get shareBody => '운동한 근육';

  @override
  String get shareCompare => '전 / 후';

  @override
  String get shareHint => '카드는 휴대전화에서 생성됩니다. 공유할 곳을 선택하기 전까지 아무것도 밖으로 나가지 않습니다.';

  @override
  String get shareFailed => '카드를 만들 수 없습니다';

  @override
  String get shareWeekOf => '최근 7일';

  @override
  String get shareStreakLabel => '연속 일수';

  @override
  String get shareSessionsLabel => '운동';

  @override
  String get shareVolumeLabel => '볼륨';

  @override
  String get restForExercise => '이 운동의 휴식';

  @override
  String get restUsingDefault => '기본 시간 사용';

  @override
  String get restCustom => '이 운동에만';

  @override
  String get setType => '세트 유형';

  @override
  String get setTypeNormal => '본 세트';

  @override
  String get setTypeWarmup => '워밍업';

  @override
  String get setTypeDrop => '드롭 세트';

  @override
  String get setTypeFailure => '실패 지점까지';

  @override
  String get addWarmup => '워밍업';

  @override
  String platesPerSide(String plates) {
    return '한쪽당: $plates';
  }

  @override
  String get howTo => '수행 방법';

  @override
  String get similar => '유사 운동';

  @override
  String get primaryLabel => '주요';

  @override
  String get secondaryLabel => '보조';

  @override
  String get none => '없음';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n세트', one: '$n세트');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '볼륨 $v';
  }

  @override
  String get weeklyPlan => '주간 계획';

  @override
  String get yourRoutines => '내 루틴';

  @override
  String get noRoutines => '아직 루틴이 없습니다. 하나 만들고 운동을 추가하세요.';

  @override
  String get newRoutine => '새 루틴';

  @override
  String get routineName => '루틴 이름';

  @override
  String get schedule => '일정';

  @override
  String get addFromList => '아래 목록에서 운동을 추가하세요.';

  @override
  String get addExercises => '운동 추가';

  @override
  String get deleteRoutine => '이 루틴을 삭제할까요?';

  @override
  String exercisesWithCount(int n) {
    return '운동 · $n';
  }

  @override
  String setDay(String day) {
    return '$day 설정';
  }

  @override
  String get newRoutineName => '새 루틴';

  @override
  String get dragToReorder => '점 손잡이를 끌어 순서를 바꾸세요. 이 순서대로 운동해요.';

  @override
  String reorderHandle(String name) {
    return '$name 순서 변경';
  }

  @override
  String get removeFromRoutine => '루틴에서 제거';

  @override
  String get dropExercise => '이 운동을 뺄까요?';

  @override
  String dropExerciseBody(String name) {
    return '“$name”을 이 운동에서 뺍니다. 이미 기록된 내용은 유지됩니다.';
  }

  @override
  String get drop => '빼기';

  @override
  String get resetData => '내 모든 데이터 삭제';

  @override
  String get resetTitle => '모두 삭제할까요?';

  @override
  String get resetBody => '운동, 기록, 루틴, 메모, 프로필이 모두 삭제됩니다. 되돌릴 수 없으니 필요하다면 먼저 백업을 내보내세요.';

  @override
  String get resetConfirm => '모두 삭제';

  @override
  String get resetDone => '모든 데이터가 삭제되었습니다';

  @override
  String get support => '지원';

  @override
  String get reportBug => '버그 신고';

  @override
  String get requestFeature => '기능 제안';

  @override
  String get starOnGithub => 'GitHub에서 별 주기';

  @override
  String get buyCoffee => '커피 사주기';

  @override
  String get cantOpenLink => '링크를 열 수 없습니다';

  @override
  String get theme => '테마';

  @override
  String get darkTheme => '다크';

  @override
  String get lightTheme => '라이트';

  @override
  String get editDuration => '운동 시간';

  @override
  String get languageLabel => '언어';

  @override
  String get unitsLabel => '단위';

  @override
  String get restTimer => '휴식 타이머';

  @override
  String get alarmBlockedTitle => '알림이 꺼져 있습니다';

  @override
  String get alarmBlockedBody => '화면이 잠겨 있으면 휴식 알람이 울리지 않습니다';

  @override
  String get alarmBlockedAction => '켜기';

  @override
  String get alarmSound => '알람 소리';

  @override
  String get alarmDefaultName => '기본값';

  @override
  String get alarmSoundHint => '직접 고른 소리 사용 — 최대 15초';

  @override
  String get alarmChoose => '소리 선택…';

  @override
  String get alarmPreview => '현재 소리 재생';

  @override
  String get alarmReset => '기본 소리로 재설정';

  @override
  String get alarmTooLong => '이 소리는 15초보다 깁니다';

  @override
  String get alarmInvalid => '이 오디오 파일을 읽을 수 없습니다';

  @override
  String alarmChanged(String name) {
    return '알람 소리가 “$name”(으)로 설정되었습니다';
  }

  @override
  String get alarmChangedDefault => '기본 소리로 돌아갔습니다';

  @override
  String get addActivityWidget => '활동 위젯 추가';

  @override
  String get addStatsWidget => '통계 위젯 추가';

  @override
  String get pinUnsupported => '런처의 위젯 메뉴에서 추가하세요';

  @override
  String get background => '배경';

  @override
  String get bgNone => '없음';

  @override
  String get bgDots => '점';

  @override
  String get bgGrid => '그리드';

  @override
  String get exportCsv => '운동 내보내기(CSV)';

  @override
  String get exportBackup => '백업 내보내기(ZIP)';

  @override
  String get importBackup => '백업 가져오기';

  @override
  String get importHint => 'GymMane에서 내보낸 .zip(또는 이전 .json) 백업을 선택하세요. 미디어를 포함한 현재 데이터가 대체됩니다.';

  @override
  String get import => '가져오기';

  @override
  String get chooseFile => '파일 선택';

  @override
  String get importFromApp => '다른 앱에서 가져오기';

  @override
  String get importUnknownFormat => '이 파일에는 날짜, 운동, 반복, 중량 열이 필요합니다';

  @override
  String get importZipNoWeights => '이 zip에 체중 파일이 없습니다';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '체중 기록 $n개 가져옴',
      one: '체중 기록 $n개 가져옴',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => '이 파일을 읽을 수 없습니다';

  @override
  String get importUnitTitle => '이 파일의 단위는 무엇인가요?';

  @override
  String get importUnitBody => '이 내보내기 파일에는 중량 단위가 표시되어 있지 않습니다.';

  @override
  String get importNothing => '새로 가져올 항목이 없습니다';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '운동 $n회 가져옴', one: '운동 $n회 가져옴');
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymMane 정보';

  @override
  String get yourProfile => '내 프로필';

  @override
  String get autofills => '계산기에 자동 입력';

  @override
  String get nameLabel => '이름';

  @override
  String get sexLabel => '성별';

  @override
  String get macroProtein => '단백질';

  @override
  String get macroCarbs => '탄수화물';

  @override
  String get macroFat => '지방';

  @override
  String get male => '남성';

  @override
  String get female => '여성';

  @override
  String get ageLabel => '나이';

  @override
  String get heightLabel => '키';

  @override
  String get weightLabel => '체중';

  @override
  String get weeklyGoal => '주간 목표';

  @override
  String get activityLabel => '활동';

  @override
  String get addPhoto => '사진 추가';

  @override
  String get removePhoto => '사진 제거';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get chooseGallery => '갤러리에서 선택';

  @override
  String get backupImported => '백업을 가져왔습니다';

  @override
  String get backupFailed => '이 백업을 읽을 수 없습니다';

  @override
  String get nothingToExport => '아직 내보낼 내용이 없습니다 — 먼저 운동을 기록하세요';

  @override
  String calculatorsCount(int n) {
    return '운동용 계산기 $n개';
  }

  @override
  String get result => '결과';

  @override
  String get weightLifted => '든 중량';

  @override
  String get repsPerformed => '수행 반복 수';

  @override
  String get neck => '목';

  @override
  String get waist => '허리';

  @override
  String get hip => '엉덩이(여성)';

  @override
  String get targetWeight => '목표 체중';

  @override
  String get workingWeight => '작업 중량';

  @override
  String get activityLevel => '활동 수준';

  @override
  String get barWeight => '바 무게';

  @override
  String get perSide => '한쪽당';

  @override
  String get justTheBar => '바만 사용.';

  @override
  String perSideCount(int n) {
    return '한쪽당 × $n';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => '칼로리';

  @override
  String get toolNameBf => '체지방';

  @override
  String get toolNamePlate => '원판';

  @override
  String get toolNameWarmup => '워밍업';

  @override
  String get toolTitleRm => '1RM 계산기';

  @override
  String get toolTitleBmi => 'BMI 계산기';

  @override
  String get toolTitleCal => '칼로리 및 매크로';

  @override
  String get toolTitleBf => '체지방률';

  @override
  String get toolTitlePlate => '원판 계산기';

  @override
  String get toolTitleWarmup => '워밍업 세트';

  @override
  String get toolHintRm => '예상 1회 최대중량(Epley 공식)';

  @override
  String get toolHintCal => '일일 유지 필요량 추정';

  @override
  String get toolHintBf => '미 해군 방식 추정';

  @override
  String get toolHintPlate => '바벨 총 중량';

  @override
  String get toolHintWarmup => '목표 작업 중량';

  @override
  String get toolDescRm => '예상 1회 최대중량';

  @override
  String get toolDescBmi => '체질량지수';

  @override
  String get toolDescCal => '칼로리와 다량영양소';

  @override
  String get toolDescBf => '체지방률';

  @override
  String get toolDescPlate => '웨이트 원판 계산기';

  @override
  String get toolDescWarmup => '단계별 워밍업 세트';

  @override
  String get bmiUnderweight => '저체중';

  @override
  String get bmiNormal => '정상 체중';

  @override
  String get bmiOverweight => '과체중';

  @override
  String get bmiObese => '비만';

  @override
  String get actSedentary => '좌식';

  @override
  String get actLight => '가벼움';

  @override
  String get actActive => '활동적';

  @override
  String get actModerate => '보통';

  @override
  String get muscleChest => '가슴';

  @override
  String get muscleBack => '등';

  @override
  String get muscleLowerBack => '허리';

  @override
  String get muscleShoulders => '어깨';

  @override
  String get muscleBiceps => '이두근';

  @override
  String get muscleTriceps => '삼두근';

  @override
  String get muscleForearm => '전완';

  @override
  String get muscleTrapezius => '승모근';

  @override
  String get muscleAbdomen => '복근';

  @override
  String get muscleObliques => '복사근';

  @override
  String get muscleQuads => '대퇴사두근';

  @override
  String get muscleHamstrings => '햄스트링';

  @override
  String get muscleGlutes => '둔근';

  @override
  String get muscleCalves => '종아리';

  @override
  String get mgChest => '가슴';

  @override
  String get mgBack => '등';

  @override
  String get mgLegs => '하체';

  @override
  String get mgShoulders => '어깨';

  @override
  String get mgArms => '팔';

  @override
  String get mgCore => '코어';

  @override
  String get equipBarbell => '바벨';

  @override
  String get equipDumbbell => '덤벨';

  @override
  String get equipCable => '케이블';

  @override
  String get equipMachine => '머신';

  @override
  String get equipBodyweight => '맨몸';

  @override
  String get equipWeighted => '중량 추가';

  @override
  String get equipBand => '밴드';

  @override
  String get equipKettlebell => '케틀벨';

  @override
  String get equipRings => '링';

  @override
  String get equipOther => '기타';

  @override
  String get diffBeginner => '초급';

  @override
  String get diffAdvanced => '고급';

  @override
  String get diffIntermediate => '중급';

  @override
  String get about => '정보';

  @override
  String version(String v) {
    return '버전 $v';
  }

  @override
  String get aboutBlurb => '운동하는 사람이 운동하는 사람을 위해 만들었습니다.';

  @override
  String get freeForever => '영원히 무료';

  @override
  String get freeForeverWhy => '구독 없음, 광고 없음, 유료 잠금 없음.';

  @override
  String get fullyOffline => '100% 오프라인';

  @override
  String get fullyOfflineWhy => '계정도 서버도 없습니다. 운동 데이터는 이 휴대전화 밖으로 나가지 않습니다.';

  @override
  String get yoursToTake => '데이터는 사용자의 것입니다';

  @override
  String get yoursToTakeWhy => '언제든 CSV로 내보내고 한 번에 모두 삭제할 수 있습니다.';

  @override
  String get whatsInside => '포함 내용';

  @override
  String exercisesInside(int n) {
    return '운동 $n개';
  }

  @override
  String get exercisesInsideWhy => '각 운동에 애니메이션과 단계별 설명이 있습니다.';

  @override
  String get calculatorsInside => '계산기 10개';

  @override
  String get calculatorsInsideWhy =>
      '1RM, 원판, BMI, 칼로리, 체지방, FFMI, 워밍업, RPE 중량, DOTS·Wilks 근력 점수 — 모두 공개된 공식에 기반합니다.';

  @override
  String get mathInside => '투명한 계산';

  @override
  String get mathInsideWhy => '볼륨, 기록, 세트는 사용자의 실제 데이터로 계산됩니다. 장식용 수치는 없습니다.';

  @override
  String get streakCaps => '연속';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '일', one: '일');
    return '$_temp0';
  }

  @override
  String get reset => '재설정';

  @override
  String get welcomeKicker => '환영합니다';

  @override
  String get welcomeBlurb => '모든 데이터는 휴대전화에 남습니다. 계정, 인터넷, 결제가 필요 없습니다.';

  @override
  String get welcomeStart => '시작';

  @override
  String onbStep(int i, int n) {
    return '$i/$n 단계';
  }

  @override
  String get onbNameTitle => '어떻게 불러드릴까요?';

  @override
  String get onbNameHint => '이름';

  @override
  String get onbNameWhy => '인사에만 사용됩니다. 휴대전화 밖으로 나가지 않습니다.';

  @override
  String get onbBodyTitle => '몇 가지 정보';

  @override
  String get onbBodyWhy => '계산기에 사용됩니다. 설정에서 언제든 변경할 수 있습니다.';

  @override
  String get onbGoalTitle => '얼마나 자주 운동하나요?';

  @override
  String get onbGoalWhy => '주간 목표를 설정합니다. 너무 무리하지 말고 현실적으로 정하세요.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '주 $n회', one: '주 $n회');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => '킬로그램 또는 파운드?';

  @override
  String get next => '다음';

  @override
  String get back => '뒤로';

  @override
  String get skip2 => '건너뛰기';

  @override
  String get madeWithLoveBy => '사랑으로 만든 사람';

  @override
  String get sourceCode => '소스 코드';

  @override
  String get suggested => '추천';

  @override
  String get results => '결과';

  @override
  String get noMatches => '이 검색과 일치하는 운동이 없습니다.';

  @override
  String get tapToEdit => '연필을 탭해 항목을 수정하거나 휴지통을 탭해 삭제하세요.';

  @override
  String get editEntry => '수정';

  @override
  String get editEntryHint => '모든 세트의 반복 수나 중량을 수정할 수 있습니다.';

  @override
  String get removeSet => '세트 삭제';

  @override
  String get continueWorkout => '계속하기';

  @override
  String get continueWorkoutBody => '체크된 세트를 유지한 채 운동이 다시 진행됩니다. 다시 종료하면 원래 날짜로 저장됩니다.';

  @override
  String get addBodyWidget => '근육 지도 위젯 추가';

  @override
  String get repsOnly => '반복만';

  @override
  String get repsOnlyHint => '이 운동을 중량 없이 기록합니다.';

  @override
  String get useDefaultArt => '기본 그림으로 돌아가기';

  @override
  String daysShort(int n) {
    return '$n일';
  }

  @override
  String get focusCard => '오늘의 초점';

  @override
  String get autoAdvance => '자동으로 다음으로';

  @override
  String get keepScreenOn => '운동 중에는 화면 켜 두기';

  @override
  String get lockWorkout => '화면 잠금';

  @override
  String get unlockWorkout => '잠금 해제';

  @override
  String get holdToUnlock => '길게 눌러 잠금 해제';

  @override
  String get liveChannel => '진행 중인 운동';

  @override
  String get liveChannelWhy => '운동 중에 현재 운동, 세트, 휴식 타이머를 보여 줍니다';

  @override
  String liveSet(int n, int total) {
    return '$total세트 중 $n세트';
  }

  @override
  String get liveResting => '휴식 중';

  @override
  String get liveAllDone => '모든 세트 완료';

  @override
  String get autoAdvanceHint => '운동의 마지막 세트를 체크하면 자동으로 다음 운동으로 넘어갑니다.';

  @override
  String get autoProgress => '다음에 중량 추가';

  @override
  String autoProgressHint(String w) {
    return '모든 반복을 성공하면 다음 운동은 $w 더 높은 중량으로 시작합니다.';
  }

  @override
  String get placePlates => '원판과 바';

  @override
  String get platesAll => '모두 사용 가능';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n개 크기', one: '$n개 크기');
    return '$_temp0';
  }

  @override
  String get platePairs => '쌍';

  @override
  String plateAchievable(String w) {
    return '가장 가까운 가능 중량: $w';
  }

  @override
  String get autoWarmup => '워밍업 세트로 시작';

  @override
  String get autoWarmupHint => '운동을 열 때 단계별 워밍업 세트를 추가합니다.';

  @override
  String get trainReminder => '운동 알림';

  @override
  String get trainReminderHint => '이 시간에, 루틴이 예정된 날에만 알림을 보냅니다.';

  @override
  String get reminderExactTime => '정확한 시간';

  @override
  String get toastSoundSetting => '알림 소리';

  @override
  String get toastSoundHint => '위에 알림이 뜰 때 나는 부드러운 소리.';

  @override
  String get notifTrainChannel => '운동 알림';

  @override
  String get notifTrainChannelWhy => '계획한 날에 운동하도록 알려줍니다.';

  @override
  String get notifTrainTitle => '운동할 시간입니다';

  @override
  String get notifTrainBody => '루틴이 기다리고 있습니다.';

  @override
  String get planIntro => '이 목록의 운동만 사용해 운동 루틴을 만들어 주세요.';

  @override
  String get planFormat => '다음 형식의 JSON으로만 답하세요:';

  @override
  String get planNothing => '이 파일의 운동이 라이브러리와 일치하지 않습니다';

  @override
  String get planFailed => '이 파일은 GymMane이 읽을 수 있는 루틴이 아닙니다';

  @override
  String get routineGroup => '그룹';

  @override
  String get newGroup => '새 그룹';

  @override
  String get noGroup => '그룹 없음';

  @override
  String get groupNameHint => '푸시 / 풀 / 하체, 5×5…';

  @override
  String get filters => '필터';

  @override
  String get setsPlannedHint => '각 운동의 원하는 세트 수를 선택하세요. 운동을 열면 모두 준비되어 있습니다.';

  @override
  String get nextTime => '다음번';

  @override
  String get nextHold => '모든 반복을 성공할 때까지 같은 중량 유지';

  @override
  String get bgPhoto => '내 사진';

  @override
  String get bgPhotoPick => '사진 선택';

  @override
  String get bgPhotoChange => '사진 변경';

  @override
  String get bgPhotoRemove => '사진 제거';

  @override
  String get bgDim => '어둡게';

  @override
  String get dimSoft => '약하게';

  @override
  String get dimMedium => '중간';

  @override
  String get dimStrong => '강하게';

  @override
  String get bgPhotoHint => '전체 인터페이스 뒤에 표시되며 앱이 잘 보이도록 어둡게 처리됩니다.';

  @override
  String get reminderSmart => '스마트';

  @override
  String get reminderFixed => '고정 시간';

  @override
  String get reminderSmartHint => '실제로 운동하는 요일과 시간을 사용하며 그날 이미 운동했다면 알림을 보내지 않습니다.';

  @override
  String get reminderSmartEmpty => '습관을 학습할 수 있도록 운동을 몇 번 더 기록하세요.';

  @override
  String habitFocus(String day) {
    return '$day에 평소 운동하는 부위';
  }

  @override
  String get duplicateRoutine => '루틴 복제';

  @override
  String copySuffix(String name) {
    return '$name (사본)';
  }

  @override
  String get saveAsRoutine => '루틴으로 저장';

  @override
  String get savedAsRoutine => '루틴으로 저장됨';

  @override
  String get templates => '준비된 루틴';

  @override
  String get templatesHint => '내 라이브러리로 구성된 기본 루틴입니다. 나중에 모두 수정할 수 있습니다.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '루틴 $n개 추가됨', one: '루틴 $n개 추가됨');
    return '$_temp0';
  }

  @override
  String get tplFullbody => '주 3회 전신 운동. 시작하기에 좋습니다.';

  @override
  String get tplPpl => '푸시, 풀, 하체. 주 3일 또는 6일.';

  @override
  String get tplUpperlower => '상체와 하체, 주 4일.';

  @override
  String get tplStronglifts => '5회×5세트 두 운동을 번갈아 진행합니다.';

  @override
  String get tplStartingstrength => '매 운동마다 스쿼트, 두 운동을 번갈아 진행합니다.';

  @override
  String get tplHome => '철봉과 바닥만 있으면 됩니다.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n일', one: '$n일');
    return '$_temp0';
  }

  @override
  String get logRpe => '운동 강도 기록(RPE)';

  @override
  String get rpeHint => '10 = 더 이상 반복 불가; 8 = 약 2회 여유.';

  @override
  String get superset => '슈퍼세트';

  @override
  String get supersetLink => '다음과 연결';

  @override
  String get supersetHint => '연결된 운동 사이에는 휴식 없이 바로 다음 운동으로 넘어갑니다.';

  @override
  String get aiRoutine => 'AI 루틴';

  @override
  String get aiIntro =>
      'GymMane은 AI와 직접 통신하지 않습니다. 운동 목록을 내보내고 이미 사용하는 AI 도우미에 붙여넣은 뒤 응답을 다시 가져옵니다. 어떤 데이터도 자동으로 휴대전화 밖으로 나가지 않습니다.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '라이브러리에 없는 이름 $n개',
      one: '라이브러리에 없는 이름 1개',
    );
    return '$_temp0';
  }

  @override
  String get importApps => '지원 앱';

  @override
  String get importOtherCsv => '날짜, 운동, 반복, 중량이 포함된 다른 CSV';

  @override
  String get importAskApp => '다른 앱이 필요한가요? 추가를 요청하세요';

  @override
  String get awardFirstStepName => '첫걸음';

  @override
  String get awardFirstStepLine => 'GymMane에 오신 것을 환영합니다. 이건 선물입니다.';

  @override
  String get awardFirstWorkoutName => '첫 운동';

  @override
  String get awardFirstWorkoutLine => '첫 운동을 기록했습니다. 첫 번째가 가장 어렵죠.';

  @override
  String get awardFirstRoutineName => '첫 루틴';

  @override
  String get awardFirstRoutineLine => '이제 다시 따라갈 계획이 생겼습니다.';

  @override
  String get awardFirstRecordName => '첫 기록';

  @override
  String get awardFirstRecordLine => '한 운동에서 최고 기록을 경신했습니다.';

  @override
  String get awardStreak3Name => '3일 연속';

  @override
  String get awardStreak3Line => '3일 연속. 이렇게 시작됩니다.';

  @override
  String get awardTonne1Name => '1톤';

  @override
  String get awardTonne1Line => '세트 전체에서 총 1,000kg을 들었습니다.';

  @override
  String get awardSets100Name => '100세트';

  @override
  String get awardSets100Line => '100세트 완료, 하나씩 쌓아 올렸습니다.';

  @override
  String get awardHours10Name => '10시간';

  @override
  String get awardHours10Line => '운동 시간 10시간 달성.';

  @override
  String get awardWorkouts50Name => '운동 50회';

  @override
  String get awardWorkouts50Line => '운동 50회를 마쳤습니다.';

  @override
  String get awardHours50Name => '50시간';

  @override
  String get awardHours50Line => '운동에 50시간을 보냈습니다.';

  @override
  String get awardsTitle => '메달';

  @override
  String get yearTitle => '나의 1년';

  @override
  String get yearBestMonth => '최고의 달';

  @override
  String get yearMonths => '개월';

  @override
  String get awardSpinHint => '메달을 밀어 회전하세요';

  @override
  String get awardUnlocked => '새 업적 잠금 해제';

  @override
  String get awardNice => '좋아요!';

  @override
  String get awardSaveImage => '이미지 저장';

  @override
  String get awardSaved => '갤러리에 저장됨';

  @override
  String get awardStreak7Name => '7일';

  @override
  String get awardStreak7Line => '하루도 빠짐없이 일주일.';

  @override
  String get awardStreak30Name => '30일';

  @override
  String get awardStreak30Line => '한 달 연속. 이제 습관이 되었습니다.';

  @override
  String get awardWorkouts100Name => '운동 100회';

  @override
  String get awardWorkouts100Line => '운동 100회를 처음부터 끝까지 기록했습니다.';

  @override
  String get awardTonnes100Name => '100톤';

  @override
  String get awardTonnes100Line => '지금까지 든 총 중량이 100,000kg에 도달했습니다.';

  @override
  String get awardSets1000Name => '1,000세트';

  @override
  String get awardSets1000Line => '한 세트씩 쌓아 1,000세트까지.';

  @override
  String get profile => '프로필';

  @override
  String get editProfile => '프로필 수정';

  @override
  String get pickBadge => '배지';

  @override
  String get statWorkouts => '운동';

  @override
  String get statTrained => '운동 시간';

  @override
  String get statSets => '세트';

  @override
  String get statLifted => '든 중량';

  @override
  String get statStreak => '연속';

  @override
  String get statDays => '일';

  @override
  String get unitHours => '시간';

  @override
  String get unitDays => '일';

  @override
  String get snapshots => '사진';

  @override
  String get snapNow => '지금 찍기';

  @override
  String get addCover => '커버 추가';

  @override
  String get addTodayWidget => '오늘 운동 완료 여부';

  @override
  String get photosCard => '내 사진';

  @override
  String get handleLabel => '사용자 이름';

  @override
  String get setupTitle => '이 항목을 입력하면 나머지 페이지가 자동으로 채워집니다';

  @override
  String get setupHint => '여기의 모든 수치는 사용자가 기록한 데이터에서 나옵니다. 어디에도 전송되지 않습니다.';

  @override
  String get setupWorkout => '첫 운동 기록';

  @override
  String get setupWeight => '체중 기록';

  @override
  String get setupMeasures => '신체 치수 측정';

  @override
  String get setupPhoto => '첫 진행 사진 촬영';

  @override
  String get progressTitle => '진행 상황';

  @override
  String get tileVolume30 => '볼륨 · 30일';

  @override
  String get tileAddWeight => '내 값 추가';

  @override
  String get heatToneTitle => '히트맵 색상';

  @override
  String get heatToneHint => '그리드와 몸의 색상만 변경합니다.';

  @override
  String get thisWeekTitle => '이번 주';

  @override
  String get momentsEmptyTitle => '아직 아무것도 없습니다';

  @override
  String get deletePhotoTitle => '이 사진을 삭제할까요?';

  @override
  String get deletePhotoBody => '영구적으로 삭제됩니다.';

  @override
  String get awardsEarned => '획득';

  @override
  String get awardsLocked => '잠김';

  @override
  String get awardStreak100Name => '100일';

  @override
  String get awardWorkouts10Name => '운동 10회';

  @override
  String get awardWorkouts10Line => '처음 10회가 차이를 만듭니다.';

  @override
  String get awardWorkouts365Name => '365';

  @override
  String get awardWorkouts365Line => '1년의 매일에 해당하는 운동을 하나씩 기록했습니다.';

  @override
  String get awardTonnes10Name => '10톤';

  @override
  String get awardTonnes10Line => '10,000kg을 들어 올렸습니다.';

  @override
  String get awardHours100Name => '100시간';

  @override
  String get awardHours100Line => '타이머와 함께 바 아래에서 100시간.';

  @override
  String awardWonOn(String date) {
    return '$date에 획득';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {'gold': '골드', 'blue': '블루', 'green': '그린', 'other': '배지'});
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$date부터';
  }

  @override
  String levelShort(int n) {
    return '레벨 $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '레벨 $next까지 운동 $n회',
      one: '레벨 $next까지 운동 1회',
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
      'ember': '불씨',
      'green': '그린',
      'blue': '블루',
      'mono': '회색',
      'other': '색상',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n세트';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '이번 주 $n/$goal';
  }

  @override
  String momentCount(int n) {
    return '사진 $n장';
  }

  @override
  String photosSelected(int n) {
    return '$n장 선택됨';
  }

  @override
  String deletePhotosTitle(int n) {
    return '사진 $n장을 삭제할까요?';
  }

  @override
  String get momentsEmptyHint => '헬스장, 보드, 원판을 끼운 바 등 기억하고 싶은 것을 촬영하세요. 사진은 휴대전화에만 남고 본인만 볼 수 있습니다.';

  @override
  String get awardStreak100Line => '100일 연속. 이제 동기가 아니라 습관입니다.';

  @override
  String get coverLabel => '커버';

  @override
  String get removeCover => '커버 제거';

  @override
  String get startTitle => '운동 시작';

  @override
  String get logTitle => '운동 기록';

  @override
  String get logHint => '타이머 없이 — 한 내용을 간단히 입력하세요.';

  @override
  String get orStartFrom => '또는 다음에서 시작';

  @override
  String get pickExercisesOption => '운동 선택';

  @override
  String get chooseFocusOption => '초점 선택';

  @override
  String get plannedRoutine => '예정';

  @override
  String get logWorkoutAction => '운동 기록';

  @override
  String get logging => '기록 중';

  @override
  String get placesLabel => '내 장소';

  @override
  String get undo => '실행 취소';

  @override
  String get deleteSet => '세트 삭제';

  @override
  String get setDeleted => '세트를 삭제했어요';

  @override
  String get removeWarmup => '워밍업 빼기';

  @override
  String get addWeightAction => '무게 추가';

  @override
  String get workoutOverview => '이번 운동';

  @override
  String get allExercisesShort => '전체';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total세트';
  }

  @override
  String get nowLabel => '지금';

  @override
  String get deleteWorkout => '운동 삭제';

  @override
  String get deleteWorkoutBody => '이 운동과 모든 세트가 기록에서 삭제됩니다.';

  @override
  String get themeAuto => '자동';

  @override
  String get themeAutoHint => '휴대폰 설정 따름';

  @override
  String get demoSizeTitle => '운동 중 동작 데모';

  @override
  String get demoLarge => '크게';

  @override
  String get demoSmall => '작게';

  @override
  String get demoOff => '숨김';

  @override
  String get demoLoopTitle => '데모 애니메이션';

  @override
  String get demoLoopAlways => '반복';

  @override
  String get demoLoopShort => '10초';

  @override
  String get demoLoopHint => '약 10초 동안 움직인 뒤 시작 자세에서 멈춥니다. 다시 보려면 데모를 탭하세요.';

  @override
  String get alarmStyleTitle => '휴식이 끝나면';

  @override
  String get alarmStyleLoud => '항상 울림';

  @override
  String get alarmStyleQuiet => '무음 모드 따르기';

  @override
  String get alarmStyleVibrate => '진동만';

  @override
  String get alarmStyleHint =>
      '\'항상 울림\'은 무음 상태에서도 알람 볼륨을 사용합니다. \'무음 모드 따르기\'는 알림 볼륨을 사용하고, 휴대폰이 무음이면 진동만 합니다.';

  @override
  String get suggestedPicks => '추천 운동';

  @override
  String get moreOptions => '더 보기';

  @override
  String get suggestInWorkouts => '빠른 운동에서 추천';

  @override
  String get suggestInWorkoutsHint => '끄면 추천에 나오지 않아요. 직접 추가는 계속 할 수 있어요.';

  @override
  String get onbPlaceTitle => '어디서 운동하나요?';

  @override
  String get onbPlaceWhy => '운동하는 장소를 모두 골라 주세요. 장소마다 할 수 있는 운동만 추천할게요.';

  @override
  String get onbPlaceGear => '그곳에 무엇이 있나요?';

  @override
  String distanceCol(String unit) {
    return '거리($unit)';
  }

  @override
  String get timeCol => '시간';

  @override
  String get timeMinutesTitle => '시간(분)';

  @override
  String get timeSecondsTitle => '시간(초)';

  @override
  String distanceTitle(String unit) {
    return '거리($unit)';
  }

  @override
  String get holdLabel => '버티기';

  @override
  String get stopLabel => '정지';

  @override
  String startHold(String time) {
    return '시작 · $time';
  }

  @override
  String get exerciseTypeLabel => '기록 방식';

  @override
  String get typeReps => '횟수와 무게';

  @override
  String get typeTime => '시간';

  @override
  String get typeCardio => '거리와 시간';

  @override
  String get exerciseTypeHint => '달리기나 수영 같은 유산소는 거리와 시간을 기록해요. 플랭크 같은 버티기 운동은 시간을 기록해요.';

  @override
  String get howToLabel => '운동 방법(선택)';

  @override
  String get howToHint => '한 줄에 한 단계';

  @override
  String get editExercise => '운동 편집';

  @override
  String get saveChanges => '변경 사항 저장';

  @override
  String get noStepsYet => '아직 단계가 없어요. 어떻게 하는지 기억하도록 직접 적어 보세요.';

  @override
  String get addSteps => '단계 적기';

  @override
  String get setTypeRestPause => '레스트-포즈';

  @override
  String get setTypeNormalInfo => '일반 세트입니다. 볼륨과 기록에 포함됩니다.';

  @override
  String get setTypeWarmupInfo => '준비를 위한 가벼운 세트입니다. 볼륨과 기록에 포함되지 않습니다.';

  @override
  String get setTypeDropInfo => '세트 직후 무게를 낮추고 쉬지 않고 이어갑니다.';

  @override
  String get setTypeFailureInfo => '바른 자세로 한 번도 더 못 할 때까지 계속합니다. 실제로 한 횟수를 기록하세요.';

  @override
  String get setTypeRestPauseInfo => '세트 후 10~20초 쉬고 몇 회를 더 짜냅니다.';

  @override
  String get planFormatNotes =>
      '운동 이름은 목록에 보이는 그대로 쓰세요. \"sets\", \"reps\", \"weight\"(지정한 단위), 초 단위 \"rest\", \"days\"는 선택 사항입니다. \"superset\": true는 다음 운동과 연결합니다. 여러 주는 두 번째 예시처럼 루틴을 \"weeks\" 안에 묶으세요.';

  @override
  String get planSets => '세트 계획';

  @override
  String get planSetsHint => '각 세트의 종류, 횟수, 무게를 고르세요. 무게를 자동으로 두면 지난 운동에서 시작해요.';

  @override
  String get planHintReps => '세트마다 종류와 반복 수를 정하세요. 자동은 지난 세션에서 시작해요.';

  @override
  String get planHintTime => '세트마다 종류와 시간을 정하세요. 자동은 지난 세션에서 시작해요.';

  @override
  String get planHintTimeWeight => '세트마다 종류, 시간, 무게를 정하세요. 자동은 지난 세션에서 시작해요.';

  @override
  String get planHintCardio => '세트마다 거리와 시간을 정하세요. 자동은 지난 세션에서 시작해요.';

  @override
  String get timeOnly => '시간만';

  @override
  String get autoValue => '자동';

  @override
  String get clearPlan => '계획 지우기';

  @override
  String get shareRoutine => '루틴 공유';

  @override
  String get shareWeek => '내 한 주 공유';

  @override
  String get shareWeekHint => '모든 루틴과 각 루틴의 요일.';

  @override
  String shareMessage(String name) {
    return '$name — GymMane으로 파일을 열어 추가하세요.';
  }

  @override
  String get importRoutines => '루틴 가져오기';

  @override
  String get importPasteHint => '여기에 루틴을 붙여 넣으세요: GymMane에서 공유한 루틴, AI 답변, JSON 또는 CSV.';

  @override
  String get pasteAction => '붙여 넣기';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '루틴 $n개');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => '주간 일정도 사용';

  @override
  String get useTheirScheduleHint => '가져온 요일이 그 요일의 기존 계획을 대신해요.';

  @override
  String get addToMyRoutines => '내 루틴에 추가';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '루틴 $n개를 추가했어요');
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'GymMane이 가져올 수 있는 내용이 없어요';

  @override
  String get aiStepCopy => '요청을 복사하세요. 내 운동 목록과 GymMane이 읽는 형식이 들어 있어요.';

  @override
  String get aiStepAsk => '아무 AI에나 붙여 넣고 원하는 걸 말하세요: 주당 일수, 목표, 몇 주인지.';

  @override
  String get aiStepPaste => 'AI의 답변을 아래에 붙여 넣고 가져오세요. 파일은 필요 없어요.';

  @override
  String get copyForAi => 'AI용으로 복사';

  @override
  String get copiedDone => '복사했어요';

  @override
  String get aiPasteHint => '여기에 AI 답변을 붙여 넣기';

  @override
  String get importAction => '가져오기';

  @override
  String get showFormat => '형식 보기';

  @override
  String get shareAsFile => '파일로 공유';

  @override
  String get recoveryTab => '회복';

  @override
  String recoveryOverall(int pct) {
    return '몸 회복률 $pct%';
  }

  @override
  String get recoveryAllFresh => '모두 회복됐어요. 어떤 부위든 운동하기 좋은 날이에요.';

  @override
  String recoveryStill(String muscles) {
    return '아직 회복 중: $muscles';
  }

  @override
  String get recoveryTired => '피로';

  @override
  String get recoveryFresh => '회복됨';

  @override
  String get recoveryHint => '근육을 탭하면 회복 정도를 볼 수 있어요. 최근 세트일수록, 더 힘든 세트(RPE)일수록 더 크게 반영돼요.';

  @override
  String recoveryPct(int pct) {
    return '$pct% 회복';
  }

  @override
  String readyInHours(int h) {
    return '약 $h시간 후 준비';
  }

  @override
  String get tplAbcd => '4일: 가슴과 삼두, 등과 이두, 하체, 어깨와 복근.';

  @override
  String get tplAbcde => '5일, 하루 한 부위: 가슴, 등, 하체, 어깨, 팔.';

  @override
  String get elapsedCaps => '경과';

  @override
  String get tapToSkip => '탭해서 건너뛰기';

  @override
  String get screenLocked => '화면 잠김';

  @override
  String get lockedHint => '위쪽 지문 아이콘을 길게 눌러 잠금 해제';

  @override
  String get liveDoneSet => '세트 완료';

  @override
  String get liveSkipRest => '휴식 건너뛰기';

  @override
  String get livePause => '일시정지';

  @override
  String get liveResume => '재개';

  @override
  String get liveNext => '다음';

  @override
  String liveUpNext(String name) {
    return '다음: $name';
  }

  @override
  String get stickerOpen => '사진 위에 공유';

  @override
  String get stickerNoPhoto => '사진 없음';

  @override
  String get stickerWorkout => '운동';

  @override
  String get stickerStreak => '연속 기록';

  @override
  String get stickerDate => '날짜';

  @override
  String get stickerHint => '드래그해서 옮기고, 두 손가락으로 크기를 바꾸거나 돌리세요';

  @override
  String get stickerSaved => '갤러리에 저장했어요';

  @override
  String get stickerWeek => '이번 주';

  @override
  String get getReady => '준비';

  @override
  String get stickerGallery => '갤러리';

  @override
  String get stickerCamera => '카메라';

  @override
  String get shareIntroTitle => '이 루틴 공유하기';

  @override
  String get shareIntroBody => '연인, 친구, 가족에게 보내 보세요. GymMane으로 열리는 작은 파일이 가고, 세트와 무게까지 한 번에 추가돼요.';

  @override
  String get removedFromRoutine => '루틴에서 뺐어요';

  @override
  String get radarTitle => '최근 30일';

  @override
  String get radarHint => '더 운동이 필요한 부위를 확인하세요';

  @override
  String get radarEmpty => '며칠 운동하면 균형이 보여요';

  @override
  String get radarBalanced => '지금까지 균형이 좋아요';

  @override
  String radarFocus(String list) {
    return '더 필요해요: $list';
  }

  @override
  String get countdownReady => '준비하세요';

  @override
  String get countdownSkip => '탭하면 바로 시작해요';

  @override
  String get countdownSetting => '시작 전 카운트다운';

  @override
  String get effortSetting => '세트별 강도 기록';

  @override
  String get effortHint =>
      'RPE: 10은 한 번도 더 못 하는 상태, 8은 두 번 더 할 수 있던 상태예요. RIR은 남아 있던 반복 수예요. 기록된 세트는 예상 1RM에 RPE 표를 사용해요.';

  @override
  String get rirHint => '0은 한 번도 더 못 하는 상태, 2는 두 번 더 할 수 있던 상태예요.';

  @override
  String get addWeekWidget => '이번 주 위젯 추가';

  @override
  String get gamificationSetting => '메달과 레벨';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n회', one: '$n회');
    return '$_temp0';
  }

  @override
  String get prBestSet => '최고 세트';

  @override
  String get weekStartSetting => '한 주의 시작';

  @override
  String get stepOutOfWorkout => '일시정지하고 나가기';

  @override
  String get saveToRoutine => '루틴에 변경 사항 저장';

  @override
  String get routineUpdated => '루틴을 업데이트했어요';

  @override
  String saveChangesTitle(String name) {
    return '$name에 변경 사항을 저장할까요?';
  }

  @override
  String get saveChangesBody => '다음에 시작하면 루틴에 이 변경 사항이 반영돼요.';

  @override
  String get routineOrderChanged => '새 운동 순서';

  @override
  String get mineOnly => '내가 만든 운동';

  @override
  String createNamed(String name) {
    return '없나요? “$name” 만들기';
  }

  @override
  String get orStartWith => '또는 이렇게 시작';

  @override
  String get warmupFocus => '워밍업';

  @override
  String get warmupFocusHint => '기구 유무와 상관없는 가동성·활성화';

  @override
  String get cardioFocus => '유산소';

  @override
  String get cardioFocusHint => '달리기, 자전거, 로잉, 줄넘기를 거리와 시간으로';

  @override
  String get homeRecommended => '홈 추천';

  @override
  String get homeRoutines => '홈의 루틴';

  @override
  String get homeRoutinesHint => '최근에 한 루틴부터 보여줘요. 탭하면 시작해요.';

  @override
  String get homeWeekStats => '홈의 이번 주';

  @override
  String get homeWeekStatsHint => '이번 주 볼륨, 세트, 기록.';

  @override
  String get routineDoneToday => '오늘 완료 · 수고했어요';

  @override
  String get trainAgain => '다시 운동하기';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n일 전', one: '어제 완료', zero: '오늘 완료');
    return '$_temp0';
  }

  @override
  String get archivedFilter => '보관됨';

  @override
  String get archiveExercise => '운동 보관';

  @override
  String get restoreExercise => '복원';

  @override
  String get archivedToast => '운동을 보관했어요';

  @override
  String get archivedToastHint => '운동 › 보관됨에서 찾을 수 있어요';

  @override
  String get archivedBanner => '보관됨. 목록과 추천에 나오지 않고 기록은 그대로 남아요.';

  @override
  String get videoMarksHint => '단계에서 일시정지하고 핀을 누르면 다음에 그 지점으로 이동해요.';

  @override
  String get videoMarkHere => '이 단계를 여기로 표시';

  @override
  String get sectionGeneral => '일반';

  @override
  String get sectionTraining => '운동';

  @override
  String get sectionAlerts => '알림과 알람';

  @override
  String get sectionHome => '홈';

  @override
  String get sectionWidgets => '위젯';

  @override
  String get sectionData => '데이터와 백업';

  @override
  String get multiPlanSetting => '하루에 여러 루틴';

  @override
  String get multiPlanHint => '이날 할 루틴을 모두 누르세요. 추가한 순서대로 진행돼요.';

  @override
  String routineOfDay(int n, int total) {
    return '오늘 $n/$total';
  }

  @override
  String get nextToday => '오늘 다음 루틴';

  @override
  String get planAboutMe => '나에 대해:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age세, 키 $height, 몸무게 $weight.';
  }

  @override
  String planDays(int n) {
    return '주 $n일 운동하고 싶어요.';
  }

  @override
  String get planNoHistory => '아직 운동 기록이 없어요. 초보자로 보고 볼륨과 무게를 보수적으로 잡아 주세요.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '최근 30일 운동 $n회.',
      one: '최근 30일 운동 1회.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => '최근 최고 세트';

  @override
  String get planAskFirst =>
      '내 목표(근력, 근육, 체지방 감량, 전반적 체력)나 한 번에 운동할 수 있는 시간을 모르면 먼저 짧게 물어봐 주세요. 알게 되면 JSON으로만 답해 주세요.';

  @override
  String get backToTop => '맨 위로';

  @override
  String get deleteExerciseTitle => '이 운동을 삭제할까요?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\"이(가) 라이브러리와 루틴에서 삭제돼요. 지난 세트 기록은 남아요.';
  }

  @override
  String get exportForStravaHint =>
      '브라우저에서 strava.com/upload/select 로 올리세요(Strava 앱은 파일을 가져올 수 없어요). 세트와 함께 웨이트 트레이닝으로 표시돼요.';

  @override
  String get manualStartTime => '시작 시간';

  @override
  String get manualDuration => '운동 시간';

  @override
  String get manualDurationUnset => '시간 추가';

  @override
  String get stravaRow => 'Strava로 내보내기 (베타)';

  @override
  String get stravaBeta => '베타';

  @override
  String get stravaIntro =>
      'Strava로 보낼 운동을 고르세요. .fit 파일이 만들어지면 브라우저에서 strava.com/upload/select 로 올리세요. 세트와 함께 웨이트 트레이닝으로 표시돼요.';

  @override
  String get stravaEmpty => '아직 내보낼 운동이 없어요.';

  @override
  String get tapToPause => '탭하면 일시정지';

  @override
  String get holdPausedHint => '일시정지됨 · 탭하면 계속';

  @override
  String get finishHoldNow => '지금 세트 끝내기';

  @override
  String get barWeightExercise => '바 또는 슬레드 무게';

  @override
  String get barWeightHint => '원판 계산기에 사용돼요';

  @override
  String get barWeightCustom => '직접 설정 · 탭하면 초기화';

  @override
  String get groupRename => '그룹 이름 변경';

  @override
  String get groupUngroup => '그룹만 해제 (루틴 유지)';

  @override
  String get groupDeleteAll => '그룹과 루틴 삭제';

  @override
  String groupDeleteTitle(String name) {
    return '「$name」을(를) 삭제할까요?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count이(가) 삭제됩니다. 운동 기록은 유지됩니다.';
  }

  @override
  String get tplRr => 'r/bodyweightfitness의 대표 루틴: 주 3일 전신 운동. 쉬워지면 다음 단계로 넘어가세요.';

  @override
  String get levelUpKicker => '다음 단계';

  @override
  String levelUpBody(int reps, String name) {
    return '$name 3×$reps을(를) 두 번 연속 달성했어요. 다음 단계로 갈까요?';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routine에서 교체';
  }

  @override
  String get levelUpSee => '방법 보기';

  @override
  String get levelUpLater => '나중에';

  @override
  String get levelUpStay => '이대로 할게요';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name이(가) 이제 $routine에 있어요';
  }

  @override
  String get levelUpStayed => '이 운동은 더 이상 단계 상승을 제안하지 않아요';

  @override
  String get levelHintsSetting => '다음 단계 제안';

  @override
  String get heatmapLabelsSetting => '활동 지도에 요일과 월 표시';

  @override
  String get rmPercent => '퍼센트';

  @override
  String rmAtPercent(String pct) {
    return '최대치의 $pct';
  }

  @override
  String get copyWorkout => '텍스트로 복사';

  @override
  String get goalSet => '목표 설정';

  @override
  String get goalTargetReps => '목표 횟수';

  @override
  String goalToGo(String value) {
    return '$value 남음';
  }

  @override
  String get goalReached => '목표 달성';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n일 남음');
    return '$_temp0';
  }

  @override
  String get goalOverdue => '기한 지남';

  @override
  String get goalDeadline => '기한';

  @override
  String get goalNoDeadline => '기한 없음';

  @override
  String get goalRemove => '목표 삭제';

  @override
  String get exerciseNameMissing => '이름을 입력하세요';

  @override
  String get aliasesLabel => '다른 이름(선택)';

  @override
  String get aliasesHint => '다른 이름을 쉼표로 구분';

  @override
  String alsoCalled(String names) {
    return '다른 이름: $names';
  }

  @override
  String get addToRoutine => '루틴에 추가';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '루틴 $n개에 있어요',
      zero: '아직 어떤 루틴에도 없어요',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => '이미 있음';

  @override
  String get restInRoutine => '이 루틴의 휴식';

  @override
  String get restInRoutineHint => '운동 설정과 같음';

  @override
  String get restInRoutineReset => '여기서만 · 탭하면 되돌림';

  @override
  String get swapExercise => '운동 바꾸기';

  @override
  String get swapShort => '바꾸기';

  @override
  String swapHint(String name) {
    return '오늘만 $name 대신. 끝나면 루틴에 남길 수 있어요.';
  }

  @override
  String get swapKeepsDone => '이미 한 세트는 남고, 새 운동이 나머지를 이어서 해요.';

  @override
  String swapSameMuscle(String muscle) {
    return '같은 부위 · $muscle';
  }

  @override
  String get swapDoneBefore => '해 본 적 있음';

  @override
  String get multiPlanSettingHint => '같은 요일에 여러 루틴.';

  @override
  String get levelHintsHint => '운동이 쉬워지면 더 어려운 버전을 제안해요.';

  @override
  String get focusCardHint => '오늘의 루틴을 홈 맨 위에.';

  @override
  String get gamificationHint => '메달, 레벨, 운동을 마칠 때의 축하.';

  @override
  String get exerciseSettings => '이 운동의 설정';

  @override
  String get placeActiveNow => '지금 여기';

  @override
  String get placeTapToUse => '여기서 운동하려면 탭';

  @override
  String get intervalDays => '일';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target일';
  }

  @override
  String get toolNameRpe => 'RPE로 무게';

  @override
  String get toolTitleRpe => 'RPE로 무게';

  @override
  String get toolDescRpe => '원하는 강도에 맞는 무게';

  @override
  String get toolNameDots => '근력 레벨';

  @override
  String get toolTitleDots => '근력 레벨 (DOTS)';

  @override
  String get toolDescDots => '체중 대비 내 근력';

  @override
  String rpeResultHint(int reps, String rpe) {
    return '$reps회 · RPE $rpe 기준';
  }

  @override
  String get rpeYourSet => '방금 한 세트';

  @override
  String get rpeGoal => '하고 싶은 것';

  @override
  String rpeOneRmLine(String value) {
    return '예상 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10은 한 번도 더 못 하는 상태, 8은 두 번 남은 상태예요.';

  @override
  String get dotsBestLifts => '내 최고 기록';

  @override
  String get dotsSquat => '스쿼트';

  @override
  String get dotsBench => '벤치프레스';

  @override
  String get dotsDeadlift => '데드리프트';

  @override
  String dotsTotalLine(String value) {
    return '합계: $value';
  }

  @override
  String get dotsExplain => '체중과 상관없이 누구와도 근력을 비교해요. 1회 최고 기록이나 예상 1RM을 쓰세요.';

  @override
  String get dotsLevel0 => '초급';

  @override
  String get dotsLevel1 => '중급';

  @override
  String get dotsLevel2 => '상급';

  @override
  String get dotsLevel3 => '최상급';

  @override
  String get dotsLevel4 => '엘리트';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks 점수';

  @override
  String get toolDescWilks => '파워리프팅의 전통 점수';

  @override
  String get wilksExplain => '파워리프팅의 전통적인 공식입니다. 2020년에 DOTS로 대체됐지만 여전히 많은 대회와 순위에서 쓰입니다.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => '제지방량 지수';

  @override
  String get toolDescFfmi => '키 대비 근육량';

  @override
  String get ffmiBodyFat => '체지방';

  @override
  String ffmiLeanLine(String value) {
    return '제지방량: $value';
  }

  @override
  String get ffmiExplain => 'BMI와 비슷하지만 지방을 뺀 제지방량만 계산합니다. 키에 맞춰 보정해 키가 크든 작든 공정하게 비교할 수 있어요.';

  @override
  String get ffmiLevel0 => '평균 이하';

  @override
  String get ffmiLevel1 => '평균';

  @override
  String get ffmiLevel2 => '평균 이상';

  @override
  String get ffmiLevel3 => '우수';

  @override
  String get ffmiLevel4 => '최상위';

  @override
  String get rpeEffortLabel => '강도 (RPE)';

  @override
  String get restRowHint => '세트 사이, 운동별 휴식이 없을 때.';

  @override
  String get effortRowHint => '세트마다 RPE나 RIR 기록.';

  @override
  String get countdownHint => '첫 세트 전에 3, 2, 1.';

  @override
  String get keepScreenOnHint => '운동하는 동안 화면이 꺼지지 않아요.';

  @override
  String get demoSizeRowHint => '운동 중 보이는 동작 그림.';

  @override
  String get demoLoopRowHint => '애니메이션 반복 또는 멈춤.';

  @override
  String get trainReminderRowHint => '운동하는 날 알림.';

  @override
  String get alarmSoundRowHint => '휴식이 끝날 때 나는 소리.';

  @override
  String get alarmStyleRowHint => '무음 모드에서도 울릴지.';

  @override
  String get recommendedRowHint => '홈에서 추천하는 운동.';

  @override
  String get weightStepSetting => '무게 단위';

  @override
  String get weightStepHint => '− 및 + 버튼이 더하는 양.';

  @override
  String get prBestWorkout => '최고 운동';

  @override
  String get mergeExercise => '병합';

  @override
  String mergeExerciseInto(String name) {
    return '$name 병합 대상…';
  }

  @override
  String get mergeExerciseTitle => '운동을 병합할까요?';

  @override
  String mergeExerciseBody(String from, String to) {
    return '「$from」의 모든 기록이 「$to」(으)로 옮겨집니다. 「$from」은(는) 라이브러리에 남습니다. 되돌릴 수 없습니다.';
  }

  @override
  String get mergedToast => '기록을 병합했어요';
}
