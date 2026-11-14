// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get languageName => '日本語';

  @override
  String vsLastMonthLabel(String pct) {
    return '先月比 $pct%';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'レベル $level · $streak';
  }

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get cancelCaps => 'キャンセル';

  @override
  String get deleteCaps => '削除';

  @override
  String get done => '完了';

  @override
  String get set => '設定';

  @override
  String get home => 'ホーム';

  @override
  String get progress => '進捗';

  @override
  String get exercises => 'エクササイズ';

  @override
  String get settings => '設定';

  @override
  String get today => '今日';

  @override
  String get thisWeek => '今週';

  @override
  String get recommended => 'おすすめ';

  @override
  String get goal => '目標';

  @override
  String get volume => 'ボリューム';

  @override
  String get setsToday => '今日のセット';

  @override
  String get prs => '記録';

  @override
  String get todaysFocus => '今日の重点';

  @override
  String get todaysRoutine => '今日のルーティン';

  @override
  String get startWorkout => 'ワークアウト開始';

  @override
  String get routines => 'ルーティン';

  @override
  String get tools => 'ツール';

  @override
  String get firstSessionHint => '鍛える筋肉を選んで最初のワークアウトを記録しよう';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 種目', one: '$n 種目');
    return '$_temp0';
  }

  @override
  String get pushDay => 'プッシュデー';

  @override
  String get pullDay => 'プルデー';

  @override
  String get legDay => '脚';

  @override
  String get pushFocus => '胸 · 肩 · 上腕三頭筋';

  @override
  String get pullFocus => '背中 · 上腕二頭筋 · 僧帽筋';

  @override
  String get legFocus => '大腿四頭筋 · ハムストリング · 臀筋';

  @override
  String get train => 'トレーニング';

  @override
  String get step1 => 'ステップ 1/2';

  @override
  String get step2 => 'ステップ 2/2';

  @override
  String get chooseFocus => '重点を選択';

  @override
  String get buildSession => 'ワークアウトを作成';

  @override
  String get tapMuscles => '鍛えたい筋肉をタップ、前面と背面。';

  @override
  String get continueBtn => '続ける';

  @override
  String get nothingForFocus => 'この重点に合う種目がありません';

  @override
  String get goBackPick => '戻って、ライブラリに種目がある筋肉を選んでください。';

  @override
  String pickedHint(int n) {
    return 'ワークアウトを組みました、$n 種目から追加・削除できます。';
  }

  @override
  String get pickAnExercise => '種目を選択';

  @override
  String get searchAllExercises => '種目を検索…';

  @override
  String get noExercisesMatch => '一致する種目がありません';

  @override
  String get createItInstead => '代わりに自分の種目を作成';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 種目', one: '$n 種目');
    return '開始 · $_temp0';
  }

  @override
  String get inProgress => '進行中';

  @override
  String get paused => '一時停止';

  @override
  String get last => '前回';

  @override
  String get rest => '休憩';

  @override
  String get skip => 'スキップ';

  @override
  String get addSet => '+ セットを追加';

  @override
  String get finishSession => 'ワークアウト終了';

  @override
  String get setDone => 'セット完了';

  @override
  String get nextExercise => '次の種目';

  @override
  String get dropExerciseAction => '種目を外す';

  @override
  String get restOff => 'オフ';

  @override
  String get miniRest => 'レストポーズとクラスターの休憩';

  @override
  String get miniRestHint => 'レストポーズやクラスターの前';

  @override
  String get gymPass => 'ジムのパス';

  @override
  String get gymPassEmpty => 'ジムのコードをここに保存して、カードなしで入館';

  @override
  String get gymPassAdd => 'パスを追加';

  @override
  String get gymPassScan => 'コードを撮影';

  @override
  String get gymPassScanHint => 'スマホのカメラで';

  @override
  String get gymPassPhoto => '写真やスクリーンショットから';

  @override
  String get gymPassPhotoHint => 'たとえばジムのアプリのスクリーンショット';

  @override
  String get gymPassType => '番号を入力';

  @override
  String get gymPassTypeHint => 'バーコードの場合：下に印刷された番号';

  @override
  String get gymPassNotFound => 'その画像にQRコードがありません。もっと鮮明な画像を試すか、番号を入力してください。';

  @override
  String get gymPassName => 'ジムの名前';

  @override
  String get gymPassDefaultName => 'マイジム';

  @override
  String get gymPassCode => 'コード';

  @override
  String get gymPassFormat => 'コードの種類';

  @override
  String get gymPassInvalid => 'その番号はこの種類のコードに合いません';

  @override
  String get gymPassShowHint => 'リーダーにかざしてください。明るさは自動で上がります。';

  @override
  String get gymPassDeleted => 'パスを削除しました';

  @override
  String get gymPassEdit => 'パスを編集';

  @override
  String get gymPassShow => '入口で見せる';

  @override
  String get gymPassPrivate => 'スマホの中だけに保存。どこにもアップロードされません。';

  @override
  String get gymPassColor => '色';

  @override
  String get gymPassRescan => 'コードを読み直す';

  @override
  String get gymPassReading => 'コードを読み取り中…';

  @override
  String get gymPassSettingHint => 'ジムの会員証をプロフィールに';

  @override
  String get gymPassMember => '会員';

  @override
  String get widgetHintActivity => 'トレーニングした日のマップ';

  @override
  String get widgetHintStats => '今週の連続記録・ボリューム・セッション';

  @override
  String get widgetHintBody => '鍛えた筋肉';

  @override
  String get widgetHintToday => 'ひと目で：今日はトレーニングした？';

  @override
  String get widgetHintWeek => '今週のプランを一日ずつ';

  @override
  String get supportHintBug => '不具合をGitHubで教えてください';

  @override
  String get supportHintFeature => 'アプリへのアイデアを提案';

  @override
  String get supportHintStar => 'もっと多くの人に見つけてもらえます';

  @override
  String get supportHintCoffee => '開発を支援。無料で広告なし';

  @override
  String get bodyweightNoteHint => 'メモを追加：体調や試していること…（任意）';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'この種目は$unitを使う';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => '回数';

  @override
  String weightCol(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get repsTitle => '回数';

  @override
  String weightTitle(String unit) {
    return '重量 ($unit)';
  }

  @override
  String get sessionComplete => 'ワークアウトを記録しました';

  @override
  String get finishHeadlinePr => '自己ベスト更新';

  @override
  String get finishHeadlineGoal => '週間目標達成';

  @override
  String get finishHeadlineStreak => '連続記録継続';

  @override
  String get finishHeadlineDefault => 'また一つ積み上げました';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs種目', one: '1種目');
    return '$_temp0で過去最高を更新しました。記録に保存されました。';
  }

  @override
  String get finishBodyGoal => '今週予定していた回数のワークアウトを達成しました。';

  @override
  String finishBodyStreak(int streak) {
    return '$streak日連続。難しいのは続けること。';
  }

  @override
  String get finishBodyDefault => '記録・集計完了。数字を動かすのは継続です。';

  @override
  String get vsLastTime => '前回比';

  @override
  String get firstTime => '初回記録';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n件の新記録', one: '$n件の新記録');
    return '$_temp0';
  }

  @override
  String get duration => '時間';

  @override
  String get setsCaps => 'セット';

  @override
  String exerciseXofY(int i, int n) {
    return '種目 $i/$n';
  }

  @override
  String get decrease => '減らす';

  @override
  String get increase => '増やす';

  @override
  String markSet(int n) {
    return 'セット $n を完了にする';
  }

  @override
  String get pauseWorkout => 'ワークアウトを一時停止';

  @override
  String get resumeWorkout => 'ワークアウトを再開';

  @override
  String get discardTitle => 'ワークアウトを破棄しますか？';

  @override
  String get discardBody => 'このワークアウトのセットは失われます。';

  @override
  String get keepTraining => 'トレーニングを続ける';

  @override
  String get discard => '破棄';

  @override
  String get notifRestChannel => '休憩タイマー';

  @override
  String get notifRestChannelWhy => 'セット間の休憩終了を知らせます';

  @override
  String get notifAlertChannel => '休憩タイマー（通知）';

  @override
  String get notifAlertChannelWhy => '休憩終了と同時にバナーを表示します';

  @override
  String get restOverTitle => '休憩終了';

  @override
  String get restOverBody => '再開しよう、次のセットが待っています。';

  @override
  String get allTimeSessions => 'ワークアウト';

  @override
  String get allTimeTime => '時間';

  @override
  String get allTimeSets => 'セット';

  @override
  String get consistency => '継続性';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n回のワークアウトを記録',
      one: '$n回のワークアウトを記録',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n日連続';
  }

  @override
  String get bodyweight => '体重';

  @override
  String get logBodyweight => '体重を記録';

  @override
  String get trackWeight => '体重の変化を追跡';

  @override
  String get muscleMap => '筋肉マップ';

  @override
  String get days7 => '7日';

  @override
  String get days30 => '30日';

  @override
  String get days90 => '90日';

  @override
  String get days365 => '1年';

  @override
  String get daysAll => 'すべて';

  @override
  String get weeklyAvgTitle => '週の平均';

  @override
  String weekOfDate(String date) {
    return '$dateの週';
  }

  @override
  String weightChangeRange(String change) {
    return 'この期間で$change';
  }

  @override
  String get heatLow => '未トレーニング';

  @override
  String get heatHigh => '最大ボリューム';

  @override
  String get muscleMapEmpty => 'ワークアウトを記録すると、ここで体が色づき始めます。';

  @override
  String get muscleMapHint => '筋肉をタップしてトレーニング量を確認。';

  @override
  String muscleMapBehind(String names) {
    return '遅れ気味: $names';
  }

  @override
  String ofTarget(int pct) {
    return '目標の $pct%';
  }

  @override
  String get muscleSplit => '筋肉別配分';

  @override
  String get personalRecords => '自己ベスト';

  @override
  String get strength1rm => '筋力 · 推定1RM';

  @override
  String get strengthEmpty => '同じ種目を2回記録すると筋力の推移が表示されます。';

  @override
  String oneRmEst(String w) {
    return '推定1RM: $w';
  }

  @override
  String get restDayShort => '休養日';

  @override
  String get restDay => '休養日、記録なし。';

  @override
  String get delete => '削除';

  @override
  String get deleteEntry => 'この記録を削除しますか？';

  @override
  String deleteEntryBody(String name) {
    return '「$name」はこの日、記録、グラフから削除されます。';
  }

  @override
  String get bodyweightHistory => '履歴';

  @override
  String get exercisesCaps => 'エクササイズ';

  @override
  String get timeCaps => '時間';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ライブラリに$n種目', one: 'ライブラリに$n種目');
    return '$_temp0';
  }

  @override
  String get searchExercises => '種目を検索';

  @override
  String get muscleFilter => '筋肉';

  @override
  String get levelFilter => 'レベル';

  @override
  String get kindLabel => '種類';

  @override
  String get kindStrength => '筋力';

  @override
  String get kindCalisthenics => '自重';

  @override
  String get kindCardio => '有酸素';

  @override
  String get kindStretch => 'ストレッチ';

  @override
  String get newExercise => '新しい種目';

  @override
  String get exerciseName => '種目名';

  @override
  String get equipmentLabel => '器具';

  @override
  String get addExercise => '種目を追加';

  @override
  String get advanced => '上級';

  @override
  String get demoMedia => 'デモ';

  @override
  String get addMedia => 'メディアを追加';

  @override
  String get mediaHint => '画像、GIF、動画';

  @override
  String get changeMedia => '変更';

  @override
  String get videoSelected => '動画を選択しました';

  @override
  String get favouritesOnly => 'お気に入り';

  @override
  String get noFavouritesYet => 'お気に入りはまだありません';

  @override
  String get noFavouritesHint => '種目の星をタップするとここに保存されます。';

  @override
  String get clearFilters => 'フィルターをクリア';

  @override
  String get quickAddAmount => '食べた量';

  @override
  String get homeCardsTitle => 'ホームのカード';

  @override
  String get homeCardsHint => 'オンにしたものがホームに表示されます';

  @override
  String get homeCardFocus => '今日';

  @override
  String get homeCardSteps => '歩数';

  @override
  String get homeCardWeek => '今週';

  @override
  String get homeCardRoutines => 'ルーティン';

  @override
  String get homeCardRecommended => 'おすすめ';

  @override
  String get textSizeSetting => '文字サイズ';

  @override
  String get textSizeSmall => '小';

  @override
  String get textSizeNormal => '標準';

  @override
  String get textSizeLarge => '大';

  @override
  String get textSizeHint => 'スマホの文字サイズに上乗せ';

  @override
  String get calmMotionSetting => 'アニメーションを減らす';

  @override
  String get calmMotionHint => '画面がスライドせずに表示されます';

  @override
  String get dishArchive => 'アーカイブ';

  @override
  String get dishUnarchive => '元に戻す';

  @override
  String get dishArchivedToast => '料理をアーカイブしました';

  @override
  String get filterShowLabel => '表示';

  @override
  String get noExercisesFound => '種目が見つかりません';

  @override
  String get noExercisesHint => '別の検索を試すか、フィルターをクリアしてください。';

  @override
  String get personalRecord => '自己ベスト';

  @override
  String get history => '履歴';

  @override
  String get noHistory => 'まだ記録がありません。この種目を行うと履歴が作成されます。';

  @override
  String get notes => 'メモ';

  @override
  String get notePlaceholder => 'コツ、セットアップ、感覚…';

  @override
  String notHere(String gear, String place) {
    return '$placeには$gearがありません';
  }

  @override
  String get notHereWhy => '今日使えるものに入れ替えましょう。';

  @override
  String get altHere => 'ここでできること';

  @override
  String get places => 'マイ場所';

  @override
  String get placesHint => '各場所にある器具を設定すると、その場所でできる種目だけが表示されます。';

  @override
  String get placeAll => 'どこでも';

  @override
  String get placeNew => '新しい場所';

  @override
  String get placeNamePlaceholder => '自宅、ジム、公園…';

  @override
  String get placeGearLabel => '利用できる器具';

  @override
  String placeExercises(int n) {
    return 'ここで$n種目';
  }

  @override
  String get placeEmptyTitle => 'どこでもトレーニング';

  @override
  String get placeEmptyBody => '場所とは、そこにある器具の一覧です。まず1つ選び、後から編集できます。';

  @override
  String get placeDeleteTitle => '場所を削除';

  @override
  String get placeDeleteBody => '場所だけが削除され、種目とワークアウトは残ります。';

  @override
  String get placeGym => 'ジム';

  @override
  String get placeHome => '自宅';

  @override
  String get placeOutdoors => '屋外';

  @override
  String get placeFilterLabel => '場所';

  @override
  String get noGearOnly => '器具なし';

  @override
  String placeActive(String name) {
    return '$nameでトレーニング';
  }

  @override
  String get journal => 'ジャーナル';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'メモ$n件', one: 'メモ1件', zero: 'メモなし');
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'メモ';

  @override
  String get noteKindPlan => '計画';

  @override
  String get noteKindDone => '達成';

  @override
  String get noteKindPain => '違和感';

  @override
  String get noteFilterAll => 'すべて';

  @override
  String get newNote => '新しいメモ';

  @override
  String get editNote => 'メモを編集';

  @override
  String get addNote => 'メモを追加';

  @override
  String get noteEmptyTitle => 'まだ何も書かれていません';

  @override
  String get noteEmptyBody => 'コツ、次回の計画、ワークアウトの感覚など、必要なら写真や動画も添付できます。';

  @override
  String get noteNoneForExercise => 'この種目のメモはまだありません。';

  @override
  String get noteKindLabel => '種類';

  @override
  String get noteTextLabel => 'メモ';

  @override
  String get noteDateLabel => '日付';

  @override
  String get noteExerciseLabel => '種目';

  @override
  String get noteMediaLabel => '写真と動画';

  @override
  String get noteGeneral => '種目なし';

  @override
  String get noteAttach => '添付';

  @override
  String get noteRemoveMedia => '添付を削除';

  @override
  String get deleteNoteTitle => 'メモを削除';

  @override
  String get deleteNoteBody => 'メモと添付ファイルは完全に削除されます。';

  @override
  String get noteToday => '今日';

  @override
  String get noteYesterday => '昨日';

  @override
  String get noteAllNotes => 'すべてのメモ';

  @override
  String get noteCalendar => 'カレンダー';

  @override
  String get noteNoneOnDay => 'この日は何も書かれていません';

  @override
  String get noteAddOnDay => 'この日にメモを追加';

  @override
  String get notePrevMonth => '前の月';

  @override
  String get noteNextMonth => '次の月';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '今月のメモ$n件',
      one: '今月のメモ1件',
      zero: '今月のメモなし',
    );
    return '$_temp0';
  }

  @override
  String get measures => '身体測定';

  @override
  String get measuresHint => '首からふくらはぎまで、バーの重量だけでなく体の変化も追跡。';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '測定$n件', one: '測定1件', zero: '測定なし');
    return '$_temp0';
  }

  @override
  String get measureNoneYet => '未測定';

  @override
  String get measureHistory => '履歴';

  @override
  String get measureNeck => '首';

  @override
  String get measureShoulders => '肩';

  @override
  String get measureChest => '胸囲';

  @override
  String get measureArm => '腕';

  @override
  String get measureForearm => '前腕';

  @override
  String get measureWaist => 'ウエスト';

  @override
  String get measureHips => 'ヒップ';

  @override
  String get measureThigh => '太もも';

  @override
  String get measureCalf => 'ふくらはぎ';

  @override
  String get measureBodyfat => '体脂肪';

  @override
  String get timeline => 'タイムライン';

  @override
  String get hidePhotos => '写真を隠す';

  @override
  String get showPhotos => '写真を表示';

  @override
  String get timelineHint => '同じポーズ、同じ場所、同じ光。1年後、きっと驚きます。';

  @override
  String get timelineEmptyTitle => '最初の写真から記録が始まります';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '写真$n枚', one: '写真1枚', zero: '写真なし');
    return '$_temp0';
  }

  @override
  String get poseFront => '正面';

  @override
  String get poseSide => '側面';

  @override
  String get poseBack => '背面';

  @override
  String get photoEvery => 'リマインド';

  @override
  String photoEveryDays(int n) {
    return '$n日ごと';
  }

  @override
  String get photoEveryOff => 'しない';

  @override
  String get timelineEvery => '間隔でグループ化';

  @override
  String get custom => 'カスタム';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '次の写真まであと$n日', one: '次の写真は明日');
    return '$_temp0';
  }

  @override
  String get photoDueNow => '写真の日です、今日撮影しましょう';

  @override
  String get addTodayPhotos => '今日の写真を追加';

  @override
  String posePhoto(String pose) {
    return '$poseの写真';
  }

  @override
  String get compare => '比較';

  @override
  String get compareNeedTwo => '同じポーズを別の日に2回撮ると、ここで比較できます。';

  @override
  String dayNumber(int n) {
    return '$n日目';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日間隔', one: '1日間隔', zero: '同じ日');
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'この日を削除';

  @override
  String get deleteDayBody => 'この日の写真も完全に削除されます。';

  @override
  String get timelinePhotos => '写真';

  @override
  String get timelineBody => '筋肉マップ';

  @override
  String get timelineBodyEmpty => 'ワークアウトを記録すると筋肉マップが埋まり始めます、写真は不要です。';

  @override
  String get timelineBodyHint => 'あなたのセット記録から作成、アップロードはありません。';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'ワークアウト$n回',
      one: 'ワークアウト1回',
      zero: 'ワークアウトなし',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => '進捗写真';

  @override
  String get notifPhotoChannelWhy => '次の進捗写真のタイミングをお知らせします。';

  @override
  String get notifPhotoTitle => '進捗写真の時間です';

  @override
  String notifPhotoBody(int n) {
    return '前回から$n日。同じポーズ、同じ光で。';
  }

  @override
  String get share => '共有';

  @override
  String get sharePick => '何を表示しますか？';

  @override
  String get shareStreak => '連続記録と継続性';

  @override
  String get shareBody => '鍛えた筋肉';

  @override
  String get shareCompare => 'ビフォー / アフター';

  @override
  String get shareHint => 'カードは端末上で作成されます。共有先を選ぶまで外部には送られません。';

  @override
  String get shareFailed => 'カードを作成できませんでした';

  @override
  String get shareWeekOf => '過去7日間';

  @override
  String get shareStreakLabel => '連続日数';

  @override
  String get shareSessionsLabel => 'ワークアウト';

  @override
  String get shareVolumeLabel => 'ボリューム';

  @override
  String get restForExercise => 'この種目の休憩';

  @override
  String get restUsingDefault => 'デフォルトを使用';

  @override
  String get restCustom => 'この種目だけ';

  @override
  String get setType => 'セット種類';

  @override
  String get setTypeNormal => 'ワーキング';

  @override
  String get setTypeWarmup => 'ウォームアップ';

  @override
  String get setTypeDrop => 'ドロップセット';

  @override
  String get setTypeFailure => '限界まで';

  @override
  String get addWarmup => 'ウォームアップ';

  @override
  String platesPerSide(String plates) {
    return '片側: $plates';
  }

  @override
  String get howTo => 'やり方';

  @override
  String get similar => '類似';

  @override
  String get primaryLabel => 'メイン';

  @override
  String get secondaryLabel => 'サブ';

  @override
  String get none => 'なし';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nセット', one: '$nセット');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'ボリューム $v';
  }

  @override
  String get weeklyPlan => '週間プラン';

  @override
  String get yourRoutines => 'あなたのルーティン';

  @override
  String get noRoutines => 'ルーティンはまだありません。作成して種目を追加しましょう。';

  @override
  String get newRoutine => '新しいルーティン';

  @override
  String get routineName => 'ルーティン名';

  @override
  String get schedule => 'スケジュール';

  @override
  String get addFromList => '下のリストから種目を追加してください。';

  @override
  String get addExercises => '種目を追加';

  @override
  String get deleteRoutine => 'このルーティンを削除しますか？';

  @override
  String exercisesWithCount(int n) {
    return '種目 · $n';
  }

  @override
  String setDay(String day) {
    return '$day を設定';
  }

  @override
  String get newRoutineName => '新しいルーティン';

  @override
  String get dragToReorder => '点のハンドルをドラッグして並べ替え。この順番でトレーニングします。';

  @override
  String reorderHandle(String name) {
    return '$name を並べ替え';
  }

  @override
  String get removeFromRoutine => 'ルーティンから削除';

  @override
  String get dropExercise => 'この種目を外しますか？';

  @override
  String dropExerciseBody(String name) {
    return '「$name」をこのワークアウトから外します。記録済みの内容は失われません。';
  }

  @override
  String get drop => '外す';

  @override
  String get resetData => 'すべてのデータを削除';

  @override
  String get resetTitle => 'すべて削除しますか？';

  @override
  String get resetBody => 'ワークアウト、記録、ルーティン、メモ、プロフィールをすべて削除します。元に戻せません、必要なら先にバックアップを書き出してください。';

  @override
  String get resetConfirm => 'すべて削除';

  @override
  String get resetDone => 'すべてのデータを削除しました';

  @override
  String get support => 'サポート';

  @override
  String get reportBug => 'バグを報告';

  @override
  String get requestFeature => '機能を提案';

  @override
  String get starOnGithub => 'GitHubでスター';

  @override
  String get buyCoffee => 'コーヒーをおごる';

  @override
  String get cantOpenLink => 'リンクを開けませんでした';

  @override
  String get theme => 'テーマ';

  @override
  String get darkTheme => 'ダーク';

  @override
  String get lightTheme => 'ライト';

  @override
  String get amoledTheme => 'AMOLEDブラック';

  @override
  String get editDuration => 'トレーニング時間';

  @override
  String get sessionName => 'トレーニング名';

  @override
  String get nameWorkout => '名前をつける';

  @override
  String get sessionNameHint => '例：脚、プッシュ、全身';

  @override
  String get secondaryPickHint => 'この種目で使うほかの筋肉をタップしてください。';

  @override
  String get languageLabel => '言語';

  @override
  String get unitsLabel => '単位';

  @override
  String get restTimer => '休憩タイマー';

  @override
  String get alarmBlockedTitle => '通知がオフです';

  @override
  String get alarmBlockedBody => '画面ロック中は休憩アラームが鳴りません';

  @override
  String get alarmBlockedAction => 'オンにする';

  @override
  String get alarmSound => 'アラーム音';

  @override
  String get alarmDefaultName => 'デフォルト';

  @override
  String get alarmSoundHint => '自分の音を使用、最大15秒';

  @override
  String get alarmChoose => '音を選択…';

  @override
  String get alarmPreview => '現在の音を再生';

  @override
  String get alarmReset => 'デフォルトに戻す';

  @override
  String get alarmTooLong => 'この音は15秒を超えています';

  @override
  String get alarmInvalid => 'この音声ファイルを読み込めませんでした';

  @override
  String alarmChanged(String name) {
    return 'アラーム音を「$name」に設定しました';
  }

  @override
  String get alarmChangedDefault => 'デフォルト音に戻しました';

  @override
  String get addActivityWidget => 'アクティビティウィジェットを追加';

  @override
  String get addStatsWidget => '統計ウィジェットを追加';

  @override
  String get pinUnsupported => 'ランチャーのウィジェットメニューから追加してください';

  @override
  String get background => '背景';

  @override
  String get bgNone => 'なし';

  @override
  String get bgDots => 'ドット';

  @override
  String get bgGrid => 'グリッド';

  @override
  String get exportCsv => 'ワークアウトを書き出す（CSV）';

  @override
  String get exportBackup => 'バックアップを書き出す（ZIP）';

  @override
  String get importBackup => 'バックアップを読み込む';

  @override
  String get importHint => 'GymManeから書き出した.zip（または旧.json）バックアップを選択してください。メディアを含む現在のデータが置き換わります。';

  @override
  String get import => '読み込む';

  @override
  String get chooseFile => 'ファイルを選択';

  @override
  String get importFromApp => '別のアプリから読み込む';

  @override
  String get importUnknownFormat => 'このファイルには日付、種目、回数、重量の列が必要です';

  @override
  String get importZipNoWeights => 'このZIPには体重ファイルがありません';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件の体重記録を読み込み',
      one: '$n件の体重記録を読み込み',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'このファイルを読み込めませんでした';

  @override
  String get importUnitTitle => 'このファイルの単位は？';

  @override
  String get importUnitBody => 'このエクスポートには重量の単位が記載されていません。';

  @override
  String get importNothing => '新しく読み込むものはありません';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n回のワークアウトを読み込み',
      one: '$n回のワークアウトを読み込み',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymManeについて';

  @override
  String get yourProfile => 'プロフィール';

  @override
  String get autofills => '計算ツールに自動入力';

  @override
  String get onbUnitsWhy => '重量・サイズ・距離に使います。設定からいつでも変更できます。';

  @override
  String get nameLabel => '名前';

  @override
  String get sexLabel => '性別';

  @override
  String get macroProtein => 'タンパク質';

  @override
  String get macroCarbs => '炭水化物';

  @override
  String get macroFat => '脂質';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String get ageLabel => '年齢';

  @override
  String get heightLabel => '身長';

  @override
  String get weightLabel => '体重';

  @override
  String get weeklyGoal => '週間目標';

  @override
  String get activityLabel => '活動量';

  @override
  String get addPhoto => '写真を追加';

  @override
  String get removePhoto => '写真を削除';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get chooseGallery => 'ギャラリーから選択';

  @override
  String get backupImported => 'バックアップを読み込みました';

  @override
  String get backupFailed => 'このバックアップを読み込めませんでした';

  @override
  String get nothingToExport => 'まだ書き出すデータがありません、まずワークアウトを記録してください';

  @override
  String calculatorsCount(int n) {
    return 'トレーニング用計算ツール $n 個';
  }

  @override
  String get result => '結果';

  @override
  String get weightLifted => '挙上重量';

  @override
  String get repsPerformed => '実施回数';

  @override
  String get neck => '首';

  @override
  String get waist => 'ウエスト';

  @override
  String get hip => 'ヒップ（女性）';

  @override
  String get targetWeight => '目標体重';

  @override
  String get workingWeight => '作業重量';

  @override
  String get activityLevel => '活動レベル';

  @override
  String get barWeight => 'バー重量';

  @override
  String get perSide => '片側';

  @override
  String get justTheBar => 'バーのみ。';

  @override
  String perSideCount(int n) {
    return '片側 × $n';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'カロリー';

  @override
  String get toolNameBf => '体脂肪';

  @override
  String get toolNamePlate => 'プレート';

  @override
  String get toolNameWarmup => 'ウォームアップ';

  @override
  String get toolTitleRm => '1RM計算機';

  @override
  String get toolTitleBmi => 'BMI計算機';

  @override
  String get toolTitleCal => 'カロリーとマクロ';

  @override
  String get toolTitleBf => '体脂肪率';

  @override
  String get toolTitlePlate => 'プレート計算機';

  @override
  String get toolTitleWarmup => 'ウォームアップセット';

  @override
  String get toolHintRm => '推定1回最大重量（Epley式）';

  @override
  String get toolHintCal => '1日の維持必要量の推定';

  @override
  String get toolHintBf => '米海軍方式による推定';

  @override
  String get toolHintPlate => 'バーベル総重量';

  @override
  String get toolHintWarmup => '目標作業重量';

  @override
  String get toolDescRm => '推定1回最大重量';

  @override
  String get toolDescBmi => 'BMI（体格指数）';

  @override
  String get toolDescCal => 'カロリーとマクロ栄養素';

  @override
  String get toolDescBf => '体脂肪率';

  @override
  String get toolDescPlate => 'プレート計算機';

  @override
  String get toolDescWarmup => '段階的ウォームアップセット';

  @override
  String get bmiUnderweight => '低体重';

  @override
  String get bmiNormal => '標準体重';

  @override
  String get bmiOverweight => '過体重';

  @override
  String get bmiObese => '肥満';

  @override
  String get actSedentary => '座りがち';

  @override
  String get actLight => '軽い';

  @override
  String get actActive => 'アクティブ';

  @override
  String get actModerate => '中程度';

  @override
  String get muscleChest => '胸';

  @override
  String get muscleBack => '背中';

  @override
  String get muscleLowerBack => '腰';

  @override
  String get muscleShoulders => '肩';

  @override
  String get muscleBiceps => '上腕二頭筋';

  @override
  String get muscleTriceps => '上腕三頭筋';

  @override
  String get muscleForearm => '前腕';

  @override
  String get muscleTrapezius => '僧帽筋';

  @override
  String get muscleAbdomen => '腹筋';

  @override
  String get muscleObliques => '腹斜筋';

  @override
  String get muscleQuads => '大腿四頭筋';

  @override
  String get muscleHamstrings => 'ハムストリング';

  @override
  String get muscleGlutes => '臀筋';

  @override
  String get muscleCalves => 'ふくらはぎ';

  @override
  String get mgChest => '胸';

  @override
  String get mgBack => '背中';

  @override
  String get mgLegs => '脚';

  @override
  String get mgShoulders => '肩';

  @override
  String get mgArms => '腕';

  @override
  String get mgCore => '体幹';

  @override
  String get equipBarbell => 'バーベル';

  @override
  String get equipDumbbell => 'ダンベル';

  @override
  String get equipCable => 'ケーブル';

  @override
  String get equipMachine => 'マシン';

  @override
  String get equipBodyweight => '自重';

  @override
  String get equipWeighted => '加重';

  @override
  String get equipBand => 'バンド';

  @override
  String get equipKettlebell => 'ケトルベル';

  @override
  String get equipRings => 'リング';

  @override
  String get equipOther => 'その他';

  @override
  String get diffBeginner => '初心者';

  @override
  String get diffAdvanced => '上級';

  @override
  String get diffIntermediate => '中級';

  @override
  String get about => '概要';

  @override
  String version(String v) {
    return 'バージョン $v';
  }

  @override
  String get aboutBlurb => 'トレーニングする人が、トレーニングする人のために作りました。';

  @override
  String get freeForever => 'ずっと無料';

  @override
  String get freeForeverWhy => 'サブスクなし、広告なし、課金でロックされる機能なし。';

  @override
  String get fullyOffline => '100%オフライン';

  @override
  String get fullyOfflineWhy => 'アカウントもサーバーも不要。ワークアウトデータはこの端末から出ません。';

  @override
  String get yoursToTake => 'データはあなたのもの';

  @override
  String get yoursToTakeWhy => 'いつでもCSVで書き出し、ワンタップですべて削除できます。';

  @override
  String get whatsInside => '内容';

  @override
  String exercisesInside(int n) {
    return '$n種目';
  }

  @override
  String get exercisesInsideWhy => 'すべてにアニメーションと手順説明があります。';

  @override
  String get calculatorsInside => '10個の計算ツール';

  @override
  String get calculatorsInsideWhy =>
      '1RM、プレート、BMI、カロリー、体脂肪、FFMI、ウォームアップ、RPE重量、DOTSとWilksの筋力スコア、すべて公開済みの式に基づきます。';

  @override
  String get mathInside => '透明な計算';

  @override
  String get mathInsideWhy => 'ボリューム、記録、セットはあなた自身のデータから計算されます。見た目だけの数字はありません。';

  @override
  String get streakCaps => '連続';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '日', one: '日');
    return '$_temp0';
  }

  @override
  String get reset => 'リセット';

  @override
  String get welcomeKicker => 'ようこそ';

  @override
  String get welcomeBlurb => 'すべて端末内に保存。アカウント不要、インターネット不要、支払いなし。';

  @override
  String get welcomeStart => '始める';

  @override
  String onbStep(int i, int n) {
    return 'ステップ $i/$n';
  }

  @override
  String get onbNameTitle => '何とお呼びすればいいですか？';

  @override
  String get onbNameHint => '名前';

  @override
  String get onbPhotoAdd => '写真を追加';

  @override
  String get onbPhotoChange => '写真を変更';

  @override
  String get onbPhotoTitle => 'プロフィールに顔を';

  @override
  String get onbPhotoWhy => '任意です。写真は端末に残り、プロフィールからいつでも変更できます。';

  @override
  String get onbPhotoLater => 'あとで';

  @override
  String get onbNameWhy => '挨拶にのみ使用します。端末外には送信されません。';

  @override
  String get onbBodyTitle => 'いくつかの数値';

  @override
  String get onbBodyWhy => '計算ツールに使います。設定からいつでも変更できます。';

  @override
  String get onbGoalTitle => '週にどのくらいトレーニングしますか？';

  @override
  String get onbGoalWhy => '週間目標を設定します。無理のない現実的な回数にしましょう。';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '週$n回', one: '週$n回');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'キロかポンド？';

  @override
  String get next => '次へ';

  @override
  String get back => '戻る';

  @override
  String get skip2 => 'スキップ';

  @override
  String get madeWithLoveBy => '愛を込めて制作';

  @override
  String get sourceCode => 'ソースコード';

  @override
  String get suggested => '推奨';

  @override
  String get results => '結果';

  @override
  String get noMatches => 'この検索に一致する種目はありません。';

  @override
  String get tapToEdit => '鉛筆をタップして記録を修正、ゴミ箱で削除します。';

  @override
  String get editEntry => '編集';

  @override
  String get editEntryHint => '任意のセットの回数や重量を修正できます。';

  @override
  String get removeSet => 'セットを削除';

  @override
  String get continueWorkout => '続ける';

  @override
  String get continueWorkoutBody => 'チェック済みのセットを保持したままワークアウトを再開します。再度終了すると元の日付で保存されます。';

  @override
  String get addBodyWidget => '筋肉マップウィジェットを追加';

  @override
  String get repsOnly => '回数のみ';

  @override
  String get repsOnlyHint => 'この種目を重量なしで記録します。';

  @override
  String get eachSide => '左右それぞれ';

  @override
  String get eachSideHint => 'タイマーは片側ずつ動き、両側が終わってから休憩が始まります。';

  @override
  String get useDefaultArt => 'デフォルト画像に戻す';

  @override
  String daysShort(int n) {
    return '$n日';
  }

  @override
  String get focusCard => '今日の重点';

  @override
  String get autoAdvance => '自動で次へ';

  @override
  String get keepScreenOn => 'トレーニング中は画面をつけたままにする';

  @override
  String get lockWorkout => '画面をロック';

  @override
  String get unlockWorkout => 'ロック解除';

  @override
  String get holdToUnlock => '長押しで解除';

  @override
  String get liveChannel => 'トレーニング中';

  @override
  String get liveChannelWhy => 'トレーニング中に現在の種目、セット、休憩タイマーを表示します';

  @override
  String liveSet(int n, int total) {
    return 'セット $n/$total';
  }

  @override
  String get liveResting => '休憩中';

  @override
  String get liveAllDone => '全セット完了';

  @override
  String get autoAdvanceHint => '最後のセットで次へ進む';

  @override
  String get placePlates => 'プレートとバー';

  @override
  String get platesAll => 'すべて利用可能';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$nサイズ', one: '$nサイズ');
    return '$_temp0';
  }

  @override
  String get platePairs => 'ペア';

  @override
  String plateAchievable(String w) {
    return '最も近い重量: $w';
  }

  @override
  String get autoWarmup => 'ウォームアップセットから開始';

  @override
  String get autoWarmupHint => 'ワークアウト開始時に段階的ウォームアップセットを追加します。';

  @override
  String get trainReminder => 'ワークアウトリマインダー';

  @override
  String get trainReminderHint => 'この時刻に、ルーティン予定日のみ通知します。';

  @override
  String get reminderExactTime => '時刻を指定';

  @override
  String get toastSoundSetting => '通知音';

  @override
  String get toastSoundHint => '通知ごとにやさしい音';

  @override
  String get notifTrainChannel => 'ワークアウトリマインダー';

  @override
  String get notifTrainChannelWhy => '予定した日にトレーニングするよう通知します。';

  @override
  String get notifTrainTitle => 'ワークアウトの時間です';

  @override
  String get notifTrainBody => 'ルーティンが待っています。';

  @override
  String get planIntro => 'このリストの種目だけを使ってトレーニングルーティンを作ってください。';

  @override
  String get planFormat => '次の形式のJSONのみで回答してください:';

  @override
  String get planNothing => 'このファイルの種目はライブラリに一致しません';

  @override
  String get planFailed => 'このファイルはGymManeが読み込めるルーティンではありません';

  @override
  String get routineGroup => 'グループ';

  @override
  String get newGroup => '新しいグループ';

  @override
  String get noGroup => 'グループなし';

  @override
  String get groupNameHint => 'プッシュ / プル / 脚、5×5…';

  @override
  String get filters => 'フィルター';

  @override
  String get setsPlannedHint => '各種目のセット数を選択してください。ワークアウト開始時にすべて準備されます。';

  @override
  String get nextTime => '次回';

  @override
  String get nextHold => 'すべての回数を達成するまで同じ重量を維持';

  @override
  String get bgPhoto => 'あなたの写真';

  @override
  String get bgPhotoPick => '写真を選択';

  @override
  String get bgPhotoChange => '写真を変更';

  @override
  String get bgPhotoRemove => '写真を削除';

  @override
  String get bgDim => '暗さ';

  @override
  String get dimSoft => '弱';

  @override
  String get dimMedium => '中';

  @override
  String get dimStrong => '強';

  @override
  String get bgPhotoHint => 'アプリ全体の背景に表示され、読みやすいよう暗く処理されます。';

  @override
  String get reminderSmart => 'スマート';

  @override
  String get reminderFixed => '固定時刻';

  @override
  String get reminderSmartHint => '実際にトレーニングする曜日と時刻を学習し、その日に既にトレーニング済みなら通知しません。';

  @override
  String get reminderSmartEmpty => '習慣を学習するため、もう数回ワークアウトを記録してください。';

  @override
  String habitFocus(String day) {
    return '$dayに普段鍛える内容';
  }

  @override
  String get duplicateRoutine => 'ルーティンを複製';

  @override
  String copySuffix(String name) {
    return '$name（コピー）';
  }

  @override
  String get saveAsRoutine => 'ルーティンとして保存';

  @override
  String get savedAsRoutine => 'ルーティンとして保存しました';

  @override
  String get templates => 'テンプレート';

  @override
  String get templatesHint => 'あなたのライブラリから作る定番ルーティン。後からすべて編集できます。';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ルーティン$n件追加', one: 'ルーティン$n件追加');
    return '$_temp0';
  }

  @override
  String get tplFullbody => '週3回の全身トレーニング。初心者に最適。';

  @override
  String get tplPpl => 'プッシュ、プル、脚。週3日または6日。';

  @override
  String get tplArnold => '胸と背中、肩と腕、脚。定番の6日分割。';

  @override
  String get tplUpperlower => '上半身・下半身、週4日。';

  @override
  String get tplStronglifts => '5回×5セットの2種類のワークアウトを交互に。';

  @override
  String get tplStartingstrength => '毎回スクワット、2種類のワークアウトを交互に。';

  @override
  String get tplHome => '懸垂バーと床だけ。';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日', one: '$n日');
    return '$_temp0';
  }

  @override
  String get logRpe => '強度を記録（RPE）';

  @override
  String get rpeHint => '10 = もう1回もできない；8 = あと約2回できる。';

  @override
  String get superset => 'スーパーセット';

  @override
  String get supersetLink => '次と連結';

  @override
  String get supersetUnlink => '次との連結を解除';

  @override
  String get supersetHint => '連結した種目の間は休憩なし、そのまま次へ進みます。';

  @override
  String get aiRoutine => 'AIでルーティン作成';

  @override
  String get aiIntro =>
      'GymManeがAIと直接通信することはありません。種目リストを書き出し、普段使っているAIアシスタントに貼り付け、その回答を読み込みます。端末から自動で送信されるものはありません。';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'ライブラリにない名前が$n件',
      one: 'ライブラリにない名前が1件',
    );
    return '$_temp0';
  }

  @override
  String get importApps => '対応アプリ';

  @override
  String get importOtherCsv => '日付、種目、回数、重量を含むその他のCSV';

  @override
  String get importAskApp => '別のアプリが必要ですか？追加をリクエスト';

  @override
  String get awardFirstStepName => '最初の一歩';

  @override
  String get awardFirstStepLine => 'GymManeへようこそ。これはプレゼントです。';

  @override
  String get awardFirstWorkoutName => '最初のワークアウト';

  @override
  String get awardFirstWorkoutLine => '最初の1回を記録しました。これが一番難しい。';

  @override
  String get awardFirstRoutineName => '最初のルーティン';

  @override
  String get awardFirstRoutineLine => 'これで戻ってこられるプランができました。';

  @override
  String get awardFirstRecordName => '最初の記録';

  @override
  String get awardFirstRecordLine => 'ある種目で自己ベストを更新しました。';

  @override
  String get awardStreak3Name => '3日連続';

  @override
  String get awardStreak3Line => '3日連続。ここから始まります。';

  @override
  String get awardTonne1Name => '1トン';

  @override
  String get awardTonne1Line => 'セット合計で1,000kgを持ち上げました。';

  @override
  String get awardSets100Name => '100セット';

  @override
  String get awardSets100Line => '100セット完了。一つずつ積み上げました。';

  @override
  String get awardHours10Name => '10時間';

  @override
  String get awardHours10Line => 'トレーニング時間が10時間に到達。';

  @override
  String get awardWorkouts50Name => '50回のワークアウト';

  @override
  String get awardWorkouts50Line => '50回のワークアウトを完了しました。';

  @override
  String get awardHours50Name => '50時間';

  @override
  String get awardHours50Line => 'トレーニングに50時間。';

  @override
  String get awardsTitle => 'メダル';

  @override
  String get yearTitle => 'あなたの1年';

  @override
  String get yearBestMonth => 'ベスト月';

  @override
  String get yearMonths => 'か月';

  @override
  String get awardSpinHint => 'メダルをスワイプして回転';

  @override
  String get awardUnlocked => '新しい実績を解除';

  @override
  String get awardNice => 'いいね！';

  @override
  String get awardSaveImage => '画像を保存';

  @override
  String get awardSaved => 'ギャラリーに保存しました';

  @override
  String get awardStreak7Name => '7日間';

  @override
  String get awardStreak7Line => '1日も欠かさず丸1週間。';

  @override
  String get awardStreak30Name => '30日間';

  @override
  String get awardStreak30Line => '1か月連続。もう習慣です。';

  @override
  String get awardWorkouts100Name => '100回のワークアウト';

  @override
  String get awardWorkouts100Line => '100回のワークアウトを最初から最後まで記録。';

  @override
  String get awardTonnes100Name => '100トン';

  @override
  String get awardTonnes100Line => 'これまでの総挙上量が100,000kgに到達。';

  @override
  String get awardSets1000Name => '1,000セット';

  @override
  String get awardSets1000Line => '1セットずつ積み上げて1,000へ。';

  @override
  String get profile => 'プロフィール';

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get pickBadge => 'バッジ';

  @override
  String get statWorkouts => 'ワークアウト';

  @override
  String get statTrained => 'トレーニング';

  @override
  String get statSets => 'セット';

  @override
  String get statLifted => '挙上量';

  @override
  String get statStreak => '連続';

  @override
  String get statDays => '日';

  @override
  String get unitHours => '時間';

  @override
  String get unitDays => '日';

  @override
  String get snapshots => '写真';

  @override
  String get snapNow => '今撮る';

  @override
  String get addCover => 'カバーを追加';

  @override
  String get addTodayWidget => '今日のワークアウト完了状況';

  @override
  String get photosCard => 'あなたの写真';

  @override
  String get handleLabel => 'ユーザー名';

  @override
  String get setupTitle => 'これらを入力すると、ページの残りが自動で埋まります';

  @override
  String get setupHint => 'ここにある数字はすべてあなたの記録から算出されます。どこにも送信されません。';

  @override
  String get setupWorkout => '最初のワークアウトを記録';

  @override
  String get setupWeight => '体重を記録';

  @override
  String get setupMeasures => '身体測定をする';

  @override
  String get setupPhoto => '最初の進捗写真を撮る';

  @override
  String get progressTitle => '進捗';

  @override
  String get tileVolume30 => 'ボリューム · 30日';

  @override
  String get tileAddWeight => '自分の値を追加';

  @override
  String get heatToneTitle => 'ヒートカラー';

  @override
  String get heatToneHint => 'グリッドと体の色だけを変更します。';

  @override
  String get thisWeekTitle => '今週';

  @override
  String get momentsEmptyTitle => 'まだ何もありません';

  @override
  String get deletePhotoTitle => 'この写真を削除しますか？';

  @override
  String get deletePhotoBody => '完全に削除されます。';

  @override
  String get awardsEarned => '獲得済み';

  @override
  String get awardsLocked => '未解除';

  @override
  String get awardStreak100Name => '100日';

  @override
  String get awardWorkouts10Name => '10回のワークアウト';

  @override
  String get awardWorkouts10Line => '最初の10回が違いを作ります。';

  @override
  String get awardWorkouts365Name => '365';

  @override
  String get awardWorkouts365Line => '1年の毎日に相当する365回のワークアウトを、一つずつ記録しました。';

  @override
  String get awardTonnes10Name => '10トン';

  @override
  String get awardTonnes10Line => '10,000kgを持ち上げてきました。';

  @override
  String get awardHours100Name => '100時間';

  @override
  String get awardHours100Line => 'タイマーを回しながら、バーの下で100時間。';

  @override
  String awardWonOn(String date) {
    return '$dateに獲得';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'ゴールド',
      'blue': 'ブルー',
      'green': 'グリーン',
      'other': 'バッジ',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$dateから';
  }

  @override
  String levelShort(int n) {
    return 'レベル $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'レベル$nextまであと$n回',
      one: 'レベル$nextまであと1回',
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
      'ember': '残り火',
      'green': 'グリーン',
      'blue': 'ブルー',
      'mono': 'グレー',
      'other': 'カラー',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$nセット';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '今週 $n/$goal';
  }

  @override
  String momentCount(int n) {
    return '写真$n枚';
  }

  @override
  String photosSelected(int n) {
    return '$n枚を選択中';
  }

  @override
  String deletePhotosTitle(int n) {
    return '写真$n枚を削除しますか？';
  }

  @override
  String get momentsEmptyHint => 'ジム、ホワイトボード、プレートを付けたバーなど、残しておきたいものを撮影。写真は端末内に残り、自分だけが見られます。';

  @override
  String get awardStreak100Line => '100日連続。もうモチベーションではなく習慣です。';

  @override
  String get coverLabel => 'カバー';

  @override
  String get removeCover => 'カバーを削除';

  @override
  String get startTitle => 'ワークアウトを開始';

  @override
  String get logTitle => 'ワークアウトを記録';

  @override
  String get logHint => 'タイマーなし、実施内容だけを入力します。';

  @override
  String get orStartFrom => 'またはここから開始';

  @override
  String get pickExercisesOption => '種目を選択';

  @override
  String get chooseFocusOption => '重点を選択';

  @override
  String get plannedRoutine => '予定';

  @override
  String get logWorkoutAction => 'ワークアウトを記録';

  @override
  String get logging => '記録中';

  @override
  String get placesLabel => 'マイ場所';

  @override
  String get undo => '元に戻す';

  @override
  String get deleteSet => 'セットを削除';

  @override
  String get setDeleted => 'セットを削除しました';

  @override
  String get removeWarmup => 'ウォームアップを外す';

  @override
  String get addWeightAction => '重量を追加';

  @override
  String get workoutOverview => 'このトレーニング';

  @override
  String get allExercisesShort => 'すべて';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total セット';
  }

  @override
  String get nowLabel => '現在';

  @override
  String get deleteWorkout => 'トレーニングを削除';

  @override
  String get deleteWorkoutBody => 'このトレーニングとすべてのセットが履歴から削除されます。';

  @override
  String get themeAuto => '自動';

  @override
  String get themeAutoHint => '端末の設定に合わせる';

  @override
  String get demoSizeTitle => 'トレーニング中の種目デモ';

  @override
  String get demoLarge => '大';

  @override
  String get demoSmall => '小';

  @override
  String get demoOff => '非表示';

  @override
  String get demoLoopTitle => 'デモのアニメーション';

  @override
  String get demoLoopAlways => 'ループ';

  @override
  String get demoLoopShort => '10秒';

  @override
  String get demoLoopHint => '約10秒動いたあと、開始姿勢で止まります。もう一度見るにはデモをタップ。';

  @override
  String get alarmStyleTitle => '休憩が終わったら';

  @override
  String get alarmStyleLoud => '常に鳴らす';

  @override
  String get alarmStyleQuiet => 'マナーモードに従う';

  @override
  String get alarmStyleVibrate => 'バイブのみ';

  @override
  String get alarmStyleHint => '「常に鳴らす」はマナーモードでもアラーム音量で鳴ります。「マナーモードに従う」は通知音量を使い、消音中はバイブだけになります。';

  @override
  String get suggestedPicks => 'あなたへのおすすめ';

  @override
  String get moreOptions => 'その他のオプション';

  @override
  String get suggestInWorkouts => 'クイックトレーニングで提案する';

  @override
  String get suggestInWorkoutsHint => 'オフにすると提案に出なくなります。手動では追加できます。';

  @override
  String get onbPlaceTitle => 'どこでトレーニングしますか？';

  @override
  String get onbPlaceWhy => 'トレーニングする場所をすべて選んでください。それぞれの場所でできる種目だけを提案します。';

  @override
  String get onbPlaceGear => 'そこには何がありますか？';

  @override
  String distanceCol(String unit) {
    return '距離（$unit）';
  }

  @override
  String get timeCol => '時間';

  @override
  String get timePerSideCol => '時間/片側';

  @override
  String get timeMinutesTitle => '時間（分）';

  @override
  String get timeSecondsTitle => '時間（秒）';

  @override
  String distanceTitle(String unit) {
    return '距離（$unit）';
  }

  @override
  String get holdLabel => 'キープ';

  @override
  String get stopLabel => '停止';

  @override
  String startHold(String time) {
    return '開始 · $time';
  }

  @override
  String get exerciseTypeLabel => '記録方法';

  @override
  String get typeReps => '回数と重量';

  @override
  String get typeTime => '時間';

  @override
  String get typeCardio => '距離と時間';

  @override
  String get exerciseTypeHint => 'ランニングや水泳などの有酸素は距離と時間を記録します。プランクのようなキープ系は時間を記録します。';

  @override
  String get howToLabel => 'やり方（任意）';

  @override
  String get howToHint => '1行に1ステップ';

  @override
  String get editExercise => '種目を編集';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get noStepsYet => 'まだ手順がありません。やり方を忘れないよう自分で書いておきましょう。';

  @override
  String get addSteps => '手順を書く';

  @override
  String get setTypeRestPause => 'レストポーズ';

  @override
  String get setTypeNormalInfo => '通常のセット。ボリュームと自己ベストに反映されます。';

  @override
  String get setTypeWarmupInfo => '準備のための軽いセット。ボリュームや自己ベストには含まれません。';

  @override
  String get setTypeDropInfo => 'セット直後に重量を下げ、休まずに続けます。';

  @override
  String get setTypeFailureInfo => '正しいフォームでもう1回もできなくなるまで続けます。実際にできた回数を記録しましょう。';

  @override
  String get setTypeRestPauseInfo => 'セット後に10〜20秒休み、さらに数回絞り出します。';

  @override
  String get planFormatNotes =>
      '種目名はリストの表記どおりに使ってください。\"sets\"、\"reps\"、\"weight\"（指定の単位）、秒単位の \"rest\"、\"days\" は省略可能です。\"superset\": true で次の種目とつなげます。複数週の場合は、2つ目の例のようにルーティンを \"weeks\" の中にまとめます。';

  @override
  String get planSets => 'セットを計画';

  @override
  String get planSetsHint => '各セットの種類、回数、重量を選びます。重量を自動にすると前回のトレーニングから始まります。';

  @override
  String get planHintReps => '各セットの種類と回数を選びます。「自動」は前回のセッションから始まります。';

  @override
  String get planHintTime => '各セットの種類と時間を選びます。「自動」は前回のセッションから始まります。';

  @override
  String get planHintTimeWeight => '各セットの種類、時間、重量を選びます。「自動」は前回のセッションから始まります。';

  @override
  String get planHintCardio => '各セットの距離と時間を選びます。「自動」は前回のセッションから始まります。';

  @override
  String get timeOnly => '時間のみ';

  @override
  String get autoValue => '自動';

  @override
  String get clearPlan => '計画をクリア';

  @override
  String get shareRoutine => 'ルーティンを共有';

  @override
  String get shareWeek => '1週間を共有';

  @override
  String get shareWeekHint => 'すべてのルーティンとそれぞれの曜日。';

  @override
  String shareMessage(String name) {
    return '$name、GymMane でファイルを開いて追加してください。';
  }

  @override
  String get importRoutines => 'ルーティンを読み込む';

  @override
  String get importPasteHint => 'ここにルーティンを貼り付け：GymMane から共有されたもの、AIの回答、JSON、CSV。';

  @override
  String get pasteAction => '貼り付け';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 件のルーティン');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'その週間スケジュールも使う';

  @override
  String get useTheirScheduleHint => '含まれる曜日は、その曜日の予定を置き換えます。';

  @override
  String get addToMyRoutines => 'マイルーティンに追加';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 件のルーティンを追加しました');
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'GymMane が読み込めるものがありません';

  @override
  String get aiStepCopy => '依頼文をコピーします。あなたの種目リストと GymMane が読む形式が入っています。';

  @override
  String get aiStepAsk => '好きなAIに貼り付けて、希望を伝えましょう：週の日数、目標、何週間か。';

  @override
  String get aiStepPaste => 'AIの回答を下に貼り付けて読み込みます。ファイルは不要です。';

  @override
  String get copyForAi => 'AI用にコピー';

  @override
  String get copiedDone => 'コピーしました';

  @override
  String get aiPasteHint => 'ここにAIの回答を貼り付け';

  @override
  String get importAction => '読み込む';

  @override
  String get showFormat => '形式を見る';

  @override
  String get shareAsFile => 'ファイルとして共有';

  @override
  String get recoveryTab => '回復';

  @override
  String recoveryOverall(int pct) {
    return '体の回復度 $pct%';
  }

  @override
  String get recoveryAllFresh => 'すべて回復しています。どの部位を鍛えてもいい日です。';

  @override
  String recoveryStill(String muscles) {
    return '回復中：$muscles';
  }

  @override
  String get recoveryTired => '疲労';

  @override
  String get recoveryFresh => '回復済み';

  @override
  String get recoveryHint => '筋肉をタップすると回復度が分かります。最近のセットほど、そしてきついセット（RPE）ほど重く数えます。';

  @override
  String recoveryPct(int pct) {
    return '$pct% 回復';
  }

  @override
  String readyInHours(int h) {
    return 'あと約 $h 時間';
  }

  @override
  String get tplAbcd => '4日：胸と三頭、背中と二頭、脚、肩と腹筋。';

  @override
  String get tplAbcde => '5日、1日1部位：胸、背中、脚、肩、腕。';

  @override
  String get elapsedCaps => '経過';

  @override
  String get tapToChange => 'タップで変更';

  @override
  String get swipeToSkipHint => 'タイマーを横にスワイプすると休憩をスキップできます。';

  @override
  String get screenLocked => '画面ロック中';

  @override
  String get lockedHint => '上の指紋マークを長押しして解除します';

  @override
  String get liveDoneSet => 'セット完了';

  @override
  String get liveSkipRest => '休憩をスキップ';

  @override
  String get livePause => '一時停止';

  @override
  String get liveResume => '再開';

  @override
  String get liveNext => '次へ';

  @override
  String liveUpNext(String name) {
    return '次：$name';
  }

  @override
  String get stickerOpen => '写真に重ねて共有';

  @override
  String get stickerNoPhoto => '写真なし';

  @override
  String get stickerWorkout => 'トレーニング';

  @override
  String get stickerStreak => '連続記録';

  @override
  String get stickerDate => '日付';

  @override
  String get stickerHint => 'ドラッグで移動、ピンチでサイズ変更や回転';

  @override
  String get stickerSaved => 'ギャラリーに保存しました';

  @override
  String get stickerWeek => '今週';

  @override
  String get getReady => '準備して';

  @override
  String sideOfTwo(String n) {
    return '片側 $n/2';
  }

  @override
  String get switchSides => '反対側へ';

  @override
  String get stickerGallery => 'ギャラリー';

  @override
  String get stickerCamera => 'カメラ';

  @override
  String get shareIntroTitle => 'このルーティンを共有';

  @override
  String get shareIntroBody => 'パートナーや友だち、家族に送りましょう。GymMane で開ける小さなファイルが届き、セットや重量ごとワンタップで追加できます。';

  @override
  String get removedFromRoutine => 'ルーティンから外しました';

  @override
  String get radarTitle => '直近30日';

  @override
  String get radarHint => 'もっと鍛えたい部位をチェック';

  @override
  String get radarEmpty => '数日トレーニングするとバランスが見えます';

  @override
  String get radarBalanced => '今のところバランス良好';

  @override
  String radarFocus(String list) {
    return 'もっと必要：$list';
  }

  @override
  String get countdownReady => '準備して';

  @override
  String get countdownSkip => 'タップですぐ開始';

  @override
  String get countdownSetting => '開始前のカウントダウン';

  @override
  String get effortSetting => 'セットごとの強度を記録';

  @override
  String get effortHint => 'RPE：10 はもう 1 回もできない、8 はあと 2 回できた状態。RIR は残っていた回数。記録したセットは、推定 1RM に RPE 表を使います。';

  @override
  String get rirHint => '0 はもう 1 回もできない、2 はあと 2 回できた状態。';

  @override
  String get addWeekWidget => '今週のウィジェットを追加';

  @override
  String get gamificationSetting => 'メダルとレベル';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n回', one: '$n回');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'ベストセット';

  @override
  String get weekStartSetting => '週の始まり';

  @override
  String get stepOutOfWorkout => '一時停止して離れる';

  @override
  String get saveToRoutine => 'ルーティンに変更を保存';

  @override
  String get routineUpdated => 'ルーティンを更新しました';

  @override
  String saveChangesTitle(String name) {
    return '$nameに変更を保存しますか？';
  }

  @override
  String get saveChangesBody => '次に始めるとき、ルーティンにはこれらの変更が反映されます。';

  @override
  String get routineOrderChanged => '新しい種目の順番';

  @override
  String get mineOnly => '自分で作成';

  @override
  String createNamed(String name) {
    return '見つからない？「$name」を作成';
  }

  @override
  String get orStartWith => 'または次から始める';

  @override
  String get warmupFocus => 'ウォームアップ';

  @override
  String get warmupFocusHint => '器具あり・なしのモビリティと活性化';

  @override
  String get cardioFocus => '有酸素運動';

  @override
  String get cardioFocusHint => 'ラン、バイク、ローイング、縄跳びを距離と時間で';

  @override
  String get homeRecommended => 'ホームのおすすめ';

  @override
  String get homeRoutines => 'ホームのルーティン';

  @override
  String get homeRoutinesHint => '最近やった順';

  @override
  String get homeWeekStats => 'ホームの今週';

  @override
  String get homeWeekStatsHint => '今週のボリューム・セット・記録';

  @override
  String get stepsSetting => 'Health Connect の歩数';

  @override
  String get stepsSettingHint => '今日の歩数をホームに';

  @override
  String get stepsToday => '今日の歩数';

  @override
  String stepsOfGoal(String goal) {
    return '/ $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '今日 $count 歩';
  }

  @override
  String get stepsGoal => '1日の歩数目標';

  @override
  String get stepsNoAccess => '歩数にアクセスできません';

  @override
  String get stepsGrant => 'タップして Health Connect で許可';

  @override
  String get stepsInfoRead => '歩数だけを読み取ります。それ以外は読まず、Health Connect に書き込むこともありません。';

  @override
  String get stepsInfoLocal => '歩数は端末内に残ります。GymMane はインターネットに接続しません。';

  @override
  String get stepsInfoOff => '設定または Health Connect でいつでもオフにできます。';

  @override
  String get stepsManage => '権限を管理';

  @override
  String get routineDoneToday => '今日は完了 · お疲れさま';

  @override
  String get trainAgain => 'もう一度トレーニング';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日前', one: '昨日実施', zero: '今日実施');
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'アーカイブ';

  @override
  String get archiveExercise => '種目をアーカイブ';

  @override
  String get restoreExercise => '元に戻す';

  @override
  String get archivedToast => '種目をアーカイブしました';

  @override
  String get archivedToastHint => '種目 › アーカイブ にあります';

  @override
  String get archivedBanner => 'アーカイブ済み。一覧や提案には出ませんが、履歴は残ります。';

  @override
  String get videoMarksHint => '手順の場面で一時停止してピンをタップすると、次回そこへ移動できます。';

  @override
  String get videoMarkHere => 'この手順をここに記録';

  @override
  String get sectionGeneral => '一般';

  @override
  String get sectionTraining => 'トレーニング';

  @override
  String get sectionAlerts => 'リマインダーとアラーム';

  @override
  String get sectionHome => 'ホーム';

  @override
  String get sectionWidgets => 'ウィジェット';

  @override
  String get sectionData => 'データとバックアップ';

  @override
  String get multiPlanSetting => '1日に複数のルーティン';

  @override
  String get multiPlanHint => 'この日のルーティンをすべてタップ。追加した順に進みます。';

  @override
  String routineOfDay(int n, int total) {
    return '今日 $n/$total';
  }

  @override
  String get nextToday => '今日の次のルーティン';

  @override
  String get planAboutMe => '私について：';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex、$age歳、身長$height、体重$weight。';
  }

  @override
  String planDays(int n) {
    return '週$n日トレーニングしたい。';
  }

  @override
  String get planNoHistory => 'まだ記録がありません。初心者として扱い、ボリュームと重量は控えめにしてください。';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '直近30日のトレーニングは$n回。',
      one: '直近30日のトレーニングは1回。',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => '最近のベストセット';

  @override
  String get planAskFirst => '目標（筋力、筋肥大、減量、体力づくり）や1回の時間が分からなければ、まず短いメッセージで質問してください。分かったらJSONだけで答えてください。';

  @override
  String get backToTop => '先頭へ戻る';

  @override
  String get deleteExerciseTitle => 'この種目を削除しますか？';

  @override
  String deleteExerciseBody(String name) {
    return '「$name」をライブラリとルーティンから削除します。これまでのセットは残ります。';
  }

  @override
  String get exportForStravaHint =>
      'ブラウザで strava.com/upload/select からアップロード（Stravaアプリはファイルを取り込めません）。セット付きのウェイトトレーニングとして表示されます。';

  @override
  String get manualStartTime => '開始時刻';

  @override
  String get manualDuration => '時間';

  @override
  String get manualDurationUnset => '時間を入力';

  @override
  String get stravaRow => 'Stravaへ書き出し（ベータ）';

  @override
  String get stravaBeta => 'ベータ';

  @override
  String get stravaIntro =>
      'Stravaに送るトレーニングを選んでください。.fitファイルができるので、ブラウザで strava.com/upload/select からアップロードすると、セット付きのウェイトトレーニングとして表示されます。';

  @override
  String get stravaEmpty => '書き出せるトレーニングはまだありません。';

  @override
  String get tapToPause => 'タップで一時停止';

  @override
  String get holdPausedHint => '一時停止中 · タップで再開';

  @override
  String get finishHoldNow => '今すぐセットを終える';

  @override
  String get barWeightExercise => 'バーまたはスレッドの重さ';

  @override
  String get barWeightHint => 'プレート計算に使われます';

  @override
  String get barWeightCustom => '自分で設定 · タップでリセット';

  @override
  String get groupRename => 'グループ名を変更';

  @override
  String get groupUngroup => 'グループを解除(ルーティンは残す)';

  @override
  String get groupDeleteAll => 'グループとルーティンを削除';

  @override
  String groupDeleteTitle(String name) {
    return '「$name」を削除しますか?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$countが削除されます。トレーニング履歴は残ります。';
  }

  @override
  String get tplRr => 'r/bodyweightfitness の定番:週3日の全身トレーニング。楽になったら次の段階へ。';

  @override
  String get levelUpKicker => '次のステップ';

  @override
  String levelUpBody(int reps, String name) {
    return '$nameで3×$repsを2回連続で達成。次のステップに進みますか?';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routineで入れ替える';
  }

  @override
  String get levelUpSee => 'やり方を見る';

  @override
  String get levelUpLater => '今はしない';

  @override
  String get levelUpStay => 'このまま続ける';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$nameが$routineに入りました';
  }

  @override
  String get levelUpStayed => 'この種目ではステップアップを提案しません';

  @override
  String get levelHintsSetting => '次のステップを提案';

  @override
  String get heatmapLabelsSetting => 'アクティビティマップに曜日と月を表示';

  @override
  String get rmPercent => 'パーセント';

  @override
  String rmAtPercent(String pct) {
    return '最大の$pct';
  }

  @override
  String get copyWorkout => 'テキストでコピー';

  @override
  String get goalSet => '目標を設定';

  @override
  String get goalTargetReps => '目標回数';

  @override
  String goalToGo(String value) {
    return 'あと$value';
  }

  @override
  String get goalReached => '目標達成';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '残り$n日');
    return '$_temp0';
  }

  @override
  String get goalOverdue => '期限切れ';

  @override
  String get goalDeadline => '期限';

  @override
  String get goalNoDeadline => '期限なし';

  @override
  String get goalRemove => '目標を削除';

  @override
  String get exerciseNameMissing => '名前を入力してください';

  @override
  String get aliasesLabel => '別名（任意）';

  @override
  String get aliasesHint => '別の呼び方をカンマ区切りで';

  @override
  String alsoCalled(String names) {
    return '別名: $names';
  }

  @override
  String get addToRoutine => 'ルーティンに追加';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件のルーティンに入っています',
      zero: 'まだどのルーティンにも入っていません',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => '追加済み';

  @override
  String get restInRoutine => 'このルーティンでの休憩';

  @override
  String get restInRoutineHint => '種目の設定と同じ';

  @override
  String get restInRoutineReset => 'ここだけ · タップで戻す';

  @override
  String get swapExercise => '種目を変更';

  @override
  String get swapShort => '変更';

  @override
  String swapHint(String name) {
    return '今日だけ$nameの代わりに。終了時にルーティンに残すこともできます。';
  }

  @override
  String get swapKeepsDone => '終わったセットは残り、新しい種目で残りを続けます。';

  @override
  String swapSameMuscle(String muscle) {
    return '同じ部位 · $muscle';
  }

  @override
  String get swapDoneBefore => '実施済み';

  @override
  String get multiPlanSettingHint => '同じ曜日に複数のルーティン';

  @override
  String get levelHintsHint => 'より難しい種目を提案';

  @override
  String get focusCardHint => '今日のルーティンをホームの一番上に';

  @override
  String get gamificationHint => 'メダル、レベル、お祝い';

  @override
  String get exerciseSettings => 'この種目の設定';

  @override
  String get placeActiveNow => '現在地';

  @override
  String get placeTapToUse => 'タップしてここでトレーニング';

  @override
  String get intervalDays => '日';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target日';
  }

  @override
  String get toolNameRpe => 'RPEで重量';

  @override
  String get toolTitleRpe => 'RPEで重量';

  @override
  String get toolDescRpe => '狙う強度に合う重量';

  @override
  String get toolNameDots => '筋力レベル';

  @override
  String get toolTitleDots => '筋力レベル（DOTS）';

  @override
  String get toolDescDots => '体重に対するあなたの筋力';

  @override
  String rpeResultHint(int reps, String rpe) {
    return '$reps回・RPE $rpeの場合';
  }

  @override
  String get rpeYourSet => '今やったセット';

  @override
  String get rpeGoal => 'やりたいこと';

  @override
  String rpeOneRmLine(String value) {
    return '推定1RM：$value';
  }

  @override
  String get rpeExplain => 'RPE 10はもう1回もできない、8はあと2回できた状態です。';

  @override
  String get dotsBestLifts => 'ベスト記録';

  @override
  String get dotsSquat => 'スクワット';

  @override
  String get dotsBench => 'ベンチプレス';

  @override
  String get dotsDeadlift => 'デッドリフト';

  @override
  String dotsTotalLine(String value) {
    return '合計：$value';
  }

  @override
  String get dotsExplain => '体重に関係なく、誰とでも筋力を比べられます。1回のベスト記録か推定1RMを使ってください。';

  @override
  String get dotsLevel0 => '初心者';

  @override
  String get dotsLevel1 => '中級者';

  @override
  String get dotsLevel2 => '上級者';

  @override
  String get dotsLevel3 => 'かなりの上級者';

  @override
  String get dotsLevel4 => 'エリート';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilksスコア';

  @override
  String get toolDescWilks => 'パワーリフティングの定番スコア';

  @override
  String get wilksExplain => 'パワーリフティングの定番の式。2020年にDOTSに置き換えられましたが、今も多くの大会やランキングで使われています。';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => '除脂肪量指数';

  @override
  String get toolDescFfmi => '身長に対する筋肉量';

  @override
  String get ffmiBodyFat => '体脂肪率';

  @override
  String ffmiLeanLine(String value) {
    return '除脂肪量：$value';
  }

  @override
  String get ffmiExplain => 'BMIに似ていますが脂肪を除き、除脂肪量だけを数えます。身長で補正しているので、背の高い人も低い人も公平に比べられます。';

  @override
  String get ffmiLevel0 => '平均以下';

  @override
  String get ffmiLevel1 => '平均';

  @override
  String get ffmiLevel2 => '平均以上';

  @override
  String get ffmiLevel3 => '優秀';

  @override
  String get ffmiLevel4 => '傑出';

  @override
  String get rpeEffortLabel => '強度（RPE）';

  @override
  String get restRowHint => 'セット間。種目に専用の時間がなければ';

  @override
  String get effortRowHint => '各セットにRPEかRIRを記録';

  @override
  String get countdownHint => '最初のセットの前に3、2、1';

  @override
  String get keepScreenOnHint => 'トレーニング中は画面を消さない';

  @override
  String get demoSizeRowHint => 'トレーニング中の種目のイラスト';

  @override
  String get demoLoopRowHint => 'アニメーションを繰り返すか止めるか';

  @override
  String get trainReminderRowHint => 'トレーニング日のお知らせ';

  @override
  String get alarmSoundRowHint => '休憩終了時に鳴る音';

  @override
  String get alarmStyleRowHint => 'マナーモードでも鳴らすか';

  @override
  String get recommendedRowHint => 'ホームでおすすめする種目';

  @override
  String get weightStepSetting => '重量の刻み';

  @override
  String get weightStepHint => '− と + ボタンで増減する量';

  @override
  String get prBestWorkout => 'ベストワークアウト';

  @override
  String get mergeExercise => '統合';

  @override
  String mergeExerciseInto(String name) {
    return '$name を統合…';
  }

  @override
  String get mergeExerciseTitle => '種目を統合しますか？';

  @override
  String mergeExerciseBody(String from, String to) {
    return '「$from」の履歴はすべて「$to」に移ります。「$from」はライブラリに残ります。元に戻せません。';
  }

  @override
  String get mergedToast => '履歴を統合しました';

  @override
  String get nutrition => '食事';

  @override
  String get nutritionHomeEmpty => '水分・タンパク質・カロリー';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · タンパク質 $protein g';
  }

  @override
  String get nutritionToday => '今日';

  @override
  String get nutritionYesterday => '昨日';

  @override
  String get nutritionGoals => '1日の目標';

  @override
  String get kcalLabel => 'カロリー';

  @override
  String get kcalOver => 'オーバー';

  @override
  String get waterLabel => '水分';

  @override
  String get waterDone => '目標達成';

  @override
  String get waterCustom => 'ほかの量';

  @override
  String get glassSize => 'グラスの量';

  @override
  String get supplementsLabel => 'サプリ';

  @override
  String get supplementsEmpty => 'タップで追加、+ で自分のを追加。';

  @override
  String get addSupplement => '新しいサプリ';

  @override
  String get supplementNameHint => 'クレアチン、ビタミンD…';

  @override
  String removeSupplementTitle(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get removeSupplementBody => '飲んだ印をつけた日も一緒に消えます。';

  @override
  String get suppCreatine => 'クレアチン';

  @override
  String get suppVitaminD => 'ビタミンD';

  @override
  String get suppOmega3 => 'オメガ3';

  @override
  String get suppMagnesium => 'マグネシウム';

  @override
  String get suppMultivitamin => 'マルチビタミン';

  @override
  String get suppCaffeine => 'カフェイン';

  @override
  String get myFoods => 'マイ食品';

  @override
  String get newFood => '新しい食品';

  @override
  String get editFood => '食品を編集';

  @override
  String get foodNameHint => 'プロテイン、オートミール、パン…';

  @override
  String get servingLabel => '1食分';

  @override
  String get servingHint => '1スクープ · 30 g';

  @override
  String get perServing => '1食あたり';

  @override
  String get servingsLabel => '食分';

  @override
  String get foodPhotoHint => '無地の背景ならステッカーになります。';

  @override
  String get cutoutWorking => '切り抜き中…';

  @override
  String get cutoutTry => '切り抜く';

  @override
  String get cutoutKeep => '写真全体';

  @override
  String deleteFoodTitle(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get deleteFoodBody => 'マイ食品から消えます。記録済みのものは残ります。';

  @override
  String get mealBreakfast => '朝食';

  @override
  String get mealLunch => '昼食';

  @override
  String get mealDinner => '夕食';

  @override
  String get mealSnacks => '間食';

  @override
  String get nothingLogged => 'まだ記録がありません。';

  @override
  String addToMeal(String meal) {
    return '$mealに追加';
  }

  @override
  String get quickAdd => 'クイック追加';

  @override
  String get quickAddHint => '食品を保存せずに数値だけ。';

  @override
  String get quickAddName => '何でしたか？（任意）';

  @override
  String get logFood => '追加';

  @override
  String loggedToast(String meal) {
    return '$mealに追加しました';
  }

  @override
  String get entryRemoved => '削除しました';

  @override
  String get goalsFromProfile => 'プロフィールから計算';

  @override
  String get goalsFromProfileHint => 'プロフィールのカロリー、体重1kgあたりタンパク質1.8gと水35ml。';

  @override
  String get kcalEaten => '摂取';

  @override
  String get kcalRemaining => '残り';

  @override
  String waterTapHint(String amount) {
    return 'グラスをタップ：+ $amount';
  }

  @override
  String get shakeEmpty => 'タップしてシェイクを選ぶ';

  @override
  String shakeTapHint(String name) {
    return 'タップ：+ $name';
  }

  @override
  String get shakePick => 'あなたのシェイク';

  @override
  String get shakePickHint => 'グラスをタップすると一度で記録されます。';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'C';

  @override
  String get fatLetter => 'F';

  @override
  String get addBurnedLabel => '消費カロリーを足す';

  @override
  String get addBurnedHint => '消費カロリーはトレーニング時間と体重から推定します。';

  @override
  String get amountLabel => '量';

  @override
  String amountIn(String unit) {
    return '量（$unit）';
  }

  @override
  String get bodyweightLabel => '体重';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 品をコピーしました');
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => '記録済みのものはそのまま残ります。';

  @override
  String get fiberLabel => '食物繊維';

  @override
  String get sugarLabel => '糖質';

  @override
  String get sodiumLabel => 'ナトリウム';

  @override
  String get foodDatabase => '食品データベース';

  @override
  String get kcalBurned => '消費';

  @override
  String get mealOptions => '食事のオプション';

  @override
  String get moreNutrients => '食物繊維・糖質・ナトリウム';

  @override
  String ofGoal(int goal, String unit) {
    return '/ $goal $unit';
  }

  @override
  String per100(String unit) {
    return '100 $unitあたり';
  }

  @override
  String get perServingShort => '1食あたり';

  @override
  String get foodCategory => 'カテゴリー';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 個');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 枚');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count スクープ');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '大さじ $count');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '小さじ $count');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count カップ');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'グラス $count 杯');
    return '$_temp0';
  }

  @override
  String get recentFoods => '最近';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 品');
    return '$_temp0';
  }

  @override
  String get renameLabel => '名前を変更';

  @override
  String get repeatFrom => 'ここから繰り返す';

  @override
  String get repeatNone => 'ほかの日にこの食事の記録はまだありません。';

  @override
  String get restDayGoals => '休息日は別の目標にする';

  @override
  String get trainingDays => 'トレーニング日';

  @override
  String get restDays => '休息日';

  @override
  String get trainingDay => 'トレーニング日';

  @override
  String get saveAsMeal => '食事として保存';

  @override
  String get savedMealNameHint => '例：いつもの朝食';

  @override
  String get savedMealToast => '食事を保存しました';

  @override
  String get savedMeals => '保存した食事';

  @override
  String get searchFoodsHint => '食品を検索';

  @override
  String get searchFoodsEmpty => '写真付きの500以上の食品から探すか、自分で作れます。';

  @override
  String searchFoodsNone(String query) {
    return '「$query」は見つかりません。自分の食品として作成しましょう。';
  }

  @override
  String get servingWeight => 'グラム';

  @override
  String get weekAverage => '今週';

  @override
  String get weekAvgEnergy => '1日平均';

  @override
  String get weekAvgProtein => '1日のタンパク質';

  @override
  String get weekEnergyOnTarget => 'カロリー目標内';

  @override
  String get weekProteinOnTarget => 'タンパク質目標内';

  @override
  String weekProteinAvg(int grams) {
    return '1日タンパク質 $grams g';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$days 日中 $met 日が目標内';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 日記録');
    return '$_temp0';
  }

  @override
  String get weekNoData => 'まだ記録がありません';

  @override
  String get weekOnTargetHint => '目標内：カロリーが目標の±10%以内、タンパク質が90%以上。';

  @override
  String get weightGoalLabel => '目標体重';

  @override
  String weightGoalTitle(String unit) {
    return '目標体重（$unit）';
  }

  @override
  String weightGoalLine(String weight) {
    return '目標 $weight';
  }

  @override
  String get weightGoalNone => '長押しで目標を設定';

  @override
  String get weightGoalReached => '目標達成';

  @override
  String weightToLose(String weight) {
    return 'あと $weight 減';
  }

  @override
  String weightToGain(String weight) {
    return 'あと $weight 増';
  }

  @override
  String get aminoHis => 'ヒスチジン';

  @override
  String get aminoIle => 'イソロイシン';

  @override
  String get aminoLeu => 'ロイシン';

  @override
  String get aminoLys => 'リジン';

  @override
  String get aminoSaa => 'メチオニン';

  @override
  String get aminoAaa => 'フェニルアラニン';

  @override
  String get aminoThr => 'トレオニン';

  @override
  String get aminoTrp => 'トリプトファン';

  @override
  String get aminoVal => 'バリン';

  @override
  String get animalProtein => '動物性タンパク質';

  @override
  String get proteinQuality => 'タンパク質の質';

  @override
  String get qualityComplete => '完全';

  @override
  String get qualityAlmost => 'ほぼ完全';

  @override
  String get qualityIncomplete => '不完全';

  @override
  String get qualityNoData => 'まだデータがありません';

  @override
  String get qualityNoDataHint => 'データベースの食品を記録するとアミノ酸が表示されます。';

  @override
  String get qualityAllCovered => '9種類の必須アミノ酸をすべて満たしています。';

  @override
  String qualityLimiting(String amino) {
    return '$aminoが不足しています。多く含む食品と組み合わせましょう。';
  }

  @override
  String qualityCoverage(int pct) {
    return 'タンパク質の $pct% で計算：自分の食品にはアミノ酸データがありません。';
  }

  @override
  String get fatTypes => '脂肪の種類';

  @override
  String get fatSaturated => '飽和';

  @override
  String get fatMono => '一価不飽和';

  @override
  String get fatPoly => '多価不飽和';

  @override
  String satLimitLine(String grams, int limit) {
    return '飽和脂肪 $grams g / 上限 $limit g（カロリーの10%）';
  }

  @override
  String get sugarSodium => '糖質とナトリウム';

  @override
  String get shakeCard => 'プロテインシェイク';

  @override
  String get mealOther => '食事';

  @override
  String get mealAdd => '食事を追加';

  @override
  String get mealAddHint => '例：トレーニング前';

  @override
  String get mealsOfDay => '1日の食事';

  @override
  String get mealsHint => '好きなだけ作れます。削除すると中身は一つ上の食事に移ります。';

  @override
  String get trackersTitle => 'カスタマイズ';

  @override
  String get trackersHint => '記録したいものだけ表示しましょう。';

  @override
  String get trackersDaily => '1日のまとめ';

  @override
  String get trackersDetail => '詳細';

  @override
  String get trackersCards => 'カード';

  @override
  String get prepTitle => '作り置き';

  @override
  String get prepNewShort => '新しい作り置き';

  @override
  String get prepNew => '新しい作り置き';

  @override
  String get prepEdit => '作り置きを編集';

  @override
  String get prepHint => '鍋ごと一度記録して、少しずつ食べましょう。';

  @override
  String get prepEmpty => '数日分を作りましたか？一度記録したら、残りからどれだけ食べたかだけ入力します。';

  @override
  String get prepNameHint => '例：チキンライス';

  @override
  String get prepDefaultName => '作り置き';

  @override
  String get prepIngredients => '材料';

  @override
  String get prepAddIngredient => '材料を追加';

  @override
  String get prepCookedWeight => '調理後の重さ';

  @override
  String prepCookedHint(String grams) {
    return '正確にするには調理後に鍋ごと量りましょう。空欄なら生の合計（$grams g）を使います。';
  }

  @override
  String get prepNeedWeight => '調理後の重さを入力してください：グラムのない材料があります。';

  @override
  String prepLeftOf(String left, String total) {
    return '残り $left / $total';
  }

  @override
  String get prepOfWhatsLeft => '残りの %';

  @override
  String get prepAll => '全部';

  @override
  String prepLogAmount(String grams) {
    return '$grams を記録';
  }

  @override
  String get prepWeighLeft => '残りを量る';

  @override
  String get prepFinished => 'この作り置きはなくなりました。';

  @override
  String get approxValues => '概算';

  @override
  String get editValues => '値を編集';

  @override
  String get editValuesHint => 'この記録だけ変わります。次回のために直すにはマイ食品から編集してください。';

  @override
  String get editLibraryHint => '同じ写真で自分の食品として保存されます';

  @override
  String per100Line(String energy, String unit) {
    return '100 $unitあたり $energy';
  }

  @override
  String get rawLabel => '生';

  @override
  String get cookedLabel => '調理後';

  @override
  String get rawHint => '調理前の重さ';

  @override
  String cookedHint(String factor) {
    return '調理後の重さ（生の ×$factor）';
  }

  @override
  String get servingsUnit => '食分';

  @override
  String logAmount(String energy) {
    return '記録 · $energy';
  }

  @override
  String get catFruit => '果物';

  @override
  String get catVeg => '野菜';

  @override
  String get catMeat => '肉';

  @override
  String get catFish => '魚';

  @override
  String get catEgg => '卵';

  @override
  String get catDairy => '乳製品';

  @override
  String get catGrain => '穀物';

  @override
  String get catBakery => 'パン';

  @override
  String get catLegume => '豆類';

  @override
  String get catNut => 'ナッツ';

  @override
  String get catOil => '油';

  @override
  String get catPantry => '食材庫';

  @override
  String get catDrink => '飲み物';

  @override
  String get catSauce => 'ソース';

  @override
  String get catSpice => 'スパイス';

  @override
  String get searchFoodsPrompt => '何を食べましたか？';

  @override
  String get shelfEmpty => '食品を探すか自分のを撮影しましょう：よく記録するものがここに出ます。';

  @override
  String get repeatEntry => 'もう一度';

  @override
  String get notifSuppChannel => 'サプリ';

  @override
  String get notifSuppChannelWhy => 'サプリを飲むための毎日のお知らせ';

  @override
  String get energySplit => 'カロリーの内訳';

  @override
  String get typicalServing => '一般的な1食分';

  @override
  String cookedYieldLine(String factor) {
    return '生の重さの$factor倍';
  }

  @override
  String get readyDishes => '料理';

  @override
  String weightLastLine(String weight) {
    return '前回の体重 $weight';
  }

  @override
  String get proteinAnimalShort => '動物性';

  @override
  String get proteinPlantShort => '植物性';

  @override
  String kcalFromMacros(String value) {
    return 'このマクロでおよそ $value';
  }

  @override
  String get useValue => '使う';

  @override
  String get suppRowHint => 'タップでチェック · 長押しで詳細';

  @override
  String get suppPhoto => '写真';

  @override
  String get suppDose => '用量';

  @override
  String get suppDoseHint => '5 g、2 カプセル…';

  @override
  String get suppRemind => 'リマインド';

  @override
  String mealPlanDefault(int n) {
    return 'プラン $n';
  }

  @override
  String get mealPlansTitle => '食事プラン';

  @override
  String get mealPlanNew => '新しいプラン';

  @override
  String fromPlan(String name) {
    return '$name から';
  }

  @override
  String get logPlan => '記録';

  @override
  String get planFromDay => 'この日をコピー';

  @override
  String get planNewHint => 'ルーティンのように一日を計画して、食事をまるごとワンタップで記録しましょう。';

  @override
  String get planLogDay => '空いている食事を記録';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 品を記録しました');
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'プランなし';

  @override
  String get planWeekHint => '日をタップしてプランを割り当てます。';

  @override
  String get planDuplicate => '複製';

  @override
  String planDeleteTitle(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get planDeleteBody => 'ルーティンは残ります。この保存した週だけが削除されます。';

  @override
  String get sectionBeta => 'ベータ';

  @override
  String get nutritionBeta => '食事';

  @override
  String get nutritionBetaHint => '食事、水分、サプリ';

  @override
  String get nutritionAboutTitle => '食事について';

  @override
  String get nutritionAboutSub => 'これが何なのか、そして決してならないもの。';

  @override
  String get nutritionAboutWhatTitle => 'トレーニングの一部';

  @override
  String get nutritionAboutWhat =>
      '食事、水、プロテイン、サプリをトレーニングのすぐ隣で記録できるシンプルな機能です。GymMane はまずジムのアプリです。食事はすべてを一か所にまとめるためのもので、本格的なダイエットアプリの代わりではありません。';

  @override
  String get nutritionAboutScanTitle => 'スキャンは今後もなし';

  @override
  String get nutritionAboutScan =>
      'バーコードを読み取るだけで全部入力されたら便利です。でもそのためにはインターネットと巨大なオンライン食品データベースが必要で、あなたが食べたものは他人のサーバーに送られます。そのデータはいつ何を食べ、どう体を管理しているかを示し、広告に使われたり大企業の手に渡ったりすることがあります。だからスキャナーはありませんし、これからも付けません。';

  @override
  String get nutritionAboutLocalTitle => 'すべてスマホの中に';

  @override
  String get nutritionAboutLocal =>
      'アプリには写真付きの食品が500以上入っています。自分の食品を追加したり、写真を変えたり、数値を編集したりできます。GymMane の他の部分と同じく、すべてあなたのスマホに残ります。';

  @override
  String get nutritionAboutBetaTitle => 'まだベータ版';

  @override
  String get nutritionAboutBeta =>
      '足りないものがあれば GitHub で提案してください。ただしスキャナーや大きな食品データベースは除きます。プライバシーの問題に加えて、アプリがずっと重くなってしまいます。食事が不要なら、設定でオフにできます。データは残ります。';

  @override
  String get nutritionAboutSuggest => 'アイデアを提案';

  @override
  String get nutritionAboutOk => 'わかった';

  @override
  String get planShare => '共有';

  @override
  String get planImport => 'プランを読み込む';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 件のプランを読み込みました');
    return '$_temp0';
  }

  @override
  String get planImportNone => 'このファイルには食事プランがありません。';

  @override
  String get planMoveUp => '上へ移動';

  @override
  String get planMoveDown => '下へ移動';

  @override
  String get cutoutEdit => '切り抜きを修正';

  @override
  String get cutoutEditHint => 'ドラッグで消したり戻したりできます。範囲をタップすると丸ごと消すか戻します。ピンチで拡大。';

  @override
  String get cutoutErase => '消す';

  @override
  String get cutoutRestore => '戻す';

  @override
  String get cutoutReset => '自動に戻す';

  @override
  String get cutoutByHand => '手で切り抜く';

  @override
  String notifSuppTitleFor(String names) {
    return '飲む時間です：$names';
  }

  @override
  String get notifSuppTap => '飲んだら GymMane でチェックしてください。';

  @override
  String get suppNoneToday => '今日飲むものはありません。';

  @override
  String get suppOtherDays => 'ほかの日';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 日ごと', one: '毎日');
    return '$_temp0';
  }

  @override
  String get suppDaily => '毎日';

  @override
  String suppFromDate(String date) {
    return '$date から';
  }

  @override
  String suppUntilDate(String date) {
    return '$date まで';
  }

  @override
  String get suppSomeDays => '特定の日';

  @override
  String get suppEveryShort => 'X 日ごと';

  @override
  String get suppWhen => 'いつ';

  @override
  String get suppEveryLead => '間隔';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '日ごと');
    return '$_temp0';
  }

  @override
  String get suppStarts => '開始';

  @override
  String get suppEnds => '終了';

  @override
  String get suppTomorrow => '明日';

  @override
  String get suppPickDate => '日付を選ぶ';

  @override
  String get suppNever => 'なし';

  @override
  String get suppOneWeek => '1 週間後';

  @override
  String get suppOneMonth => '1 か月後';

  @override
  String get planPickHint => 'この日のプランを選ぶか、新しく作りましょう。';

  @override
  String planSetForDay(String day) {
    return '$day にプランを設定しました';
  }

  @override
  String get planSaved => 'プランを保存しました';

  @override
  String get planDiscardTitle => '変更を破棄しますか？';

  @override
  String get planDiscardBody => '変更した内容は保存されません。';

  @override
  String get planDiscard => '破棄';

  @override
  String get planEdit => 'プランを編集';

  @override
  String get planNameHint => '夏、旅行…';

  @override
  String get planDaysQuestion => 'どの曜日？';

  @override
  String get planDaysHint => 'その日は食事に表示され、ワンタップで記録できます。';

  @override
  String get planDaysNone => '少なくとも 1 日選んでください。選ばないとどこにも表示されません。';

  @override
  String get planNothingToLog => 'その食事はすでに記録済みです';

  @override
  String get planSave => 'プランを保存';

  @override
  String get planToday => '今日のプラン';

  @override
  String get planLogRest => '残りを記録';

  @override
  String get dishNew => '自分の料理を作る';

  @override
  String get dishNewHint => '材料と量を選んで保存すれば、ワンタップで記録できます。';

  @override
  String get dishEdit => '料理を編集';

  @override
  String get dishNameHint => '例：母のレンズ豆の煮込み';

  @override
  String get dishIngredients => '材料';

  @override
  String get dishEmptyHint => '入っているものを、いつも食べる量で追加しましょう。';

  @override
  String get dishSave => '料理を保存';

  @override
  String get dishNeedsName => '名前を付けてください';

  @override
  String get dishNeedsItems => '材料を 1 つ以上追加してください';

  @override
  String get suppHistory => '過去 14 日';

  @override
  String suppTakenOf(int n, int total) {
    return '$total 回中 $n 回';
  }

  @override
  String get suppNoReminder => 'リマインドなし';

  @override
  String get suppMarkTaken => '飲んだことにする';

  @override
  String get suppUnmark => 'チェックを外す';

  @override
  String get suppEdit => '編集';

  @override
  String get mealMoveTo => '移動先';

  @override
  String get mealClear => '食事を空にする';

  @override
  String get mealCleared => '食事を空にしました';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 品を移動しました');
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => '一日分を繰り返す';

  @override
  String createFoodNamed(String name) {
    return '「$name」を作成';
  }

  @override
  String get entryDay => '日';

  @override
  String get movedToDay => '移動しました';

  @override
  String get favFoodsHint => '食品の ☆ をタップ';

  @override
  String get favFoodsEmpty => '食品の星をタップすると、ここにすぐ呼び出せるよう置いておけます。';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 食');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => '食事の ••• メニューから保存するか、自分の料理を作りましょう。';

  @override
  String get sugarLimitLabel => '糖質の上限';

  @override
  String get sodiumLimitLabel => 'ナトリウムの上限';

  @override
  String get waterOptions => '水分のオプション';

  @override
  String get waterNone => 'まだ水分が記録されていません。';

  @override
  String get waterDailyGoal => '1 日の水分';

  @override
  String get trackersScreen => '画面';

  @override
  String get vesselMotion => '揺れる水とシェイカー';

  @override
  String get vesselMotionHint => '画面が重く感じたらオフにしてください。グラスは満たされたままで、動かなくなるだけです。';

  @override
  String get planFixedWeek => '固定の週';

  @override
  String get planRotation => 'ローテーション';

  @override
  String get rotationTitle => 'ローテーション';

  @override
  String get rotationHint => '曜日に関係なく、前回の次のルーティンが「次」になります。';

  @override
  String get rotationEmpty => 'やる順番にルーティンを追加しよう: A、B、C…';

  @override
  String rotationProgress(int done, int total) {
    return '今回のサイクルで $total 中 $done 完了';
  }

  @override
  String get rotationNext => '次';

  @override
  String get rotationAdd => 'ルーティンを追加';

  @override
  String get rotationPickHint => 'タップした順に並びます。';

  @override
  String get rotationSkip => '次へスキップ';

  @override
  String get rotationRestart => '新しいサイクル';

  @override
  String get rotationMakeNext => '次にする';

  @override
  String get rotationRemove => 'ローテーションから外す';

  @override
  String rotationPlace(int n, int total) {
    return 'ローテーション $n/$total';
  }

  @override
  String get moveToDay => '別の日に移動';

  @override
  String get moveToDayHint => '今回だけ。週間プランはそのままです。';

  @override
  String get movedToast => 'トレーニングを移動しました';

  @override
  String get backToPlan => '週間プランに戻す';

  @override
  String get tomorrow => '明日';

  @override
  String get untrainedTab => '未トレーニング';

  @override
  String get untrainedRecent => '最近';

  @override
  String get untrainedLong => 'だいぶ前';

  @override
  String untrainedWaiting(String list) {
    return 'いちばん間が空いている: $list';
  }

  @override
  String get untrainedAllRecent => '今週はすべての筋肉を鍛えました。いいね。';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n日前',
      one: '昨日トレーニング',
      zero: '今日トレーニング',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'まだ未トレーニング';

  @override
  String get layoutSetting => 'ワークアウトの表示';

  @override
  String get layoutCards => 'カード';

  @override
  String get layoutList => 'リスト';

  @override
  String get layoutHint => 'カードは種目を1つずつ表示。リストはワークアウト全体を1画面にセットごとに表示します。';

  @override
  String get layoutRowHint => '1種目ずつ、または全体をリストで';

  @override
  String get previousCol => '前回';

  @override
  String get usePrevious => '前回の値を使う';

  @override
  String get skipShort => 'スキップ';

  @override
  String get moveUp => '上へ移動';

  @override
  String get moveDown => '下へ移動';

  @override
  String get widgetNutritionOff => 'このウィジェットを使うには、設定 › ベータ で食事をオンにしてください。';

  @override
  String get widgetPickShake => 'シェイクを選ぶ';

  @override
  String get heatRangeSetting => 'アクティビティカレンダー';

  @override
  String get heatRangeWeeks => '12週間';

  @override
  String get heatRangeYear => '12か月';

  @override
  String get heatRangeHint => '12か月は1年分を表示します。横にスワイプすると最初のトレーニングまでさかのぼれます。';

  @override
  String get pdfPlan => 'プランをPDFで';

  @override
  String get pdfPlanHint => '1週間と全ルーティンをまとめたシート。印刷や送信にそのまま使えます。';

  @override
  String get pdfExport => 'PDFで書き出す';

  @override
  String get pdfFooter => '無料・オープンソース・オフライン';

  @override
  String get shakeTag => 'シェイクです';

  @override
  String get shakeTagHint => '「あなたのシェイク」に表示されます';

  @override
  String get shakeNone => 'シェイクに印を付けると、ここにはそれだけが表示されます。';

  @override
  String get shakeMarkLabel => 'シェイクとして印を付ける';

  @override
  String get shakeNew => '新しいシェイク';

  @override
  String get shakeUntag => 'シェイクではない';

  @override
  String get pdfKicker => 'トレーニングプラン';

  @override
  String get pdfStatDays => '日 / 週';

  @override
  String get pdfStatMinutes => '分 / 回';

  @override
  String pdfMinutes(int n) {
    return '約 $n 分';
  }

  @override
  String get workoutNotesTitle => '種目のメモ';

  @override
  String get workoutNoteEvery => '毎回';

  @override
  String get workoutNoteNext => '次回';

  @override
  String get workoutNoteEveryHint => 'この種目をするたびに表示。シートやケーブルの設定に便利。';

  @override
  String get workoutNoteNextHint => '次回だけ表示され、その後は消えます。';

  @override
  String workoutNoteFromLast(String date) {
    return '前回のメモ · $date';
  }

  @override
  String get workoutNoteHint => 'シートは穴2、ケーブルは19…';

  @override
  String get notePinWorkout => 'トレーニング中に表示';

  @override
  String get assistedSetting => 'アシストマシン';

  @override
  String get assistedSettingHint => '重りが補助するので少ないほど上達。記録と提案は下がっていきます。';

  @override
  String get assistedRecordHint => '最小アシスト';

  @override
  String get trainAgainLabel => 'まだトレーニングしていない? もう一度通知';

  @override
  String get trainAgainOff => 'なし';

  @override
  String trainAgainAfter(int n) {
    return '+$n時間';
  }

  @override
  String get trainAgainHint => '1回だけ、その日にまだ記録がない場合のみ。';

  @override
  String get notifTrainAgainBody => '今日のトレーニングにまだ間に合います。';

  @override
  String nextDeload(int n) {
    return '軽めに: $n回続けて全レップ未達';
  }

  @override
  String get historyTitle => '履歴';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 回のトレーニング');
    return '$_temp0';
  }

  @override
  String get historyEmpty => '今月のトレーニングはありません';

  @override
  String get historyEmptyHint => '横にスワイプするか矢印で他の月を表示。';

  @override
  String historyMore(int n) {
    return 'ほか$n件';
  }

  @override
  String get stopwatch => 'ストップウォッチ';

  @override
  String get proteinSource => 'たんぱく源';

  @override
  String get proteinMixedShort => '混合';

  @override
  String get kcalActive => 'アクティブ';

  @override
  String get kcalEstimated => '推定';

  @override
  String get kcalYours => 'あなたの値';

  @override
  String kcalTotalRest(String value) {
    return '安静時の消費を含めて合計 $value';
  }

  @override
  String get inclineLabel => '傾斜';

  @override
  String get kcalUseOwn => '自分の値を使う';

  @override
  String get kcalBackToEstimate => '推定値に戻す';

  @override
  String get kcalNeedsData => '距離と時間を入力するとカロリーを推定します';

  @override
  String get kcalHowEstimated => '距離・時間・傾斜・体重から推定（ACSM式）。';

  @override
  String get kcalOwnTitle => 'アクティブカロリー';

  @override
  String get planMine => 'マイプラン';

  @override
  String get planNew => '新しいプラン';

  @override
  String get planSaveWeek => 'この週を保存';

  @override
  String get planSaveWeekHint => '今の週をいつでも戻れるプランとして保存';

  @override
  String get planEmptyWeek => '空の週から始める';

  @override
  String get planEmptyWeekHint => '今の週はプランとして保存されます';

  @override
  String get planName => 'プラン名';

  @override
  String get planRename => '名前を変更';

  @override
  String get planDelete => 'プランを削除';

  @override
  String get plansHint => '週の変更は選択中のプランに保存されます';

  @override
  String get progression => 'プログレッション';

  @override
  String get progManual => '手動';

  @override
  String get progManualHint => '提案なし：重量は毎回自分で選びます。';

  @override
  String get progLinear => 'リニア';

  @override
  String get progLinearHint => '全レップ達成で重量アップ。';

  @override
  String get progDouble => 'ダブルプログレッション';

  @override
  String get progDoubleHint => 'レンジ上限までレップを増やし、その後重量アップ。';

  @override
  String get progVolume => 'レップ・セット・重量';

  @override
  String get progVolumeHint => '上限までレップ、次にセット追加、最後に重量アップ。';

  @override
  String get progAmrap => 'ラストセットは限界まで';

  @override
  String get progAmrapHint => 'ラストセット：できるだけ多く。目標の2倍なら2段階アップ。';

  @override
  String get progStep => '重量の上げ幅';

  @override
  String get progRange => 'レップ範囲';

  @override
  String get progSets => 'セット';

  @override
  String get progDeload => '軽くするまで';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n回失敗', one: '1回失敗');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => '下げ幅';

  @override
  String get progApply => '次のワークアウトに入力';

  @override
  String get progApplyHint => 'オフなら提案として表示のみ。';

  @override
  String get nextMoreReps => '同じ重量で1レップ多く';

  @override
  String get nextAddSet => '1セット追加';

  @override
  String get nextAmrap => 'ラストセット：できるだけ多く';

  @override
  String fillDay(String amount) {
    return '一日を埋める · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return '残り $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return '残り $kcal、たんぱく質 $grams g';
  }

  @override
  String leftAfterOver(String kcal) {
    return '目標を $kcal 超過';
  }

  @override
  String perDayUnit(String unit) {
    return '1 日 $unit';
  }

  @override
  String get byZone => '部位別';

  @override
  String get importAlreadyHave => 'これらのルーティンはすでにあります。コピーとして追加し直せます。';

  @override
  String get importAsCopy => 'コピーとして追加';

  @override
  String get routineExerciseNote => 'Routine note';

  @override
  String get importRoutineNotes => 'Add missing routine notes';

  @override
  String get routineNotesAdded => 'Routine notes added';

  @override
  String get importOwned => '追加済み';

  @override
  String get setDuplicated => 'セットを複製しました';

  @override
  String get setTypeCluster => 'クラスター';

  @override
  String get setTypeClusterInfo => '1セットを15〜30秒の休憩を挟んだ小さなブロックに分けます。合計回数を記録します。';

  @override
  String timesBodyweight(String value) {
    return '体重の$value倍';
  }

  @override
  String get archiveRoutine => 'ルーティンをアーカイブ';

  @override
  String get routineArchived => 'ルーティンをアーカイブしました';

  @override
  String get archivedRoutines => 'アーカイブ';

  @override
  String get autoBackup => '自動バックアップ';

  @override
  String get autoBackupHint =>
      'すべてのデータを ZIP にして、選んだフォルダに保存します。Nextcloud や Syncthing などの同期アプリでそのフォルダを同期すれば、スマホの外にもコピーを残せます。';

  @override
  String get autoBackupFolder => 'フォルダを選ぶ';

  @override
  String get autoBackupNoFolder => 'フォルダ未選択';

  @override
  String get autoBackupOff => 'オフ';

  @override
  String get autoBackupWorkout => 'トレーニングのたび';

  @override
  String get autoBackupDaily => '1日1回';

  @override
  String get autoBackupWeekly => '週1回';

  @override
  String get autoBackupOnLeave => 'アプリを離れたとき';

  @override
  String get autoBackupKeep => '残す数';

  @override
  String get autoBackupNow => '今すぐバックアップ';

  @override
  String autoBackupLast(String when) {
    return '前回のバックアップ $when';
  }

  @override
  String get autoBackupNever => 'まだバックアップはありません';

  @override
  String get autoBackupLost => '前回のバックアップを保存できませんでした。フォルダを選び直してください。';

  @override
  String get autoBackupSaved => 'バックアップを保存しました';

  @override
  String get prepPortions => '等分';

  @override
  String get rotationAddRest => '休息日を追加';

  @override
  String get rotationRestHint => '翌日に自動で進みます';

  @override
  String get rotationRestToday => '今日';

  @override
  String get rotationSkipRest => 'この休息日をスキップ';

  @override
  String rotationRestUpNext(String name) {
    return '次：$name';
  }

  @override
  String get trainAnyway => 'それでもトレーニング';

  @override
  String get healthTitle => '健康';

  @override
  String get healthSetting => '健康データ';

  @override
  String get healthSettingHint => 'Health Connect のデータを進捗に';

  @override
  String get healthPickTitle => '健康データ';

  @override
  String get healthPickHint =>
      'Health Connect から取り込む項目を選んでください。Android が項目ごとに一度だけ許可を求めます。読み取るだけで、端末の外には出ません。';

  @override
  String get healthGroupHeart => '心臓';

  @override
  String get healthGroupVitals => 'バイタル';

  @override
  String get healthGroupActivity => 'アクティビティ';

  @override
  String get healthRestingHr => '安静時心拍数';

  @override
  String get healthHeartRate => '平均心拍数';

  @override
  String get healthHrv => '心拍変動';

  @override
  String get healthSpo2 => '血中酸素';

  @override
  String get healthRespiration => '呼吸数';

  @override
  String get healthBloodPressure => '血圧';

  @override
  String get healthTemperature => '体温';

  @override
  String get healthSleep => '睡眠';

  @override
  String get healthDistance => '距離';

  @override
  String get healthFloors => '上った階数';

  @override
  String get healthElevation => '獲得標高';

  @override
  String get healthActiveKcal => 'アクティブカロリー';

  @override
  String get healthNoData => 'まだデータがありません';

  @override
  String get healthReadFailed => '読み取れませんでした';

  @override
  String get healthAllow => 'タップして許可';

  @override
  String get healthLast7 => '過去7日間';

  @override
  String get healthAvg30 => '30日平均';

  @override
  String get healthLow => '最低';

  @override
  String get healthHigh => '最高';

  @override
  String get healthFrom => 'Health Connect より · 過去30日間';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => '回/分';

  @override
  String get weekTab => '週';

  @override
  String get muscleSetsList => '筋肉ごとのセット数';

  @override
  String get fatTrans => 'トランス';

  @override
  String get fatTypesHint => '任意。ラベルにない項目は空欄のままで。';

  @override
  String get sessionPhotos => 'トレーニングの写真';

  @override
  String get sessionPhotosAdd => '写真を追加';

  @override
  String get sessionPhotosHint => '「あなたの写真」にも保存されます。';

  @override
  String get ladderTitle => 'プログレッション';

  @override
  String get ladderHint => 'ステップを易しい順に並べます。8回×3セットを2回続けて達成すると（スロー種目は5回）、GymMane が次のステップを提案します。';

  @override
  String get ladderBuiltIn => 'アプリのプログレッションが元になっています。ステップを追加・削除・並べ替えると、このルーティン専用になります。';

  @override
  String get ladderNone => 'まだありません。タップして作成。';

  @override
  String ladderStep(int n, int total) {
    return 'ステップ $n/$total';
  }

  @override
  String get ladderAdd => 'ステップを追加';

  @override
  String get ladderInRoutine => 'ルーティン内';

  @override
  String get ladderClear => 'アプリのものを使う';

  @override
  String get ladderPick => 'ステップを選択';

  @override
  String get periodWeek => '今週';

  @override
  String get periodMonth => '今月';

  @override
  String get periodYear => '今年';

  @override
  String get periodAll => '全期間';

  @override
  String get settingsSearch => '設定を検索';

  @override
  String get settingsNoResults => 'その名前の設定はありません';

  @override
  String get settingsGroupApp => 'あなたのアプリ';

  @override
  String get settingsGroupHome => 'ホームとその他';

  @override
  String get settingsGroupData => 'データとヘルプ';

  @override
  String get healthAllowAll => 'すべてオン';

  @override
  String get healthSeeAll => 'すべて見る';

  @override
  String get healthPinTitle => 'カードに表示';

  @override
  String get healthPinHint => '進捗カードに最大3つまで選べます。';

  @override
  String get blurSetting => 'ぼかし効果';

  @override
  String get blurSettingHint => '動作が重いならオフに';

  @override
  String get lowEndTitle => 'スマホのメモリが少なめです';

  @override
  String get lowEndBody => 'ぼかしをオフにすると動きがなめらかになります。設定→一般でいつでも戻せます。';

  @override
  String get lowEndOff => 'ぼかしをオフ';

  @override
  String get lowEndKeep => 'そのまま';

  @override
  String get momentsThisMonth => '今月';

  @override
  String get momentsDays => '写真のある日';

  @override
  String get awardsPick => 'プロフィール用に選ぶ';

  @override
  String get awardsPickHint => 'プロフィールに表示したいものをタップ';

  @override
  String get gymPassPicture => 'コードの写真を保存';

  @override
  String get gymPassPictureHint => 'アプリが読めないコード用：写真を最大の明るさで表示します';

  @override
  String get gymPassPictureFormat => '写真';

  @override
  String get gymPassUsePicture => '写真を保存';

  @override
  String get gymPassChangePicture => '写真を変更';

  @override
  String get cropTitle => 'コードを切り抜く';

  @override
  String get cropHint => '角をドラッグしてコードだけにします';

  @override
  String get rotatePhoto => '回転';

  @override
  String get cardioNoSets => '有酸素は部位ごとの週間セット数に入りません';

  @override
  String get countsAsWater => '水分に数える';

  @override
  String get countsAsWaterHint => '水で作るシェイク向け：記録すると水分にも加算されます';

  @override
  String get waterPerServing => '1 杯あたりの水';

  @override
  String get estOneRm => '推定1RM';

  @override
  String get newInWorkout => 'この回の追加種目';

  @override
  String newInWorkoutHint(String routine) {
    return '今やったセットのまま$routineに追加します。ほかの内容は変わりません。';
  }

  @override
  String get addedToRoutine => '追加しました';

  @override
  String get addShort => '追加';

  @override
  String get allTimeLifted => '総挙上量';

  @override
  String get pctBodyweight => '体重比';

  @override
  String get ofBodyweight => '体重に対して';

  @override
  String get recoveryStateMid => '回復中';

  @override
  String get recoveryStateReady => '準備OK';

  @override
  String recoveringIn(String time) {
    return '$timeで回復中に';
  }

  @override
  String readyIn(String time) {
    return '$timeで準備OK';
  }

  @override
  String get recoveryReadyNow => 'また鍛えられます';

  @override
  String get restAfterThisSet => 'このセット後の休憩';

  @override
  String restUsual(String time) {
    return 'いつも: $time';
  }

  @override
  String get restJustToday => '今日のこのセットだけ';

  @override
  String get restUseUsual => 'いつもの休憩に戻す';

  @override
  String get restChange => '変更';

  @override
  String get noRestTimer => 'タイマーなし';

  @override
  String get sessionMuscles => 'この回の筋肉';

  @override
  String get sessionMusclesHint => '薄い所はこれから、濃い所は済み。部位ごとのセット数、補助筋は半分で計算。';

  @override
  String get miniBodySetting => 'ルーティンに小さな筋肉マップ';

  @override
  String get miniBodySettingHint => '各ルーティンの筋肉';

  @override
  String get balanceTitle => '筋力バランス';

  @override
  String get balanceWhy => '仕組み';

  @override
  String get balanceGood => '基本種目のバランスは良好です';

  @override
  String balanceBehind(String lift, String gap) {
    return '$liftが遅れています: あと約$gap';
  }

  @override
  String get balanceHint =>
      '直近4か月の推定1RMを定番の比率と比べます: スクワット100%、デッドリフト120%、ベンチ75%、ロウ52%、ショルダープレス45%。ほかより大きく低い種目はたいてい弱点です。';

  @override
  String get balanceEven => 'バランス良好';

  @override
  String get balanceBehindShort => '遅れ';

  @override
  String get balanceAheadShort => '先行';

  @override
  String get holdProgress => '時間で進歩';

  @override
  String get holdProgressHint => '全セットをキープしたら秒数を追加';

  @override
  String holdProgressOn(int s) {
    return '全セットをキープするたびに+$s秒';
  }

  @override
  String get paceTitle => '週ペース';

  @override
  String get paceOn => '順調';

  @override
  String get paceTooFast => '設定した範囲より速い';

  @override
  String get paceTooSlow => '設定した範囲より遅い';

  @override
  String get paceWrongWay => '逆方向です';

  @override
  String get paceDrifting => '維持にしては動きが大きい';

  @override
  String get paceSetAim => 'タップして目標を設定';

  @override
  String get paceBasis => '直近3週間の体重の傾向。塩辛い夕食にだまされません。';

  @override
  String get paceAimTitle => '目標は?';

  @override
  String get paceAimHint => 'カードで週ペースが合っているか分かります';

  @override
  String get paceLose => '減量';

  @override
  String get paceHold => '維持';

  @override
  String get paceGain => '増量';

  @override
  String get paceAuto => '自動';

  @override
  String get paceLoseRange => '週に体重の0.5〜1%';

  @override
  String get paceHoldRange => '週0.25%以内';

  @override
  String get paceGainRange => '週に体重の0.25〜0.5%';

  @override
  String get paceAutoHint => '目標体重から';

  @override
  String get weekShort => '週';

  @override
  String get weightStack => 'ウェイトスタック';

  @override
  String get weightStackHint => 'このマシンの実際の重さ。+と−、進歩、ディロードはこの値だけに合わせます。';

  @override
  String get weightStackOff => 'オフ: 通常の刻み';

  @override
  String get stackFrom => 'から';

  @override
  String get stackTo => 'まで';

  @override
  String get stackEvery => 'ごと';

  @override
  String get stackFill => 'スタックを埋める';

  @override
  String get stackTapToFix => '半端な重さを直す・消すにはタップ。';

  @override
  String get stackAddWeight => '重さを追加';

  @override
  String get stackEditWeight => 'ピンの重さ';

  @override
  String get stackClear => 'スタックを削除';

  @override
  String stackCount(int n) {
    return '$n段';
  }

  @override
  String get healthLinksTitle => 'トレーニングと連携';

  @override
  String get healthLinkHeart => '時計の心拍数';

  @override
  String get healthLinkHeartHint => '記録した時計に関係なく、各トレーニングの平均・最大心拍数';

  @override
  String get healthLinkWeight => 'ほかのアプリの体重';

  @override
  String get healthLinkWeightHint => '体重計の直近30日の記録。自分で入力した値は上書きしません。';

  @override
  String get healthLinkDenied => 'Health Connectの許可がありません';

  @override
  String get healthOpenSettings => '開く';

  @override
  String hrMaxShort(int bpm) {
    return '最大$bpm';
  }

  @override
  String get setNote => 'このセットのメモ';

  @override
  String get setNoteHint => 'グリップ、痛み、効いたコツ…';

  @override
  String setNoteLast(String note) {
    return '前回: $note';
  }

  @override
  String get lastTimeNotes => '前回';

  @override
  String setNoteLine(int n, String note) {
    return 'セット$n · $note';
  }

  @override
  String get newMeasure => '新しい計測';

  @override
  String get newMeasureHint => '記録したいもの: 手首、安静時心拍、体水分…';

  @override
  String get measureKindLength => '長さ';

  @override
  String get measureKindLengthHint => 'ほかと同じくcmかインチ';

  @override
  String get measureKindOther => 'その他';

  @override
  String get measureKindOtherHint => '自分の単位で';

  @override
  String get measureUnit => '単位';

  @override
  String get measureUnitHint => 'mm、bpm、kg…';

  @override
  String get measureNameHint => '手首、安静時心拍…';

  @override
  String get measureRename => '名前を変更';

  @override
  String measureDeleteTitle(String name) {
    return '$nameを削除しますか?';
  }

  @override
  String get measureDeleteBody => '記録した値もすべて削除されます。';

  @override
  String get measureDelete => 'この計測を削除';

  @override
  String get measureEvery => '計測をリマインド';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日後', one: '明日', zero: '今日');
    return '$_temp0';
  }

  @override
  String get measureDueNow => '計測のタイミング';

  @override
  String get notifMeasureChannel => '体の計測';

  @override
  String get notifMeasureChannelWhy => 'また計測する時にお知らせします。';

  @override
  String get notifMeasureTitle => '計測の時間です';

  @override
  String notifMeasureBody(int n) {
    return '前回から$n日。同じ場所、同じ時間帯で。';
  }

  @override
  String get healthLinkWrite => 'トレーニングを保存';

  @override
  String get healthLinkWriteHint => '終えたトレーニングを時間と種類つきでHealth Connectに送り、ほかのアプリでも反映されます。直近30日分も送ります。';

  @override
  String get healthWorkoutTitle => 'トレーニング';

  @override
  String get circuits => 'タイマーサーキット';

  @override
  String get circuitsHint => '時間で動いて休む、ラウンドごとに';

  @override
  String get newCircuit => '新しいサーキット';

  @override
  String get editCircuit => 'サーキットを編集';

  @override
  String get circuitDefaultName => 'サーキット';

  @override
  String get circuitNameHint => '名前(例: 体幹フィニッシャー)';

  @override
  String get circuitRounds => 'ラウンド';

  @override
  String get circuitRoundRest => 'ラウンド間の休憩';

  @override
  String get circuitWork => 'ワーク';

  @override
  String get circuitRest => '休憩';

  @override
  String get circuitAdd => '種目を追加';

  @override
  String get circuitEmpty => '行う順番に種目を追加しましょう。サイドプランクの左右のように、同じ種目を2回入れてもOK。';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(steps, locale: localeName, other: '$steps種目');
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$roundsラウンド');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'スタート';

  @override
  String get circuitGetReady => '準備して';

  @override
  String circuitRoundOf(int n, int total) {
    return 'ラウンド $n/$total';
  }

  @override
  String circuitNext(String name) {
    return '次: $name';
  }

  @override
  String get circuitFinishLine => 'これで最後';

  @override
  String get circuitDone => 'サーキット完了';

  @override
  String circuitDoneBody(String time) {
    return '$time · 履歴に保存しました';
  }

  @override
  String get circuitStopTitle => 'サーキットを止めますか?';

  @override
  String get circuitStopBody => 'ここまでの分は履歴に保存されます。';

  @override
  String get circuitStop => '止める';

  @override
  String get circuitKeepGoing => '続ける';

  @override
  String circuitDeleteTitle(String name) {
    return '$nameを削除しますか?';
  }

  @override
  String get circuitDeleteBody => 'これで行ったトレーニングは履歴に残ります。';

  @override
  String get circuitPickExercise => '種目を選ぶ';

  @override
  String get circuitNoSteps => '種目を1つ以上追加してください';

  @override
  String get circuitPrevious => '前へ';

  @override
  String get circuitUpNext => '次はこれ';

  @override
  String get foodGroupNew => '新しいカテゴリー';

  @override
  String get foodGroupHint => '調理済み、冷凍…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 品', zero: 'まだ食品がありません');
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return '$name を削除しますか？';
  }

  @override
  String get foodGroupDeleteBody => '食品は残ります。このカテゴリーがなくなるだけです。';

  @override
  String onbHello(String name) {
    return 'こんにちは、$name';
  }

  @override
  String get onbPlaceHero => 'できる種目';

  @override
  String get settingsRests => '休憩';

  @override
  String get settingsDuring => 'トレーニング中';

  @override
  String get settingsLook => '表示';

  @override
  String get importCardTitle => 'ワークアウトをここに移そう';

  @override
  String get importCardBody => 'Hevy、Strong、FitNotes などから';

  @override
  String get checkInTitle => '調子はどうだった？';

  @override
  String get checkInSleep => '睡眠';

  @override
  String get checkInEnergy => 'エネルギー';

  @override
  String get checkInSkip => '任意';

  @override
  String get checkInLevel1 => '最悪';

  @override
  String get checkInLevel2 => 'いまいち';

  @override
  String get checkInLevel3 => '普通';

  @override
  String get checkInLevel4 => '良い';

  @override
  String get checkInLevel5 => '最高';

  @override
  String get checkInSetting => '睡眠とエネルギー';

  @override
  String get checkInSettingHint => 'トレーニング終了時に聞く';

  @override
  String get readinessTitle => '睡眠とエネルギー';

  @override
  String get readinessWaiting => 'トレーニングの評価を続けよう';

  @override
  String get readinessWaitingHint => '調子の良い日と悪い日が何日かあると、重量への影響が見えてきます。';

  @override
  String readinessSleepLess(int n) {
    return '睡眠不足の日は$n%軽くなります';
  }

  @override
  String readinessSleepMore(int n) {
    return '面白いことに、睡眠不足の日は$n%重く挙げています';
  }

  @override
  String get readinessSleepNone => '睡眠は重量にほとんど影響しません';

  @override
  String readinessEnergyLess(int n) {
    return 'エネルギーが低い日は$n%軽くなります';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'エネルギーが低い日でも$n%重く挙げています';
  }

  @override
  String get readinessEnergyNone => 'エネルギーは重量にほとんど影響しません';

  @override
  String get readinessHint => '推定1RMを直前90日間のベストと比べます。';

  @override
  String get readinessLast30 => '直近30日の平均';

  @override
  String get kindSport => 'スポーツ';

  @override
  String get clearWorkouts => 'トレーニングだけ削除';

  @override
  String get clearWorkoutsNone => '削除するトレーニングはありません';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n件のトレーニングを削除しますか？');
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      '履歴、記録、メダルが消えます。ルーティン、種目、写真、測定、栄養、設定は残ります。戻したくなるかもしれないなら、先にバックアップを書き出してください。';

  @override
  String get clearWorkoutsConfirm => 'トレーニングを削除';

  @override
  String get clearWorkoutsDone => 'トレーニングを削除しました';

  @override
  String get reportTitle => 'レポート';

  @override
  String get reportHint => '日付を選んでPDFかCSVで共有';

  @override
  String get reportCustom => 'その他';

  @override
  String get reportPickRange => '日付を選ぶ';

  @override
  String get reportEmpty => 'この期間には記録がありません。';

  @override
  String get reportKicker => 'トレーニングレポート';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'トレーニング';

  @override
  String get reportPerWeek => '週あたり';

  @override
  String get reportHours => '時間';

  @override
  String get reportVsPrev => '割合は直前の同じ日数と比べています。';

  @override
  String get reportRecords => '新記録';

  @override
  String get reportLifts => '種目';

  @override
  String get reportSessionsCol => '日数';

  @override
  String get reportBestCol => 'ベスト1RM';

  @override
  String get reportChangeCol => '変化';

  @override
  String get reportBestHint => 'ベスト1RMはセットから推定します。変化はこのレポート内の種目の最初と最後の日を比べます。';

  @override
  String get reportMuscles => '部位ごとのセット';

  @override
  String get reportBody => '体と回復';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '栄養 · $n日の平均');
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '新記録$n件');
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n種目');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '1日$kcal・たんぱく質$protein g · 記録$days日';
  }

  @override
  String get reportSharePdf => 'PDFを共有';

  @override
  String get reportShareCsv => 'CSVを書き出す';

  @override
  String get reportChooseCsv => 'Choose which CSV files to share.';

  @override
  String get reportWeighIns => 'Weigh-ins';

  @override
  String get reportSessionDetails => 'Workout session details';

  @override
  String get reportShareCsvBoth => 'CSVを書き出す（トレーニングと栄養）';

  @override
  String fastMinutes(int n) {
    return '$n 分';
  }

  @override
  String fastHours(int n) {
    return '$n 時間';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h 時間 $m 分';
  }

  @override
  String get fastTracker => '断続的ファスティング';

  @override
  String fastTitle(int fast, int eat) {
    return 'ファスティング $fast:$eat';
  }

  @override
  String get fastOptions => 'ファスティングのオプション';

  @override
  String get fastWindowOpen => '食事の時間です';

  @override
  String get fastLeft => '残り';

  @override
  String get fastDoneLabel => '目標達成';

  @override
  String get fastIdle => '最後の食事のあとに始めましょう';

  @override
  String fastLast(String time) {
    return '前回のファスティング：$time';
  }

  @override
  String fastStreak(int n) {
    return '$n 回連続';
  }

  @override
  String fastReached(String time) {
    return '目標より $time 長く';
  }

  @override
  String fastEndsAt(String time) {
    return '$time に終了';
  }

  @override
  String fastSince(String time) {
    return '$time から';
  }

  @override
  String get fastStartedAt => 'ファスティングはいつ始めましたか？';

  @override
  String get fastStart => 'ファスティングを開始';

  @override
  String fastFromMeal(String time) {
    return '$time から';
  }

  @override
  String get fastEnd => 'ファスティングを終了';

  @override
  String get fastCancel => 'このファスティングを取り消す';

  @override
  String get fastPlan => 'ファスティングプラン';

  @override
  String get fastPlanHint => '断食時間 : 食事時間';

  @override
  String get fastThisWeek => '過去 7 日';

  @override
  String get fastCount => '回数';

  @override
  String get fastReachedCount => '達成';

  @override
  String get fastAverage => '平均';

  @override
  String get fastHistory => '最近のファスティング';

  @override
  String get notifFastLiveChannel => 'ファスティング中';

  @override
  String get notifFastLiveChannelWhy => 'ファスティング中の静かなカウントダウン。';

  @override
  String get notifFastChannel => 'ファスティング';

  @override
  String get notifFastChannelWhy => 'ファスティングが終わったらお知らせします。';

  @override
  String get notifFastLiveTitle => 'ファスティング中';

  @override
  String notifFastLiveBody(String time) {
    return '$time から食事できます';
  }

  @override
  String get notifFastDoneTitle => 'ファスティング完了';

  @override
  String notifFastDoneBody(int n) {
    return '$n 時間。食事の時間です。';
  }

  @override
  String get newExerciseHint => '必須なのは名前だけ。ほかは後から追加できます。';

  @override
  String get supportThanksTitle => '使ってくれてありがとう 🤍';

  @override
  String get supportThanksBody =>
      'GymMane はずっと無料です。広告も隠れた課金もありません。\n\nトレーニングの役に立っていたら、コーヒーをおごってもらえるとうれしいです ☕\n難しければ大丈夫。GitHub のスターでも十分うれしいです ⭐';

  @override
  String get perfSetting => 'パフォーマンス';

  @override
  String get perfSheetHint => 'GymMane がスマホの性能をどれだけ使うか。下でそれぞれ変更できます。';

  @override
  String get perfLite => '省エネ';

  @override
  String get perfLiteHint => 'ぼかしなし、動きも控えめ。動作が重いスマホ向け。';

  @override
  String get perfBalanced => 'バランス';

  @override
  String get perfBalancedHint => 'バッテリーを消耗しすぎずに、ぼかしとアニメーションを。';

  @override
  String get perfMax => '最大';

  @override
  String perfMaxHint(int hz) {
    return 'より細かいぼかしと $hz Hz の画面。ハイエンドのスマホ向け。';
  }

  @override
  String get perfMaxHintNoHz => 'すべてでより細かいぼかし。ハイエンドのスマホ向け。';

  @override
  String get perfCustom => 'カスタム';

  @override
  String get perfTweak => '細かい調整';

  @override
  String get perfFine => '細かいぼかし';

  @override
  String get perfFineHint => 'パネルの奥がより柔らかな縁と鮮明な背景に';

  @override
  String perfHz(int hz) {
    return '$hz Hz の画面';
  }

  @override
  String get perfHzHint => 'すべてがなめらかにスクロール。バッテリーは少し多めに使います';

  @override
  String get lowEndLiteBody => '省エネモード（ぼかしなし、控えめな動き）のほうがなめらかに動きます。設定 → 一般 → パフォーマンス で変更できます。';

  @override
  String get lowEndLiteOn => '省エネをオンにする';

  @override
  String get dayOffHint => '連続記録とリマインドはこの日をそっとしておきます';

  @override
  String get dayOffTrained => 'トレーニングしたけど記録していない';

  @override
  String get dayOffSick => '体調不良';

  @override
  String get dayOffTravel => '旅行';

  @override
  String get dayOffInjury => 'けが';

  @override
  String get dayOffRest => '休養';

  @override
  String get altsTitle => '代わりの種目';

  @override
  String get altsHint => 'マシンが使われているとき用';

  @override
  String altsPickHint(int count) {
    return '$count 個まで選べます。マシンが空いていなければワンタップで入れ替え。';
  }

  @override
  String get placeDumbbells => 'ダンベル';

  @override
  String get dumbbellsHint => 'ダンベル 1 個の重さ。ここではプログレッションと + − ボタンがこの値にだけ合わせます。';

  @override
  String get dumbbellOther => 'ほかの重さ';

  @override
  String get tuneTitle => '今日のボリューム';

  @override
  String get tuneHint => '各筋肉の感触を教えてください。次回のセット数を調整します。';

  @override
  String get tuneLess => '少なすぎ';

  @override
  String get tuneRight => 'ちょうどいい';

  @override
  String get tuneMore => '多すぎ';

  @override
  String tuneNext(String sets, String name) {
    return '次回：$name を $sets';
  }

  @override
  String get tuneSame => '次回も同じ';

  @override
  String get tuneSetting => '筋肉ごとにセット数を調整';

  @override
  String get tuneSettingHint => 'ルーティンのあとに各筋肉を評価すると、セット数が調整されます';

  @override
  String insightLoad(int pct) {
    return 'いつもの週よりセット数が $pct % 多めです。回復に気をつけて。';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle：$days 日間トレーニングしていません。';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return '引くより押すほうが多いです：4 週間で $a セット対 $b セット。';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return '押すより引くほうが多いです：4 週間で $a セット対 $b セット。';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name：先月より $pct % 強く。';
  }

  @override
  String recapPull(String month) {
    return '引き続き引っぱって$monthを見る';
  }

  @override
  String get recapRelease => '離して';

  @override
  String recapHi(String name) {
    return 'こんにちは、$name';
  }

  @override
  String recapReady(String month) {
    return '$monthの成果を見てみよう';
  }

  @override
  String get recapGo => '見る';

  @override
  String recapEmpty(String month) {
    return '$monthのワークアウトはまだありません。最初の1回で開きます。';
  }

  @override
  String get recapClose => '閉じる';

  @override
  String get recapShare => '共有';

  @override
  String get recapWorkoutsKicker => '今月のトレーニング';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '回');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日間', one: '1日だけ');
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'バーの下にいた時間';

  @override
  String recapLongest(String time, String date) {
    return '最長セッション: $date、$time';
  }

  @override
  String get recapVolumeKicker => '動かした重量';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '車$count台を持ち上げたのと同じ',
      one: '車1台を持ち上げたのと同じ',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return '最多: $name、$volume';
  }

  @override
  String get recapMuscleKicker => '今月の筋肉';

  @override
  String get recapRecordsKicker => '新記録';

  @override
  String recapNoRecords(int n) {
    return '今回は記録なし。でも$nセットを積み上げました。';
  }

  @override
  String get recapHabitKicker => 'あなたの時間';

  @override
  String recapHabitStart(String time) {
    return 'いつも$time頃に始めています';
  }

  @override
  String get recapShareKicker => 'あなたの1か月、シェアの準備完了';

  @override
  String get recapTickWorkouts => 'ワークアウト';

  @override
  String get recapTickTime => '時間';

  @override
  String get recapTickVolume => '重量';

  @override
  String get recapTickRecords => '記録';

  @override
  String recapAvg(int n) {
    return '1回あたり平均$n分';
  }

  @override
  String get recapLiftKicker => '今月の種目';

  @override
  String get recapBest => 'ベスト';

  @override
  String get recapTimes => '日数';

  @override
  String get recapDaysLabel => '日数';

  @override
  String get recapAvgLabel => '平均';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$days日で$workouts回';
  }

  @override
  String get recapFavLabel => 'あなたの曜日';

  @override
  String get recapWatermark => '無料のジム記録';

  @override
  String get recapTickSteps => '歩数';

  @override
  String get recapTickFood => '食事';

  @override
  String get recapCardioKicker => '有酸素';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n回で', one: '1回で');
    return '$_temp0$minutes分';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '有酸素$n回');
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return '定番: $name';
  }

  @override
  String get recapStepsKicker => '歩いた歩数';

  @override
  String get recapStepsWord => '歩';

  @override
  String recapStepsAvg(String value) {
    return '1日平均$value';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'ベストな日: $date、$value';
  }

  @override
  String get recapFoodKicker => 'あなたのお皿';

  @override
  String get recapLiftRest => '続いて';

  @override
  String recapSameAs(String month) {
    return '$monthと同じ';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$monthより$value多い';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$monthより$value少ない';
  }

  @override
  String get recapTickMedals => 'メダル';

  @override
  String get recapTickSleep => '睡眠';

  @override
  String get recapMedalsKicker => '獲得したメダル';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ほか$n個');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => '睡眠時間';

  @override
  String get recapSleepAvg => '1晩あたりの平均';

  @override
  String recapSleepBest(String value, String date) {
    return 'ベストな夜: $date、$value';
  }

  @override
  String get recapCardSummary => 'まとめ';

  @override
  String get recapCardCalendar => 'カレンダー';

  @override
  String get recapCardLift => '種目';

  @override
  String get recapPeakKicker => 'いちばんきつかったセッション';

  @override
  String get recapTickPeak => 'セッション';

  @override
  String get recapFreshKicker => '今月はじめて';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '新しい種目');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => '新規';

  @override
  String recapStreak(int n) {
    return '$n日連続、最長の記録';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n回');
    return '1年前: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return '今月できなかった部位: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return '1日のたんぱく質 · 目標 $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日お皿に');
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'たんぱく質 · g/日';

  @override
  String get recapFoodGoalDays => '目標達成';

  @override
  String get recapFoodWaterLabel => '水/日';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => '今月の食べ物';

  @override
  String get onbSpeedTitle => 'なめらかに動かそう';

  @override
  String get onbSpeedWhy => 'スマホが頑張りすぎているようです。これらをオフにすると全体がなめらかになります。試してプレビューを見てください。';

  @override
  String get onbSpeedMotion => 'アニメーション';

  @override
  String get onbSpeedBlurHint => 'パネルやバーの奥のすりガラス';

  @override
  String get onbSpeedMotionHint => 'スライドして出てくる画面やパネル';

  @override
  String get onbSpeedLater => '設定 › 一般 › パフォーマンス でいつでも変更できます。';

  @override
  String get notifSoundSetting => '通知音';

  @override
  String get notifSoundRowHint => 'リマインドの種類ごとの音';

  @override
  String get notifSoundHint => 'リマインドの種類ごとに音を選びます。「スマホから」でスマホの音を開けます。多くのスマホではそこに好きな曲も追加できます。';

  @override
  String get notifSoundTrain => 'トレーニング';

  @override
  String get notifSoundFood => '食事、サプリ、ファスティング';

  @override
  String get notifSoundOther => '写真と測定';

  @override
  String get notifSoundNormal => '標準';

  @override
  String get notifSoundPhone => 'スマホから';

  @override
  String get notifSoundSilent => '無音';

  @override
  String get notifSoundPhoneHint => 'タップで試聴できます。すぐに保存されます。';

  @override
  String get notifSoundMore => 'ほかのファイル…';

  @override
  String get notifSoundChange => '変更';

  @override
  String get workoutNoteAdd => '固定メモ：シート、グリップ、マシン…';

  @override
  String get autoProgressSetting => '自動プログレッション';

  @override
  String get autoProgressRowHint => '次回に提案する内容';

  @override
  String get autoProgressOff => 'オフ';

  @override
  String get autoProgressWeight => '重量を増やす';

  @override
  String get autoProgressReps => '回数を増やす';

  @override
  String get autoProgressHint =>
      'トレーニングを始めると、GymMane が各種目の次のステップを入力します。「回数を増やす」では 12 回までセットごとに 1 回ずつ増やし、その後重量を上げて 8 回から再スタートします。各種目はそれぞれのページで調整できます。';

  @override
  String get noteFolders => 'フォルダー';

  @override
  String get noteFolderNew => '新しいフォルダー';

  @override
  String get noteFolderEdit => 'フォルダーを編集';

  @override
  String get noteFolderName => 'フォルダー名';

  @override
  String get noteFolderLabel => 'フォルダー';

  @override
  String get noteFolderNone => 'フォルダーなし';

  @override
  String get noteFolderDelete => 'フォルダーを削除しますか？';

  @override
  String get noteFolderDeleteBody => 'メモは残ります。フォルダーから出るだけです。';

  @override
  String get foodArchivedToast => '食品をアーカイブしました';

  @override
  String get planArchivedToast => 'プランをアーカイブしました';

  @override
  String get suppArchivedToast => 'サプリをアーカイブしました';

  @override
  String get voiceSetting => 'トレーニング音声';

  @override
  String get voiceSettingHint => 'スマホの音声で次のセットを読み上げ、休憩の終わりをカウントダウンします';

  @override
  String get voiceHello => '音声オン';

  @override
  String voiceRest(String time) {
    return '休憩 $time。';
  }

  @override
  String voiceNext(String name, String load) {
    return '次は $name、$load。';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$weight で $reps 回';
  }

  @override
  String voiceReps(int reps) {
    return '$reps 回';
  }

  @override
  String get voiceGo => 'いきましょう！';

  @override
  String get deloadSetting => 'ディロード週';

  @override
  String get deloadOff => 'なし';

  @override
  String deloadEvery(int weeks) {
    return '$weeks 週ごと';
  }

  @override
  String get deloadHint => '数週ごとに回復のための軽い週を：セット数は半分、重量は 10 % 減。その週はプログレッションに数えません。';

  @override
  String get deloadRowHint => '数週ごとに軽い週';

  @override
  String get deloadNow => 'ディロード週';

  @override
  String get deloadNowHint => '今日はセット数半分、重量 10 % 減';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks 週間後',
      one: '来週',
      zero: '今週',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'いつもどおりトレーニング';

  @override
  String get voiceSheetTitle => '音声のしくみ';

  @override
  String get voicePointRest => 'セットをチェックすると、休憩時間と次にやることを教えてくれます。';

  @override
  String get voicePointCount => '休憩の終わりに 3、2、1 と数えて呼び戻します。';

  @override
  String get voicePointPhone => 'スマホの音声を使い、音楽の上で再生されます。';

  @override
  String get voiceTry => '音声を試す';

  @override
  String get voiceNoEngine => 'スマホで音声エンジンがオンになっていません。';

  @override
  String get voiceNoLang => 'あなたの言語の音声がありません。スマホの音声設定でダウンロードしてください。';

  @override
  String get voiceOpenSettings => '音声の設定';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 分');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count 秒');
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'と';

  @override
  String get repRecordsTitle => '回数別のベスト重量';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'カプセル');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '錠');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'スクープ');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '滴');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '回分');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => '残量';

  @override
  String get suppLeftHint => '任意';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'あと $n 日分');
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 日分');
    return '$_temp0';
  }

  @override
  String get suppRanOut => '切れました';

  @override
  String get lightSession => '軽めのセッション';

  @override
  String get lightSessionHint => '履歴と統計には残りますが、次の目標は変わりません。';

  @override
  String get lightSessionNote => 'プログレッションに数えません';

  @override
  String get lightSessionOff => 'オフにする';

  @override
  String get eachSideRepsHint => '左右の回数を別々に記録します。プログレッションは弱いほうに合わせます。';

  @override
  String get repsLeftCol => '回数 左';

  @override
  String get repsRightCol => '回数 右';

  @override
  String get repsLeftTitle => '左の回数';

  @override
  String get repsRightTitle => '右の回数';

  @override
  String sidesReps(int l, int r) {
    return '左$l 右$r';
  }

  @override
  String get progSchemeTitle => '重量のプログレッション';

  @override
  String get groupMoveUp => 'グループを上へ';

  @override
  String get groupMoveDown => 'グループを下へ';

  @override
  String get mealAiRow => 'AI に聞く';

  @override
  String get mealAiRowHint => '依頼文をコピーして、答えを貼り付け';

  @override
  String get mealAiTitle => 'AI で食事';

  @override
  String get mealAiSubtitle => 'どのチャットボットでも使えます。アプリはオフラインのままです。';

  @override
  String get mealAiStepAsk => '聞く';

  @override
  String get mealAiStepPaste => '貼り付け';

  @override
  String get mealAiWholeDay => '一日分';

  @override
  String get mealAiTarget => '目標';

  @override
  String mealAiLeft(String kcal, int protein) {
    return '今日は残り $kcal、たんぱく質 $protein g です';
  }

  @override
  String get mealAiStyle => '好み';

  @override
  String get mealAiTagProtein => '高たんぱく';

  @override
  String get mealAiTagVeggie => 'ベジタリアン';

  @override
  String get mealAiTagVegan => 'ヴィーガン';

  @override
  String get mealAiTagNoGluten => 'グルテンフリー';

  @override
  String get mealAiTagNoLactose => '乳糖不使用';

  @override
  String get mealAiTagQuick => '手早く';

  @override
  String get mealAiTagNoCook => '調理なし';

  @override
  String get mealAiTagCheap => '節約';

  @override
  String get mealAiNotesHint => '家にあるもの… 苦手なもの… アレルギー…';

  @override
  String get mealAiOptions => '候補';

  @override
  String get mealAiCopy => '依頼文をコピー';

  @override
  String get mealAiCopied => '依頼文をコピーしました';

  @override
  String get mealAiCopiedHint => 'AI に貼り付けて、答えを持ってここに戻ってきてください';

  @override
  String get mealAiShowText => '依頼文を見る';

  @override
  String get mealAiHideText => '依頼文を隠す';

  @override
  String get mealAiPasteHint => 'AI の答えをここに貼り付け';

  @override
  String get mealAiReview => '答えを確認';

  @override
  String get mealAiUnreadable => 'そのテキストから食品が見つかりませんでした';

  @override
  String get mealAiUnreadableHint => '依頼文の形式どおり、JSON だけを 1 つのコードブロックで送るよう AI に頼んでください。';

  @override
  String get mealAiCopyFix => 'その文をコピー';

  @override
  String mealAiOption(int n) {
    return '候補 $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return '$meal に追加';
  }

  @override
  String get mealAiAddDay => '今日に追加';

  @override
  String get mealAiAddPick => '追加';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 品を追加しました');
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'レシピとして保存';

  @override
  String get mealAiSavePlan => 'プランとして保存';

  @override
  String get mealAiRecipeSaved => 'レシピを保存しました';

  @override
  String get mealAiPlanSaved => 'プランを保存しました';

  @override
  String get mealAiFlagEstimated => 'AI による推定';

  @override
  String get mealAiFlagAdjusted => 'マクロに合わせてカロリーを修正';

  @override
  String get mealAiFlagDoubtful => '数値が合いません、確認を';

  @override
  String get mealAiFlagNoValues => '栄養値なし';

  @override
  String get mealAiFlagNoAmount => '量の記載なし';

  @override
  String get mealAiTruncated => '答えが途中で切れているようです。完全な食品だけ残しました。';

  @override
  String get mealAiAmount => '量';

  @override
  String mealAiTargetLine(String kcal) {
    return '目標 $kcal';
  }

  @override
  String get mealAiNothingChosen => '少なくとも 1 品をオンにしてください';

  @override
  String get cholesterolLabel => 'コレステロール';

  @override
  String get mealAiFlagMatched => '保存した食品と同じ';

  @override
  String get mealAiNotSame => '同じではない';

  @override
  String get homeOrderRow => 'セクションの並び順';

  @override
  String get homeOrderHint => '長押ししてドラッグすると、ホームの並び順を変えられます。';

  @override
  String get homeOrderFolders => 'ショートカット';

  @override
  String get equipNew => '新規';

  @override
  String get equipNewTitle => '新しい器具';

  @override
  String get equipNewHint => '例：トレーニングベルト';

  @override
  String get homeOrderWeekdays => '週のチェック';

  @override
  String get repsMaxTitle => '回数の上限';

  @override
  String get repsRangeHint => '回数を長押しすると 8-12 のような範囲を設定できます。';

  @override
  String get repsRangeClear => '範囲を外す';

  @override
  String get noteLinksLabel => 'リンク';

  @override
  String get noteLinkAdd => 'リンクを追加';

  @override
  String get noteLinkEdit => 'リンクを編集';

  @override
  String get noteLinkNameHint => '名前';

  @override
  String get noteLinkUrlHint => 'ウェブアドレス';

  @override
  String get noteLinkInvalid => 'そのアドレスは正しくないようです';

  @override
  String get changeRest => '種目間の休憩';

  @override
  String get changeRestHint => '最後のセットのあと、次の種目の前';

  @override
  String get notifSuppTake => '飲んだ';

  @override
  String get sideRest => '左右の間の休憩';

  @override
  String get sideRestHint => '片側ずつの種目：最初の ✓ で片側が終わります';

  @override
  String get gfxCompat => '互換グラフィック';

  @override
  String get gfxCompatHint => '文字が崩れて見えるスマホ向け。ぼかしはそのまま、一部の効果がシンプルになります';

  @override
  String get gfxRestartTitle => 'GymMane を再起動しますか？';

  @override
  String get gfxRestartBody => '画面の描き方を変えるため、いったん閉じてまた開きます。保存した内容は失われません。';

  @override
  String get gfxRestart => '再起動';

  @override
  String get webSynced => '別のデバイスの変更で更新しました';

  @override
  String get webSyncedPhone => 'スマホの変更が届きました';

  @override
  String get webWelcomeBlurb => 'すべてあなた自身のサーバーに残ります。アカウントも、クラウドも、支払いもありません。';

  @override
  String get webOwnServer => 'あなたのサーバー、あなたのルール';

  @override
  String get webOwnServerWhy => 'アカウントも第三者のクラウドもありません。データは動かしている場所にあります。';

  @override
  String get webServerSaved => 'サーバーに保存しました';

  @override
  String get webServerOffline => 'サーバーに接続できません';

  @override
  String get webServerLocal => 'このブラウザーに保存しました';

  @override
  String get webServerTitle => 'あなたのサーバー';

  @override
  String webPhoneLast(String date) {
    return 'スマホからの最新コピー：$date';
  }

  @override
  String get webPhoneNone => 'スマホからのコピーはまだありません';

  @override
  String get webPhoneScan => 'スマホから取り込む';

  @override
  String get webPhoneExport => 'スマホへ送る';

  @override
  String get webPhoneExportDone => '共有フォルダーに置きました。同期するとスマホが取り込みます';

  @override
  String get webPhoneImported => 'スマホの変更が届きました';

  @override
  String get webPhoneNothing => 'スマホからの新しい変更はありません';

  @override
  String get webPhoneHow =>
      'スマホで、Syncthing と同期するフォルダーへの自動バックアップをオンにしてください。サーバーとスマホが互いの変更を自動で取り込み、統合で何かが消えることはありません。';

  @override
  String get webPhoneGuide => '設定方法';

  @override
  String get webPhoneOff => 'このサーバーではスマホとの同期がオフです';

  @override
  String get toolGroupBody => '体';

  @override
  String get toolNameProtein => 'たんぱく質';

  @override
  String get toolTitleProtein => '1 日のたんぱく質';

  @override
  String get toolDescProtein => '1 日にとるたんぱく質の量';

  @override
  String get toolHintProtein => '1 日のグラム数、食事に分けて';

  @override
  String get proteinGoalLabel => '目標';

  @override
  String get proteinExplain => 'トレーニングする人について多くの研究が一致する範囲に基づいています。減量中は筋肉を守るため多めに。超えても安全ですが、上乗せの効果はわずかです。';

  @override
  String get toolNameWater => '水分';

  @override
  String get toolTitleWater => '1 日の水分';

  @override
  String get toolDescWater => '1 日に飲む量';

  @override
  String get toolHintWater => '1 日のリットル数、食事を含む';

  @override
  String get waterTrainingLabel => '1 日のトレーニング';

  @override
  String get waterExplain => '体重 1 kg あたり約 35 ml、さらにトレーニング 1 分ごとに少し多めに。暑い日はもっと飲みましょう。';

  @override
  String get autoBackupSync => '今すぐ同期';

  @override
  String get autoBackupMerged => 'ほかのデバイスの変更が届きました';

  @override
  String get autoBackupSyncHint => 'このフォルダーを Syncthing で共有すると、各デバイスがほかのデバイスの置いたものを取り込みます。統合で何かが消えることはありません。';

  @override
  String get webPhoneFolder => '共有フォルダー';

  @override
  String get webPhoneFolderHow => 'サーバーのインストール時に決まります。変更するには、サーバーの .env ファイルで GYMMANE_SYNC を設定して再起動してください。';

  @override
  String get webPhoneOffHow => 'オンにするには、サーバーの .env ファイルから GYMMANE_SYNC=off を消して再起動してください。';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 台のスマホが同期済み',
      zero: 'まだ同期したスマホはありません',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'フォルダーを読み込めませんでした：$error';
  }

  @override
  String get duplicateExercise => '複製';

  @override
  String exerciseCopyName(String name) {
    return '$name（コピー）';
  }
}
