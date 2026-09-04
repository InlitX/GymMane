// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get languageName => '简体中文';

  @override
  String vsLastMonthLabel(String pct) {
    return '较上月 $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return '等级 $level · $streak';
  }

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get cancelCaps => '取消';

  @override
  String get deleteCaps => '删除';

  @override
  String get done => '完成';

  @override
  String get set => '设置';

  @override
  String get home => '首页';

  @override
  String get progress => '进度';

  @override
  String get exercises => '动作库';

  @override
  String get settings => '设置';

  @override
  String get today => '今天';

  @override
  String get thisWeek => '本周';

  @override
  String get recommended => '推荐';

  @override
  String get goal => '目标';

  @override
  String get volume => '容量';

  @override
  String get setsToday => '今日组数';

  @override
  String get prs => '个人纪录';

  @override
  String get todaysFocus => '今日重点';

  @override
  String get todaysRoutine => '今日计划';

  @override
  String get startWorkout => '开始训练';

  @override
  String get routines => '训练计划';

  @override
  String get tools => '实用工具';

  @override
  String get firstSessionHint => '选择想要训练的肌群，记录你的第一次训练';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 项动作', one: '$n 项动作');
    return '$_temp0';
  }

  @override
  String get pushDay => '推力日';

  @override
  String get pullDay => '拉力日';

  @override
  String get legDay => '腿部日';

  @override
  String get pushFocus => '胸部 · 肩部 · 肱三头肌';

  @override
  String get pullFocus => '背部 · 肱二头肌 · 斜方肌';

  @override
  String get legFocus => '股四头肌 · 腘绳肌 · 臀肌';

  @override
  String get train => '训练';

  @override
  String get step1 => '第 1 步 / 共 2 步';

  @override
  String get step2 => '第 2 步 / 共 2 步';

  @override
  String get chooseFocus => '选择训练重点';

  @override
  String get buildSession => '定制本次训练';

  @override
  String get tapMuscles => '点击你想训练的肌肉部位 — 正面与背面。';

  @override
  String get noMusclesYet => '尚未选择肌肉 — 点击人体图开始选择。';

  @override
  String get continueBtn => '继续';

  @override
  String get nothingForFocus => '该重点部位暂无可用动作';

  @override
  String get goBackPick => '请返回并选择动作库中已有动作的肌肉部位。';

  @override
  String pickedHint(int n) {
    return '已为你推荐一组动作 — 点击可添加或删减这 $n 项动作。';
  }

  @override
  String get pickAnExercise => '选择动作';

  @override
  String get searchAllExercises => '搜索全部动作…';

  @override
  String get noExercisesMatch => '没有匹配的动作';

  @override
  String get createItInstead => '添加为自定义动作';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 项动作', one: '$n 项动作');
    return '开始 · $_temp0';
  }

  @override
  String get inProgress => '进行中';

  @override
  String get paused => '已暂停';

  @override
  String get last => '上次';

  @override
  String get rest => '休息';

  @override
  String get skip => '跳过';

  @override
  String get addSet => '+ 添加组';

  @override
  String get finishSession => '完成训练';

  @override
  String get setCol => '#';

  @override
  String get repsCol => '次数';

  @override
  String weightCol(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get repsTitle => '次数';

  @override
  String weightTitle(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get sessionComplete => '训练已记录';

  @override
  String get finishHeadlinePr => '突破个人纪录！';

  @override
  String get finishHeadlineGoal => '达成每周目标！';

  @override
  String get finishHeadlineStreak => '打卡连胜中！';

  @override
  String get finishHeadlineDefault => '又完成了一次训练！';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs 项动作', one: '1 项动作');
    return '你在 $_temp0 中突破了个人最佳纪录，已记入历史成绩。';
  }

  @override
  String get finishBodyGoal => '你已完成了本周设定的全部训练目标。';

  @override
  String finishBodyStreak(int streak) {
    return '已连续坚持 $streak 天。最难的是坚持，而你做到了。';
  }

  @override
  String get finishBodyDefault => '训练已妥善记录。持之以恒，终见成效。';

  @override
  String get vsLastTime => '对比上次';

  @override
  String get firstTime => '首次记录';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 项新纪录', one: '$n 项新纪录');
    return '$_temp0';
  }

  @override
  String get saveAndExit => '保存并退出';

  @override
  String get duration => '时长';

  @override
  String get setsCaps => '组数';

  @override
  String exerciseXofY(int i, int n) {
    return '动作 $i / $n';
  }

  @override
  String get decrease => '减少';

  @override
  String get increase => '增加';

  @override
  String markSet(int n) {
    return '标记第 $n 组完成';
  }

  @override
  String get pauseWorkout => '暂停训练';

  @override
  String get resumeWorkout => '继续训练';

  @override
  String get discardTitle => '放弃本次训练？';

  @override
  String get discardBody => '本次训练已记录的组数都将丢失。';

  @override
  String get keepTraining => '继续训练';

  @override
  String get discard => '放弃';

  @override
  String get notifRestChannel => '组间休息计时器';

  @override
  String get notifRestChannelWhy => '在组间休息结束时提醒你';

  @override
  String get notifAlertChannel => '组间休息提示（警报）';

  @override
  String get notifAlertChannelWhy => '休息结束时弹出即时横幅提示';

  @override
  String get restOverTitle => '休息结束';

  @override
  String get restOverBody => '准备就绪 — 该开始下一组了！';

  @override
  String get totalVolume30d => '30天总容量';

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
  String get consistency => '出勤与坚持';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已记录 $n 次训练', one: '已记录 $n 次训练');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '连续坚持 $n 天';
  }

  @override
  String get bodyweight => '体重';

  @override
  String get notLoggedYet => '暂无记录';

  @override
  String get logShort => '+ 记录';

  @override
  String get logBodyweight => '记录体重';

  @override
  String get trackWeight => '追踪长期体重变化';

  @override
  String get muscleMap => '肌肉受训热力图';

  @override
  String get days7 => '7天';

  @override
  String get days30 => '30天';

  @override
  String get heatLow => '未练';

  @override
  String get heatHigh => '高容量';

  @override
  String get muscleMapEmpty => '记录训练后，受训肌群便会在此高亮亮起。';

  @override
  String get muscleMapHint => '点击肌肉部位查看受训详情。';

  @override
  String muscleMapBehind(String names) {
    return '训练偏少部位：$names';
  }

  @override
  String ofTarget(int pct) {
    return '达标率 $pct%';
  }

  @override
  String get muscleSplit => '各部位容量占比';

  @override
  String get splitEmpty => '开始训练即可查看各个肌群的训练量分布。';

  @override
  String get personalRecords => '个人纪录';

  @override
  String get prEmpty => '随着训练组数的记录，你的个人纪录将展示于此。';

  @override
  String get strength1rm => '力量表现 · 估算 1RM';

  @override
  String get strengthEmpty => '记录同一动作 2 次以上，即可生成力量增长曲线。';

  @override
  String oneRmEst(String w) {
    return '估算 1RM：$w';
  }

  @override
  String get restDayShort => '休息日';

  @override
  String get restDay => '休息日 — 未记录训练。';

  @override
  String get delete => '删除';

  @override
  String get deleteEntry => '删除此条记录？';

  @override
  String deleteEntryBody(String name) {
    return '“$name” 将从该日移除，并同步从历史纪录与图表中删除。';
  }

  @override
  String get bodyweightHistory => '历史记录';

  @override
  String get noBodyweightYet => '暂无记录。';

  @override
  String get exercisesCaps => '动作';

  @override
  String get timeCaps => '时间';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '动作库共有 $n 项动作', one: '动作库共有 $n 项动作');
    return '$_temp0';
  }

  @override
  String get searchExercises => '搜索动作';

  @override
  String get muscleFilter => '肌群';

  @override
  String get levelFilter => '难度';

  @override
  String get newExercise => '新建动作';

  @override
  String get exerciseName => '动作名称';

  @override
  String get equipmentLabel => '器械';

  @override
  String get addExercise => '添加动作';

  @override
  String get advanced => '进阶选项';

  @override
  String get demoMedia => '演示媒体';

  @override
  String get addMedia => '添加演示';

  @override
  String get mediaHint => '图片、GIF 或视频';

  @override
  String get changeMedia => '更换';

  @override
  String get videoSelected => '已选择视频';

  @override
  String get favouritesOnly => '我的收藏';

  @override
  String get noFavouritesYet => '暂无收藏';

  @override
  String get noFavouritesHint => '在动作卡片上点亮星标，即可将其收藏于此。';

  @override
  String get clearFilters => '清除筛选';

  @override
  String get noExercisesFound => '未找到匹配动作';

  @override
  String get noExercisesHint => '请尝试搜索其他关键词或清除筛选条件。';

  @override
  String get personalRecord => '个人纪录';

  @override
  String get history => '历史记录';

  @override
  String get noHistory => '暂无记录。开始练习此动作即可建立历史。';

  @override
  String get notes => '笔记';

  @override
  String get notePlaceholder => '发力感、器械调试、动作细节、心得…';

  @override
  String showAllNotes(int n) {
    return '查看全部 $n 条笔记';
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
  String get howTo => '动作指南';

  @override
  String get similar => '相似动作';

  @override
  String get primaryLabel => '主导肌群';

  @override
  String get secondaryLabel => '协同肌群';

  @override
  String get none => '无';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 组', one: '$n 组');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v 容量';
  }

  @override
  String get weeklyPlan => '每周计划';

  @override
  String get yourRoutines => '我的计划';

  @override
  String get noRoutines => '暂无计划。创建一个计划并添加训练动作吧。';

  @override
  String get newRoutine => '新建计划';

  @override
  String get routineName => '计划名称';

  @override
  String get schedule => '安排日程';

  @override
  String get addFromList => '从下方列表中添加动作。';

  @override
  String get addExercises => '添加动作';

  @override
  String get deleteRoutine => '删除此计划？';

  @override
  String exercisesWithCount(int n) {
    return '动作 · $n';
  }

  @override
  String setDay(String day) {
    return '设为$day';
  }

  @override
  String get newRoutineName => '新计划';

  @override
  String get dragToReorder => '长按并拖动以调整顺序 — 这将决定你的训练顺序。';

  @override
  String reorderHandle(String name) {
    return '拖动重新排序 $name';
  }

  @override
  String get removeFromRoutine => '从计划中移除';

  @override
  String get dropExercise => '移除此动作？';

  @override
  String dropExerciseBody(String name) {
    return '“$name” 将从本次训练中移除，已记录的数据不会丢失。';
  }

  @override
  String get drop => '移除';

  @override
  String get addToWorkout => '添加动作';

  @override
  String get resetData => '清空全部数据';

  @override
  String get resetTitle => '确定清空所有数据？';

  @override
  String get resetBody => '将清空所有训练记录、个人纪录、计划、笔记及个人资料。此操作不可逆 — 如有需要，请先导出备份。';

  @override
  String get resetConfirm => '清空全部数据';

  @override
  String get resetDone => '所有数据已清空';

  @override
  String get support => '支持与帮助';

  @override
  String get reportBug => '反馈 Bug';

  @override
  String get requestFeature => '功能建议';

  @override
  String get starOnGithub => '在 GitHub 上点个 Star';

  @override
  String get buyCoffee => '请作者喝杯咖啡';

  @override
  String get cantOpenLink => '无法打开该链接';

  @override
  String get preferences => '偏好设置';

  @override
  String get theme => '外观主题';

  @override
  String get darkTheme => '深色模式';

  @override
  String get lightTheme => '浅色模式';

  @override
  String get languageLabel => '语言';

  @override
  String get unitsLabel => '单位';

  @override
  String get restTimer => '组间休息计时器';

  @override
  String get alarmBlockedTitle => '通知权限未开启';

  @override
  String get alarmBlockedBody => '锁屏状态下将无法响铃提醒组间休息结束';

  @override
  String get alarmBlockedAction => '去开启';

  @override
  String get alarmSound => '提示音';

  @override
  String get alarmDefaultName => '默认声音';

  @override
  String get alarmSoundHint => '可导入自定义音频 — 长度不超过 15 秒';

  @override
  String get alarmChoose => '选择音频文件…';

  @override
  String get alarmPreview => '试听当前声音';

  @override
  String get alarmReset => '恢复默认声音';

  @override
  String get alarmTooLong => '音频时长不能超过 15 秒';

  @override
  String get alarmInvalid => '无法读取该音频文件';

  @override
  String alarmChanged(String name) {
    return '提示音已设置为 “$name”';
  }

  @override
  String get alarmChangedDefault => '已恢复为默认提示音';

  @override
  String get homeWidgets => '桌面微件';

  @override
  String get addActivityWidget => '添加今日动态微件';

  @override
  String get addStatsWidget => '添加统计概览微件';

  @override
  String get pinUnsupported => '请从手机桌面启动器的微件菜单中手动添加';

  @override
  String get background => '背景纹理';

  @override
  String get bgNone => '纯色无底纹';

  @override
  String get bgDots => '点阵';

  @override
  String get bgGrid => '网格';

  @override
  String get data => '数据备份与导入';

  @override
  String get exportCsv => '导出训练记录 (CSV)';

  @override
  String get exportBackup => '导出完整备份 (JSON)';

  @override
  String get importBackup => '导入备份';

  @override
  String get importHint => '选择从 GymMane 导出的 .json 备份文件。这将会覆盖你当前的数据。';

  @override
  String get import => '导入';

  @override
  String get chooseFile => '选择文件';

  @override
  String get importFromApp => '从其他应用导入';

  @override
  String get importUnknownFormat => '不支持的文件格式。仅支持 Hevy、Strong 或 FitNotes 的导出文件';

  @override
  String get importZipNoWeights => '该 zip 压缩包中未包含体重数据文件';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已导入 $n 条体重记录', one: '已导入 $n 条体重记录');
    return '$_temp0';
  }

  @override
  String get importReadFailed => '无法读取该文件';

  @override
  String get importUnitTitle => '该文件使用什么重量单位？';

  @override
  String get importUnitBody => '导入的数据中未注明重量单位。';

  @override
  String get importNothing => '没有可导入的新数据';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已导入 $n 次训练记录', one: '已导入 $n 次训练记录');
    return '$_temp0';
  }

  @override
  String get aboutGymmane => '关于 GymMane';

  @override
  String get yourProfile => '个人资料';

  @override
  String get autofills => '用于自动填充计算器参数';

  @override
  String get nameLabel => '昵称';

  @override
  String get sexLabel => '生理性别';

  @override
  String get macroProtein => 'PROTEIN';

  @override
  String get macroCarbs => 'CARBS';

  @override
  String get macroFat => 'FAT';

  @override
  String get male => '男';

  @override
  String get female => '女';

  @override
  String get ageLabel => '年龄';

  @override
  String get heightLabel => '身高';

  @override
  String get weightLabel => '体重';

  @override
  String get weeklyGoal => '每周训练目标';

  @override
  String get activityLabel => '日常活动量';

  @override
  String get addPhoto => '添加头像';

  @override
  String get removePhoto => '移除头像';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseGallery => '从相册选择';

  @override
  String get backupCopied => '备份数据已复制到剪贴板';

  @override
  String get backupImported => '备份已成功导入';

  @override
  String get backupFailed => '无法读取该备份文件';

  @override
  String get nothingToExport => '暂无可导出的数据 — 请先记录一次训练';

  @override
  String get athlete => '健身者';

  @override
  String calculatorsCount(int n) {
    return '专为训练打造的 $n 款实用计算器';
  }

  @override
  String get result => '计算结果';

  @override
  String get weightLifted => '负重量';

  @override
  String get repsPerformed => '完成次数';

  @override
  String get neck => '颈围';

  @override
  String get waist => '腰围';

  @override
  String get hip => '臀围（女性）';

  @override
  String get targetWeight => '目标重量';

  @override
  String get workingWeight => '正式组重量';

  @override
  String get activityLevel => '日常活动水平';

  @override
  String get barWeight => '杠铃杆重';

  @override
  String get perSide => '单侧配重';

  @override
  String get justTheBar => '仅空杆。';

  @override
  String perSideCount(int n) {
    return '单侧各 $n 片';
  }

  @override
  String rampSet(String pct, int reps) {
    return '$pct · $reps 次';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => '卡路里';

  @override
  String get toolNameBf => '体脂率';

  @override
  String get toolNamePlate => '杠铃片';

  @override
  String get toolNameWarmup => '热身组';

  @override
  String get toolTitleRm => '1RM 极限力量计算器';

  @override
  String get toolTitleBmi => 'BMI 身体质量指数计算器';

  @override
  String get toolTitleCal => '每日热量与营养素计算器';

  @override
  String get toolTitleBf => '体脂率估算器';

  @override
  String get toolTitlePlate => '杠铃片配重计算器';

  @override
  String get toolTitleWarmup => '热身组推算工具';

  @override
  String get toolHintRm => '估算单次最大重量（Epley 公式）';

  @override
  String get toolHintCal => '估算每日维持热量（TDEE）';

  @override
  String get toolHintBf => '美国海军体脂估算法';

  @override
  String get toolHintPlate => '杠铃总重量';

  @override
  String get toolHintWarmup => '目标正式组重量';

  @override
  String get toolDescRm => '估算单次最大重量';

  @override
  String get toolDescBmi => '身体质量指数';

  @override
  String get toolDescCal => '每日热量及营养素建议';

  @override
  String get toolDescBf => '体脂百分比估算';

  @override
  String get toolDescPlate => '杠铃配重片组合推算';

  @override
  String get toolDescWarmup => '热身递增组建议';

  @override
  String get bmiUnderweight => '偏瘦';

  @override
  String get bmiNormal => '正常';

  @override
  String get bmiOverweight => '超重';

  @override
  String get bmiObese => '肥胖';

  @override
  String get actSedentary => '久坐少动';

  @override
  String get actLight => '轻度活动';

  @override
  String get actActive => '高强度活动';

  @override
  String get actModerate => '中度活动';

  @override
  String get muscleChest => '胸肌';

  @override
  String get muscleBack => '背部';

  @override
  String get muscleShoulders => '肩部';

  @override
  String get muscleBiceps => '肱二头肌';

  @override
  String get muscleTriceps => '肱三头肌';

  @override
  String get muscleForearm => '前臂';

  @override
  String get muscleTrapezius => '斜方肌';

  @override
  String get muscleAbdomen => '腹肌';

  @override
  String get muscleObliques => '腹外斜肌';

  @override
  String get muscleQuads => '股四头肌';

  @override
  String get muscleHamstrings => '腘绳肌';

  @override
  String get muscleGlutes => '臀肌';

  @override
  String get muscleCalves => '小腿';

  @override
  String get mgChest => '胸部';

  @override
  String get mgBack => '背部';

  @override
  String get mgLegs => '腿部';

  @override
  String get mgShoulders => '肩部';

  @override
  String get mgArms => '手臂';

  @override
  String get mgCore => '核心';

  @override
  String get equipBarbell => '杠铃';

  @override
  String get equipDumbbell => '哑铃';

  @override
  String get equipCable => '绳索';

  @override
  String get equipMachine => '固定器械';

  @override
  String get equipBodyweight => '自重';

  @override
  String get equipWeighted => '负重自重';

  @override
  String get equipBand => '弹力带';

  @override
  String get equipKettlebell => '壶铃';

  @override
  String get equipOther => '其他';

  @override
  String get diffBeginner => '初学者';

  @override
  String get diffAdvanced => '高阶';

  @override
  String get diffIntermediate => '进阶';

  @override
  String get about => '关于';

  @override
  String version(String v) {
    return '版本 $v';
  }

  @override
  String get aboutBlurb => '由健身者打造，为健身者而生。';

  @override
  String get freeForever => '永久免费';

  @override
  String get freeForeverWhy => '无订阅、无广告、没有任何付费墙功能阻碍。';

  @override
  String get fullyOffline => '完全离线';

  @override
  String get fullyOfflineWhy => '无账号、无服务器。你的训练数据绝不离开这台手机。';

  @override
  String get yoursToTake => '数据归你所有';

  @override
  String get yoursToTakeWhy => '随时导出为 CSV 文件，也可一键清空所有数据。';

  @override
  String get whatsInside => '功能一览';

  @override
  String exercisesInside(int n) {
    return '$n 项内置动作';
  }

  @override
  String get exercisesInsideWhy => '全部配有动作动画和分步图文指导。';

  @override
  String get calculatorsInside => '6 款实用计算器';

  @override
  String get calculatorsInsideWhy => '涵盖 1RM、杠铃片、BMI、热量、体脂率和热身推算 — 均基于公开发表的科学公式。';

  @override
  String get mathInside => '真实可信的数据';

  @override
  String get mathInsideWhy => '容量、纪录和打卡连胜均由你的真实训练组数如实计算，绝无虚饰。';

  @override
  String get yourNumbers => '你的数据概览';

  @override
  String get sessionsCaps => '训练总次数';

  @override
  String get liftedCaps => '总举起重量';

  @override
  String get streakCaps => '连续打卡';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '天', one: '天');
    return '$_temp0';
  }

  @override
  String get restDefaultLabel => '默认组间休息';

  @override
  String restDefault(int s) {
    return '默认为 $s 秒 — 可在设置中修改';
  }

  @override
  String get reset => '重置';

  @override
  String get welcomeKicker => '欢迎使用';

  @override
  String get welcomeBlurb => '所有数据均保存在你的手机上。无账号、无网络连接要求、无任何费用。';

  @override
  String get welcomeStart => '立即开始';

  @override
  String onbStep(int i, int n) {
    return '第 $i 步 / 共 $n 步';
  }

  @override
  String get onbNameTitle => '我们该如何称呼你？';

  @override
  String get onbNameHint => '你的名字或昵称';

  @override
  String get onbNameWhy => '仅用于应用内的日常问候，绝不会离开你的手机。';

  @override
  String get onbBodyTitle => '身体基本数据';

  @override
  String get onbBodyWhy => '用于为计算器提供基础参数，可随时在“设置”中修改。';

  @override
  String get onbGoalTitle => '你计划每周训练几次？';

  @override
  String get onbGoalWhy => '用于设定每周目标环。诚实记录，量力而行。';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '每周 $n 次', one: '每周 $n 次');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => '选择重量单位：公斤还是磅？';

  @override
  String get next => '下一步';

  @override
  String get back => '上一步';

  @override
  String get skip2 => '跳过';

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
