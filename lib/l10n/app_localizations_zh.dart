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
  String get allTimeSessions => '总训练次数';

  @override
  String get allTimeTime => '总训练时长';

  @override
  String get allTimeSets => '累计总组数';

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
  String get personalRecords => '个人纪录';

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
  String get kindLabel => '类型';

  @override
  String get kindStrength => '力量';

  @override
  String get kindCalisthenics => '自重训练';

  @override
  String get kindCardio => '有氧';

  @override
  String get kindStretch => '拉伸';

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
  String get placesHint => '标记各个场地的可用器械，动作库将智能仅展示该场地支持的动作。';

  @override
  String get placeAll => '所有场地';

  @override
  String get placeNew => '新建场地';

  @override
  String get placeNamePlaceholder => '家庭、健身房、公园……';

  @override
  String get placeGearLabel => '场地现有器械';

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
  String get dragToReorder => '拖动带点的手柄调整顺序，这就是你的训练顺序。';

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
  String get backupImported => '备份已成功导入';

  @override
  String get backupFailed => '无法读取该备份文件';

  @override
  String get nothingToExport => '暂无可导出的数据 — 请先记录一次训练';

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
  String get muscleLowerBack => '下背';

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
  String get calculatorsInside => '10 款实用计算器';

  @override
  String get calculatorsInsideWhy => '涵盖 1RM、杠铃片、BMI、热量、体脂率、FFMI、热身、RPE 负重以及 DOTS 和 Wilks 力量评分。';

  @override
  String get mathInside => '真实可信的数据';

  @override
  String get mathInsideWhy => '容量、纪录和打卡连胜均由你的真实训练组数如实计算，绝无虚饰。';

  @override
  String get streakCaps => '连续打卡';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '天', one: '天');
    return '$_temp0';
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
  String get keepScreenOn => '训练时保持屏幕常亮';

  @override
  String get lockWorkout => '锁定屏幕';

  @override
  String get unlockWorkout => '解锁';

  @override
  String get holdToUnlock => '长按解锁';

  @override
  String get liveChannel => '进行中的训练';

  @override
  String get liveChannelWhy => '训练时显示当前动作、组数和休息倒计时';

  @override
  String liveSet(int n, int total) {
    return '第 $n/$total 组';
  }

  @override
  String get liveResting => '休息中';

  @override
  String get liveAllDone => '所有组已完成';

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
  String get reminderExactTime => '精确时间';

  @override
  String get toastSoundSetting => '提示音';

  @override
  String get toastSoundHint => '顶部弹出提示时的轻柔提示音。';

  @override
  String get notifTrainChannel => '训练提醒';

  @override
  String get notifTrainChannelWhy => '在你安排训练的日子提醒你。';

  @override
  String get notifTrainTitle => '该训练了';

  @override
  String get notifTrainBody => '你的训练计划在等你。';

  @override
  String get planIntro => '只用这份清单里的动作，帮我做一份训练计划。';

  @override
  String get planFormat => '只用 JSON 回答，格式如下：';

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
  String get awardStreak7Name => '七天';

  @override
  String get awardStreak7Line => '整整一周，一天都没落下。';

  @override
  String get awardStreak30Name => '三十天';

  @override
  String get awardStreak30Line => '连续一个月，已经成为习惯。';

  @override
  String get awardWorkouts100Name => '一百次训练';

  @override
  String get awardWorkouts100Line => '完整记录了一百次训练。';

  @override
  String get awardTonnes100Name => '一百吨';

  @override
  String get awardTonnes100Line => '你举起的总重量达到 100,000 公斤。';

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
  String get addCover => '添加封面';

  @override
  String get addTodayWidget => '今天是否完成';

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
  String photosSelected(int n) {
    return '已选 $n 张';
  }

  @override
  String deletePhotosTitle(int n) {
    return '删除 $n 张照片？';
  }

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

  @override
  String get undo => '撤销';

  @override
  String get deleteSet => '删除这一组';

  @override
  String get setDeleted => '已删除这一组';

  @override
  String get removeWarmup => '移除热身';

  @override
  String get addWeightAction => '添加负重';

  @override
  String get workoutOverview => '本次训练';

  @override
  String get allExercisesShort => '全部';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total 组';
  }

  @override
  String get nowLabel => '当前';

  @override
  String get deleteWorkout => '删除训练';

  @override
  String get deleteWorkoutBody => '这次训练及其所有组都会从记录中删除。';

  @override
  String get themeAuto => '自动';

  @override
  String get themeAutoHint => '跟随系统';

  @override
  String get demoSizeTitle => '训练时的动作演示';

  @override
  String get demoLarge => '大';

  @override
  String get demoSmall => '小';

  @override
  String get demoOff => '隐藏';

  @override
  String get demoLoopTitle => '演示动画';

  @override
  String get demoLoopAlways => '循环';

  @override
  String get demoLoopShort => '10 秒';

  @override
  String get demoLoopHint => '播放约 10 秒后停在起始姿势。点按演示可再次观看。';

  @override
  String get alarmStyleTitle => '休息结束时';

  @override
  String get alarmStyleLoud => '始终响铃';

  @override
  String get alarmStyleQuiet => '跟随静音模式';

  @override
  String get alarmStyleVibrate => '仅振动';

  @override
  String get alarmStyleHint => '“始终响铃”使用闹钟音量，静音时也会响。“跟随静音模式”使用通知音量，手机静音时只振动。';

  @override
  String get suggestedPicks => '为你推荐';

  @override
  String get moreOptions => '更多选择';

  @override
  String get suggestInWorkouts => '在快速训练中推荐';

  @override
  String get suggestInWorkoutsHint => '关闭后不会出现在为你挑选的动作里，但仍可手动添加。';

  @override
  String get onbPlaceTitle => '你在哪里训练？';

  @override
  String get onbPlaceWhy => '选出你训练的所有地点。我们只推荐你在每个地点能做的动作。';

  @override
  String get onbPlaceGear => '那里有哪些器材？';

  @override
  String distanceCol(String unit) {
    return '距离（$unit）';
  }

  @override
  String get timeCol => '时间';

  @override
  String get timeMinutesTitle => '时间（分钟）';

  @override
  String get timeSecondsTitle => '时间（秒）';

  @override
  String distanceTitle(String unit) {
    return '距离（$unit）';
  }

  @override
  String get holdLabel => '坚持';

  @override
  String get stopLabel => '停止';

  @override
  String startHold(String time) {
    return '开始 · $time';
  }

  @override
  String get exerciseTypeLabel => '记录方式';

  @override
  String get typeReps => '次数和重量';

  @override
  String get typeTime => '时间';

  @override
  String get typeCardio => '距离和时间';

  @override
  String get exerciseTypeHint => '跑步、游泳等有氧记录距离和时间；平板支撑等静态动作只记录时间。';

  @override
  String get howToLabel => '动作要领（可选）';

  @override
  String get howToHint => '每行一个步骤';

  @override
  String get editExercise => '编辑动作';

  @override
  String get saveChanges => '保存修改';

  @override
  String get noStepsYet => '还没有步骤。写下你自己的做法，方便以后回顾。';

  @override
  String get addSteps => '写下步骤';

  @override
  String get setTypeRestPause => '休息暂停';

  @override
  String get setTypeNormalInfo => '普通组，计入训练量和个人纪录。';

  @override
  String get setTypeWarmupInfo => '用于热身的轻重量组，不计入训练量和个人纪录。';

  @override
  String get setTypeDropInfo => '一组结束后立刻降低重量，不休息继续做。';

  @override
  String get setTypeFailureInfo => '做到无法再以标准动作完成一次为止。记录实际完成的次数。';

  @override
  String get setTypeRestPauseInfo => '一组后休息 10 到 20 秒，再挤出几次。';

  @override
  String get planFormatNotes =>
      '动作名称请完全按照列表书写。\"sets\"、\"reps\"、\"weight\"（按给定单位）、\"rest\"（秒）和 \"days\" 都是可选的。\"superset\": true 表示与下一个动作组成超级组。多周计划请像第二个示例那样放在 \"weeks\" 里。';

  @override
  String get planSets => '规划每组';

  @override
  String get planSetsHint => '设置每组的类型、次数和重量。重量留“自动”则沿用你上次的训练。';

  @override
  String get autoValue => '自动';

  @override
  String get clearPlan => '清除计划';

  @override
  String get shareRoutine => '分享训练计划';

  @override
  String get shareWeek => '分享我的一周';

  @override
  String get shareWeekHint => '你所有的训练计划，以及各自安排在哪天。';

  @override
  String shareMessage(String name) {
    return '$name —— 用 GymMane 打开这个文件即可添加。';
  }

  @override
  String get importRoutines => '导入训练计划';

  @override
  String get importPasteHint => '在这里粘贴训练计划：GymMane 分享的内容、AI 的回答、JSON 或 CSV 都可以。';

  @override
  String get pasteAction => '粘贴';

  @override
  String routineCount(int n) {
    return '$n 个训练计划';
  }

  @override
  String get useTheirSchedule => '同时采用它的每周安排';

  @override
  String get useTheirScheduleHint => '它包含的日子会替换你在那些天的安排。';

  @override
  String get addToMyRoutines => '添加到我的计划';

  @override
  String routinesAdded(int n) {
    return '已添加 $n 个训练计划';
  }

  @override
  String get nothingToImport => '这里没有 GymMane 能导入的内容';

  @override
  String get aiStepCopy => '复制请求。它包含你的动作列表和 GymMane 能读取的格式。';

  @override
  String get aiStepAsk => '把它粘贴到任意 AI 里，说出你的需求：每周几天、目标、几周。';

  @override
  String get aiStepPaste => '把它的回答粘贴在下面并导入，无需创建文件。';

  @override
  String get copyForAi => '复制给 AI';

  @override
  String get copiedDone => '已复制';

  @override
  String get aiPasteHint => '在这里粘贴 AI 的回答';

  @override
  String get importAction => '导入';

  @override
  String get showFormat => '查看格式';

  @override
  String get shareAsFile => '以文件分享';

  @override
  String get recoveryTab => '恢复';

  @override
  String recoveryOverall(int pct) {
    return '身体已恢复 $pct%';
  }

  @override
  String get recoveryAllFresh => '全部恢复了，今天练什么都可以。';

  @override
  String recoveryStill(String muscles) {
    return '仍在恢复：$muscles';
  }

  @override
  String get recoveryTired => '疲劳';

  @override
  String get recoveryFresh => '充沛';

  @override
  String get recoveryHint => '点一块肌肉查看它的恢复程度。越近的训练组影响越大，越吃力的组（按 RPE）影响更大。';

  @override
  String recoveryPct(int pct) {
    return '已恢复 $pct%';
  }

  @override
  String readyInHours(int h) {
    return '约 $h 小时后恢复';
  }

  @override
  String get tplAbcd => '四天：胸+三头、背+二头、腿、肩+腹。';

  @override
  String get tplAbcde => '五天，每天一个部位：胸、背、腿、肩、手臂。';

  @override
  String get elapsedCaps => '已用时';

  @override
  String get tapToSkip => '点按跳过';

  @override
  String get screenLocked => '屏幕已锁定';

  @override
  String get lockedHint => '长按顶部的指纹图标即可解锁';

  @override
  String get liveDoneSet => '完成这一组';

  @override
  String get liveSkipRest => '跳过休息';

  @override
  String get livePause => '暂停';

  @override
  String get liveResume => '继续';

  @override
  String get liveNext => '下一个';

  @override
  String liveUpNext(String name) {
    return '下一个：$name';
  }

  @override
  String get stickerOpen => '分享到照片上';

  @override
  String get stickerNoPhoto => '不用照片';

  @override
  String get stickerWorkout => '训练';

  @override
  String get stickerStreak => '连续';

  @override
  String get stickerDate => '日期';

  @override
  String get stickerHint => '拖动来移动，双指缩放或旋转';

  @override
  String get stickerSaved => '已保存到相册';

  @override
  String get stickerWeek => '本周';

  @override
  String get getReady => '准备';

  @override
  String get stickerGallery => '相册';

  @override
  String get stickerCamera => '相机';

  @override
  String get shareIntroTitle => '分享这个计划';

  @override
  String get shareIntroBody => '发给你的伴侣、朋友或家人。他们会收到一个小文件，用 GymMane 打开，一点就能加入，组数和重量都在。';

  @override
  String get removedFromRoutine => '已从计划中移除';

  @override
  String get radarTitle => '最近 30 天';

  @override
  String get radarHint => '看看哪些部位需要多练';

  @override
  String get radarEmpty => '练几天就能看到你的均衡情况';

  @override
  String get radarBalanced => '目前很均衡';

  @override
  String radarFocus(String list) {
    return '需要多练：$list';
  }

  @override
  String get countdownReady => '准备';

  @override
  String get countdownSkip => '点一下立即开始';

  @override
  String get countdownSetting => '开始前倒计时';

  @override
  String get effortSetting => '记录每组强度';

  @override
  String get effortHint => 'RPE：10 表示一次都做不动了，8 表示还能再做两次。RIR 表示还剩几次。记录后，估算 1RM 会使用 RPE 表。';

  @override
  String get rirHint => '0 表示一次都做不动了，2 表示还能再做两次。';

  @override
  String get addWeekWidget => '添加本周小组件';

  @override
  String get gamificationSetting => '勋章和等级';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 次', one: '$n 次');
    return '$_temp0';
  }

  @override
  String get prBestSet => '最佳一组';

  @override
  String get weekStartSetting => '每周开始于';

  @override
  String get stepOutOfWorkout => '暂停并离开';

  @override
  String get saveToRoutine => '将更改保存到训练计划';

  @override
  String get routineUpdated => '训练计划已更新';

  @override
  String saveChangesTitle(String name) {
    return '将更改保存到$name？';
  }

  @override
  String get saveChangesBody => '下次开始时，训练计划会包含这些更改。';

  @override
  String get routineOrderChanged => '新的动作顺序';

  @override
  String get mineOnly => '我创建的';

  @override
  String createNamed(String name) {
    return '没有？创建“$name”';
  }

  @override
  String get orStartWith => '或者从这里开始';

  @override
  String get warmupFocus => '热身';

  @override
  String get warmupFocusHint => '有无器械都能做的灵活性与激活';

  @override
  String get cardioFocus => '有氧';

  @override
  String get cardioFocusHint => '跑步、骑行、划船或跳绳，按距离和时间记录';

  @override
  String get homeRecommended => '首页推荐';

  @override
  String get archivedFilter => '已归档';

  @override
  String get archiveExercise => '归档动作';

  @override
  String get restoreExercise => '恢复';

  @override
  String get archivedToast => '动作已归档';

  @override
  String get archivedToastHint => '可在 动作 › 已归档 中找到';

  @override
  String get archivedBanner => '已归档：不会出现在列表和推荐中，训练记录会保留。';

  @override
  String get videoMarksHint => '在某一步暂停并点图钉，下次可直接跳到这里。';

  @override
  String get videoMarkHere => '把这一步标记在这里';

  @override
  String get sectionGeneral => '通用';

  @override
  String get sectionTraining => '训练';

  @override
  String get sectionAlerts => '提醒与闹钟';

  @override
  String get sectionHome => '首页';

  @override
  String get sectionWidgets => '小组件';

  @override
  String get sectionData => '数据与备份';

  @override
  String get multiPlanSetting => '一天多个训练计划';

  @override
  String get multiPlanHint => '点选这一天的每个计划，按添加顺序进行。';

  @override
  String routineOfDay(int n, int total) {
    return '今天第 $n/$total 个';
  }

  @override
  String get nextToday => '今天的下一个';

  @override
  String get planAboutMe => '关于我：';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex，$age 岁，身高 $height，体重 $weight。';
  }

  @override
  String planDays(int n) {
    return '我想每周训练 $n 天。';
  }

  @override
  String get planNoHistory => '还没有训练记录：请把我当作新手，训练量和重量要保守。';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '最近 30 天训练了 $n 次。',
      one: '最近 30 天训练了 1 次。',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => '最近的最佳组';

  @override
  String get planAskFirst => '如果你不知道我的目标（力量、增肌、减脂或一般体能）或每次能练多久，请先用一条简短消息问我。知道后只用 JSON 回答。';

  @override
  String get backToTop => '回到顶部';

  @override
  String get deleteExerciseTitle => '删除这个动作？';

  @override
  String deleteExerciseBody(String name) {
    return '“$name”将从动作库和训练计划中移除，之前的训练记录会保留。';
  }

  @override
  String get exportForStravaHint => '请在浏览器中打开 strava.com/upload/select 上传（Strava 应用无法导入文件），会显示为带组数的力量训练。';

  @override
  String get manualStartTime => '开始时间';

  @override
  String get manualDuration => '时长';

  @override
  String get manualDurationUnset => '添加时长';

  @override
  String get stravaRow => '导出到 Strava（测试版）';

  @override
  String get stravaBeta => '测试版';

  @override
  String get stravaIntro =>
      '选择一次训练导出到 Strava。你会得到一个 .fit 文件：在浏览器中打开 strava.com/upload/select 上传，会显示为带组数的力量训练。';

  @override
  String get stravaEmpty => '还没有可导出的训练。';

  @override
  String get tapToPause => '点按暂停';

  @override
  String get holdPausedHint => '已暂停 · 点按继续';

  @override
  String get finishHoldNow => '现在完成这组';

  @override
  String get barWeightExercise => '杠铃杆或滑车重量';

  @override
  String get barWeightHint => '杠铃片计算器会用到';

  @override
  String get barWeightCustom => '自定义 · 点按重置';

  @override
  String get groupRename => '重命名分组';

  @override
  String get groupUngroup => '取消分组,保留计划';

  @override
  String get groupDeleteAll => '删除分组及其计划';

  @override
  String groupDeleteTitle(String name) {
    return '删除“$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return '将删除$count。训练记录会保留。';
  }

  @override
  String get tplRr => 'r/bodyweightfitness 的经典计划:每周三天全身训练。变轻松了就进阶到下一级。';

  @override
  String get levelUpKicker => '下一步';

  @override
  String levelUpBody(int reps, String name) {
    return '$name 连续两次训练完成 3×$reps。准备好进阶了吗?';
  }

  @override
  String levelUpSwap(String routine) {
    return '在$routine中替换';
  }

  @override
  String get levelUpSee => '看看怎么做';

  @override
  String get levelUpLater => '以后再说';

  @override
  String get levelUpStay => '继续做这个';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name 已加入$routine';
  }

  @override
  String get levelUpStayed => '不再为这个动作提示进阶';

  @override
  String get levelHintsSetting => '提示下一步进阶';

  @override
  String get heatmapLabelsSetting => '在活动图上显示星期和月份';

  @override
  String get rmPercent => '百分比';

  @override
  String rmAtPercent(String pct) {
    return '最大重量的 $pct';
  }

  @override
  String get copyWorkout => '复制为文本';

  @override
  String get goalSet => '设定目标';

  @override
  String get goalTargetReps => '目标次数';

  @override
  String goalToGo(String value) {
    return '还差 $value';
  }

  @override
  String get goalReached => '目标达成';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '还剩 $n 天');
    return '$_temp0';
  }

  @override
  String get goalOverdue => '已过期限';

  @override
  String get goalDeadline => '截止日期';

  @override
  String get goalNoDeadline => '无截止日期';

  @override
  String get goalRemove => '删除目标';

  @override
  String get exerciseNameMissing => '请输入名称';

  @override
  String get aliasesLabel => '别名（可选）';

  @override
  String get aliasesHint => '其他叫法，用逗号分隔';

  @override
  String alsoCalled(String names) {
    return '又称：$names';
  }

  @override
  String get addToRoutine => '加入计划';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已在 $n 个计划中', zero: '还没加入任何计划');
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => '已在其中';

  @override
  String get restInRoutine => '本计划中的休息';

  @override
  String get restInRoutineHint => '与动作设置相同';

  @override
  String get restInRoutineReset => '仅此处 · 点按恢复';

  @override
  String get swapExercise => '更换动作';

  @override
  String get swapShort => '更换';

  @override
  String swapHint(String name) {
    return '今天用它代替$name。结束时可以保留到计划中。';
  }

  @override
  String get swapKeepsDone => '已完成的组会保留，新动作接着做剩下的。';

  @override
  String swapSameMuscle(String muscle) {
    return '同一肌群 · $muscle';
  }

  @override
  String get swapDoneBefore => '做过';

  @override
  String get multiPlanSettingHint => '同一天安排多个计划。';

  @override
  String get levelHintsHint => '动作变轻松时，推荐更难的版本。';

  @override
  String get focusCardHint => '今天的计划，显示在首页顶部。';

  @override
  String get gamificationHint => '奖章、等级和完成时的庆祝。';

  @override
  String get exerciseSettings => '此动作的设置';

  @override
  String get placeActiveNow => '你在这里';

  @override
  String get placeTapToUse => '点按在这里训练';

  @override
  String get intervalDays => '天';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target 天';
  }

  @override
  String get toolNameRpe => '按 RPE 算重量';

  @override
  String get toolTitleRpe => '按 RPE 算重量';

  @override
  String get toolDescRpe => '想要的强度该用多重';

  @override
  String get toolNameDots => '力量水平';

  @override
  String get toolTitleDots => '力量水平（DOTS）';

  @override
  String get toolDescDots => '相对体重的力量';

  @override
  String rpeResultHint(int reps, String rpe) {
    return '$reps 次 · RPE $rpe';
  }

  @override
  String get rpeYourSet => '刚做完的一组';

  @override
  String get rpeGoal => '你想做的';

  @override
  String rpeOneRmLine(String value) {
    return '预估 1RM：$value';
  }

  @override
  String get rpeExplain => 'RPE 10 表示一次也做不了了；8 表示还剩两次。';

  @override
  String get dotsBestLifts => '你的最佳成绩';

  @override
  String get dotsSquat => '深蹲';

  @override
  String get dotsBench => '卧推';

  @override
  String get dotsDeadlift => '硬拉';

  @override
  String dotsTotalLine(String value) {
    return '总计：$value';
  }

  @override
  String get dotsExplain => '不论体重，都能和任何人比较力量。用你的单次最佳成绩或预估 1RM。';

  @override
  String get dotsLevel0 => '新手';

  @override
  String get dotsLevel1 => '中级';

  @override
  String get dotsLevel2 => '高级';

  @override
  String get dotsLevel3 => '很高级';

  @override
  String get dotsLevel4 => '精英';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks 系数';

  @override
  String get toolDescWilks => '力量举的经典评分';

  @override
  String get wilksExplain => '力量举的经典公式。2020 年被 DOTS 取代，但很多比赛和排名仍在使用。';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => '去脂体重指数';

  @override
  String get toolDescFfmi => '相对身高的肌肉量';

  @override
  String get ffmiBodyFat => '体脂率';

  @override
  String ffmiLeanLine(String value) {
    return '去脂体重：$value';
  }

  @override
  String get ffmiExplain => '类似 BMI，但不算脂肪：只计算去脂体重，并按身高校正，让高个子和矮个子能公平比较。';

  @override
  String get ffmiLevel0 => '低于平均';

  @override
  String get ffmiLevel1 => '平均';

  @override
  String get ffmiLevel2 => '高于平均';

  @override
  String get ffmiLevel3 => '优秀';

  @override
  String get ffmiLevel4 => '卓越';

  @override
  String get rpeEffortLabel => '强度（RPE）';

  @override
  String get restRowHint => '组间休息，动作没有单独设置时使用。';

  @override
  String get effortRowHint => '每组记录 RPE 或 RIR。';

  @override
  String get countdownHint => '第一组前 3、2、1 倒数。';

  @override
  String get keepScreenOnHint => '训练时屏幕保持常亮。';

  @override
  String get demoSizeRowHint => '训练时显示的动作图。';

  @override
  String get demoLoopRowHint => '动画循环还是停止。';

  @override
  String get trainReminderRowHint => '训练日提醒你。';

  @override
  String get alarmSoundRowHint => '休息结束时的声音。';

  @override
  String get alarmStyleRowHint => '静音模式下是否响铃。';

  @override
  String get recommendedRowHint => '首页推荐的动作。';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get languageName => '繁體中文';

  @override
  String vsLastMonthLabel(String pct) {
    return '較上個月 $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return '等級 $level · $streak';
  }

  @override
  String get save => '儲存';

  @override
  String get cancel => '取消';

  @override
  String get cancelCaps => '取消';

  @override
  String get deleteCaps => '刪除';

  @override
  String get done => '完成';

  @override
  String get set => '組';

  @override
  String get home => '首頁';

  @override
  String get progress => '進度';

  @override
  String get exercises => '動作';

  @override
  String get settings => '設定';

  @override
  String get today => '今天';

  @override
  String get thisWeek => '本週';

  @override
  String get recommended => '推薦';

  @override
  String get goal => '目標';

  @override
  String get volume => '訓練量';

  @override
  String get setsToday => '今日組數';

  @override
  String get prs => '紀錄';

  @override
  String get todaysFocus => '今日重點';

  @override
  String get todaysRoutine => '今日課表';

  @override
  String get startWorkout => '開始訓練';

  @override
  String get routines => '課表';

  @override
  String get tools => '工具';

  @override
  String get firstSessionHint => '選擇肌群並記錄第一次訓練';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 個動作', one: '$n 個動作');
    return '$_temp0';
  }

  @override
  String get pushDay => '推日';

  @override
  String get pullDay => '拉日';

  @override
  String get legDay => '腿部';

  @override
  String get pushFocus => '胸 · 肩 · 三頭肌';

  @override
  String get pullFocus => '背 · 二頭肌 · 斜方肌';

  @override
  String get legFocus => '股四頭肌 · 腿後肌 · 臀肌';

  @override
  String get train => '訓練';

  @override
  String get step1 => '第 1 步，共 2 步';

  @override
  String get step2 => '第 2 步，共 2 步';

  @override
  String get chooseFocus => '選擇重點';

  @override
  String get buildSession => '建立訓練';

  @override
  String get tapMuscles => '點選你想訓練的肌群 — 正面與背面。';

  @override
  String get continueBtn => '繼續';

  @override
  String get nothingForFocus => '此重點暫無動作';

  @override
  String get goBackPick => '返回並選擇你的資料庫中有動作的肌群。';

  @override
  String pickedHint(int n) {
    return '我們已為你安排訓練 — 點選即可新增或移除這 $n 個動作中的任一項。';
  }

  @override
  String get pickAnExercise => '選擇動作';

  @override
  String get searchAllExercises => '搜尋動作…';

  @override
  String get noExercisesMatch => '沒有相符的動作';

  @override
  String get createItInstead => '改為建立自己的動作';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 個動作', one: '$n 個動作');
    return '開始 · $_temp0';
  }

  @override
  String get inProgress => '進行中';

  @override
  String get paused => '已暫停';

  @override
  String get last => '上次';

  @override
  String get rest => '休息';

  @override
  String get skip => '略過';

  @override
  String get addSet => '+ 新增一組';

  @override
  String get finishSession => '結束訓練';

  @override
  String get setDone => '本組完成';

  @override
  String get nextExercise => '下一個動作';

  @override
  String get dropExerciseAction => '移除動作';

  @override
  String get restOff => '關閉';

  @override
  String get setCol => '#';

  @override
  String get repsCol => '次數';

  @override
  String weightCol(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get repsTitle => '次數';

  @override
  String weightTitle(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get sessionComplete => '訓練已記錄';

  @override
  String get finishHeadlinePr => '新的個人紀錄';

  @override
  String get finishHeadlineGoal => '已達成本週目標';

  @override
  String get finishHeadlineStreak => '連續紀錄保持中';

  @override
  String get finishHeadlineDefault => '又完成一次訓練';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs 個動作', one: '1 個動作');
    return '你在 $_temp0中舉出了新高。已記錄下來。';
  }

  @override
  String get finishBodyGoal => '你已完成本週預定的訓練次數。';

  @override
  String finishBodyStreak(int streak) {
    return '連續 $streak 天。最難的是不要停下來。';
  }

  @override
  String get finishBodyDefault => '已記錄並計入。持續才會帶來進步。';

  @override
  String get vsLastTime => '與上次相比';

  @override
  String get firstTime => '首次記錄';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 個新紀錄', one: '$n 個新紀錄');
    return '$_temp0';
  }

  @override
  String get duration => '時長';

  @override
  String get setsCaps => '組數';

  @override
  String exerciseXofY(int i, int n) {
    return '動作 $i/$n';
  }

  @override
  String get decrease => '減少';

  @override
  String get increase => '增加';

  @override
  String markSet(int n) {
    return '將第 $n 組標記為完成';
  }

  @override
  String get pauseWorkout => '暫停訓練';

  @override
  String get resumeWorkout => '繼續訓練';

  @override
  String get discardTitle => '捨棄這次訓練？';

  @override
  String get discardBody => '這次訓練的組數資料將會遺失。';

  @override
  String get keepTraining => '繼續訓練';

  @override
  String get discard => '捨棄';

  @override
  String get notifRestChannel => '休息計時器';

  @override
  String get notifRestChannelWhy => '在組間休息結束時通知你';

  @override
  String get notifAlertChannel => '休息計時器（提醒）';

  @override
  String get notifAlertChannelWhy => '休息一結束就顯示橫幅提醒';

  @override
  String get restOverTitle => '休息結束';

  @override
  String get restOverBody => '繼續吧 — 下一組在等你。';

  @override
  String get allTimeSessions => '訓練';

  @override
  String get allTimeTime => '時間';

  @override
  String get allTimeSets => '組數';

  @override
  String get consistency => '持續性';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已記錄 $n 次訓練', one: '已記錄 $n 次訓練');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '連續 $n 天';
  }

  @override
  String get bodyweight => '體重';

  @override
  String get logBodyweight => '記錄體重';

  @override
  String get trackWeight => '追蹤你的體重變化';

  @override
  String get muscleMap => '肌肉地圖';

  @override
  String get days7 => '7 天';

  @override
  String get days30 => '30 天';

  @override
  String get heatLow => '未訓練';

  @override
  String get heatHigh => '最大訓練量';

  @override
  String get muscleMapEmpty => '記錄一次訓練後，你的身體會在這裡開始亮起。';

  @override
  String get muscleMapHint => '點選肌肉查看訓練情況。';

  @override
  String muscleMapBehind(String names) {
    return '落後：$names';
  }

  @override
  String ofTarget(int pct) {
    return '目標的 $pct%';
  }

  @override
  String get muscleSplit => '肌群分布';

  @override
  String get personalRecords => '個人紀錄';

  @override
  String get strength1rm => '力量 · 估算 1RM';

  @override
  String get strengthEmpty => '同一動作記錄兩次後，力量曲線會顯示在這裡。';

  @override
  String oneRmEst(String w) {
    return '估算 1RM：$w';
  }

  @override
  String get restDayShort => '休息日';

  @override
  String get restDay => '休息日 — 沒有紀錄。';

  @override
  String get delete => '刪除';

  @override
  String get deleteEntry => '刪除此紀錄？';

  @override
  String deleteEntryBody(String name) {
    return '「$name」會從這一天、紀錄與圖表中移除。';
  }

  @override
  String get bodyweightHistory => '歷史';

  @override
  String get exercisesCaps => '動作';

  @override
  String get timeCaps => '時間';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '資料庫中有 $n 個動作', one: '資料庫中有 $n 個動作');
    return '$_temp0';
  }

  @override
  String get searchExercises => '搜尋動作';

  @override
  String get muscleFilter => '肌群';

  @override
  String get levelFilter => '等級';

  @override
  String get kindLabel => '類型';

  @override
  String get kindStrength => '力量';

  @override
  String get kindCalisthenics => '自重訓練';

  @override
  String get kindCardio => '有氧';

  @override
  String get kindStretch => '伸展';

  @override
  String get newExercise => '新增動作';

  @override
  String get exerciseName => '動作名稱';

  @override
  String get equipmentLabel => '器材';

  @override
  String get addExercise => '新增動作';

  @override
  String get advanced => '進階';

  @override
  String get demoMedia => '示範';

  @override
  String get addMedia => '新增媒體';

  @override
  String get mediaHint => '圖片、GIF 或影片';

  @override
  String get changeMedia => '變更';

  @override
  String get videoSelected => '已選擇影片';

  @override
  String get favouritesOnly => '收藏';

  @override
  String get noFavouritesYet => '尚無收藏';

  @override
  String get noFavouritesHint => '點選動作旁的星號即可收藏在這裡。';

  @override
  String get clearFilters => '清除篩選條件';

  @override
  String get noExercisesFound => '找不到動作';

  @override
  String get noExercisesHint => '試試其他搜尋方式或清除篩選條件。';

  @override
  String get personalRecord => '個人紀錄';

  @override
  String get history => '歷史';

  @override
  String get noHistory => '尚無訓練紀錄。進行這個動作以建立歷史資料。';

  @override
  String get notes => '筆記';

  @override
  String get notePlaceholder => '提示、設定、感受…';

  @override
  String notHere(String gear, String place) {
    return '$place 沒有 $gear';
  }

  @override
  String get notHereWhy => '換成你今天真的能使用的器材。';

  @override
  String get altHere => '你在這裡可以做的';

  @override
  String get places => '我的地點';

  @override
  String get placesHint => '設定每個地點有哪些器材，資料庫就只會顯示你實際能做的動作。';

  @override
  String get placeAll => '任何地方';

  @override
  String get placeNew => '新增地點';

  @override
  String get placeNamePlaceholder => '家、健身房、公園…';

  @override
  String get placeGearLabel => '可用器材';

  @override
  String placeExercises(int n) {
    return '這裡有 $n 個動作';
  }

  @override
  String get placeEmptyTitle => '隨時隨地訓練';

  @override
  String get placeEmptyBody => '地點就是你在那裡擁有的器材清單。先選一個開始，之後可再編輯。';

  @override
  String get placeDeleteTitle => '刪除地點';

  @override
  String get placeDeleteBody => '只會刪除地點 — 你的動作與訓練會保留。';

  @override
  String get placeGym => '健身房';

  @override
  String get placeHome => '家';

  @override
  String get placeOutdoors => '戶外';

  @override
  String get placeFilterLabel => '地點';

  @override
  String get noGearOnly => '無器材';

  @override
  String placeActive(String name) {
    return '在 $name 訓練';
  }

  @override
  String get journal => '日誌';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 則筆記', one: '1 則筆記', zero: '沒有筆記');
    return '$_temp0';
  }

  @override
  String get noteKindNote => '筆記';

  @override
  String get noteKindPlan => '計畫';

  @override
  String get noteKindDone => '成功';

  @override
  String get noteKindPain => '不適';

  @override
  String get noteFilterAll => '全部';

  @override
  String get newNote => '新增筆記';

  @override
  String get editNote => '編輯筆記';

  @override
  String get addNote => '新增筆記';

  @override
  String get noteEmptyTitle => '尚無任何筆記';

  @override
  String get noteEmptyBody => '記錄提示、下次計畫、訓練感受 — 想的話也可附上照片或影片。';

  @override
  String get noteNoneForExercise => '此動作尚無筆記。';

  @override
  String get noteKindLabel => '類型';

  @override
  String get noteTextLabel => '筆記';

  @override
  String get noteDateLabel => '日期';

  @override
  String get noteExerciseLabel => '動作';

  @override
  String get noteMediaLabel => '照片與影片';

  @override
  String get noteGeneral => '無動作';

  @override
  String get noteAttach => '附加';

  @override
  String get noteRemoveMedia => '移除附件';

  @override
  String get deleteNoteTitle => '刪除筆記';

  @override
  String get deleteNoteBody => '筆記及所有附件將永久刪除。';

  @override
  String get noteToday => '今天';

  @override
  String get noteYesterday => '昨天';

  @override
  String get noteAllNotes => '所有筆記';

  @override
  String get noteCalendar => '日曆';

  @override
  String get noteNoneOnDay => '這一天沒有任何筆記';

  @override
  String get noteAddOnDay => '為這一天新增筆記';

  @override
  String get notePrevMonth => '上個月';

  @override
  String get noteNextMonth => '下個月';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '本月 $n 則筆記',
      one: '本月 1 則筆記',
      zero: '本月沒有筆記',
    );
    return '$_temp0';
  }

  @override
  String get measures => '身體尺寸';

  @override
  String get measuresHint => '從頸部到小腿 — 不只看槓鈴，也觀察身體的變化。';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 筆測量', one: '1 筆測量', zero: '沒有測量');
    return '$_temp0';
  }

  @override
  String get measureNoneYet => '尚未測量';

  @override
  String get measureHistory => '歷史';

  @override
  String get measureNeck => '頸部';

  @override
  String get measureShoulders => '肩';

  @override
  String get measureChest => '胸圍';

  @override
  String get measureArm => '手臂';

  @override
  String get measureForearm => '前臂';

  @override
  String get measureWaist => '腰圍';

  @override
  String get measureHips => '臀圍';

  @override
  String get measureThigh => '大腿';

  @override
  String get measureCalf => '小腿';

  @override
  String get measureBodyfat => '體脂';

  @override
  String get timeline => '時間軸';

  @override
  String get timelineHint => '相同姿勢、相同地點、相同光線。一年後你會難以置信。';

  @override
  String get timelineEmptyTitle => '第一張照片會開始追蹤';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 張照片', one: '1 張照片', zero: '沒有照片');
    return '$_temp0';
  }

  @override
  String get poseFront => '正面';

  @override
  String get poseSide => '側面';

  @override
  String get poseBack => '背面';

  @override
  String get photoEvery => '提醒我';

  @override
  String photoEveryDays(int n) {
    return '每 $n 天';
  }

  @override
  String get photoEveryOff => '永不';

  @override
  String get timelineEvery => '每隔以下天數分組';

  @override
  String get custom => '自訂';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '距下一張照片還有 $n 天', one: '下一張照片是明天');
    return '$_temp0';
  }

  @override
  String get photoDueNow => '該拍照片了 — 今天拍一張吧';

  @override
  String get addTodayPhotos => '新增今天的照片';

  @override
  String posePhoto(String pose) {
    return '$pose照片';
  }

  @override
  String get compare => '比較';

  @override
  String get compareNeedTwo => '在不同的兩天拍攝相同姿勢，就能在這裡比較。';

  @override
  String dayNumber(int n) {
    return '第 $n 天';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '相隔 $n 天',
      one: '相隔 1 天',
      zero: '同一天',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => '刪除這一天';

  @override
  String get deleteDayBody => '這一天的照片也會永久刪除。';

  @override
  String get timelinePhotos => '照片';

  @override
  String get timelineBody => '肌肉地圖';

  @override
  String get timelineBodyEmpty => '記錄訓練後，肌肉地圖會開始填滿 — 不需要照片。';

  @override
  String get timelineBodyHint => '由你自己的組數資料建立 — 不會上傳任何內容。';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 次訓練', one: '1 次訓練', zero: '沒有訓練');
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => '進度照片';

  @override
  String get notifPhotoChannelWhy => '到下一張進度照片時間時提醒你。';

  @override
  String get notifPhotoTitle => '該拍進度照片了';

  @override
  String notifPhotoBody(int n) {
    return '距上一張已 $n 天。相同姿勢、相同光線。';
  }

  @override
  String get share => '分享';

  @override
  String get sharePick => '你想顯示什麼？';

  @override
  String get shareStreak => '連續紀錄與持續性';

  @override
  String get shareBody => '訓練肌群';

  @override
  String get shareCompare => '之前 / 之後';

  @override
  String get shareHint => '卡片在你的手機上建立。直到你選擇傳送位置前，任何內容都不會離開手機。';

  @override
  String get shareFailed => '無法建立卡片';

  @override
  String get shareWeekOf => '最近 7 天';

  @override
  String get shareStreakLabel => '連續天數';

  @override
  String get shareSessionsLabel => '訓練';

  @override
  String get shareVolumeLabel => '訓練量';

  @override
  String get restForExercise => '此動作的休息';

  @override
  String get restUsingDefault => '使用預設時間';

  @override
  String get restCustom => '僅此動作';

  @override
  String get setType => '組別類型';

  @override
  String get setTypeNormal => '正式組';

  @override
  String get setTypeWarmup => '暖身';

  @override
  String get setTypeDrop => '遞減組';

  @override
  String get setTypeFailure => '力竭';

  @override
  String get addWarmup => '暖身';

  @override
  String platesPerSide(String plates) {
    return '每側：$plates';
  }

  @override
  String get howTo => '如何進行';

  @override
  String get similar => '類似';

  @override
  String get primaryLabel => '主要';

  @override
  String get secondaryLabel => '次要';

  @override
  String get none => '無';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 組', one: '$n 組');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '訓練量 $v';
  }

  @override
  String get weeklyPlan => '每週計畫';

  @override
  String get yourRoutines => '你的課表';

  @override
  String get noRoutines => '尚無課表。建立一個並加入你的動作。';

  @override
  String get newRoutine => '新增課表';

  @override
  String get routineName => '課表名稱';

  @override
  String get schedule => '排程';

  @override
  String get addFromList => '從下方清單新增動作。';

  @override
  String get addExercises => '新增動作';

  @override
  String get deleteRoutine => '刪除此課表？';

  @override
  String exercisesWithCount(int n) {
    return '動作 · $n';
  }

  @override
  String setDay(String day) {
    return '設定 $day';
  }

  @override
  String get newRoutineName => '新增課表';

  @override
  String get dragToReorder => '拖曳帶點的把手調整順序，這就是你的訓練順序。';

  @override
  String reorderHandle(String name) {
    return '重新排序 $name';
  }

  @override
  String get removeFromRoutine => '從課表移除';

  @override
  String get dropExercise => '移除此動作？';

  @override
  String dropExerciseBody(String name) {
    return '「$name」會從這次訓練移除。已記錄的內容不會遺失。';
  }

  @override
  String get drop => '移除';

  @override
  String get resetData => '刪除我的所有資料';

  @override
  String get resetTitle => '全部刪除？';

  @override
  String get resetBody => '訓練、紀錄、課表、筆記與個人檔案都會刪除。此操作無法復原 — 如有需要請先匯出備份。';

  @override
  String get resetConfirm => '全部刪除';

  @override
  String get resetDone => '所有資料已刪除';

  @override
  String get support => '支援';

  @override
  String get reportBug => '回報錯誤';

  @override
  String get requestFeature => '建議功能';

  @override
  String get starOnGithub => '在 GitHub 給星';

  @override
  String get buyCoffee => '請我喝咖啡';

  @override
  String get cantOpenLink => '無法開啟連結';

  @override
  String get theme => '主題';

  @override
  String get darkTheme => '深色';

  @override
  String get lightTheme => '淺色';

  @override
  String get languageLabel => '語言';

  @override
  String get unitsLabel => '單位';

  @override
  String get restTimer => '休息計時器';

  @override
  String get alarmBlockedTitle => '通知已關閉';

  @override
  String get alarmBlockedBody => '螢幕鎖定時休息鬧鐘不會響';

  @override
  String get alarmBlockedAction => '開啟';

  @override
  String get alarmSound => '鬧鐘聲音';

  @override
  String get alarmDefaultName => '預設';

  @override
  String get alarmSoundHint => '使用自己的聲音 — 最長 15 秒';

  @override
  String get alarmChoose => '選擇聲音…';

  @override
  String get alarmPreview => '播放目前聲音';

  @override
  String get alarmReset => '重設為預設聲音';

  @override
  String get alarmTooLong => '這個聲音超過 15 秒';

  @override
  String get alarmInvalid => '無法讀取此音訊檔案';

  @override
  String alarmChanged(String name) {
    return '鬧鐘聲音設為「$name」';
  }

  @override
  String get alarmChangedDefault => '已恢復預設聲音';

  @override
  String get addActivityWidget => '新增活動小工具';

  @override
  String get addStatsWidget => '新增統計小工具';

  @override
  String get pinUnsupported => '請從啟動器的小工具選單加入';

  @override
  String get background => '背景';

  @override
  String get bgNone => '無';

  @override
  String get bgDots => '圓點';

  @override
  String get bgGrid => '格線';

  @override
  String get exportCsv => '匯出訓練（CSV）';

  @override
  String get exportBackup => '匯出備份（ZIP）';

  @override
  String get importBackup => '匯入備份';

  @override
  String get importHint => '選擇從 GymMane 匯出的 .zip 備份（或舊版 .json）。目前資料（包括媒體）將被取代。';

  @override
  String get import => '匯入';

  @override
  String get chooseFile => '選擇檔案';

  @override
  String get importFromApp => '從其他應用程式匯入';

  @override
  String get importUnknownFormat => '此檔案需要包含日期、動作、次數與重量欄位';

  @override
  String get importZipNoWeights => '此 ZIP 中沒有體重檔案';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已匯入 $n 筆體重紀錄', one: '已匯入 $n 筆體重紀錄');
    return '$_temp0';
  }

  @override
  String get importReadFailed => '無法讀取此檔案';

  @override
  String get importUnitTitle => '這個檔案使用哪種單位？';

  @override
  String get importUnitBody => '此匯出檔未標示重量單位。';

  @override
  String get importNothing => '沒有新的內容可匯入';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已匯入 $n 次訓練', one: '已匯入 $n 次訓練');
    return '$_temp0';
  }

  @override
  String get aboutGymmane => '關於 GymMane';

  @override
  String get yourProfile => '你的個人檔案';

  @override
  String get autofills => '自動填入計算器';

  @override
  String get nameLabel => '姓名';

  @override
  String get sexLabel => '性別';

  @override
  String get macroProtein => '蛋白質';

  @override
  String get macroCarbs => '碳水化合物';

  @override
  String get macroFat => '脂肪';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String get ageLabel => '年齡';

  @override
  String get heightLabel => '身高';

  @override
  String get weightLabel => '體重';

  @override
  String get weeklyGoal => '每週目標';

  @override
  String get activityLabel => '活動量';

  @override
  String get addPhoto => '新增照片';

  @override
  String get removePhoto => '移除照片';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseGallery => '從相簿選擇';

  @override
  String get backupImported => '備份已匯入';

  @override
  String get backupFailed => '無法讀取此備份';

  @override
  String get nothingToExport => '尚無可匯出的內容 — 請先記錄一次訓練';

  @override
  String calculatorsCount(int n) {
    return '$n 個訓練計算器';
  }

  @override
  String get result => '結果';

  @override
  String get weightLifted => '舉起重量';

  @override
  String get repsPerformed => '完成次數';

  @override
  String get neck => '頸部';

  @override
  String get waist => '腰圍';

  @override
  String get hip => '臀圍（女性）';

  @override
  String get targetWeight => '目標體重';

  @override
  String get workingWeight => '訓練重量';

  @override
  String get activityLevel => '活動等級';

  @override
  String get barWeight => '槓鈴重量';

  @override
  String get perSide => '每側';

  @override
  String get justTheBar => '只有槓鈴桿。';

  @override
  String perSideCount(int n) {
    return '每側 × $n';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => '卡路里';

  @override
  String get toolNameBf => '體脂';

  @override
  String get toolNamePlate => '槓片';

  @override
  String get toolNameWarmup => '暖身';

  @override
  String get toolTitleRm => '1RM 計算器';

  @override
  String get toolTitleBmi => 'BMI 計算器';

  @override
  String get toolTitleCal => '卡路里與宏量營養素';

  @override
  String get toolTitleBf => '體脂率';

  @override
  String get toolTitlePlate => '槓片計算器';

  @override
  String get toolTitleWarmup => '暖身組';

  @override
  String get toolHintRm => '估算單次最大重量（Epley 公式）';

  @override
  String get toolHintCal => '估算每日維持所需熱量';

  @override
  String get toolHintBf => '依美國海軍法估算';

  @override
  String get toolHintPlate => '槓鈴總重量';

  @override
  String get toolHintWarmup => '目標訓練重量';

  @override
  String get toolDescRm => '估算單次最大重量';

  @override
  String get toolDescBmi => '身體質量指數';

  @override
  String get toolDescCal => '卡路里與宏量營養素';

  @override
  String get toolDescBf => '體脂百分比';

  @override
  String get toolDescPlate => '槓片計算器';

  @override
  String get toolDescWarmup => '漸進暖身組';

  @override
  String get bmiUnderweight => '體重過輕';

  @override
  String get bmiNormal => '正常體重';

  @override
  String get bmiOverweight => '過重';

  @override
  String get bmiObese => '肥胖';

  @override
  String get actSedentary => '久坐';

  @override
  String get actLight => '輕度';

  @override
  String get actActive => '活躍';

  @override
  String get actModerate => '中等';

  @override
  String get muscleChest => '胸';

  @override
  String get muscleBack => '背';

  @override
  String get muscleLowerBack => '下背';

  @override
  String get muscleShoulders => '肩';

  @override
  String get muscleBiceps => '二頭肌';

  @override
  String get muscleTriceps => '三頭肌';

  @override
  String get muscleForearm => '前臂';

  @override
  String get muscleTrapezius => '斜方肌';

  @override
  String get muscleAbdomen => '腹肌';

  @override
  String get muscleObliques => '腹斜肌';

  @override
  String get muscleQuads => '股四頭肌';

  @override
  String get muscleHamstrings => '腿後肌';

  @override
  String get muscleGlutes => '臀肌';

  @override
  String get muscleCalves => '小腿';

  @override
  String get mgChest => '胸';

  @override
  String get mgBack => '背';

  @override
  String get mgLegs => '腿部';

  @override
  String get mgShoulders => '肩';

  @override
  String get mgArms => '手臂';

  @override
  String get mgCore => '核心';

  @override
  String get equipBarbell => '槓鈴';

  @override
  String get equipDumbbell => '啞鈴';

  @override
  String get equipCable => '滑輪';

  @override
  String get equipMachine => '機械';

  @override
  String get equipBodyweight => '自體重量';

  @override
  String get equipWeighted => '負重';

  @override
  String get equipBand => '彈力帶';

  @override
  String get equipKettlebell => '壺鈴';

  @override
  String get equipRings => '吊環';

  @override
  String get equipOther => '其他';

  @override
  String get diffBeginner => '初學者';

  @override
  String get diffAdvanced => '進階';

  @override
  String get diffIntermediate => '中階';

  @override
  String get about => '關於';

  @override
  String version(String v) {
    return '版本 $v';
  }

  @override
  String get aboutBlurb => '由訓練者為訓練者打造。';

  @override
  String get freeForever => '永久免費';

  @override
  String get freeForeverWhy => '無訂閱、無廣告、沒有付費鎖定功能。';

  @override
  String get fullyOffline => '100% 離線';

  @override
  String get fullyOfflineWhy => '不需帳號、不連伺服器。你的訓練資料永遠不會離開這支手機。';

  @override
  String get yoursToTake => '資料屬於你';

  @override
  String get yoursToTakeWhy => '隨時匯出為 CSV，並可一次刪除所有資料。';

  @override
  String get whatsInside => '內容';

  @override
  String exercisesInside(int n) {
    return '$n 個動作';
  }

  @override
  String get exercisesInsideWhy => '每個動作都有動畫與逐步說明。';

  @override
  String get calculatorsInside => '10 個計算器';

  @override
  String get calculatorsInsideWhy => '1RM、槓片、BMI、卡路里、體脂、FFMI、暖身、RPE 重量與 DOTS、Wilks 力量評分 — 全都基於公開公式。';

  @override
  String get mathInside => '透明計算';

  @override
  String get mathInsideWhy => '訓練量、紀錄與組數都依你的資料計算，沒有只是裝飾的數字。';

  @override
  String get streakCaps => '連續';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '天', one: '天');
    return '$_temp0';
  }

  @override
  String get reset => '重設';

  @override
  String get welcomeKicker => '歡迎使用';

  @override
  String get welcomeBlurb => '所有資料都留在手機上。不需帳號、不需網路、不用付費。';

  @override
  String get welcomeStart => '開始';

  @override
  String onbStep(int i, int n) {
    return '第 $i 步，共 $n 步';
  }

  @override
  String get onbNameTitle => '我們該怎麼稱呼你？';

  @override
  String get onbNameHint => '你的名字';

  @override
  String get onbNameWhy => '僅用於稱呼你。永遠不會離開你的手機。';

  @override
  String get onbBodyTitle => '一些數據';

  @override
  String get onbBodyWhy => '這些資料用於計算器，你可以隨時在設定中修改。';

  @override
  String get onbGoalTitle => '你多久訓練一次？';

  @override
  String get onbGoalWhy => '設定每週目標。請務實，不要過度勉強。';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '每週 $n 次訓練', one: '每週 $n 次訓練');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => '公斤還是磅？';

  @override
  String get next => '下一步';

  @override
  String get back => '返回';

  @override
  String get skip2 => '略過';

  @override
  String get madeWithLoveBy => '用心製作';

  @override
  String get sourceCode => '原始碼';

  @override
  String get suggested => '建議';

  @override
  String get results => '結果';

  @override
  String get noMatches => '沒有符合此搜尋的動作。';

  @override
  String get tapToEdit => '點選鉛筆修正紀錄，或點垃圾桶刪除。';

  @override
  String get editEntry => '編輯';

  @override
  String get editEntryHint => '修正任何一組的次數或重量。';

  @override
  String get removeSet => '刪除本組';

  @override
  String get continueWorkout => '繼續';

  @override
  String get continueWorkoutBody => '訓練會以已勾選的組數繼續。再次完成後，會以原始日期儲存。';

  @override
  String get addBodyWidget => '新增肌肉地圖小工具';

  @override
  String get repsOnly => '僅次數';

  @override
  String get repsOnlyHint => '此動作不記錄重量。';

  @override
  String get useDefaultArt => '恢復預設插圖';

  @override
  String daysShort(int n) {
    return '$n 天';
  }

  @override
  String get focusCard => '今日重點';

  @override
  String get autoAdvance => '自動前往下一個';

  @override
  String get keepScreenOn => '訓練時保持螢幕開啟';

  @override
  String get lockWorkout => '鎖定螢幕';

  @override
  String get unlockWorkout => '解鎖';

  @override
  String get holdToUnlock => '長按以解鎖';

  @override
  String get liveChannel => '訓練進行中';

  @override
  String get liveChannelWhy => '訓練時顯示目前的動作、組數和休息計時';

  @override
  String liveSet(int n, int total) {
    return '第 $n 組，共 $total 組';
  }

  @override
  String get liveResting => '休息中';

  @override
  String get liveAllDone => '所有組數已完成';

  @override
  String get autoAdvanceHint => '勾選某動作的最後一組後，訓練會自動前往下一個動作。';

  @override
  String get autoProgress => '下次增加重量';

  @override
  String autoProgressHint(String w) {
    return '完成所有次數後，下次訓練會從多 $w 的重量開始。';
  }

  @override
  String get placePlates => '槓片與槓鈴桿';

  @override
  String get platesAll => '全部可用';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 種尺寸', one: '$n 種尺寸');
    return '$_temp0';
  }

  @override
  String get platePairs => '對數';

  @override
  String plateAchievable(String w) {
    return '最接近的可用重量：$w';
  }

  @override
  String get autoWarmup => '從暖身組開始';

  @override
  String get autoWarmupHint => '開啟訓練時加入漸進暖身組。';

  @override
  String get trainReminder => '訓練提醒';

  @override
  String get trainReminderHint => '在這個時間提醒你，但只會在課表排定的日子提醒。';

  @override
  String get reminderExactTime => '精確時間';

  @override
  String get toastSoundSetting => '提示音';

  @override
  String get toastSoundHint => '頂部跳出提示時的輕柔提示音。';

  @override
  String get notifTrainChannel => '訓練提醒';

  @override
  String get notifTrainChannelWhy => '在你安排的日子提醒你訓練。';

  @override
  String get notifTrainTitle => '該訓練了';

  @override
  String get notifTrainBody => '你的課表在等你。';

  @override
  String get planIntro => '請只使用此清單中的動作為我建立訓練課表。';

  @override
  String get planFormat => '只以 JSON 回覆，格式如下：';

  @override
  String get planNothing => '此檔案中的動作都與你的資料庫不符';

  @override
  String get planFailed => '這個檔案不是 GymMane 能讀取的課表';

  @override
  String get routineGroup => '群組';

  @override
  String get newGroup => '新增群組';

  @override
  String get noGroup => '無群組';

  @override
  String get groupNameHint => '推 / 拉 / 腿、5×5…';

  @override
  String get filters => '篩選條件';

  @override
  String get setsPlannedHint => '為每個動作選擇需要的組數。訓練開啟時會全部準備好。';

  @override
  String get nextTime => '下次';

  @override
  String get nextHold => '維持相同重量，直到完成所有次數';

  @override
  String get bgPhoto => '你的照片';

  @override
  String get bgPhotoPick => '選擇照片';

  @override
  String get bgPhotoChange => '變更照片';

  @override
  String get bgPhotoRemove => '移除照片';

  @override
  String get bgDim => '變暗程度';

  @override
  String get dimSoft => '輕微';

  @override
  String get dimMedium => '中等';

  @override
  String get dimStrong => '強烈';

  @override
  String get bgPhotoHint => '它會顯示在整個介面背後，並加深以保持可讀性。';

  @override
  String get reminderSmart => '智慧';

  @override
  String get reminderFixed => '固定時間';

  @override
  String get reminderSmartHint => '它會使用你實際訓練的日子與時間；如果當天已訓練，就不再提醒。';

  @override
  String get reminderSmartEmpty => '再記錄幾次訓練，讓它學習你的習慣。';

  @override
  String habitFocus(String day) {
    return '你通常在 $day 訓練的內容';
  }

  @override
  String get duplicateRoutine => '複製課表';

  @override
  String copySuffix(String name) {
    return '$name（副本）';
  }

  @override
  String get saveAsRoutine => '儲存為課表';

  @override
  String get savedAsRoutine => '已儲存為課表';

  @override
  String get templates => '現成課表';

  @override
  String get templatesHint => '以你的資料庫建立的經典課表，之後所有內容都可修改。';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已新增 $n 個課表', one: '已新增 $n 個課表');
    return '$_temp0';
  }

  @override
  String get tplFullbody => '每週三次全身訓練，非常適合入門。';

  @override
  String get tplPpl => '推、拉、腿。每週三天或六天。';

  @override
  String get tplUpperlower => '上半身與下半身，每週四天。';

  @override
  String get tplStronglifts => '兩套五組五次的訓練交替進行。';

  @override
  String get tplStartingstrength => '每次訓練都有深蹲，兩套訓練交替進行。';

  @override
  String get tplHome => '只需要引體向上桿與地板。';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 天', one: '$n 天');
    return '$_temp0';
  }

  @override
  String get logRpe => '記錄用力程度（RPE）';

  @override
  String get rpeHint => '10 = 無法再做一次；8 = 約還能做兩次。';

  @override
  String get superset => '超級組';

  @override
  String get supersetLink => '與下一個連接';

  @override
  String get supersetHint => '連接的動作之間不休息 — 直接進入下一個動作。';

  @override
  String get aiRoutine => 'AI 課表';

  @override
  String get aiIntro => 'GymMane 絕不直接與 AI 通訊。你先匯出動作清單，貼到你已在使用的 AI 助手，再把回覆匯入。任何資料都不會自行離開手機。';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '有 $n 個名稱不在你的資料庫',
      one: '有 1 個名稱不在你的資料庫',
    );
    return '$_temp0';
  }

  @override
  String get importApps => '支援的應用程式';

  @override
  String get importOtherCsv => '任何包含日期、動作、次數與重量的 CSV';

  @override
  String get importAskApp => '需要其他應用程式？請求加入支援';

  @override
  String get awardFirstStepName => '第一步';

  @override
  String get awardFirstStepLine => '歡迎來到 GymMane。這個送給你。';

  @override
  String get awardFirstWorkoutName => '第一次訓練';

  @override
  String get awardFirstWorkoutLine => '第一次已記錄。這是最難的一次。';

  @override
  String get awardFirstRoutineName => '第一個課表';

  @override
  String get awardFirstRoutineLine => '現在你有一個可以持續回來執行的計畫。';

  @override
  String get awardFirstRecordName => '第一個紀錄';

  @override
  String get awardFirstRecordLine => '你在一個動作中刷新了最佳成績。';

  @override
  String get awardStreak3Name => '連續三天';

  @override
  String get awardStreak3Line => '連續三天。就是這樣開始的。';

  @override
  String get awardTonne1Name => '一噸';

  @override
  String get awardTonne1Line => '所有組數累計舉起一千公斤。';

  @override
  String get awardSets100Name => '一百組';

  @override
  String get awardSets100Line => '完成一百組，一組一組累積而來。';

  @override
  String get awardHours10Name => '十小時';

  @override
  String get awardHours10Line => '累積訓練十小時。';

  @override
  String get awardWorkouts50Name => '五十次訓練';

  @override
  String get awardWorkouts50Line => '你已完成五十次訓練。';

  @override
  String get awardHours50Name => '五十小時';

  @override
  String get awardHours50Line => '花了五十小時訓練。';

  @override
  String get awardsTitle => '獎牌';

  @override
  String get yearTitle => '你的年度';

  @override
  String get yearBestMonth => '最佳月份';

  @override
  String get yearMonths => '個月';

  @override
  String get awardSpinHint => '滑動獎牌讓它旋轉';

  @override
  String get awardUnlocked => '解鎖新成就';

  @override
  String get awardNice => '很棒！';

  @override
  String get awardSaveImage => '儲存圖片';

  @override
  String get awardSaved => '已儲存到相簿';

  @override
  String get awardStreak7Name => '七天';

  @override
  String get awardStreak7Line => '整整一週，一天都沒漏掉。';

  @override
  String get awardStreak30Name => '三十天';

  @override
  String get awardStreak30Line => '連續一個月。現在已成為習慣。';

  @override
  String get awardWorkouts100Name => '一百次訓練';

  @override
  String get awardWorkouts100Line => '從頭到尾記錄一百次訓練。';

  @override
  String get awardTonnes100Name => '一百噸';

  @override
  String get awardTonnes100Line => '你累積舉起的重量達到 100,000 公斤。';

  @override
  String get awardSets1000Name => '一千組';

  @override
  String get awardSets1000Line => '一組一組累積到一千。';

  @override
  String get profile => '個人檔案';

  @override
  String get editProfile => '編輯個人檔案';

  @override
  String get pickBadge => '徽章';

  @override
  String get statWorkouts => '訓練';

  @override
  String get statTrained => '訓練';

  @override
  String get statSets => '組數';

  @override
  String get statLifted => '舉起';

  @override
  String get statStreak => '連續';

  @override
  String get statDays => '天';

  @override
  String get unitHours => '小時';

  @override
  String get unitDays => '天';

  @override
  String get snapshots => '照片';

  @override
  String get snapNow => '現在拍攝';

  @override
  String get addCover => '新增封面';

  @override
  String get addTodayWidget => '今日訓練是否完成';

  @override
  String get photosCard => '你的照片';

  @override
  String get handleLabel => '使用者名稱';

  @override
  String get setupTitle => '填寫這些資料後，頁面其餘內容會自動填入';

  @override
  String get setupHint => '這裡的每個數字都來自你的紀錄。任何資料都不會傳送到其他地方。';

  @override
  String get setupWorkout => '記錄第一次訓練';

  @override
  String get setupWeight => '記錄體重';

  @override
  String get setupMeasures => '測量身體尺寸';

  @override
  String get setupPhoto => '拍第一張進度照片';

  @override
  String get progressTitle => '進度';

  @override
  String get tileVolume30 => '訓練量 · 30 天';

  @override
  String get tileAddWeight => '新增你的數值';

  @override
  String get heatToneTitle => '熱度顏色';

  @override
  String get heatToneHint => '只會改變格線與身體的顏色。';

  @override
  String get thisWeekTitle => '本週';

  @override
  String get momentsEmptyTitle => '這裡目前沒有內容';

  @override
  String get deletePhotoTitle => '刪除這張照片？';

  @override
  String get deletePhotoBody => '它將被永久刪除。';

  @override
  String get awardsEarned => '已獲得';

  @override
  String get awardsLocked => '未解鎖';

  @override
  String get awardStreak100Name => '一百天';

  @override
  String get awardWorkouts10Name => '十次訓練';

  @override
  String get awardWorkouts10Line => '前十次最能帶來改變。';

  @override
  String get awardWorkouts365Name => '三百六十五';

  @override
  String get awardWorkouts365Line => '相當於一年每一天的一次訓練，一次一次記錄下來。';

  @override
  String get awardTonnes10Name => '十噸';

  @override
  String get awardTonnes10Line => '一萬公斤從你手中舉起。';

  @override
  String get awardHours100Name => '一百小時';

  @override
  String get awardHours100Line => '計時器運轉著，在槓鈴下度過一百小時。';

  @override
  String awardWonOn(String date) {
    return '於 $date 獲得';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {'gold': '金色', 'blue': '藍色', 'green': '綠色', 'other': '徽章'});
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '自 $date 起';
  }

  @override
  String levelShort(int n) {
    return '等級 $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '距等級 $next 還有 $n 次訓練',
      one: '距等級 $next 還有 1 次訓練',
    );
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n 公分';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': '餘燼',
      'green': '綠色',
      'blue': '藍色',
      'mono': '灰色',
      'other': '顏色',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n 組';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '本週 $n / $goal';
  }

  @override
  String momentCount(int n) {
    return '$n 張照片';
  }

  @override
  String photosSelected(int n) {
    return '已選 $n 張';
  }

  @override
  String deletePhotosTitle(int n) {
    return '刪除 $n 張照片？';
  }

  @override
  String get momentsEmptyHint => '拍下健身房、白板、上好槓片的槓鈴 — 任何你想記住的東西。照片留在手機上，只有你看得到。';

  @override
  String get awardStreak100Line => '連續一百天。這已不只是動力，而是習慣。';

  @override
  String get coverLabel => '封面';

  @override
  String get removeCover => '移除封面';

  @override
  String get startTitle => '開始訓練';

  @override
  String get logTitle => '記錄訓練';

  @override
  String get logHint => '不使用計時器 — 只要填入你做了什麼。';

  @override
  String get orStartFrom => '或從這裡開始';

  @override
  String get pickExercisesOption => '選擇動作';

  @override
  String get chooseFocusOption => '選擇重點';

  @override
  String get plannedRoutine => '已排定';

  @override
  String get logWorkoutAction => '記錄訓練';

  @override
  String get logging => '記錄中';

  @override
  String get placesLabel => '我的地點';

  @override
  String get undo => '復原';

  @override
  String get deleteSet => '刪除這一組';

  @override
  String get setDeleted => '已刪除這一組';

  @override
  String get removeWarmup => '移除熱身';

  @override
  String get addWeightAction => '增加重量';

  @override
  String get workoutOverview => '本次訓練';

  @override
  String get allExercisesShort => '全部';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total 組';
  }

  @override
  String get nowLabel => '現在';

  @override
  String get deleteWorkout => '刪除訓練';

  @override
  String get deleteWorkoutBody => '這次訓練及其所有組數都會從紀錄中刪除。';

  @override
  String get themeAuto => '自動';

  @override
  String get themeAutoHint => '跟隨手機';

  @override
  String get demoSizeTitle => '訓練時的動作示範';

  @override
  String get demoLarge => '大';

  @override
  String get demoSmall => '小';

  @override
  String get demoOff => '隱藏';

  @override
  String get demoLoopTitle => '示範動畫';

  @override
  String get demoLoopAlways => '循環';

  @override
  String get demoLoopShort => '10 秒';

  @override
  String get demoLoopHint => '播放約 10 秒後停在起始姿勢。點按示範即可再看一次。';

  @override
  String get alarmStyleTitle => '休息結束時';

  @override
  String get alarmStyleLoud => '一律響鈴';

  @override
  String get alarmStyleQuiet => '遵循靜音模式';

  @override
  String get alarmStyleVibrate => '僅震動';

  @override
  String get alarmStyleHint => '「一律響鈴」使用鬧鐘音量，靜音時也會響。「遵循靜音模式」使用通知音量，手機靜音時只會震動。';

  @override
  String get suggestedPicks => '為你推薦';

  @override
  String get moreOptions => '更多選項';

  @override
  String get suggestInWorkouts => '在快速訓練中推薦';

  @override
  String get suggestInWorkoutsHint => '關閉後不會出現在推薦中，但仍可手動加入。';

  @override
  String get onbPlaceTitle => '你在哪裡訓練？';

  @override
  String get onbPlaceWhy => '選出你訓練的所有地點。我們只會推薦你在每個地點能做的動作。';

  @override
  String get onbPlaceGear => '那裡有什麼器材？';

  @override
  String distanceCol(String unit) {
    return '距離（$unit）';
  }

  @override
  String get timeCol => '時間';

  @override
  String get timeMinutesTitle => '時間（分鐘）';

  @override
  String get timeSecondsTitle => '時間（秒）';

  @override
  String distanceTitle(String unit) {
    return '距離（$unit）';
  }

  @override
  String get holdLabel => '撐住';

  @override
  String get stopLabel => '停止';

  @override
  String startHold(String time) {
    return '開始 · $time';
  }

  @override
  String get exerciseTypeLabel => '記錄方式';

  @override
  String get typeReps => '次數和重量';

  @override
  String get typeTime => '時間';

  @override
  String get typeCardio => '距離和時間';

  @override
  String get exerciseTypeHint => '跑步或游泳等有氧運動記錄距離和時間。平板支撐等靜態動作記錄時間。';

  @override
  String get howToLabel => '做法（選填）';

  @override
  String get howToHint => '每行一個步驟';

  @override
  String get editExercise => '編輯動作';

  @override
  String get saveChanges => '儲存變更';

  @override
  String get noStepsYet => '還沒有步驟。寫下你自己的做法，免得忘記。';

  @override
  String get addSteps => '寫下步驟';

  @override
  String get setTypeRestPause => '休息暫停';

  @override
  String get setTypeNormalInfo => '一般組，計入訓練量和個人紀錄。';

  @override
  String get setTypeWarmupInfo => '用於熱身的輕重量組，不計入訓練量和個人紀錄。';

  @override
  String get setTypeDropInfo => '一組結束後立刻降低重量，不休息繼續做。';

  @override
  String get setTypeFailureInfo => '做到無法再以標準動作完成一次為止。記錄實際完成的次數。';

  @override
  String get setTypeRestPauseInfo => '一組後休息 10 到 20 秒，再擠出幾次。';

  @override
  String get planFormatNotes =>
      '動作名稱請完全照清單上的寫。\"sets\"、\"reps\"、\"weight\"（使用指定單位）、以秒計的 \"rest\" 和 \"days\" 都是選填。\"superset\": true 會把動作和下一個連起來。多週計畫請像第二個範例一樣，把課表放在 \"weeks\" 裡。';

  @override
  String get planSets => '規劃組數';

  @override
  String get planSetsHint => '選擇每一組的類型、次數和重量。重量設為自動就會從上次訓練開始。';

  @override
  String get autoValue => '自動';

  @override
  String get clearPlan => '清除規劃';

  @override
  String get shareRoutine => '分享課表';

  @override
  String get shareWeek => '分享我的一週';

  @override
  String get shareWeekHint => '你所有的課表和各自的日子。';

  @override
  String shareMessage(String name) {
    return '$name — 用 GymMane 開啟檔案即可加入。';
  }

  @override
  String get importRoutines => '匯入課表';

  @override
  String get importPasteHint => '在這裡貼上課表：從 GymMane 分享的、AI 的回答、JSON 或 CSV。';

  @override
  String get pasteAction => '貼上';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 個課表');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => '也使用它的每週安排';

  @override
  String get useTheirScheduleHint => '它帶來的日子會取代你在那幾天的安排。';

  @override
  String get addToMyRoutines => '加入我的課表';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已加入 $n 個課表');
    return '$_temp0';
  }

  @override
  String get nothingToImport => '這裡沒有 GymMane 能匯入的內容';

  @override
  String get aiStepCopy => '複製這段請求。裡面有你的動作清單和 GymMane 讀得懂的格式。';

  @override
  String get aiStepAsk => '貼到任何 AI，說出你的需求：每週幾天、目標、幾週。';

  @override
  String get aiStepPaste => '把它的回答貼在下方並匯入，不需要檔案。';

  @override
  String get copyForAi => '複製給 AI';

  @override
  String get copiedDone => '已複製';

  @override
  String get aiPasteHint => '在這裡貼上 AI 的回答';

  @override
  String get importAction => '匯入';

  @override
  String get showFormat => '查看格式';

  @override
  String get shareAsFile => '以檔案分享';

  @override
  String get recoveryTab => '恢復';

  @override
  String recoveryOverall(int pct) {
    return '身體恢復 $pct%';
  }

  @override
  String get recoveryAllFresh => '全部都恢復了。今天練什麼都可以。';

  @override
  String recoveryStill(String muscles) {
    return '仍在恢復：$muscles';
  }

  @override
  String get recoveryTired => '疲勞';

  @override
  String get recoveryFresh => '恢復';

  @override
  String get recoveryHint => '點一下肌肉看它恢復了多少。越近的組數影響越大，越吃力的組數（依 RPE）影響更大。';

  @override
  String recoveryPct(int pct) {
    return '已恢復 $pct%';
  }

  @override
  String readyInHours(int h) {
    return '約 $h 小時後可練';
  }

  @override
  String get tplAbcd => '四天：胸和三頭、背和二頭、腿、肩和腹。';

  @override
  String get tplAbcde => '五天，每天一個部位：胸、背、腿、肩、手臂。';

  @override
  String get elapsedCaps => '已經過';

  @override
  String get tapToSkip => '點一下略過';

  @override
  String get screenLocked => '螢幕已鎖定';

  @override
  String get lockedHint => '長按上方的指紋圖示即可解鎖';

  @override
  String get liveDoneSet => '完成這一組';

  @override
  String get liveSkipRest => '略過休息';

  @override
  String get livePause => '暫停';

  @override
  String get liveResume => '繼續';

  @override
  String get liveNext => '下一個';

  @override
  String liveUpNext(String name) {
    return '接下來：$name';
  }

  @override
  String get stickerOpen => '分享到照片上';

  @override
  String get stickerNoPhoto => '不用照片';

  @override
  String get stickerWorkout => '訓練';

  @override
  String get stickerStreak => '連續';

  @override
  String get stickerDate => '日期';

  @override
  String get stickerHint => '拖曳移動，雙指縮放或旋轉';

  @override
  String get stickerSaved => '已儲存到相簿';

  @override
  String get stickerWeek => '本週';

  @override
  String get getReady => '準備';

  @override
  String get stickerGallery => '相簿';

  @override
  String get stickerCamera => '相機';

  @override
  String get shareIntroTitle => '分享這個課表';

  @override
  String get shareIntroBody => '傳給你的伴侶、朋友或家人。他們會收到一個小檔案，用 GymMane 開啟，一點就能加入，組數和重量都在。';

  @override
  String get removedFromRoutine => '已從課表移除';

  @override
  String get radarTitle => '最近 30 天';

  @override
  String get radarHint => '看看哪些部位需要多練';

  @override
  String get radarEmpty => '練幾天就能看到你的均衡情況';

  @override
  String get radarBalanced => '目前很均衡';

  @override
  String radarFocus(String list) {
    return '需要多練：$list';
  }

  @override
  String get countdownReady => '準備';

  @override
  String get countdownSkip => '點一下立即開始';

  @override
  String get countdownSetting => '開始前倒數';

  @override
  String get effortSetting => '記錄每組強度';

  @override
  String get effortHint => 'RPE：10 表示一次都做不動了，8 表示還能再做兩次。RIR 表示還剩幾次。記錄後，估算 1RM 會使用 RPE 表。';

  @override
  String get rirHint => '0 表示一次都做不動了，2 表示還能再做兩次。';

  @override
  String get addWeekWidget => '新增本週小工具';

  @override
  String get gamificationSetting => '獎牌和等級';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 次', one: '$n 次');
    return '$_temp0';
  }

  @override
  String get prBestSet => '最佳一組';

  @override
  String get weekStartSetting => '每週開始於';

  @override
  String get stepOutOfWorkout => '暫停並離開';

  @override
  String get saveToRoutine => '將變更儲存到課表';

  @override
  String get routineUpdated => '課表已更新';

  @override
  String saveChangesTitle(String name) {
    return '將變更儲存到$name？';
  }

  @override
  String get saveChangesBody => '下次開始時，課表會包含這些變更。';

  @override
  String get routineOrderChanged => '新的動作順序';

  @override
  String get mineOnly => '我建立的';

  @override
  String createNamed(String name) {
    return '沒有？建立「$name」';
  }

  @override
  String get orStartWith => '或者從這裡開始';

  @override
  String get warmupFocus => '熱身';

  @override
  String get warmupFocusHint => '有無器材都能做的靈活度與啟動';

  @override
  String get cardioFocus => '有氧';

  @override
  String get cardioFocusHint => '跑步、騎車、划船或跳繩，按距離和時間記錄';

  @override
  String get homeRecommended => '首頁推薦';

  @override
  String get archivedFilter => '已封存';

  @override
  String get archiveExercise => '封存動作';

  @override
  String get restoreExercise => '還原';

  @override
  String get archivedToast => '動作已封存';

  @override
  String get archivedToastHint => '可在 動作 › 已封存 中找到';

  @override
  String get archivedBanner => '已封存：不會出現在清單和推薦中，訓練紀錄會保留。';

  @override
  String get videoMarksHint => '在某一步暫停並點圖釘，下次可直接跳到這裡。';

  @override
  String get videoMarkHere => '把這一步標記在這裡';

  @override
  String get sectionGeneral => '一般';

  @override
  String get sectionTraining => '訓練';

  @override
  String get sectionAlerts => '提醒與鬧鐘';

  @override
  String get sectionHome => '首頁';

  @override
  String get sectionWidgets => '小工具';

  @override
  String get sectionData => '資料與備份';

  @override
  String get multiPlanSetting => '一天多個課表';

  @override
  String get multiPlanHint => '點選這一天的每個課表，依加入順序進行。';

  @override
  String routineOfDay(int n, int total) {
    return '今天第 $n/$total 個';
  }

  @override
  String get nextToday => '今天的下一個';

  @override
  String get planAboutMe => '關於我：';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex，$age 歲，身高 $height，體重 $weight。';
  }

  @override
  String planDays(int n) {
    return '我想每週訓練 $n 天。';
  }

  @override
  String get planNoHistory => '還沒有訓練紀錄：請把我當作新手，訓練量和重量要保守。';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '最近 30 天訓練了 $n 次。',
      one: '最近 30 天訓練了 1 次。',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => '最近的最佳組';

  @override
  String get planAskFirst => '如果你不知道我的目標（力量、增肌、減脂或一般體能）或每次能練多久，請先用一則簡短訊息問我。知道後只用 JSON 回答。';

  @override
  String get backToTop => '回到頂端';

  @override
  String get deleteExerciseTitle => '刪除這個動作？';

  @override
  String deleteExerciseBody(String name) {
    return '「$name」將從動作庫和課表中移除，之前的訓練紀錄會保留。';
  }

  @override
  String get exportForStravaHint => '請在瀏覽器中開啟 strava.com/upload/select 上傳（Strava App 無法匯入檔案），會顯示為含組數的重量訓練。';

  @override
  String get manualStartTime => '開始時間';

  @override
  String get manualDuration => '時長';

  @override
  String get manualDurationUnset => '新增時長';

  @override
  String get stravaRow => '匯出到 Strava（測試版）';

  @override
  String get stravaBeta => '測試版';

  @override
  String get stravaIntro =>
      '選擇一次訓練匯出到 Strava。你會得到一個 .fit 檔：在瀏覽器中開啟 strava.com/upload/select 上傳，會顯示為含組數的重量訓練。';

  @override
  String get stravaEmpty => '還沒有可匯出的訓練。';

  @override
  String get tapToPause => '點按暫停';

  @override
  String get holdPausedHint => '已暫停 · 點按繼續';

  @override
  String get finishHoldNow => '現在完成這組';

  @override
  String get barWeightExercise => '槓鈴桿或滑車重量';

  @override
  String get barWeightHint => '槓片計算器會用到';

  @override
  String get barWeightCustom => '自訂 · 點按重設';

  @override
  String get groupRename => '重新命名群組';

  @override
  String get groupUngroup => '取消群組,保留課表';

  @override
  String get groupDeleteAll => '刪除群組及其課表';

  @override
  String groupDeleteTitle(String name) {
    return '刪除「$name」?';
  }

  @override
  String groupDeleteBody(String count) {
    return '將刪除$count。訓練紀錄會保留。';
  }

  @override
  String get tplRr => 'r/bodyweightfitness 的經典計畫:每週三天全身訓練。變輕鬆了就進階到下一級。';

  @override
  String get levelUpKicker => '下一步';

  @override
  String levelUpBody(int reps, String name) {
    return '$name 連續兩次訓練完成 3×$reps。準備好進階了嗎?';
  }

  @override
  String levelUpSwap(String routine) {
    return '在$routine中替換';
  }

  @override
  String get levelUpSee => '看看怎麼做';

  @override
  String get levelUpLater => '以後再說';

  @override
  String get levelUpStay => '繼續做這個';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name 已加入$routine';
  }

  @override
  String get levelUpStayed => '不再為這個動作提示進階';

  @override
  String get levelHintsSetting => '提示下一步進階';

  @override
  String get heatmapLabelsSetting => '在活動圖上顯示星期和月份';

  @override
  String get rmPercent => '百分比';

  @override
  String rmAtPercent(String pct) {
    return '最大重量的 $pct';
  }

  @override
  String get copyWorkout => '複製為文字';

  @override
  String get goalSet => '設定目標';

  @override
  String get goalTargetReps => '目標次數';

  @override
  String goalToGo(String value) {
    return '還差 $value';
  }

  @override
  String get goalReached => '目標達成';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '還剩 $n 天');
    return '$_temp0';
  }

  @override
  String get goalOverdue => '已過期限';

  @override
  String get goalDeadline => '截止日期';

  @override
  String get goalNoDeadline => '無截止日期';

  @override
  String get goalRemove => '刪除目標';

  @override
  String get exerciseNameMissing => '請輸入名稱';

  @override
  String get aliasesLabel => '別名（選填）';

  @override
  String get aliasesHint => '其他叫法，用逗號分隔';

  @override
  String alsoCalled(String names) {
    return '又稱：$names';
  }

  @override
  String get addToRoutine => '加入課表';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '已在 $n 個課表中', zero: '還沒加入任何課表');
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => '已在其中';

  @override
  String get restInRoutine => '本課表中的休息';

  @override
  String get restInRoutineHint => '與動作設定相同';

  @override
  String get restInRoutineReset => '僅此處 · 點按還原';

  @override
  String get swapExercise => '更換動作';

  @override
  String get swapShort => '更換';

  @override
  String swapHint(String name) {
    return '今天用它代替$name。結束時可以保留到課表中。';
  }

  @override
  String get swapKeepsDone => '已完成的組會保留，新動作接著做剩下的。';

  @override
  String swapSameMuscle(String muscle) {
    return '同一肌群 · $muscle';
  }

  @override
  String get swapDoneBefore => '做過';

  @override
  String get multiPlanSettingHint => '同一天安排多個課表。';

  @override
  String get levelHintsHint => '動作變輕鬆時，推薦更難的版本。';

  @override
  String get focusCardHint => '今天的課表，顯示在首頁頂部。';

  @override
  String get gamificationHint => '獎章、等級和完成時的慶祝。';

  @override
  String get exerciseSettings => '此動作的設定';

  @override
  String get placeActiveNow => '你在這裡';

  @override
  String get placeTapToUse => '點按在這裡訓練';

  @override
  String get intervalDays => '天';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target 天';
  }

  @override
  String get toolNameRpe => '按 RPE 算重量';

  @override
  String get toolTitleRpe => '按 RPE 算重量';

  @override
  String get toolDescRpe => '想要的強度該用多重';

  @override
  String get toolNameDots => '力量水準';

  @override
  String get toolTitleDots => '力量水準（DOTS）';

  @override
  String get toolDescDots => '相對體重的力量';

  @override
  String rpeResultHint(int reps, String rpe) {
    return '$reps 次 · RPE $rpe';
  }

  @override
  String get rpeYourSet => '剛做完的一組';

  @override
  String get rpeGoal => '你想做的';

  @override
  String rpeOneRmLine(String value) {
    return '預估 1RM：$value';
  }

  @override
  String get rpeExplain => 'RPE 10 表示一次也做不了了；8 表示還剩兩次。';

  @override
  String get dotsBestLifts => '你的最佳成績';

  @override
  String get dotsSquat => '深蹲';

  @override
  String get dotsBench => '臥推';

  @override
  String get dotsDeadlift => '硬舉';

  @override
  String dotsTotalLine(String value) {
    return '總計：$value';
  }

  @override
  String get dotsExplain => '不論體重，都能和任何人比較力量。用你的單次最佳成績或預估 1RM。';

  @override
  String get dotsLevel0 => '新手';

  @override
  String get dotsLevel1 => '中級';

  @override
  String get dotsLevel2 => '高級';

  @override
  String get dotsLevel3 => '很高級';

  @override
  String get dotsLevel4 => '菁英';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks 係數';

  @override
  String get toolDescWilks => '健力的經典評分';

  @override
  String get wilksExplain => '健力的經典公式。2020 年被 DOTS 取代，但許多比賽和排名仍在使用。';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => '去脂體重指數';

  @override
  String get toolDescFfmi => '相對身高的肌肉量';

  @override
  String get ffmiBodyFat => '體脂';

  @override
  String ffmiLeanLine(String value) {
    return '去脂體重：$value';
  }

  @override
  String get ffmiExplain => '類似 BMI，但不算脂肪：只計算去脂體重，並依身高校正，讓高個子和矮個子能公平比較。';

  @override
  String get ffmiLevel0 => '低於平均';

  @override
  String get ffmiLevel1 => '平均';

  @override
  String get ffmiLevel2 => '高於平均';

  @override
  String get ffmiLevel3 => '優秀';

  @override
  String get ffmiLevel4 => '卓越';

  @override
  String get rpeEffortLabel => '強度（RPE）';

  @override
  String get restRowHint => '組間休息，動作沒有單獨設定時使用。';

  @override
  String get effortRowHint => '每組記錄 RPE 或 RIR。';

  @override
  String get countdownHint => '第一組前 3、2、1 倒數。';

  @override
  String get keepScreenOnHint => '訓練時螢幕保持常亮。';

  @override
  String get demoSizeRowHint => '訓練時顯示的動作圖。';

  @override
  String get demoLoopRowHint => '動畫循環還是停止。';

  @override
  String get trainReminderRowHint => '訓練日提醒你。';

  @override
  String get alarmSoundRowHint => '休息結束時的聲音。';

  @override
  String get alarmStyleRowHint => '靜音模式下是否響鈴。';

  @override
  String get recommendedRowHint => '首頁推薦的動作。';
}
