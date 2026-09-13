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
  String get setDone => '完成一组';

  @override
  String get nextExercise => '下一个动作';

  @override
  String get skipExercise => '跳过这个动作？';

  @override
  String skipExerciseBody(String name) {
    return '你还没有标记任何一组，所以「$name」不会被记录。';
  }

  @override
  String get dropExerciseAction => '移除动作';

  @override
  String get restOff => '关闭';

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
  String get volumeCumulative => '累计训练总容量';

  @override
  String get volumeChartEmpty => '完成并记录一次训练，曲线将从这里启程';

  @override
  String get weekRhythm => '每周训练节奏';

  @override
  String get weekRhythmHint => '真实反映你的周出勤规律。';

  @override
  String weekRhythmBest(String day) {
    return '周$day是你的主场';
  }

  @override
  String get weekRhythmEmpty => '完成并记录一次训练，本周节奏即可在此呈现。';

  @override
  String get allTime => '生涯总计';

  @override
  String get allTimeSessions => '总训练次数';

  @override
  String get allTimeTime => '总训练时长';

  @override
  String get allTimeVolume => '累计总负荷';

  @override
  String get allTimeSets => '累计总组数';

  @override
  String allTimeAvg(String time) {
    return '平均每次训练 $time';
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
    return '$place 暂无 $gear';
  }

  @override
  String get notHereWhy => '替换为当前场地现有的器械进行训练。';

  @override
  String get altHere => '当前场地可用动作';

  @override
  String get places => '我的训练场地';

  @override
  String get placesShort => '场地';

  @override
  String get placesHint => '标记各个场地的可用器械，动作库将智能仅展示该场地支持的动作。';

  @override
  String get placeAll => '所有场地';

  @override
  String get placeNew => '新建场地';

  @override
  String get placeNameLabel => '场地名称';

  @override
  String get placeNamePlaceholder => '家庭、健身房、公园……';

  @override
  String get placeGearLabel => '场地现有器械';

  @override
  String placeGearCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 种器械',
      one: '1 种器械',
      zero: '未勾选器械',
    );
    return '$_temp0';
  }

  @override
  String placeExercises(int n) {
    return '支持 $n 个动作';
  }

  @override
  String get placeEmptyTitle => '随时随地，想练就练';

  @override
  String get placeEmptyBody => '场地即器械配置清单。挑选一个预设或创建新场地，后续可随时调整。';

  @override
  String get placeDeleteTitle => '删除场地';

  @override
  String get placeDeleteBody => '仅删除该场地配置，你的所有动作与训练记录均完整保留。';

  @override
  String get placeGym => '健身房';

  @override
  String get placeHome => '居家';

  @override
  String get placeOutdoors => '户外公园';

  @override
  String get placeFilterLabel => '场地筛选';

  @override
  String get noGearOnly => '仅自重';

  @override
  String placeActive(String name) {
    return '当前在 $name 训练';
  }

  @override
  String get journal => '备忘日志';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 条备忘', one: '1 条备忘', zero: '暂无备忘');
    return '$_temp0';
  }

  @override
  String get noteKindNote => '笔记';

  @override
  String get noteKindPlan => '计划';

  @override
  String get noteKindDone => '突破';

  @override
  String get noteKindPain => '酸痛';

  @override
  String get noteFilterAll => '全部';

  @override
  String get newNote => '新建备忘';

  @override
  String get editNote => '编辑备忘';

  @override
  String get addNote => '添加备忘';

  @override
  String get noteEmptyTitle => '暂无备忘内容';

  @override
  String get noteEmptyBody => '随手记录要领心得、下次训练计划或体感状态，支持附带照片与视频。';

  @override
  String get noteNoneForExercise => '该动作暂无备忘记录。';

  @override
  String get noteKindLabel => '类别';

  @override
  String get noteTextLabel => '内容';

  @override
  String get noteDateLabel => '日期';

  @override
  String get noteExerciseLabel => '关联动作';

  @override
  String get noteMediaLabel => '照片与视频';

  @override
  String get noteGeneral => '通用备忘（无关特定动作）';

  @override
  String get noteAttach => '添加附件';

  @override
  String get noteRemoveMedia => '移除附件';

  @override
  String get deleteNoteTitle => '删除备忘';

  @override
  String get deleteNoteBody => '该条备忘及其关联附件将被永久删除。';

  @override
  String get noteToday => '今天';

  @override
  String get noteYesterday => '昨天';

  @override
  String get noteAllNotes => '全部备忘';

  @override
  String get noteCalendar => '日历视图';

  @override
  String get noteNoneOnDay => '当日暂无备忘';

  @override
  String get noteAddOnDay => '在此日期添加备忘';

  @override
  String get notePrevMonth => '上个月';

  @override
  String get noteNextMonth => '下个月';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '本月 $n 条备忘',
      one: '本月 1 条备忘',
      zero: '本月暂无备忘',
    );
    return '$_temp0';
  }

  @override
  String get measures => '身体围度';

  @override
  String get measuresHint => '从颈围到小腿围，见证肉眼可见的身材蜕变，不仅关注杠铃重量。';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 次记录', one: '1 次记录', zero: '暂无记录');
    return '$_temp0';
  }

  @override
  String get measureNoneYet => '暂无记录';

  @override
  String get measureHistory => '历史趋势';

  @override
  String get measureNeck => '颈围';

  @override
  String get measureShoulders => '肩宽';

  @override
  String get measureChest => '胸围';

  @override
  String get measureArm => '臂围';

  @override
  String get measureForearm => '前臂围';

  @override
  String get measureWaist => '腰围';

  @override
  String get measureHips => '臀围';

  @override
  String get measureThigh => '大腿围';

  @override
  String get measureCalf => '小腿围';

  @override
  String get measureBodyfat => '体脂率';

  @override
  String get timeline => '身材相册';

  @override
  String get timelineHint => '同姿态、同机位、同光线。坚持一年，震撼由心而生。';

  @override
  String get timelineEmptyTitle => '拍下第一张身材照，开启蜕变之旅';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 张照片', one: '1 张照片', zero: '暂无照片');
    return '$_temp0';
  }

  @override
  String get poseFront => '正面';

  @override
  String get poseSide => '侧面';

  @override
  String get poseBack => '背面';

  @override
  String get photoEvery => '拍照提醒';

  @override
  String photoEveryDays(int n) {
    return '每 $n 天提醒';
  }

  @override
  String get photoEveryOff => '从不提醒';

  @override
  String get timelineEvery => '分组间隔';

  @override
  String get custom => '自定';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 天后拍摄身材照', one: '明天该拍照啦');
    return '$_temp0';
  }

  @override
  String get photoDueNow => '今天到了拍照打卡日，拍一张吧';

  @override
  String get addTodayPhotos => '记录今日身材照';

  @override
  String posePhoto(String pose) {
    return '$pose身材照';
  }

  @override
  String get compare => '身材对比';

  @override
  String get compareNeedTwo => '在不同日期拍摄同一姿态的照片，即可在此左右同屏对比。';

  @override
  String dayNumber(int n) {
    return '第 $n 天';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '间隔 $n 天',
      one: '间隔 1 天',
      zero: '同一天',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => '删除该日记录';

  @override
  String get deleteDayBody => '当日拍摄的所有身材照都将被永久删除。';

  @override
  String get timelinePhotos => '身材照片';

  @override
  String get timelineBody => '肌群热力图';

  @override
  String get timelineBodyEmpty => '记录训练后，肌群热力图将在此自动点亮，无需拍照。';

  @override
  String get timelineBodyHint => '由你的真实训练组数自动绘制，无需上传任何数据。';

  @override
  String timelineWindow(String from, String to) {
    return '$from 至 $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 次训练', one: '1 次训练', zero: '暂无训练');
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => '身材打卡提醒';

  @override
  String get notifPhotoChannelWhy => '在身材照拍摄日发送提醒。';

  @override
  String get notifPhotoTitle => '该拍身材照啦';

  @override
  String notifPhotoBody(int n) {
    return '距离上次拍照已有 $n 天。保持同姿态、同光线打卡一张吧！';
  }

  @override
  String get share => '分享';

  @override
  String get sharePick => '你想分享什么？';

  @override
  String get shareSession => '本次训练结算';

  @override
  String get shareStreak => '训练日历';

  @override
  String get shareBody => '训练肌群';

  @override
  String get shareCompare => '前后身材对比';

  @override
  String get shareHint => '卡片本地生成。未经允许，不会外传。';

  @override
  String get shareFailed => '卡片生成失败';

  @override
  String get shareWeekOf => '近 7 天';

  @override
  String get shareStreakLabel => '连续训练天数';

  @override
  String get shareSessionsLabel => '训练次数';

  @override
  String get shareVolumeLabel => '总负荷';

  @override
  String get shareSetsLabel => '总组数';

  @override
  String get shareNothing => '请先完成一次训练，暂无数据可供展示';

  @override
  String get restForExercise => '该动作专属间歇时间';

  @override
  String get restUsingDefault => '跟随全局默认时间';

  @override
  String get restCustom => '仅该动作自定义';

  @override
  String get setType => '组别类型';

  @override
  String get setTypeNormal => '正式组';

  @override
  String get setTypeWarmup => '热身组';

  @override
  String get setTypeDrop => '递减组';

  @override
  String get setTypeFailure => '力竭组';

  @override
  String get setTypeHint => '热身组不会计入正式容量与个人纪录（PR）。';

  @override
  String get addWarmup => '添加热身组';

  @override
  String platesPerSide(String plates) {
    return '单边挂片: $plates';
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
  String get importUnknownFormat => '该文件需要日期、动作、次数和重量这几列';

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
  String get macroProtein => '蛋白质';

  @override
  String get macroCarbs => '碳水';

  @override
  String get macroFat => '脂肪';

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
  String get toolNameRm => '极限重量 (1RM)';

  @override
  String get toolNameBmi => 'BMI 指数';

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
  String get equipRings => '吊环';

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
  String get freeForeverWhy => '无订阅、无广告、无付费功能。';

  @override
  String get fullyOffline => '完全离线';

  @override
  String get fullyOfflineWhy => '无账号、无服务器。';

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
  String get calculatorsInsideWhy => '涵盖 1RM、杠铃片、BMI、热量、体脂率和热身推算。';

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
  String get madeWithLoveBy => '用心制作';

  @override
  String get sourceCode => '开源代码';

  @override
  String get suggested => '推荐动作';

  @override
  String get results => '搜索结果';

  @override
  String get noMatches => '未找到匹配该关键词的动作。';

  @override
  String get tapToEdit => '点击铅笔修改记录，点击垃圾桶删除。';

  @override
  String get editEntry => '编辑记录';

  @override
  String get editEntryHint => '调整任意组的次数或负重重量。';

  @override
  String get removeSet => '删除此组';

  @override
  String get continueWorkout => '继续本次训练';

  @override
  String get continueWorkoutBody => '恢复为进行中的训练状态，已完成组保持勾选。再次完成时将覆盖保存在原训练日期。';

  @override
  String get addBodyWidget => '添加肌群桌面小组件';

  @override
  String get repsOnly => '仅记次数';

  @override
  String get repsOnlyHint => '纯自重动作，记录时无需输入重量。';

  @override
  String get useDefaultArt => '恢复为默认动作图';

  @override
  String daysShort(int n) {
    return '${n}d';
  }

  @override
  String get focusCard => '今日重点';

  @override
  String get autoAdvance => '自动进入下一个动作';

  @override
  String get autoAdvanceHint => '勾选一个动作的最后一组后，训练会自动进入下一个动作。';

  @override
  String get autoProgress => '下次自动加重';

  @override
  String autoProgressHint(String w) {
    return '完成全部次数后，下次训练自动增加 $w。';
  }

  @override
  String get placePlates => '杠铃片和杠铃杆';

  @override
  String get platesAll => '全部可用';

  @override
  String platesOwned(int n) {
    return '$n 种';
  }

  @override
  String get platePairs => '对数';

  @override
  String plateAchievable(String w) {
    return '最接近可加到：$w';
  }

  @override
  String get autoWarmup => '先做热身组';

  @override
  String get autoWarmupHint => '开始训练时自动加入热身组。';

  @override
  String get trainReminder => '训练提醒';

  @override
  String get trainReminderHint => '在你安排了计划的日子，按这个时间提醒你。';

  @override
  String get notifTrainChannel => '训练提醒';

  @override
  String get notifTrainChannelWhy => '在你安排训练的日子提醒你。';

  @override
  String get notifTrainTitle => '该训练了';

  @override
  String get notifTrainBody => '你的训练计划在等你。';

  @override
  String get exportCatalog => '导出动作清单';

  @override
  String get importRoutine => '导入训练计划（JSON）';

  @override
  String get planIntro => '只用这份清单里的动作，帮我做一份训练计划。';

  @override
  String get planFormat => '只用 JSON 回答，格式如下：';

  @override
  String planImported(int n) {
    return '已向训练计划加入 $n 个动作';
  }

  @override
  String get planNothing => '该文件中的动作都不在你的动作库里';

  @override
  String get planFailed => '无法读取该训练计划文件';

  @override
  String get routineGroup => '分组';

  @override
  String get newGroup => '新建分组';

  @override
  String get noGroup => '不分组';

  @override
  String get groupNameHint => '推 / 拉 / 腿，5×5…';

  @override
  String get filters => '筛选';

  @override
  String get setsPlannedHint => '为每个动作选好组数，训练开始时就已经排好。';

  @override
  String get nextTime => '下次';

  @override
  String get nextHold => '保持重量，直到完成全部次数';

  @override
  String get bgPhoto => '你的照片';

  @override
  String get bgPhotoPick => '选择照片';

  @override
  String get bgPhotoChange => '更换照片';

  @override
  String get bgPhotoRemove => '移除照片';

  @override
  String get bgDim => '变暗程度';

  @override
  String get dimSoft => '轻';

  @override
  String get dimMedium => '中';

  @override
  String get dimStrong => '重';

  @override
  String get bgPhotoHint => '照片在最底层，会调暗以保证界面清晰。';

  @override
  String get reminderSmart => '智能';

  @override
  String get reminderFixed => '固定时间';

  @override
  String get reminderSmartHint => '按你实际训练的日子和时间提醒；当天已经练过就不再打扰。';

  @override
  String get reminderSmartEmpty => '再多记录几次训练，它就会学到你的规律。';

  @override
  String habitFocus(String day) {
    return '你在$day常练的';
  }

  @override
  String get duplicateRoutine => '复制训练计划';

  @override
  String copySuffix(String name) {
    return '$name（副本）';
  }

  @override
  String get saveAsRoutine => '保存为训练计划';

  @override
  String get savedAsRoutine => '已保存为训练计划';

  @override
  String get templates => '现成计划';

  @override
  String get templatesHint => '经典训练计划，用你自己的动作库拼成。之后都能改。';

  @override
  String templateAdded(int n) {
    return '已加入 $n 个训练计划';
  }

  @override
  String get tplFullbody => '每周三次全身训练，新手从这里开始。';

  @override
  String get tplPpl => '推、拉、腿，每周三天或六天。';

  @override
  String get tplUpperlower => '上肢和下肢，每周四天。';

  @override
  String get tplStronglifts => '两个训练日，五组五次，交替进行。';

  @override
  String get tplStartingstrength => '每次都练深蹲，两个训练日交替。';

  @override
  String get tplHome => '只需要一根单杠和地板。';

  @override
  String dayCount(int n) {
    return '$n 天';
  }

  @override
  String get logRpe => '记录用力程度（RPE）';

  @override
  String get rpeTitle => '用力程度（RPE）';

  @override
  String get rpeHint => '10 表示一次也做不动了，8 表示还能再做两次。';

  @override
  String get superset => '超级组';

  @override
  String get supersetLink => '与下一个动作相连';

  @override
  String get supersetHint => '相连的动作之间不休息，直接进入下一个。';

  @override
  String get aiRoutine => '用 AI 生成计划';

  @override
  String get aiIntro => 'GymMane 不会和任何 AI 通信。你把动作清单导出，粘贴给你惯用的助手，再把它的回答导回来。手机不会自己往外发任何东西。';

  @override
  String get aiStep1 => '导出你的动作清单。如果选了场地，只会包含你在那里能做的动作。';

  @override
  String get aiStep2 => '把这个文件交给任意 AI，请它给你一份训练计划。';

  @override
  String get aiStep3 => '把它的回答存成文件，JSON 或纯文本都可以。';

  @override
  String get aiStep4 => '在这里导入。名称会和你的动作库对上，计划就建好了。';

  @override
  String aiMissing(int n) {
    return '有 $n 个名称不在你的动作库里';
  }

  @override
  String get importApps => '支持哪些 app';

  @override
  String get importOtherCsv => '任何含日期、动作、次数和重量的 CSV';

  @override
  String get importAskApp => '需要其他 app？告诉我';

  @override
  String get awardFirstStepName => '第一步';

  @override
  String get awardFirstStepLine => '欢迎来到 GymMane，这枚是送你的。';

  @override
  String get awardFirstWorkoutName => '第一次训练';

  @override
  String get awardFirstWorkoutLine => '第一次已经记录好了，最难的就是这一步。';

  @override
  String get awardFirstRoutineName => '第一个计划';

  @override
  String get awardFirstRoutineLine => '你已经有了可以回头再练的计划。';

  @override
  String get awardFirstRecordName => '第一个纪录';

  @override
  String get awardFirstRecordLine => '你刷新了某个动作的最好成绩。';

  @override
  String get awardStreak3Name => '连续三天';

  @override
  String get awardStreak3Line => '连续三天，一切都是这样开始的。';

  @override
  String get awardTonne1Name => '一吨';

  @override
  String get awardTonne1Line => '所有组加起来举起了一千公斤。';

  @override
  String get awardSets100Name => '一百组';

  @override
  String get awardSets100Line => '一组一组，练满了一百组。';

  @override
  String get awardHours10Name => '十小时';

  @override
  String get awardHours10Line => '十个小时的训练时间。';

  @override
  String get awardWorkouts50Name => '五十次训练';

  @override
  String get awardWorkouts50Line => '五十次训练已经完成。';

  @override
  String get awardHours50Name => '五十小时';

  @override
  String get awardHours50Line => '在健身房里度过了五十个小时。';

  @override
  String get awardsTitle => '勋章';

  @override
  String get awardWon => '已获得';

  @override
  String get yearTitle => '你的一年';

  @override
  String get yearBestMonth => '最佳月份';

  @override
  String get yearMonths => '月';

  @override
  String get awardSpinHint => '拖动勋章即可旋转';

  @override
  String get awardUnlocked => '解锁新成就';

  @override
  String get awardNice => '太棒了！';

  @override
  String get awardSaveImage => '保存图片';

  @override
  String get awardSaved => '已保存到相册';

  @override
  String get awardStreakBottom => '连续';

  @override
  String get awardStreak7Top => '七天';

  @override
  String get awardStreak7Name => '七天';

  @override
  String get awardStreak7Line => '整整一周，一天都没落下。';

  @override
  String get awardStreak30Top => '三十天';

  @override
  String get awardStreak30Name => '三十天';

  @override
  String get awardStreak30Line => '连续一个月，已经成为习惯。';

  @override
  String get awardWorkouts100Top => '一百次';

  @override
  String get awardWorkouts100Bottom => '训练';

  @override
  String get awardWorkouts100Name => '一百次训练';

  @override
  String get awardWorkouts100Line => '完整记录了一百次训练。';

  @override
  String get awardTonnes100Top => '一百';

  @override
  String get awardTonnes100Bottom => '吨';

  @override
  String get awardTonnes100Name => '一百吨';

  @override
  String get awardTonnes100Line => '你举起的总重量达到 100,000 公斤。';

  @override
  String get awardSets1000Top => '一千';

  @override
  String get awardSets1000Bottom => '组';

  @override
  String get awardSets1000Name => '一千组';

  @override
  String get awardSets1000Line => '一组一组，累积到一千组。';

  @override
  String get profile => '个人资料';

  @override
  String get editProfile => '编辑资料';

  @override
  String get pickBadge => '徽章';

  @override
  String get badgeTitle => '你的徽章';

  @override
  String get statWorkouts => '训练次数';

  @override
  String get statTrained => '训练时长';

  @override
  String get statSets => '组数';

  @override
  String get statLifted => '总重量';

  @override
  String get statStreak => '连续';

  @override
  String get statDays => '天';

  @override
  String get unitHours => '小时';

  @override
  String get unitDays => '天';

  @override
  String get snapshots => '照片';

  @override
  String get snapNow => '拍一张';

  @override
  String get calendarLegend => '训练 · 照片';

  @override
  String get addCover => '添加封面';

  @override
  String get addTodayWidget => '今天是否完成';

  @override
  String get monthTitle => '本月';

  @override
  String get photosCard => '你的照片';

  @override
  String get handleLabel => '用户名';

  @override
  String get setupTitle => '填好这些，页面其余部分会自动补全';

  @override
  String get setupHint => '这里的每个数字都来自你的记录，不会发送到任何地方。';

  @override
  String get setupWorkout => '记录第一次训练';

  @override
  String get setupWeight => '记下你的体重';

  @override
  String get setupMeasures => '量一下围度';

  @override
  String get setupPhoto => '拍第一张进度照片';

  @override
  String get progressTitle => '进度';

  @override
  String get tileVolume30 => '容量 · 30天';

  @override
  String get tileAddWeight => '记一下';

  @override
  String get heatToneTitle => '热力图颜色';

  @override
  String get heatToneHint => '只改变网格和人体的配色。';

  @override
  String get thisWeekTitle => '本周';

  @override
  String get momentsEmptyTitle => '这里还什么都没有';

  @override
  String get deletePhotoTitle => '删除这张照片？';

  @override
  String get deletePhotoBody => '删除后无法恢复。';

  @override
  String get awardsEarned => '已获得';

  @override
  String get awardsLocked => '未解锁';

  @override
  String get awardStreak100Name => '一百天';

  @override
  String get awardWorkouts10Name => '十次训练';

  @override
  String get awardWorkouts10Line => '最初的十次最难，也最关键。';

  @override
  String get awardWorkouts365Name => '三百六十五';

  @override
  String get awardWorkouts365Line => '一年中每一天都有一次训练，一次次记录下来。';

  @override
  String get awardTonnes10Name => '十吨';

  @override
  String get awardTonnes10Line => '一万公斤已经从你手中经过。';

  @override
  String get awardHours100Name => '一百小时';

  @override
  String get awardHours100Line => '杠铃之下的一百个小时。';

  @override
  String awardWonOn(String date) {
    return '$date 获得';
  }

  @override
  String awardProgressLabel(String value, String goal) {
    return '$value / $goal';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {'gold': '金色', 'blue': '蓝色', 'green': '绿色', 'other': '徽章'});
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '自 $date';
  }

  @override
  String levelShort(int n) {
    return '等级 $n';
  }

  @override
  String levelToNext(int n, int next) {
    return '再练 $n 次升到 $next 级';
  }

  @override
  String heightCm(int n) {
    return '$n 厘米';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': '炭橙',
      'green': '绿色',
      'blue': '蓝色',
      'mono': '灰色',
      'other': '颜色',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n 组';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '本周 $n/$goal';
  }

  @override
  String momentCount(int n) {
    return '$n 张照片';
  }

  @override
  String get badgeHint => '选一个颜色，再次点击已选的即可取消。仅供自己使用：无需验证，也无需付费。';

  @override
  String get momentsEmptyHint => '拍下健身房、白板、杠铃的配重……任何你想记住的东西。照片只留在手机里，只有你能看到。';

  @override
  String get awardStreak100Line => '连续一百天。这已经不是靠动力，而是你本来的样子。';

  @override
  String get coverLabel => '封面';

  @override
  String get removeCover => '移除封面';

  @override
  String get startTitle => '开始训练';

  @override
  String get logTitle => '记录训练';

  @override
  String get logHint => '没有计时器，只要填上你做过的内容。';

  @override
  String get orStartFrom => '或者从这里开始';

  @override
  String get pickExercisesOption => '挑选动作';

  @override
  String get chooseFocusOption => '选择训练重点';

  @override
  String get plannedRoutine => '已安排';

  @override
  String get logWorkoutAction => '记录一次训练';

  @override
  String get logging => '记录中';

  @override
  String get placesLabel => '我的场所';
}
