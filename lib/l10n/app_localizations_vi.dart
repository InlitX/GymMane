// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get languageName => 'Tiếng Việt';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% so với tháng trước';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Cấp $level · $streak';
  }

  @override
  String get save => 'LƯU';

  @override
  String get cancel => 'Hủy';

  @override
  String get cancelCaps => 'HỦY';

  @override
  String get deleteCaps => 'XÓA';

  @override
  String get done => 'XONG';

  @override
  String get set => 'Đặt';

  @override
  String get home => 'TRANG CHỦ';

  @override
  String get progress => 'TIẾN ĐỘ';

  @override
  String get exercises => 'BÀI TẬP';

  @override
  String get settings => 'CÀI ĐẶT';

  @override
  String get today => 'HÔM NAY';

  @override
  String get thisWeek => 'TUẦN NÀY';

  @override
  String get recommended => 'GỢI Ý';

  @override
  String get goal => 'MỤC TIÊU';

  @override
  String get volume => 'KHỐI LƯỢNG';

  @override
  String get setsToday => 'HIỆP HÔM NAY';

  @override
  String get prs => 'Kỷ lục';

  @override
  String get todaysFocus => 'TRỌNG TÂM HÔM NAY';

  @override
  String get todaysRoutine => 'GIÁO ÁN HÔM NAY';

  @override
  String get startWorkout => 'BẮT ĐẦU TẬP';

  @override
  String get routines => 'GIÁO ÁN TẬP';

  @override
  String get tools => 'CÔNG CỤ';

  @override
  String get firstSessionHint => 'Chọn nhóm cơ và ghi lại buổi tập đầu tiên của bạn';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n bài tập');
    return '$_temp0';
  }

  @override
  String get pushDay => 'NGÀY ĐẨY';

  @override
  String get pullDay => 'NGÀY KÉO';

  @override
  String get legDay => 'NGÀY CHÂN';

  @override
  String get pushFocus => 'Ngực · Vai · Tay sau';

  @override
  String get pullFocus => 'Lưng · Tay trước · Cơ cầu vai';

  @override
  String get legFocus => 'Đùi trước · Đùi sau · Mông';

  @override
  String get train => 'TẬP';

  @override
  String get step1 => 'BƯỚC 1/2';

  @override
  String get step2 => 'BƯỚC 2/2';

  @override
  String get chooseFocus => 'CHỌN TRỌNG TÂM';

  @override
  String get buildSession => 'TẠO BUỔI TẬP';

  @override
  String get tapMuscles => 'Chạm vào các nhóm cơ bạn muốn tập, cả mặt trước và mặt sau.';

  @override
  String get continueBtn => 'TIẾP TỤC';

  @override
  String get nothingForFocus => 'Chưa có gì cho trọng tâm này';

  @override
  String get goBackPick => 'Quay lại và chọn một nhóm cơ có bài tập trong thư viện của bạn.';

  @override
  String pickedHint(int n) {
    return 'Chúng tôi đã chọn sẵn một buổi tập cho bạn. Chạm để thêm hoặc bỏ bất kỳ bài nào trong $n bài.';
  }

  @override
  String get pickAnExercise => 'CHỌN BÀI TẬP';

  @override
  String get searchAllExercises => 'Tìm bài tập bất kỳ…';

  @override
  String get noExercisesMatch => 'Không có bài tập nào khớp';

  @override
  String get createItInstead => 'Tự tạo bài tập này';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n BÀI TẬP');
    return 'BẮT ĐẦU · $_temp0';
  }

  @override
  String get inProgress => 'ĐANG TẬP';

  @override
  String get paused => 'ĐÃ TẠM DỪNG';

  @override
  String get last => 'LẦN TRƯỚC';

  @override
  String get rest => 'NGHỈ';

  @override
  String get skip => 'BỎ QUA';

  @override
  String get addSet => '+ THÊM HIỆP';

  @override
  String get finishSession => 'KẾT THÚC BUỔI TẬP';

  @override
  String get setDone => 'XONG HIỆP';

  @override
  String get nextExercise => 'BÀI TIẾP THEO';

  @override
  String get dropExerciseAction => 'Bỏ bài tập';

  @override
  String get restOff => 'Tắt';

  @override
  String get miniRest => 'Nghỉ rest-pause và cluster';

  @override
  String get miniRestHint => 'Trước các hiệp rest-pause hoặc cluster';

  @override
  String get gymPass => 'Thẻ phòng tập';

  @override
  String get gymPassEmpty => 'Lưu mã phòng tập ở đây để vào cửa mà không cần thẻ';

  @override
  String get gymPassAdd => 'Thêm thẻ';

  @override
  String get gymPassScan => 'Chụp ảnh mã';

  @override
  String get gymPassScanHint => 'Bằng camera điện thoại';

  @override
  String get gymPassPhoto => 'Từ ảnh hoặc ảnh chụp màn hình';

  @override
  String get gymPassPhotoHint => 'Ví dụ: ảnh chụp màn hình từ ứng dụng của phòng tập';

  @override
  String get gymPassType => 'Nhập số';

  @override
  String get gymPassTypeHint => 'Với mã vạch: dãy số in bên dưới';

  @override
  String get gymPassNotFound => 'Không thấy mã QR trong ảnh đó. Hãy thử ảnh rõ hơn hoặc nhập số.';

  @override
  String get gymPassName => 'Tên phòng tập';

  @override
  String get gymPassDefaultName => 'Phòng tập của tôi';

  @override
  String get gymPassCode => 'Mã';

  @override
  String get gymPassFormat => 'Loại mã';

  @override
  String get gymPassInvalid => 'Số đó không hợp với loại mã này';

  @override
  String get gymPassShowHint => 'Đưa vào đầu đọc. Độ sáng sẽ tự tăng lên.';

  @override
  String get gymPassDeleted => 'Đã xóa thẻ';

  @override
  String get gymPassEdit => 'Sửa thẻ';

  @override
  String get gymPassShow => 'Đưa ra ở cửa';

  @override
  String get gymPassPrivate => 'Chỉ lưu trên điện thoại của bạn. Không tải gì lên.';

  @override
  String get gymPassColor => 'Màu';

  @override
  String get gymPassRescan => 'Đọc lại mã';

  @override
  String get gymPassReading => 'Đang đọc mã…';

  @override
  String get gymPassSettingHint => 'Thẻ phòng tập trong hồ sơ của bạn';

  @override
  String get gymPassMember => 'Hội viên';

  @override
  String get widgetHintActivity => 'Bản đồ những ngày bạn đã tập';

  @override
  String get widgetHintStats => 'Chuỗi ngày, khối lượng và số buổi tập tuần này';

  @override
  String get widgetHintBody => 'Các nhóm cơ bạn đã tập';

  @override
  String get widgetHintToday => 'Xem nhanh: hôm nay bạn đã tập chưa?';

  @override
  String get widgetHintWeek => 'Kế hoạch tuần của bạn, từng ngày';

  @override
  String get supportHintBug => 'Báo cho tôi biết lỗi gì, trên GitHub';

  @override
  String get supportHintFeature => 'Đề xuất ý tưởng cho ứng dụng';

  @override
  String get supportHintStar => 'Giúp nhiều người biết đến ứng dụng hơn';

  @override
  String get supportHintCoffee => 'Ủng hộ việc phát triển. Miễn phí và không quảng cáo';

  @override
  String get bodyweightNoteHint => 'Thêm ghi chú: bạn cảm thấy thế nào, bạn đang thử gì… (không bắt buộc)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Dùng $unit cho bài tập này';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'LẦN LẶP';

  @override
  String weightCol(String unit) {
    return 'MỨC TẠ ($unit)';
  }

  @override
  String get repsTitle => 'LẦN LẶP';

  @override
  String weightTitle(String unit) {
    return 'MỨC TẠ ($unit)';
  }

  @override
  String get sessionComplete => 'ĐÃ GHI BUỔI TẬP';

  @override
  String get finishHeadlinePr => 'Kỷ lục cá nhân mới';

  @override
  String get finishHeadlineGoal => 'Đã đạt mục tiêu tuần';

  @override
  String get finishHeadlineStreak => 'Chuỗi ngày vẫn tiếp tục';

  @override
  String get finishHeadlineDefault => 'Thêm một buổi nữa vào sổ';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(prs, locale: localeName, other: '$prs bài tập');
    return 'Bạn đã nâng nặng hơn bao giờ hết ở $_temp0. Thành tích đã có trong mục kỷ lục.';
  }

  @override
  String get finishBodyGoal => 'Bạn đã tập đủ số buổi đặt ra cho tuần này.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak ngày liên tiếp. Khó nhất là đừng dừng lại.';
  }

  @override
  String get finishBodyDefault => 'Đã ghi lại và tính vào. Đều đặn mới làm các con số thay đổi.';

  @override
  String get vsLastTime => 'SO VỚI LẦN TRƯỚC';

  @override
  String get firstTime => 'Lần đầu ghi lại';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n kỷ lục mới');
    return '$_temp0';
  }

  @override
  String get duration => 'THỜI LƯỢNG';

  @override
  String get setsCaps => 'HIỆP';

  @override
  String exerciseXofY(int i, int n) {
    return 'BÀI TẬP $i/$n';
  }

  @override
  String get decrease => 'Giảm';

  @override
  String get increase => 'Tăng';

  @override
  String markSet(int n) {
    return 'Đánh dấu hiệp $n đã xong';
  }

  @override
  String get pauseWorkout => 'Tạm dừng buổi tập';

  @override
  String get resumeWorkout => 'Tiếp tục buổi tập';

  @override
  String get discardTitle => 'Hủy buổi tập?';

  @override
  String get discardBody => 'Các hiệp trong buổi tập này sẽ bị mất.';

  @override
  String get keepTraining => 'Tập tiếp';

  @override
  String get discard => 'Hủy bỏ';

  @override
  String get notifRestChannel => 'Hẹn giờ nghỉ';

  @override
  String get notifRestChannelWhy => 'Báo cho bạn khi hết thời gian nghỉ giữa các hiệp';

  @override
  String get notifAlertChannel => 'Hẹn giờ nghỉ (cảnh báo)';

  @override
  String get notifAlertChannelWhy => 'Hiện biểu ngữ ngay khi hết thời gian nghỉ';

  @override
  String get restOverTitle => 'Hết giờ nghỉ';

  @override
  String get restOverBody => 'Tập tiếp thôi, hiệp kế tiếp đang chờ.';

  @override
  String get allTimeSessions => 'BUỔI TẬP';

  @override
  String get allTimeTime => 'THỜI GIAN';

  @override
  String get allTimeSets => 'HIỆP';

  @override
  String get consistency => 'MỨC ĐỀU ĐẶN';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã ghi $n buổi tập');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'chuỗi $n ngày';
  }

  @override
  String get bodyweight => 'CÂN NẶNG';

  @override
  String get logBodyweight => 'GHI CÂN NẶNG';

  @override
  String get trackWeight => 'Theo dõi cân nặng theo thời gian';

  @override
  String get muscleMap => 'BẢN ĐỒ CƠ';

  @override
  String get days7 => '7 ngày';

  @override
  String get days30 => '30 ngày';

  @override
  String get days90 => '90 ngày';

  @override
  String get days365 => '1 năm';

  @override
  String get daysAll => 'Tất cả';

  @override
  String get weeklyAvgTitle => 'Trung bình tuần';

  @override
  String weekOfDate(String date) {
    return 'Tuần của $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change trong khoảng này';
  }

  @override
  String get heatLow => 'Chưa tập';

  @override
  String get heatHigh => 'Đủ khối lượng';

  @override
  String get muscleMapEmpty => 'Ghi một buổi tập và cơ thể bạn sẽ bắt đầu sáng lên ở đây.';

  @override
  String get muscleMapHint => 'Chạm vào một nhóm cơ để xem nó được tập những gì.';

  @override
  String muscleMapBehind(String names) {
    return 'Đang tụt lại: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% mục tiêu';
  }

  @override
  String get muscleSplit => 'PHÂN BỔ NHÓM CƠ';

  @override
  String get personalRecords => 'KỶ LỤC CÁ NHÂN';

  @override
  String get strength1rm => 'SỨC MẠNH · 1RM ƯỚC TÍNH';

  @override
  String get strengthEmpty => 'Ghi một bài tập hai lần và đường sức mạnh của nó sẽ hiện ở đây.';

  @override
  String oneRmEst(String w) {
    return '1RM ước tính $w';
  }

  @override
  String get restDayShort => 'Ngày nghỉ';

  @override
  String get restDay => 'Ngày nghỉ, không ghi gì.';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteEntry => 'Xóa mục này?';

  @override
  String deleteEntryBody(String name) {
    return '“$name” sẽ bị xóa khỏi ngày này, cũng như khỏi kỷ lục và biểu đồ của bạn.';
  }

  @override
  String get bodyweightHistory => 'LỊCH SỬ';

  @override
  String get exercisesCaps => 'BÀI TẬP';

  @override
  String get timeCaps => 'THỜI GIAN';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n bài tập trong thư viện của bạn');
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Tìm bài tập';

  @override
  String get muscleFilter => 'NHÓM CƠ';

  @override
  String get levelFilter => 'TRÌNH ĐỘ';

  @override
  String get kindLabel => 'LOẠI';

  @override
  String get kindStrength => 'Sức mạnh';

  @override
  String get kindCalisthenics => 'Thể dục tự trọng';

  @override
  String get kindCardio => 'Cardio';

  @override
  String get kindStretch => 'Giãn cơ';

  @override
  String get newExercise => 'BÀI TẬP MỚI';

  @override
  String get exerciseName => 'Tên bài tập';

  @override
  String get equipmentLabel => 'DỤNG CỤ';

  @override
  String get addExercise => 'THÊM BÀI TẬP';

  @override
  String get advanced => 'NÂNG CAO';

  @override
  String get demoMedia => 'MINH HỌA';

  @override
  String get addMedia => 'Thêm ảnh/video';

  @override
  String get mediaHint => 'Ảnh, GIF hoặc video';

  @override
  String get changeMedia => 'Thay đổi';

  @override
  String get videoSelected => 'Đã chọn video';

  @override
  String get favouritesOnly => 'Yêu thích';

  @override
  String get noFavouritesYet => 'Chưa có mục yêu thích';

  @override
  String get noFavouritesHint => 'Chạm vào ngôi sao trên một bài tập để giữ nó ở đây.';

  @override
  String get clearFilters => 'Xóa bộ lọc';

  @override
  String get quickAddAmount => 'Lượng bạn đã dùng';

  @override
  String get homeCardsTitle => 'Thẻ trên trang chủ';

  @override
  String get homeCardsHint => 'Những gì bạn bật sẽ hiện trên Trang chủ';

  @override
  String get homeCardFocus => 'Hôm nay';

  @override
  String get homeCardSteps => 'Số bước';

  @override
  String get homeCardWeek => 'Tuần này';

  @override
  String get homeCardRoutines => 'Giáo án tập';

  @override
  String get homeCardRecommended => 'Gợi ý';

  @override
  String get textSizeSetting => 'Cỡ chữ';

  @override
  String get textSizeSmall => 'Nhỏ';

  @override
  String get textSizeNormal => 'Bình thường';

  @override
  String get textSizeLarge => 'Lớn';

  @override
  String get textSizeHint => 'Cộng thêm vào cỡ chữ của điện thoại';

  @override
  String get calmMotionSetting => 'Giảm chuyển động';

  @override
  String get calmMotionHint => 'Màn hình hiện ra mà không trượt vào';

  @override
  String get dishArchive => 'Lưu trữ';

  @override
  String get dishUnarchive => 'Khôi phục';

  @override
  String get dishArchivedToast => 'Đã lưu trữ món ăn';

  @override
  String get filterShowLabel => 'Hiển thị';

  @override
  String get noExercisesFound => 'Không tìm thấy bài tập nào';

  @override
  String get noExercisesHint => 'Hãy thử tìm kiếm khác hoặc xóa bộ lọc.';

  @override
  String get personalRecord => 'KỶ LỤC CÁ NHÂN';

  @override
  String get history => 'LỊCH SỬ';

  @override
  String get noHistory => 'Chưa ghi buổi tập nào. Hãy tập bài này để có lịch sử.';

  @override
  String get notes => 'GHI CHÚ';

  @override
  String get notePlaceholder => 'Lưu ý kỹ thuật, cách chuẩn bị, cảm giác thế nào…';

  @override
  String notHere(String gear, String place) {
    return 'Không có $gear ở $place';
  }

  @override
  String get notHereWhy => 'Đổi sang bài mà hôm nay bạn thực sự có thể tập.';

  @override
  String get altHere => 'NHỮNG GÌ BẠN CÓ THỂ TẬP Ở ĐÂY';

  @override
  String get places => 'ĐỊA ĐIỂM CỦA TÔI';

  @override
  String get placesHint =>
      'Cho biết mỗi nơi có gì và thư viện sẽ chỉ hiện những bài bạn thực sự tập được ở đó.';

  @override
  String get placeAll => 'Mọi nơi';

  @override
  String get placeNew => 'Địa điểm mới';

  @override
  String get placeNamePlaceholder => 'Nhà, phòng tập, công viên…';

  @override
  String get placeGearLabel => 'Ở ĐÓ CÓ GÌ';

  @override
  String placeExercises(int n) {
    return '$n bài tập ở đây';
  }

  @override
  String get placeEmptyTitle => 'Tập ở bất cứ đâu bạn có mặt';

  @override
  String get placeEmptyBody =>
      'Một địa điểm là danh sách dụng cụ bạn có ở đó. Chọn một nơi để bắt đầu rồi sửa sau.';

  @override
  String get placeDeleteTitle => 'Xóa địa điểm';

  @override
  String get placeDeleteBody => 'Chỉ xóa địa điểm. Bài tập và buổi tập của bạn vẫn được giữ.';

  @override
  String get placeGym => 'Phòng tập';

  @override
  String get placeHome => 'Nhà';

  @override
  String get placeOutdoors => 'Ngoài trời';

  @override
  String get placeFilterLabel => 'ĐỊA ĐIỂM';

  @override
  String get noGearOnly => 'Không dụng cụ';

  @override
  String placeActive(String name) {
    return 'Đang tập ở $name';
  }

  @override
  String get journal => 'NHẬT KÝ';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ghi chú',
      zero: 'Chưa có ghi chú',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Ghi chú';

  @override
  String get noteKindPlan => 'Kế hoạch';

  @override
  String get noteKindDone => 'Thành tích';

  @override
  String get noteKindPain => 'Đau nhẹ';

  @override
  String get noteFilterAll => 'Tất cả';

  @override
  String get newNote => 'Ghi chú mới';

  @override
  String get editNote => 'Sửa ghi chú';

  @override
  String get addNote => 'THÊM GHI CHÚ';

  @override
  String get noteEmptyTitle => 'Chưa ghi lại gì';

  @override
  String get noteEmptyBody =>
      'Lưu ý kỹ thuật, kế hoạch cho lần sau, cảm giác của một buổi tập. Kèm ảnh hoặc video nếu bạn muốn.';

  @override
  String get noteNoneForExercise => 'Chưa có ghi chú nào cho bài tập này.';

  @override
  String get noteKindLabel => 'LOẠI';

  @override
  String get noteTextLabel => 'GHI CHÚ';

  @override
  String get noteDateLabel => 'NGÀY';

  @override
  String get noteExerciseLabel => 'BÀI TẬP';

  @override
  String get noteMediaLabel => 'ẢNH & VIDEO';

  @override
  String get noteGeneral => 'Không có bài tập';

  @override
  String get noteAttach => 'Đính kèm';

  @override
  String get noteRemoveMedia => 'Gỡ tệp đính kèm';

  @override
  String get deleteNoteTitle => 'Xóa ghi chú';

  @override
  String get deleteNoteBody => 'Ghi chú và mọi thứ đính kèm sẽ bị xóa vĩnh viễn.';

  @override
  String get noteToday => 'Hôm nay';

  @override
  String get noteYesterday => 'Hôm qua';

  @override
  String get noteAllNotes => 'Tất cả ghi chú';

  @override
  String get noteCalendar => 'Lịch';

  @override
  String get noteNoneOnDay => 'Ngày này chưa ghi gì';

  @override
  String get noteAddOnDay => 'Ghi chú cho ngày này';

  @override
  String get notePrevMonth => 'Tháng trước';

  @override
  String get noteNextMonth => 'Tháng sau';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ghi chú trong tháng này',
      zero: 'Tháng này chưa có ghi chú',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'SỐ ĐO';

  @override
  String get measuresHint => 'Từ cổ đến bắp chân: theo dõi cơ thể thay đổi, không chỉ thanh đòn.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n lần đo', zero: 'Chưa ghi gì');
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Chưa ghi';

  @override
  String get measureHistory => 'LỊCH SỬ';

  @override
  String get measureNeck => 'Cổ';

  @override
  String get measureShoulders => 'Vai';

  @override
  String get measureChest => 'Ngực';

  @override
  String get measureArm => 'Bắp tay';

  @override
  String get measureForearm => 'Cẳng tay';

  @override
  String get measureWaist => 'Eo';

  @override
  String get measureHips => 'Hông';

  @override
  String get measureThigh => 'Đùi';

  @override
  String get measureCalf => 'Bắp chân';

  @override
  String get measureBodyfat => 'Mỡ cơ thể';

  @override
  String get timeline => 'DÒNG THỜI GIAN';

  @override
  String get hidePhotos => 'Ẩn ảnh';

  @override
  String get showPhotos => 'Hiện ảnh';

  @override
  String get timelineHint => 'Cùng tư thế, cùng chỗ, cùng ánh sáng. Một năm nữa bạn sẽ không tin nổi.';

  @override
  String get timelineEmptyTitle => 'Bức ảnh đầu tiên sẽ bắt đầu tính giờ';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ảnh', zero: 'Chưa có ảnh');
    return '$_temp0';
  }

  @override
  String get poseFront => 'Mặt trước';

  @override
  String get poseSide => 'Mặt bên';

  @override
  String get poseBack => 'Mặt sau';

  @override
  String get photoEvery => 'NHẮC TÔI';

  @override
  String photoEveryDays(int n) {
    return 'Mỗi $n ngày';
  }

  @override
  String get photoEveryOff => 'Không bao giờ';

  @override
  String get timelineEvery => 'GỘP THEO';

  @override
  String get custom => 'Tùy chỉnh';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Ảnh tiếp theo sau $n ngày',
      one: 'Ảnh tiếp theo vào ngày mai',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Đến lúc chụp ảnh: chụp ngay hôm nay';

  @override
  String get addTodayPhotos => 'THÊM ẢNH HÔM NAY';

  @override
  String posePhoto(String pose) {
    return 'Ảnh $pose';
  }

  @override
  String get compare => 'SO SÁNH';

  @override
  String get compareNeedTwo => 'Bức ảnh tiếp theo sẽ hiện trước và sau ở đây.';

  @override
  String dayNumber(int n) {
    return 'Ngày $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Cách nhau $n ngày',
      zero: 'Cùng ngày',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Xóa ngày này';

  @override
  String get deleteDayBody => 'Ảnh của ngày đó cũng bị xóa vĩnh viễn.';

  @override
  String get timelinePhotos => 'Ảnh';

  @override
  String get timelineBody => 'Bản đồ cơ';

  @override
  String get timelineBodyEmpty => 'Ghi một buổi tập và bản đồ cơ sẽ bắt đầu được tô ở đây, không cần ảnh.';

  @override
  String get timelineBodyHint => 'Dựng từ chính các hiệp bạn tập, không cần tải gì lên.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n buổi tập',
      zero: 'Chưa có buổi tập',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Ảnh tiến độ';

  @override
  String get notifPhotoChannelWhy => 'Lời nhắc khi đến lúc chụp ảnh tiến độ tiếp theo.';

  @override
  String get notifPhotoTitle => 'Đến lúc chụp ảnh tiến độ';

  @override
  String notifPhotoBody(int n) {
    return 'Đã $n ngày kể từ lần trước. Cùng tư thế, cùng ánh sáng.';
  }

  @override
  String get share => 'CHIA SẺ';

  @override
  String get sharePick => 'Bạn muốn khoe gì?';

  @override
  String get shareStreak => 'Chuỗi ngày và mức đều đặn';

  @override
  String get shareBody => 'Các nhóm cơ đã tập';

  @override
  String get shareCompare => 'Trước và sau';

  @override
  String get shareHint =>
      'Thẻ được tạo trên điện thoại của bạn. Không gì được gửi đi cho đến khi bạn chọn nơi chia sẻ.';

  @override
  String get shareFailed => 'Không thể tạo thẻ';

  @override
  String get shareWeekOf => '7 NGÀY QUA';

  @override
  String get shareStreakLabel => 'NGÀY LIÊN TIẾP';

  @override
  String get shareSessionsLabel => 'BUỔI TẬP';

  @override
  String get shareVolumeLabel => 'KHỐI LƯỢNG';

  @override
  String get restForExercise => 'THỜI GIAN NGHỈ CHO BÀI NÀY';

  @override
  String get restUsingDefault => 'Đang dùng mặc định của bạn';

  @override
  String get restCustom => 'Chỉ cho bài này';

  @override
  String get setType => 'LOẠI HIỆP';

  @override
  String get setTypeNormal => 'Hiệp chính';

  @override
  String get setTypeWarmup => 'Khởi động';

  @override
  String get setTypeDrop => 'Hiệp giảm tạ';

  @override
  String get setTypeFailure => 'Đến khi kiệt sức';

  @override
  String get addWarmup => 'KHỞI ĐỘNG';

  @override
  String platesPerSide(String plates) {
    return 'Mỗi bên: $plates';
  }

  @override
  String get howTo => 'CÁCH TẬP';

  @override
  String get similar => 'TƯƠNG TỰ';

  @override
  String get primaryLabel => 'CHÍNH';

  @override
  String get secondaryLabel => 'PHỤ';

  @override
  String get none => 'Không có';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hiệp');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'Khối lượng $v';
  }

  @override
  String get weeklyPlan => 'KẾ HOẠCH TUẦN';

  @override
  String get yourRoutines => 'GIÁO ÁN TẬP CỦA BẠN';

  @override
  String get noRoutines => 'Chưa có giáo án tập nào. Hãy tạo một giáo án và thêm bài tập.';

  @override
  String get newRoutine => 'GIÁO ÁN TẬP MỚI';

  @override
  String get routineName => 'Tên giáo án tập';

  @override
  String get schedule => 'LỊCH TẬP';

  @override
  String get addFromList => 'Thêm bài tập từ danh sách bên dưới.';

  @override
  String get addExercises => 'Thêm bài tập';

  @override
  String get deleteRoutine => 'Xóa giáo án tập này?';

  @override
  String exercisesWithCount(int n) {
    return 'BÀI TẬP · $n';
  }

  @override
  String setDay(String day) {
    return 'XẾP LỊCH $day';
  }

  @override
  String get newRoutineName => 'Giáo án tập mới';

  @override
  String get dragToReorder => 'Kéo tay nắm chấm chấm để sắp xếp lại, đây là thứ tự bạn sẽ tập.';

  @override
  String reorderHandle(String name) {
    return 'Sắp xếp lại $name';
  }

  @override
  String get removeFromRoutine => 'Gỡ khỏi giáo án tập';

  @override
  String get dropExercise => 'Bỏ bài tập này?';

  @override
  String dropExerciseBody(String name) {
    return '“$name” sẽ bị bỏ khỏi buổi tập này. Những gì đã ghi không bị mất.';
  }

  @override
  String get drop => 'Bỏ';

  @override
  String get resetData => 'Xóa toàn bộ dữ liệu của tôi';

  @override
  String get resetTitle => 'Xóa mọi thứ?';

  @override
  String get resetBody =>
      'Buổi tập, kỷ lục, giáo án tập, ghi chú và hồ sơ. Không thể hoàn tác: hãy xuất bản sao lưu trước nếu bạn có thể cần đến.';

  @override
  String get resetConfirm => 'Xóa mọi thứ';

  @override
  String get resetDone => 'Đã xóa toàn bộ dữ liệu';

  @override
  String get support => 'HỖ TRỢ';

  @override
  String get reportBug => 'Báo lỗi';

  @override
  String get requestFeature => 'Đề xuất tính năng';

  @override
  String get starOnGithub => 'Gắn sao trên GitHub';

  @override
  String get buyCoffee => 'Mời tôi một ly cà phê';

  @override
  String get cantOpenLink => 'Không mở được liên kết';

  @override
  String get theme => 'Chủ đề';

  @override
  String get darkTheme => 'Tối';

  @override
  String get lightTheme => 'Sáng';

  @override
  String get amoledTheme => 'Đen AMOLED';

  @override
  String get editDuration => 'Thời lượng buổi tập';

  @override
  String get sessionName => 'Tên buổi tập';

  @override
  String get nameWorkout => 'Đặt tên';

  @override
  String get sessionNameHint => 'Ví dụ: Chân, Đẩy, Toàn thân';

  @override
  String get secondaryPickHint => 'Chạm vào các nhóm cơ khác mà bài tập này tác động.';

  @override
  String get languageLabel => 'Ngôn ngữ';

  @override
  String get unitsLabel => 'Đơn vị';

  @override
  String get restTimer => 'Hẹn giờ nghỉ';

  @override
  String get alarmBlockedTitle => 'Thông báo đang tắt';

  @override
  String get alarmBlockedBody => 'Chuông báo nghỉ sẽ không reo khi màn hình bị khóa';

  @override
  String get alarmBlockedAction => 'BẬT';

  @override
  String get alarmSound => 'Âm báo';

  @override
  String get alarmDefaultName => 'Mặc định';

  @override
  String get alarmSoundHint => 'Dùng âm của riêng bạn, tối đa 15 giây';

  @override
  String get alarmChoose => 'Chọn âm thanh…';

  @override
  String get alarmPreview => 'Phát âm hiện tại';

  @override
  String get alarmReset => 'Đặt lại mặc định';

  @override
  String get alarmTooLong => 'Âm thanh đó dài hơn 15 giây';

  @override
  String get alarmInvalid => 'Không đọc được tệp âm thanh đó';

  @override
  String alarmChanged(String name) {
    return 'Đã đặt âm báo thành “$name”';
  }

  @override
  String get alarmChangedDefault => 'Đã quay lại âm mặc định';

  @override
  String get addActivityWidget => 'Thêm tiện ích hoạt động';

  @override
  String get addStatsWidget => 'Thêm tiện ích thống kê';

  @override
  String get pinUnsupported => 'Hãy thêm từ menu tiện ích của trình khởi chạy';

  @override
  String get background => 'Hình nền';

  @override
  String get bgNone => 'Không có';

  @override
  String get bgDots => 'Chấm';

  @override
  String get bgGrid => 'Lưới';

  @override
  String get exportCsv => 'Xuất buổi tập (CSV)';

  @override
  String get exportBackup => 'Xuất bản sao lưu (ZIP)';

  @override
  String get importBackup => 'Nhập bản sao lưu';

  @override
  String get importHint =>
      'Chọn bản sao lưu .zip (hoặc .json cũ hơn) đã xuất từ GymMane. Thao tác này thay thế dữ liệu hiện tại, kể cả ảnh và video.';

  @override
  String get import => 'Nhập';

  @override
  String get chooseFile => 'Chọn tệp';

  @override
  String get importFromApp => 'Nhập từ ứng dụng khác';

  @override
  String get importUnknownFormat => 'Tệp đó cần có các cột ngày, bài tập, số lần lặp và mức tạ';

  @override
  String get importZipNoWeights => 'Tệp zip đó không có tệp cân nặng nào';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã nhập $n lần cân');
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Không đọc được tệp đó';

  @override
  String get importUnitTitle => 'Tệp đó dùng đơn vị nào?';

  @override
  String get importUnitBody => 'Bản xuất này không cho biết mức tạ tính theo đơn vị nào.';

  @override
  String get importNothing => 'Không có gì mới để nhập';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã nhập $n buổi tập');
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Giới thiệu GymMane';

  @override
  String get yourProfile => 'HỒ SƠ CỦA BẠN';

  @override
  String get autofills => 'Tự điền vào các công cụ tính';

  @override
  String get onbUnitsWhy =>
      'Dùng cho mức tạ, số đo và quãng đường. Bạn có thể đổi bất cứ lúc nào trong Cài đặt.';

  @override
  String get nameLabel => 'TÊN';

  @override
  String get sexLabel => 'GIỚI TÍNH';

  @override
  String get macroProtein => 'ĐẠM';

  @override
  String get macroCarbs => 'TINH BỘT';

  @override
  String get macroFat => 'CHẤT BÉO';

  @override
  String get male => 'Nam';

  @override
  String get female => 'Nữ';

  @override
  String get ageLabel => 'TUỔI';

  @override
  String get heightLabel => 'CHIỀU CAO';

  @override
  String get weightLabel => 'CÂN NẶNG';

  @override
  String get weeklyGoal => 'MỤC TIÊU TUẦN';

  @override
  String get activityLabel => 'MỨC HOẠT ĐỘNG';

  @override
  String get addPhoto => 'Thêm ảnh';

  @override
  String get removePhoto => 'Gỡ ảnh';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get chooseGallery => 'Chọn từ thư viện ảnh';

  @override
  String get backupImported => 'Đã nhập bản sao lưu';

  @override
  String get backupFailed => 'Không đọc được bản sao lưu đó';

  @override
  String get nothingToExport => 'Chưa có gì để xuất: hãy ghi một buổi tập trước';

  @override
  String calculatorsCount(int n) {
    return '$n công cụ tính cho việc tập luyện';
  }

  @override
  String get result => 'KẾT QUẢ';

  @override
  String get weightLifted => 'MỨC TẠ ĐÃ NÂNG';

  @override
  String get repsPerformed => 'SỐ LẦN LẶP ĐÃ THỰC HIỆN';

  @override
  String get neck => 'CỔ';

  @override
  String get waist => 'EO';

  @override
  String get hip => 'HÔNG (cho nữ)';

  @override
  String get targetWeight => 'MỨC TẠ MỤC TIÊU';

  @override
  String get workingWeight => 'MỨC TẠ TẬP CHÍNH';

  @override
  String get activityLevel => 'MỨC HOẠT ĐỘNG';

  @override
  String get barWeight => 'MỨC TẠ CỦA THANH ĐÒN';

  @override
  String get perSide => 'MỖI BÊN';

  @override
  String get justTheBar => 'Chỉ thanh đòn.';

  @override
  String perSideCount(int n) {
    return '× $n mỗi bên';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'BMI';

  @override
  String get toolNameCal => 'Calo';

  @override
  String get toolNameBf => 'Mỡ cơ thể';

  @override
  String get toolNamePlate => 'Bánh tạ';

  @override
  String get toolNameWarmup => 'Khởi động';

  @override
  String get toolTitleRm => 'Tính 1RM';

  @override
  String get toolTitleBmi => 'Tính BMI';

  @override
  String get toolTitleCal => 'Calo & dinh dưỡng đa lượng';

  @override
  String get toolTitleBf => '% mỡ cơ thể';

  @override
  String get toolTitlePlate => 'Tính bánh tạ';

  @override
  String get toolTitleWarmup => 'Hiệp khởi động';

  @override
  String get toolHintRm => 'Mức tạ tối đa cho 1 lần lặp ước tính (công thức Epley)';

  @override
  String get toolHintCal => 'Mức calo duy trì mỗi ngày ước tính';

  @override
  String get toolHintBf => 'Ước tính theo phương pháp Hải quân Mỹ';

  @override
  String get toolHintPlate => 'Tổng mức tạ của thanh đòn';

  @override
  String get toolHintWarmup => 'Mức tạ tập chính mục tiêu';

  @override
  String get toolDescRm => 'Mức tạ tối đa cho một lần lặp ước tính';

  @override
  String get toolDescBmi => 'Chỉ số khối cơ thể';

  @override
  String get toolDescCal => 'Calo & dinh dưỡng đa lượng';

  @override
  String get toolDescBf => 'Tỷ lệ mỡ cơ thể';

  @override
  String get toolDescPlate => 'Tính bánh tạ cho thanh đòn';

  @override
  String get toolDescWarmup => 'Hiệp tăng dần';

  @override
  String get bmiUnderweight => 'Thiếu cân';

  @override
  String get bmiNormal => 'Bình thường';

  @override
  String get bmiOverweight => 'Thừa cân';

  @override
  String get bmiObese => 'Béo phì';

  @override
  String get actSedentary => 'Ít vận động';

  @override
  String get actLight => 'Nhẹ';

  @override
  String get actActive => 'Năng động';

  @override
  String get actModerate => 'Vừa phải';

  @override
  String get muscleChest => 'Ngực';

  @override
  String get muscleBack => 'Lưng';

  @override
  String get muscleLowerBack => 'Lưng dưới';

  @override
  String get muscleShoulders => 'Vai';

  @override
  String get muscleBiceps => 'Tay trước';

  @override
  String get muscleTriceps => 'Tay sau';

  @override
  String get muscleForearm => 'Cẳng tay';

  @override
  String get muscleTrapezius => 'Cơ cầu vai';

  @override
  String get muscleAbdomen => 'Bụng';

  @override
  String get muscleObliques => 'Cơ liên sườn';

  @override
  String get muscleQuads => 'Đùi trước';

  @override
  String get muscleHamstrings => 'Đùi sau';

  @override
  String get muscleGlutes => 'Mông';

  @override
  String get muscleCalves => 'Bắp chân';

  @override
  String get mgChest => 'Ngực';

  @override
  String get mgBack => 'Lưng';

  @override
  String get mgLegs => 'Chân';

  @override
  String get mgShoulders => 'Vai';

  @override
  String get mgArms => 'Tay';

  @override
  String get mgCore => 'Cơ lõi';

  @override
  String get equipBarbell => 'Thanh đòn';

  @override
  String get equipDumbbell => 'Tạ đơn';

  @override
  String get equipCable => 'Cáp';

  @override
  String get equipMachine => 'Máy';

  @override
  String get equipBodyweight => 'Trọng lượng cơ thể';

  @override
  String get equipWeighted => 'Có tạ đeo';

  @override
  String get equipBand => 'Dây kháng lực';

  @override
  String get equipKettlebell => 'Tạ ấm';

  @override
  String get equipRings => 'Vòng treo';

  @override
  String get equipOther => 'Khác';

  @override
  String get diffBeginner => 'Mới bắt đầu';

  @override
  String get diffAdvanced => 'Nâng cao';

  @override
  String get diffIntermediate => 'Trung cấp';

  @override
  String get about => 'GIỚI THIỆU';

  @override
  String version(String v) {
    return 'Phiên bản $v';
  }

  @override
  String get aboutBlurb => 'Do người tập tạ làm ra, cho người tập tạ.';

  @override
  String get freeForever => 'Miễn phí mãi mãi';

  @override
  String get freeForeverWhy => 'Không thuê bao, không quảng cáo, không có gì bị khóa sau tường phí.';

  @override
  String get fullyOffline => 'Hoàn toàn ngoại tuyến';

  @override
  String get fullyOfflineWhy =>
      'Không tài khoản, không máy chủ. Dữ liệu tập luyện không bao giờ rời khỏi điện thoại này.';

  @override
  String get yoursToTake => 'Dữ liệu là của bạn';

  @override
  String get yoursToTakeWhy => 'Xuất ra CSV bất cứ khi nào bạn muốn, và xóa sạch chỉ với một lần chạm.';

  @override
  String get whatsInside => 'CÓ GÌ BÊN TRONG';

  @override
  String exercisesInside(int n) {
    return '$n bài tập';
  }

  @override
  String get exercisesInsideWhy => 'Bài nào cũng có hình động và hướng dẫn từng bước.';

  @override
  String get calculatorsInside => '10 công cụ tính';

  @override
  String get calculatorsInsideWhy =>
      '1RM, bánh tạ, BMI, calo, mỡ cơ thể, FFMI, khởi động, mức tạ theo RPE, cùng điểm sức mạnh DOTS và Wilks, tất cả đều dùng công thức đã công bố.';

  @override
  String get mathInside => 'Tính toán trung thực';

  @override
  String get mathInsideWhy =>
      'Khối lượng, kỷ lục và chuỗi ngày đều tính từ chính các hiệp của bạn. Không có gì ở đây chỉ để trang trí.';

  @override
  String get streakCaps => 'CHUỖI NGÀY';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ngày');
    return '$_temp0';
  }

  @override
  String get reset => 'ĐẶT LẠI';

  @override
  String get welcomeKicker => 'CHÀO MỪNG ĐẾN VỚI';

  @override
  String get welcomeBlurb =>
      'Mọi thứ đều ở trên điện thoại của bạn. Không tài khoản, không cần internet, không phải trả tiền.';

  @override
  String get welcomeStart => 'BẮT ĐẦU';

  @override
  String onbStep(int i, int n) {
    return 'BƯỚC $i/$n';
  }

  @override
  String get onbNameTitle => 'Chúng tôi nên gọi bạn là gì?';

  @override
  String get onbNameHint => 'Tên của bạn';

  @override
  String get onbPhotoAdd => 'Thêm ảnh';

  @override
  String get onbPhotoChange => 'Đổi ảnh';

  @override
  String get onbPhotoTitle => 'Thêm ảnh cho hồ sơ của bạn';

  @override
  String get onbPhotoWhy =>
      'Không bắt buộc. Ảnh chỉ nằm trên điện thoại và bạn có thể đổi bất cứ lúc nào trong hồ sơ.';

  @override
  String get onbPhotoLater => 'ĐỂ SAU';

  @override
  String get onbNameWhy => 'Chỉ dùng để chào bạn. Tên không bao giờ rời khỏi điện thoại.';

  @override
  String get onbBodyTitle => 'Vài con số';

  @override
  String get onbBodyWhy =>
      'Chúng được dùng cho các công cụ tính. Bạn có thể đổi bất cứ lúc nào trong Cài đặt.';

  @override
  String get onbGoalTitle => 'Bạn tập bao lâu một lần?';

  @override
  String get onbGoalWhy => 'Dùng để đặt vòng mục tiêu tuần. Hãy thành thật, đừng quá tham vọng.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n buổi tập mỗi tuần');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilôgam hay pound?';

  @override
  String get next => 'TIẾP';

  @override
  String get back => 'QUAY LẠI';

  @override
  String get skip2 => 'Bỏ qua';

  @override
  String get madeWithLoveBy => 'ĐƯỢC LÀM VỚI TÌNH YÊU BỞI';

  @override
  String get sourceCode => 'MÃ NGUỒN';

  @override
  String get suggested => 'GỢI Ý';

  @override
  String get results => 'KẾT QUẢ';

  @override
  String get noMatches => 'Không có bài tập nào khớp với tìm kiếm đó.';

  @override
  String get tapToEdit => 'Chạm vào bút chì để sửa một mục, hoặc thùng rác để xóa.';

  @override
  String get editEntry => 'Sửa';

  @override
  String get editEntryHint => 'Sửa số lần lặp hoặc mức tạ của bất kỳ hiệp nào.';

  @override
  String get removeSet => 'Gỡ hiệp';

  @override
  String get continueWorkout => 'TIẾP TỤC';

  @override
  String get continueWorkoutBody =>
      'Buổi tập sẽ quay lại trạng thái đang tập, các hiệp đã đánh dấu vẫn giữ nguyên. Khi kết thúc lại, buổi tập được lưu vào đúng ngày ban đầu.';

  @override
  String get addBodyWidget => 'Thêm tiện ích bản đồ cơ';

  @override
  String get repsOnly => 'Chỉ số lần lặp';

  @override
  String get repsOnlyHint => 'Ghi bài tập này mà không có mức tạ.';

  @override
  String get eachSide => 'Từng bên';

  @override
  String get eachSideHint =>
      'Hẹn giờ chạy một lần cho mỗi bên và thời gian nghỉ bắt đầu sau khi xong cả hai bên.';

  @override
  String get useDefaultArt => 'Quay lại hình minh họa mặc định';

  @override
  String daysShort(int n) {
    return '$n ngày';
  }

  @override
  String get focusCard => 'Trọng tâm hôm nay';

  @override
  String get autoAdvance => 'Tự động chuyển tiếp';

  @override
  String get keepScreenOn => 'Giữ màn hình sáng khi tập';

  @override
  String get lockWorkout => 'Khóa màn hình';

  @override
  String get unlockWorkout => 'Mở khóa';

  @override
  String get holdToUnlock => 'Giữ để mở khóa';

  @override
  String get liveChannel => 'Buổi tập đang diễn ra';

  @override
  String get liveChannelWhy => 'Hiện bài tập, hiệp và hẹn giờ nghỉ hiện tại trong khi bạn tập';

  @override
  String liveSet(int n, int total) {
    return 'Hiệp $n/$total';
  }

  @override
  String get liveResting => 'Đang nghỉ';

  @override
  String get liveAllDone => 'Đã xong tất cả các hiệp';

  @override
  String get autoAdvanceHint => 'Chuyển tiếp sau hiệp cuối';

  @override
  String get placePlates => 'Bánh tạ và thanh đòn';

  @override
  String get platesAll => 'Có đủ mọi loại';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n cỡ');
    return '$_temp0';
  }

  @override
  String get platePairs => 'CẶP';

  @override
  String plateAchievable(String w) {
    return 'Mức gần nhất có thể lắp: $w';
  }

  @override
  String get autoWarmup => 'Bắt đầu bằng hiệp khởi động';

  @override
  String get autoWarmupHint => 'Thêm các hiệp tăng dần khi mở buổi tập.';

  @override
  String get trainReminder => 'Nhắc nhở tập luyện';

  @override
  String get trainReminderHint => 'Lời nhắc vào giờ này, chỉ vào những ngày có giáo án tập.';

  @override
  String get reminderExactTime => 'Giờ chính xác';

  @override
  String get toastSoundSetting => 'Âm thông báo';

  @override
  String get toastSoundHint => 'Tiếng chuông nhẹ với mỗi thông báo';

  @override
  String get notifTrainChannel => 'Nhắc nhở tập luyện';

  @override
  String get notifTrainChannelWhy => 'Lời nhắc tập vào những ngày bạn đã lên kế hoạch.';

  @override
  String get notifTrainTitle => 'Đến giờ tập rồi';

  @override
  String get notifTrainBody => 'Giáo án tập của bạn đang chờ.';

  @override
  String get planIntro => 'Hãy xây cho tôi một giáo án tập chỉ dùng các bài tập trong danh sách này.';

  @override
  String get planFormat => 'Chỉ trả lời bằng JSON, theo dạng sau:';

  @override
  String get planNothing => 'Không có bài tập nào trong tệp đó khớp với thư viện của bạn';

  @override
  String get planFailed => 'Tệp đó không phải là giáo án tập mà ứng dụng đọc được';

  @override
  String get routineGroup => 'Nhóm';

  @override
  String get newGroup => 'Nhóm mới';

  @override
  String get noGroup => 'Không có nhóm';

  @override
  String get groupNameHint => 'Đẩy / Kéo / Chân, 5×5…';

  @override
  String get filters => 'Bộ lọc';

  @override
  String get setsPlannedHint =>
      'Chọn số hiệp bạn muốn cho mỗi bài. Buổi tập sẽ mở ra với các hiệp đó sẵn sàng.';

  @override
  String get nextTime => 'LẦN SAU';

  @override
  String get nextHold => 'giữ mức tạ cho đến khi đạt đủ mọi lần lặp';

  @override
  String get bgPhoto => 'Ảnh của bạn';

  @override
  String get bgPhotoPick => 'Chọn ảnh';

  @override
  String get bgPhotoChange => 'Đổi ảnh';

  @override
  String get bgPhotoRemove => 'Gỡ ảnh';

  @override
  String get bgDim => 'ĐỘ TỐI';

  @override
  String get dimSoft => 'Nhẹ';

  @override
  String get dimMedium => 'Vừa';

  @override
  String get dimStrong => 'Mạnh';

  @override
  String get bgPhotoHint => 'Ảnh nằm phía sau mọi thứ, được làm tối để ứng dụng vẫn dễ đọc.';

  @override
  String get reminderSmart => 'Thông minh';

  @override
  String get reminderFixed => 'Giờ cố định';

  @override
  String get reminderSmartHint =>
      'Dùng những ngày và giờ bạn thực sự tập, và im lặng vào ngày bạn đã tập rồi.';

  @override
  String get reminderSmartEmpty => 'Ghi thêm vài buổi tập nữa và nó sẽ học được những ngày bạn tập.';

  @override
  String habitFocus(String day) {
    return 'những gì bạn thường tập vào $day';
  }

  @override
  String get duplicateRoutine => 'Nhân bản giáo án tập';

  @override
  String copySuffix(String name) {
    return '$name (bản sao)';
  }

  @override
  String get saveAsRoutine => 'LƯU THÀNH GIÁO ÁN TẬP';

  @override
  String get savedAsRoutine => 'Đã lưu thành giáo án tập';

  @override
  String get templates => 'Giáo án dựng sẵn';

  @override
  String get templatesHint =>
      'Các chương trình kinh điển, dựng từ chính thư viện của bạn. Bạn có thể thay đổi mọi thứ sau đó.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã thêm $n giáo án tập');
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Ba ngày toàn thân mỗi tuần. Giáo án nên bắt đầu.';

  @override
  String get tplPpl => 'Đẩy, kéo và chân. Ba hoặc sáu ngày mỗi tuần.';

  @override
  String get tplArnold => 'Ngực và lưng, vai và tay, chân. Lịch chia sáu ngày kinh điển.';

  @override
  String get tplUpperlower => 'Thân trên và thân dưới, bốn ngày mỗi tuần.';

  @override
  String get tplStronglifts => 'Hai buổi tập luân phiên, năm hiệp năm lần lặp.';

  @override
  String get tplStartingstrength => 'Squat mỗi buổi, hai buổi tập luân phiên.';

  @override
  String get tplHome => 'Chỉ cần một thanh xà để treo và mặt sàn.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ngày');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Ghi mức gắng sức (RPE)';

  @override
  String get rpeHint => '10 là cạn sức hoàn toàn, 8 là còn dư hai lần lặp.';

  @override
  String get superset => 'Siêu hiệp';

  @override
  String get supersetLink => 'Nối với bài tiếp theo';

  @override
  String get supersetUnlink => 'Tách khỏi bài tiếp theo';

  @override
  String get supersetHint => 'Không nghỉ giữa các bài được nối, bạn chuyển thẳng sang bài tiếp theo.';

  @override
  String get aiRoutine => 'Giáo án tập với AI';

  @override
  String get aiIntro =>
      'GymMane không bao giờ kết nối với AI. Bạn lấy danh sách bài tập ra, dán vào trợ lý mà bạn vẫn dùng, rồi mang câu trả lời của nó trở lại. Không gì tự rời khỏi điện thoại.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n tên không có trong thư viện của bạn',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Đọc được từ những ứng dụng nào';

  @override
  String get importOtherCsv => 'Bất kỳ tệp CSV nào khác có ngày, bài tập, số lần lặp và mức tạ';

  @override
  String get importAskApp => 'Cần ứng dụng khác? Hãy đề xuất';

  @override
  String get awardFirstStepName => 'Bước đầu tiên';

  @override
  String get awardFirstStepLine => 'Chào mừng đến với GymMane. Huy chương này là quà tặng.';

  @override
  String get awardFirstWorkoutName => 'Buổi tập đầu tiên';

  @override
  String get awardFirstWorkoutLine => 'Buổi đầu tiên đã được ghi. Đó là buổi khó nhất.';

  @override
  String get awardFirstRoutineName => 'Giáo án tập đầu tiên';

  @override
  String get awardFirstRoutineLine => 'Bạn đã có một kế hoạch để quay lại.';

  @override
  String get awardFirstRecordName => 'Kỷ lục đầu tiên';

  @override
  String get awardFirstRecordLine => 'Bạn đã vượt mức tạ tốt nhất của mình ở một bài tập.';

  @override
  String get awardStreak3Name => 'Ba ngày liền';

  @override
  String get awardStreak3Line => 'Ba ngày liên tiếp. Mọi thứ bắt đầu như thế đấy.';

  @override
  String get awardTonne1Name => 'Một tấn';

  @override
  String get awardTonne1Line => 'Một nghìn kilôgam đã được nâng qua các hiệp của bạn.';

  @override
  String get awardSets100Name => 'Một trăm hiệp';

  @override
  String get awardSets100Line => 'Một trăm hiệp đã xong, từng hiệp một.';

  @override
  String get awardHours10Name => 'Mười giờ';

  @override
  String get awardHours10Line => 'Mười giờ tập luyện trên đồng hồ.';

  @override
  String get awardWorkouts50Name => 'Năm mươi buổi tập';

  @override
  String get awardWorkouts50Line => 'Năm mươi buổi tập đã ở phía sau.';

  @override
  String get awardHours50Name => 'Năm mươi giờ';

  @override
  String get awardHours50Line => 'Năm mươi giờ trong phòng tập.';

  @override
  String get awardsTitle => 'Huy chương';

  @override
  String get yearTitle => 'Năm của bạn';

  @override
  String get yearBestMonth => 'Tháng tốt nhất';

  @override
  String get yearMonths => 'tháng';

  @override
  String get awardSpinHint => 'Kéo huy chương để xoay';

  @override
  String get awardUnlocked => 'Đã mở khóa thành tích mới';

  @override
  String get awardNice => 'Tuyệt vời!';

  @override
  String get awardSaveImage => 'Lưu ảnh';

  @override
  String get awardSaved => 'Đã lưu vào thư viện ảnh';

  @override
  String get awardStreak7Name => 'Bảy ngày';

  @override
  String get awardStreak7Line => 'Trọn một tuần không bỏ ngày nào.';

  @override
  String get awardStreak30Name => 'Ba mươi ngày';

  @override
  String get awardStreak30Line => 'Một tháng liên tục. Giờ đây đã thành thói quen.';

  @override
  String get awardWorkouts100Name => 'Một trăm buổi tập';

  @override
  String get awardWorkouts100Line => 'Một trăm buổi tập đã ghi, từ đầu đến cuối.';

  @override
  String get awardTonnes100Name => 'Một trăm tấn';

  @override
  String get awardTonnes100Line => 'Tất cả những gì bạn đã nâng cộng lại được 100.000 kg.';

  @override
  String get awardSets1000Name => 'Một nghìn hiệp';

  @override
  String get awardSets1000Line => 'Từng hiệp một, đủ một nghìn hiệp.';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get editProfile => 'Sửa hồ sơ';

  @override
  String get pickBadge => 'Huy hiệu';

  @override
  String get statWorkouts => 'Buổi tập';

  @override
  String get statTrained => 'Đã tập';

  @override
  String get statSets => 'Hiệp';

  @override
  String get statLifted => 'Đã nâng';

  @override
  String get statStreak => 'Chuỗi ngày';

  @override
  String get statDays => 'ngày';

  @override
  String get unitHours => 'giờ';

  @override
  String get unitDays => 'ngày';

  @override
  String get snapshots => 'Ảnh';

  @override
  String get snapNow => 'Chụp một tấm';

  @override
  String get addCover => 'Thêm ảnh bìa';

  @override
  String get addTodayWidget => 'Hôm nay đã tập chưa';

  @override
  String get photosCard => 'Ảnh của bạn';

  @override
  String get handleLabel => 'Tên người dùng';

  @override
  String get setupTitle => 'Điền những mục này và phần còn lại của trang sẽ tự hoàn thiện';

  @override
  String get setupHint => 'Mọi con số ở đây đều đến từ những gì bạn ghi. Không gửi gì đi đâu cả.';

  @override
  String get setupWorkout => 'Ghi buổi tập đầu tiên';

  @override
  String get setupWeight => 'Ghi lại cân nặng';

  @override
  String get setupMeasures => 'Đo các số đo cơ thể';

  @override
  String get setupPhoto => 'Chụp ảnh tiến độ đầu tiên';

  @override
  String get progressTitle => 'Tiến độ';

  @override
  String get tileVolume30 => 'Khối lượng · 30 ngày';

  @override
  String get tileAddWeight => 'Thêm của bạn';

  @override
  String get heatToneTitle => 'Màu nhiệt';

  @override
  String get heatToneHint => 'Chỉ thay đổi cách tô màu lưới và cơ thể.';

  @override
  String get thisWeekTitle => 'Tuần này';

  @override
  String get momentsEmptyTitle => 'Chưa có gì ở đây';

  @override
  String get deletePhotoTitle => 'Xóa ảnh này?';

  @override
  String get deletePhotoBody => 'Ảnh sẽ bị xóa vĩnh viễn.';

  @override
  String get awardsEarned => 'Đã đạt';

  @override
  String get awardsLocked => 'Chưa mở khóa';

  @override
  String get awardStreak100Name => 'Một trăm ngày';

  @override
  String get awardWorkouts10Name => 'Mười buổi tập';

  @override
  String get awardWorkouts10Line => 'Mười buổi đầu tiên là những buổi quyết định.';

  @override
  String get awardWorkouts365Name => 'Ba trăm sáu mươi lăm';

  @override
  String get awardWorkouts365Line => 'Mỗi ngày trong năm một buổi tập, ghi lại từng buổi một.';

  @override
  String get awardTonnes10Name => 'Mười tấn';

  @override
  String get awardTonnes10Line => 'Mười nghìn kilôgam đã đi qua tay bạn.';

  @override
  String get awardHours100Name => 'Một trăm giờ';

  @override
  String get awardHours100Line => 'Một trăm giờ dưới thanh đòn, tay cầm đồng hồ bấm giờ.';

  @override
  String awardWonOn(String date) {
    return 'Đạt được vào $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Vàng',
      'blue': 'Xanh dương',
      'green': 'Xanh lá',
      'other': 'Huy hiệu',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Từ $date';
  }

  @override
  String levelShort(int n) {
    return 'Cấp $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Còn $n buổi tập để lên cấp $next');
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n cm';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'Than hồng',
      'green': 'Xanh lá',
      'blue': 'Xanh dương',
      'mono': 'Xám',
      'other': 'Màu',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n hiệp';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n/$goal trong tuần này';
  }

  @override
  String momentCount(int n) {
    return '$n ảnh';
  }

  @override
  String photosSelected(int n) {
    return 'Đã chọn $n';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Xóa $n ảnh?';
  }

  @override
  String get momentsEmptyHint =>
      'Chụp phòng tập, tấm bảng trắng, cách lắp bánh tạ. Bất cứ điều gì bạn muốn ghi nhớ. Ảnh chỉ nằm trên điện thoại và chỉ bạn xem được.';

  @override
  String get awardStreak100Line =>
      'Một trăm ngày liên tiếp. Đó không còn là động lực nữa, đó là con người bạn.';

  @override
  String get coverLabel => 'ẢNH BÌA';

  @override
  String get removeCover => 'Gỡ ảnh bìa';

  @override
  String get startTitle => 'Bắt đầu tập';

  @override
  String get logTitle => 'Ghi buổi tập';

  @override
  String get logHint => 'Không hẹn giờ, chỉ cần điền những gì bạn đã tập.';

  @override
  String get orStartFrom => 'Hoặc bắt đầu từ';

  @override
  String get pickExercisesOption => 'Chọn bài tập';

  @override
  String get chooseFocusOption => 'Chọn trọng tâm';

  @override
  String get plannedRoutine => 'ĐÃ LÊN LỊCH';

  @override
  String get logWorkoutAction => 'GHI BUỔI TẬP';

  @override
  String get logging => 'ĐANG GHI';

  @override
  String get placesLabel => 'Địa điểm của tôi';

  @override
  String get undo => 'Hoàn tác';

  @override
  String get deleteSet => 'Xóa hiệp';

  @override
  String get setDeleted => 'Đã xóa hiệp';

  @override
  String get removeWarmup => 'Gỡ khởi động';

  @override
  String get addWeightAction => 'Thêm cân nặng';

  @override
  String get workoutOverview => 'Buổi tập này';

  @override
  String get allExercisesShort => 'Tất cả';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total hiệp';
  }

  @override
  String get nowLabel => 'Bây giờ';

  @override
  String get deleteWorkout => 'Xóa buổi tập';

  @override
  String get deleteWorkoutBody => 'Buổi tập này và tất cả các hiệp của nó sẽ bị xóa khỏi lịch sử.';

  @override
  String get themeAuto => 'Tự động';

  @override
  String get themeAutoHint => 'Theo điện thoại';

  @override
  String get demoSizeTitle => 'Minh họa bài tập khi tập';

  @override
  String get demoLarge => 'Lớn';

  @override
  String get demoSmall => 'Nhỏ';

  @override
  String get demoOff => 'Ẩn';

  @override
  String get demoLoopTitle => 'Hình động minh họa';

  @override
  String get demoLoopAlways => 'Lặp lại';

  @override
  String get demoLoopShort => '10 giây';

  @override
  String get demoLoopHint => 'Phát khoảng 10 giây và dừng ở tư thế bắt đầu. Chạm vào minh họa để xem lại.';

  @override
  String get alarmStyleTitle => 'Khi hết giờ nghỉ';

  @override
  String get alarmStyleLoud => 'Luôn đổ chuông';

  @override
  String get alarmStyleQuiet => 'Theo chế độ im lặng';

  @override
  String get alarmStyleVibrate => 'Chỉ rung';

  @override
  String get alarmStyleHint =>
      'Luôn đổ chuông dùng âm lượng báo thức, kể cả khi đang im lặng. Theo chế độ im lặng dùng âm lượng thông báo và chỉ rung khi điện thoại tắt tiếng.';

  @override
  String get suggestedPicks => 'Gợi ý cho bạn';

  @override
  String get moreOptions => 'Thêm tùy chọn';

  @override
  String get suggestInWorkouts => 'Gợi ý trong buổi tập nhanh';

  @override
  String get suggestInWorkoutsHint =>
      'Khi tắt, bài này sẽ không xuất hiện trong các gợi ý dành cho bạn. Bạn vẫn có thể tự thêm.';

  @override
  String get onbPlaceTitle => 'Bạn tập ở đâu?';

  @override
  String get onbPlaceWhy => 'Chọn mọi nơi bạn tập. Chúng tôi sẽ chỉ gợi ý những gì bạn tập được ở từng nơi.';

  @override
  String get onbPlaceGear => 'Ở đó bạn có gì?';

  @override
  String distanceCol(String unit) {
    return 'QUÃNG ĐƯỜNG ($unit)';
  }

  @override
  String get timeCol => 'THỜI GIAN';

  @override
  String get timePerSideCol => 'THỜI GIAN / BÊN';

  @override
  String get timeMinutesTitle => 'Thời gian (phút)';

  @override
  String get timeSecondsTitle => 'Thời gian (giây)';

  @override
  String distanceTitle(String unit) {
    return 'Quãng đường ($unit)';
  }

  @override
  String get holdLabel => 'Giữ';

  @override
  String get stopLabel => 'Dừng';

  @override
  String startHold(String time) {
    return 'Bắt đầu · $time';
  }

  @override
  String get exerciseTypeLabel => 'Ghi theo';

  @override
  String get typeReps => 'Lần lặp & mức tạ';

  @override
  String get typeTime => 'Thời gian';

  @override
  String get typeCardio => 'Quãng đường & thời gian';

  @override
  String get exerciseTypeHint =>
      'Cardio như chạy bộ hay bơi được ghi theo quãng đường và thời gian. Bài giữ tư thế như plank được ghi theo thời gian.';

  @override
  String get howToLabel => 'Cách tập (không bắt buộc)';

  @override
  String get howToHint => 'Mỗi dòng một bước';

  @override
  String get editExercise => 'Sửa bài tập';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get noStepsYet => 'Chưa có bước nào. Hãy tự viết để nhớ cách bạn tập.';

  @override
  String get addSteps => 'Viết các bước';

  @override
  String get setTypeRestPause => 'Hiệp nghỉ ngắn';

  @override
  String get setTypeNormalInfo => 'Một hiệp bình thường. Được tính vào khối lượng và kỷ lục của bạn.';

  @override
  String get setTypeWarmupInfo => 'Các hiệp nhẹ để làm nóng. Không tính vào khối lượng hay kỷ lục.';

  @override
  String get setTypeDropInfo => 'Ngay sau một hiệp, giảm mức tạ và tập tiếp mà không nghỉ.';

  @override
  String get setTypeFailureInfo =>
      'Tập tiếp cho đến khi không thể làm thêm một lần lặp chuẩn nào nữa. Ghi số lần lặp bạn thực sự làm được.';

  @override
  String get setTypeRestPauseInfo => 'Nghỉ 10 đến 20 giây sau hiệp, rồi cố làm thêm vài lần lặp nữa.';

  @override
  String get planFormatNotes =>
      'Dùng tên bài tập đúng như trong danh sách. \"sets\", \"reps\", \"weight\" (theo đơn vị đã cho), \"rest\" tính bằng giây và \"days\" là không bắt buộc. \"superset\": true nối một bài tập với bài tiếp theo. Với nhiều tuần, hãy nhóm các giáo án tập trong \"weeks\" như ví dụ thứ hai.';

  @override
  String get planSets => 'Lên kế hoạch hiệp';

  @override
  String get planSetsHint =>
      'Chọn loại, số lần lặp và mức tạ của từng hiệp. Để mức tạ ở Tự động để bắt đầu từ buổi tập trước.';

  @override
  String get planHintReps => 'Chọn loại và số lần lặp của từng hiệp. Tự động sẽ bắt đầu từ buổi tập trước.';

  @override
  String get planHintTime => 'Chọn loại và thời gian của từng hiệp. Tự động sẽ bắt đầu từ buổi tập trước.';

  @override
  String get planHintTimeWeight =>
      'Chọn loại, thời gian và mức tạ của từng hiệp. Tự động sẽ bắt đầu từ buổi tập trước.';

  @override
  String get planHintCardio =>
      'Chọn quãng đường và thời gian của từng hiệp. Tự động sẽ bắt đầu từ buổi tập trước.';

  @override
  String get timeOnly => 'Chỉ thời gian';

  @override
  String get autoValue => 'Tự động';

  @override
  String get clearPlan => 'Xóa kế hoạch';

  @override
  String get shareRoutine => 'Chia sẻ giáo án tập';

  @override
  String get shareWeek => 'Chia sẻ tuần của tôi';

  @override
  String get shareWeekHint => 'Tất cả giáo án tập của bạn và ngày của từng giáo án.';

  @override
  String shareMessage(String name) {
    return '$name: mở tệp bằng GymMane để thêm vào.';
  }

  @override
  String get importRoutines => 'Nhập giáo án tập';

  @override
  String get importPasteHint =>
      'Dán giáo án tập vào đây: giáo án được chia sẻ từ GymMane, câu trả lời của AI, JSON hoặc CSV.';

  @override
  String get pasteAction => 'Dán';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giáo án tập');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Dùng cả lịch tập hằng tuần của nó';

  @override
  String get useTheirScheduleHint =>
      'Các ngày đi kèm sẽ thay thế những gì bạn đã lên kế hoạch vào các ngày đó.';

  @override
  String get addToMyRoutines => 'Thêm vào giáo án tập của tôi';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã thêm $n giáo án tập');
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Không có gì ở đây mà GymMane có thể nhập';

  @override
  String get aiStepCopy =>
      'Sao chép yêu cầu. Nó chứa danh sách bài tập của bạn và định dạng mà GymMane đọc được.';

  @override
  String get aiStepAsk =>
      'Dán vào bất kỳ AI nào và nói điều bạn muốn: số ngày mỗi tuần, mục tiêu, bao nhiêu tuần.';

  @override
  String get aiStepPaste => 'Dán câu trả lời của nó vào bên dưới và nhập. Không cần tệp.';

  @override
  String get copyForAi => 'Sao chép cho AI';

  @override
  String get copiedDone => 'Đã sao chép';

  @override
  String get aiPasteHint => 'Dán câu trả lời của AI vào đây';

  @override
  String get importAction => 'Nhập';

  @override
  String get showFormat => 'Xem định dạng';

  @override
  String get shareAsFile => 'Chia sẻ dưới dạng tệp';

  @override
  String get recoveryTab => 'Phục hồi';

  @override
  String recoveryOverall(int pct) {
    return 'Cơ thể đã phục hồi $pct%';
  }

  @override
  String get recoveryAllFresh => 'Mọi thứ đã phục hồi. Hôm nay tập gì cũng được.';

  @override
  String recoveryStill(String muscles) {
    return 'Vẫn đang phục hồi: $muscles';
  }

  @override
  String get recoveryTired => 'Mỏi';

  @override
  String get recoveryFresh => 'Khỏe';

  @override
  String get recoveryHint =>
      'Chạm vào một nhóm cơ để xem nó đã phục hồi đến đâu. Các hiệp gần đây có trọng số lớn hơn, và hiệp nặng hơn (theo RPE) càng lớn hơn nữa.';

  @override
  String recoveryPct(int pct) {
    return 'Đã phục hồi $pct%';
  }

  @override
  String readyInHours(int h) {
    return 'sẵn sàng sau ~$h giờ';
  }

  @override
  String get tplAbcd => 'Bốn ngày: ngực và tay sau, lưng và tay trước, chân, vai và bụng.';

  @override
  String get tplAbcde => 'Năm ngày, mỗi ngày một nhóm cơ: ngực, lưng, chân, vai, tay.';

  @override
  String get elapsedCaps => 'ĐÃ TRÔI QUA';

  @override
  String get tapToChange => 'Chạm để thay đổi';

  @override
  String get swipeToSkipHint => 'Vuốt ngang hẹn giờ để bỏ qua thời gian nghỉ.';

  @override
  String get screenLocked => 'Đã khóa màn hình';

  @override
  String get lockedHint => 'Nhấn giữ biểu tượng vân tay ở trên cùng để mở khóa';

  @override
  String get liveDoneSet => 'Xong hiệp';

  @override
  String get liveSkipRest => 'Bỏ qua nghỉ';

  @override
  String get livePause => 'Tạm dừng';

  @override
  String get liveResume => 'Tiếp tục';

  @override
  String get liveNext => 'Tiếp';

  @override
  String liveUpNext(String name) {
    return 'Tiếp theo: $name';
  }

  @override
  String get stickerOpen => 'Chia sẻ trên ảnh';

  @override
  String get stickerNoPhoto => 'Không có ảnh';

  @override
  String get stickerWorkout => 'Buổi tập';

  @override
  String get stickerStreak => 'Chuỗi ngày';

  @override
  String get stickerDate => 'Ngày';

  @override
  String get stickerHint => 'Kéo để di chuyển, chụm hai ngón để đổi cỡ hoặc xoay';

  @override
  String get stickerSaved => 'Đã lưu vào thư viện ảnh';

  @override
  String get stickerWeek => 'Tuần này';

  @override
  String get getReady => 'Chuẩn bị';

  @override
  String sideOfTwo(String n) {
    return 'Bên $n/2';
  }

  @override
  String get switchSides => 'Đổi bên';

  @override
  String get stickerGallery => 'Thư viện ảnh';

  @override
  String get stickerCamera => 'Máy ảnh';

  @override
  String get shareIntroTitle => 'Chia sẻ giáo án tập này';

  @override
  String get shareIntroBody =>
      'Gửi cho bạn tập, bạn bè hoặc gia đình. Họ sẽ nhận một tệp nhỏ mở được bằng GymMane và thêm vào chỉ với một lần chạm, kèm các hiệp và mức tạ.';

  @override
  String get removedFromRoutine => 'Đã gỡ khỏi giáo án tập';

  @override
  String get radarTitle => '30 ngày qua';

  @override
  String get radarHint => 'Xem vùng nào cần tập thêm';

  @override
  String get radarEmpty => 'Tập vài ngày để xem mức cân bằng';

  @override
  String get radarBalanced => 'Đến giờ vẫn cân bằng tốt';

  @override
  String radarFocus(String list) {
    return 'Cần tập thêm: $list';
  }

  @override
  String get countdownReady => 'Chuẩn bị';

  @override
  String get countdownSkip => 'Chạm để bắt đầu ngay';

  @override
  String get countdownSetting => 'Đếm ngược trước khi bắt đầu';

  @override
  String get effortSetting => 'Ghi mức gắng sức mỗi hiệp';

  @override
  String get effortHint =>
      'RPE: 10 là cạn sức hoàn toàn, 8 là còn dư hai lần lặp. RIR đếm số lần lặp bạn còn dư. Khi một hiệp có giá trị này, 1RM ước tính sẽ dùng bảng RPE.';

  @override
  String get rirHint => '0 là cạn sức hoàn toàn, 2 là còn dư hai lần lặp.';

  @override
  String get addWeekWidget => 'Thêm tiện ích tuần';

  @override
  String get gamificationSetting => 'Huy chương và cấp';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n lần lặp');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Hiệp tốt nhất';

  @override
  String get weekStartSetting => 'Tuần bắt đầu vào';

  @override
  String get stepOutOfWorkout => 'Tạm dừng và thoát';

  @override
  String get saveToRoutine => 'LƯU THAY ĐỔI VÀO GIÁO ÁN TẬP';

  @override
  String get routineUpdated => 'Đã cập nhật giáo án tập';

  @override
  String saveChangesTitle(String name) {
    return 'Lưu thay đổi vào $name?';
  }

  @override
  String get saveChangesBody => 'Lần sau khi bạn bắt đầu, giáo án tập sẽ có những thay đổi này.';

  @override
  String get routineOrderChanged => 'Thứ tự bài tập mới';

  @override
  String get mineOnly => 'Do bạn tạo';

  @override
  String createNamed(String name) {
    return 'Không có ở đây? Tạo “$name”';
  }

  @override
  String get orStartWith => 'Hoặc bắt đầu với';

  @override
  String get warmupFocus => 'Khởi động';

  @override
  String get warmupFocusHint => 'Linh hoạt và kích hoạt cơ, có hoặc không có dụng cụ';

  @override
  String get cardioFocus => 'Cardio';

  @override
  String get cardioFocusHint => 'Chạy, đạp xe, chèo thuyền hoặc nhảy dây, theo quãng đường và thời gian';

  @override
  String get homeRecommended => 'Gợi ý trên trang chủ';

  @override
  String get homeRoutines => 'Giáo án tập trên trang chủ';

  @override
  String get homeRoutinesHint => 'Tập gần nhất lên đầu';

  @override
  String get homeWeekStats => 'Tuần này trên trang chủ';

  @override
  String get homeWeekStatsHint => 'Khối lượng, số hiệp và kỷ lục trong tuần';

  @override
  String get stepsSetting => 'Số bước từ Health Connect';

  @override
  String get stepsSettingHint => 'Số bước hôm nay trên Trang chủ';

  @override
  String get stepsToday => 'Số bước hôm nay';

  @override
  String stepsOfGoal(String goal) {
    return 'trên $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count bước hôm nay';
  }

  @override
  String get stepsGoal => 'Mục tiêu số bước mỗi ngày';

  @override
  String get stepsNoAccess => 'Không có quyền truy cập số bước';

  @override
  String get stepsGrant => 'Chạm để cho phép trong Health Connect';

  @override
  String get stepsInfoRead =>
      'Chỉ đọc số bước của bạn. Không bao giờ đọc gì khác hay ghi vào Health Connect.';

  @override
  String get stepsInfoLocal =>
      'Số bước chỉ nằm trên điện thoại của bạn. GymMane không bao giờ kết nối internet.';

  @override
  String get stepsInfoOff => 'Tắt bất cứ lúc nào trong Cài đặt hoặc trong Health Connect.';

  @override
  String get stepsManage => 'Quản lý quyền';

  @override
  String get routineDoneToday => 'Đã xong hôm nay · làm tốt lắm';

  @override
  String get trainAgain => 'Tập lại';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ngày trước',
      one: 'Đã tập hôm qua',
      zero: 'Đã tập hôm nay',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Đã lưu trữ';

  @override
  String get archiveExercise => 'Lưu trữ bài tập';

  @override
  String get restoreExercise => 'Khôi phục';

  @override
  String get archivedToast => 'Đã lưu trữ bài tập';

  @override
  String get archivedToastHint => 'Tìm trong Bài tập › Đã lưu trữ';

  @override
  String get archivedBanner =>
      'Đã lưu trữ. Bài này không xuất hiện trong danh sách và gợi ý; lịch sử của bạn vẫn được giữ.';

  @override
  String get videoMarksHint => 'Tạm dừng ở một bước và chạm vào ghim để lần sau nhảy thẳng đến đó.';

  @override
  String get videoMarkHere => 'Đánh dấu bước này ở đây';

  @override
  String get sectionGeneral => 'Chung';

  @override
  String get sectionTraining => 'Tập luyện';

  @override
  String get sectionAlerts => 'Nhắc nhở & chuông báo';

  @override
  String get sectionHome => 'Trang chủ';

  @override
  String get sectionWidgets => 'Tiện ích';

  @override
  String get sectionData => 'Dữ liệu & sao lưu';

  @override
  String get multiPlanSetting => 'Nhiều giáo án tập mỗi ngày';

  @override
  String get multiPlanHint => 'Chạm vào mọi giáo án tập cho ngày này. Chúng được xếp theo thứ tự bạn thêm.';

  @override
  String routineOfDay(int n, int total) {
    return '$n/$total hôm nay';
  }

  @override
  String get nextToday => 'Tiếp theo hôm nay';

  @override
  String get planAboutMe => 'Về tôi:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age tuổi, cao $height, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Tôi muốn tập $n ngày mỗi tuần.';
  }

  @override
  String get planNoHistory =>
      'Chưa ghi buổi tập nào: hãy coi tôi là người mới bắt đầu và giữ khối lượng cũng như mức tạ ở mức thận trọng.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Đã ghi $n buổi tập trong 30 ngày qua.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Các hiệp tốt nhất gần đây';

  @override
  String get planAskFirst =>
      'Nếu bạn chưa biết mục tiêu của tôi (sức mạnh, cơ bắp, giảm mỡ hay thể lực chung) hoặc mỗi buổi tập có thể kéo dài bao lâu, hãy hỏi tôi trước trong một tin nhắn ngắn. Khi đã biết, chỉ trả lời bằng JSON.';

  @override
  String get backToTop => 'Lên đầu trang';

  @override
  String get deleteExerciseTitle => 'Xóa bài tập này?';

  @override
  String deleteExerciseBody(String name) {
    return '“$name” sẽ bị xóa khỏi thư viện và các giáo án tập của bạn. Các hiệp đã tập vẫn được giữ.';
  }

  @override
  String get exportForStravaHint =>
      'Tải lên trong trình duyệt tại strava.com/upload/select (ứng dụng Strava không nhập được tệp). Buổi tập sẽ hiện dưới dạng Weight Training cùng các hiệp của bạn.';

  @override
  String get manualStartTime => 'Giờ bắt đầu';

  @override
  String get manualDuration => 'Thời lượng';

  @override
  String get manualDurationUnset => 'Thêm thời lượng';

  @override
  String get stravaRow => 'Xuất sang Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Chọn một buổi tập để đưa sang Strava. Bạn sẽ nhận được tệp .fit: tải lên trong trình duyệt tại strava.com/upload/select và buổi tập sẽ hiện dưới dạng Weight Training cùng các hiệp của bạn.';

  @override
  String get stravaEmpty => 'Chưa có buổi tập nào để xuất.';

  @override
  String get tapToPause => 'Chạm để tạm dừng';

  @override
  String get holdPausedHint => 'Đã tạm dừng · chạm để tiếp tục';

  @override
  String get finishHoldNow => 'Kết thúc hiệp ngay';

  @override
  String get barWeightExercise => 'Mức tạ của thanh đòn hoặc xe trượt';

  @override
  String get barWeightHint => 'Dùng cho công cụ tính bánh tạ';

  @override
  String get barWeightCustom => 'Của riêng bạn · chạm để đặt lại';

  @override
  String get groupRename => 'Đổi tên nhóm';

  @override
  String get groupUngroup => 'Gỡ nhóm, giữ giáo án tập';

  @override
  String get groupDeleteAll => 'Xóa nhóm và giáo án tập';

  @override
  String groupDeleteTitle(String name) {
    return 'Xóa “$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count sẽ bị xóa. Lịch sử buổi tập của bạn vẫn được giữ.';
  }

  @override
  String get tplRr =>
      'Giáo án kinh điển của r/bodyweightfitness: toàn thân ba ngày mỗi tuần. Lên bậc tiếp theo khi thấy dễ.';

  @override
  String get levelUpKicker => 'BẬC TIẾP THEO';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps ở $name hai buổi tập liên tiếp. Sẵn sàng cho bậc tiếp theo chưa?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Thay vào $routine';
  }

  @override
  String get levelUpSee => 'Xem cách tập';

  @override
  String get levelUpLater => 'Để sau';

  @override
  String get levelUpStay => 'Giữ bài này';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name giờ đã có trong $routine';
  }

  @override
  String get levelUpStayed => 'Không gợi ý lên bậc cho bài này nữa';

  @override
  String get levelHintsSetting => 'Gợi ý bậc tiếp theo';

  @override
  String get heatmapLabelsSetting => 'Ngày và tháng trên bản đồ hoạt động';

  @override
  String get rmPercent => 'PHẦN TRĂM';

  @override
  String rmAtPercent(String pct) {
    return '$pct mức tối đa của bạn';
  }

  @override
  String get copyWorkout => 'Sao chép dạng văn bản';

  @override
  String get goalSet => 'Đặt mục tiêu';

  @override
  String get goalTargetReps => 'SỐ LẦN LẶP MỤC TIÊU';

  @override
  String goalToGo(String value) {
    return 'Còn $value';
  }

  @override
  String get goalReached => 'Đã đạt mục tiêu';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Còn $n ngày');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Đã quá hạn';

  @override
  String get goalDeadline => 'HẠN CHÓT';

  @override
  String get goalNoDeadline => 'Không có hạn chót';

  @override
  String get goalRemove => 'Gỡ mục tiêu';

  @override
  String get exerciseNameMissing => 'Hãy đặt tên cho bài tập';

  @override
  String get aliasesLabel => 'Tên khác (không bắt buộc)';

  @override
  String get aliasesHint => 'Các tên khác, cách nhau bằng dấu phẩy';

  @override
  String alsoCalled(String names) {
    return 'Còn gọi là: $names';
  }

  @override
  String get addToRoutine => 'Thêm vào giáo án tập';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Có trong $n giáo án tập',
      zero: 'Chưa có trong giáo án tập nào',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Đã có trong đó';

  @override
  String get restInRoutine => 'Thời gian nghỉ trong giáo án tập này';

  @override
  String get restInRoutineHint => 'Giống như của bài tập';

  @override
  String get restInRoutineReset => 'Chỉ ở đây · chạm để hoàn tác';

  @override
  String get swapExercise => 'Đổi bài tập';

  @override
  String get swapShort => 'Đổi';

  @override
  String swapHint(String name) {
    return 'Thay cho $name, chỉ trong hôm nay. Khi kết thúc, bạn có thể giữ nó trong giáo án tập.';
  }

  @override
  String get swapKeepsDone => 'Các hiệp bạn đã tập vẫn được ghi; bài mới sẽ đảm nhận phần còn lại.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Cùng nhóm cơ · $muscle';
  }

  @override
  String get swapDoneBefore => 'Đã từng tập';

  @override
  String get multiPlanSettingHint => 'Nhiều hơn một giáo án tập trong cùng một thứ';

  @override
  String get levelHintsHint => 'Gợi ý phiên bản khó hơn';

  @override
  String get focusCardHint => 'Giáo án tập hôm nay, ở đầu Trang chủ';

  @override
  String get gamificationHint => 'Huy chương, cấp và ăn mừng';

  @override
  String get exerciseSettings => 'Cài đặt cho bài tập này';

  @override
  String get placeActiveNow => 'Bạn đang ở đây';

  @override
  String get placeTapToUse => 'chạm để tập ở đây';

  @override
  String get intervalDays => 'ngày';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target ngày';
  }

  @override
  String get toolNameRpe => 'Mức tạ theo RPE';

  @override
  String get toolTitleRpe => 'Mức tạ theo RPE';

  @override
  String get toolDescRpe => 'Mức tạ cho mức gắng sức bạn muốn';

  @override
  String get toolNameDots => 'Trình độ sức mạnh';

  @override
  String get toolTitleDots => 'Trình độ sức mạnh (DOTS)';

  @override
  String get toolDescDots => 'Sức mạnh so với cân nặng của bạn';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Cho $reps lần lặp ở RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Một hiệp bạn vừa tập';

  @override
  String get rpeGoal => 'Điều bạn muốn làm';

  @override
  String rpeOneRmLine(String value) {
    return '1RM ước tính: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 nghĩa là bạn không thể làm thêm lần nào; 8 nghĩa là bạn còn dư hai lần.';

  @override
  String get dotsBestLifts => 'Các mức tạ tốt nhất của bạn';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'ĐẨY NGỰC';

  @override
  String get dotsDeadlift => 'DEADLIFT';

  @override
  String dotsTotalLine(String value) {
    return 'Tổng: $value';
  }

  @override
  String get dotsExplain =>
      'So sánh sức mạnh của bạn với bất kỳ ai, dù họ nặng bao nhiêu. Dùng lần lặp đơn tốt nhất, hoặc 1RM ước tính của bạn.';

  @override
  String get dotsLevel0 => 'Mới bắt đầu';

  @override
  String get dotsLevel1 => 'Trung cấp';

  @override
  String get dotsLevel2 => 'Nâng cao';

  @override
  String get dotsLevel3 => 'Cao cấp';

  @override
  String get dotsLevel4 => 'Ưu tú';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Điểm Wilks';

  @override
  String get toolDescWilks => 'Điểm powerlifting kinh điển';

  @override
  String get wilksExplain =>
      'Công thức powerlifting kinh điển. DOTS đã thay thế nó từ năm 2020, nhưng nhiều giải đấu và bảng xếp hạng vẫn dùng.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Chỉ số khối không mỡ';

  @override
  String get toolDescFfmi => 'Lượng cơ so với chiều cao của bạn';

  @override
  String get ffmiBodyFat => 'MỠ CƠ THỂ';

  @override
  String ffmiLeanLine(String value) {
    return 'Khối nạc: $value';
  }

  @override
  String get ffmiExplain =>
      'Giống BMI, nhưng bỏ phần mỡ: chỉ tính khối nạc của bạn. Được điều chỉnh theo chiều cao để người cao và người thấp được so sánh công bằng.';

  @override
  String get ffmiLevel0 => 'Dưới trung bình';

  @override
  String get ffmiLevel1 => 'Trung bình';

  @override
  String get ffmiLevel2 => 'Trên trung bình';

  @override
  String get ffmiLevel3 => 'Xuất sắc';

  @override
  String get ffmiLevel4 => 'Đặc biệt';

  @override
  String get rpeEffortLabel => 'Mức gắng sức (RPE)';

  @override
  String get restRowHint => 'Giữa các hiệp, trừ khi bài tập có thời gian riêng';

  @override
  String get effortRowHint => 'Ghi RPE hoặc RIR ở mỗi hiệp';

  @override
  String get countdownHint => '3, 2, 1 trước hiệp đầu tiên';

  @override
  String get keepScreenOnHint => 'Màn hình luôn sáng khi bạn tập';

  @override
  String get demoSizeRowHint => 'Hình minh họa bài tập trong buổi tập';

  @override
  String get demoLoopRowHint => 'Hình động lặp lại hay dừng';

  @override
  String get trainReminderRowHint => 'Lời nhắc vào những ngày bạn tập';

  @override
  String get alarmSoundRowHint => 'Âm thanh phát khi hết giờ nghỉ';

  @override
  String get alarmStyleRowHint => 'Có đổ chuông ở chế độ im lặng hay không';

  @override
  String get recommendedRowHint => 'Bài tập chúng tôi gợi ý trên Trang chủ';

  @override
  String get weightStepSetting => 'Bước tăng mức tạ';

  @override
  String get weightStepHint => 'Lượng mà nút − và + thêm vào';

  @override
  String get prBestWorkout => 'Buổi tập tốt nhất';

  @override
  String get mergeExercise => 'Gộp';

  @override
  String mergeExerciseInto(String name) {
    return 'Gộp $name vào…';
  }

  @override
  String get mergeExerciseTitle => 'Gộp bài tập?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Toàn bộ lịch sử của “$from” sẽ chuyển sang “$to”. “$from” vẫn nằm trong thư viện của bạn. Không thể hoàn tác.';
  }

  @override
  String get mergedToast => 'Đã gộp lịch sử';

  @override
  String get nutrition => 'Dinh dưỡng';

  @override
  String get nutritionHomeEmpty => 'Nước, đạm và calo';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g đạm';
  }

  @override
  String get nutritionToday => 'Hôm nay';

  @override
  String get nutritionYesterday => 'Hôm qua';

  @override
  String get nutritionGoals => 'Mục tiêu hằng ngày';

  @override
  String get kcalLabel => 'CALO';

  @override
  String get kcalOver => 'vượt';

  @override
  String get waterLabel => 'NƯỚC';

  @override
  String get waterDone => 'Đã đạt mục tiêu';

  @override
  String get waterCustom => 'Lượng khác';

  @override
  String get glassSize => 'Cỡ ly';

  @override
  String get supplementsLabel => 'THỰC PHẨM BỔ SUNG';

  @override
  String get supplementsEmpty => 'Chạm vào một loại để thêm, hoặc + để tự thêm.';

  @override
  String get addSupplement => 'Thực phẩm bổ sung mới';

  @override
  String get supplementNameHint => 'Creatin, vitamin D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Gỡ $name?';
  }

  @override
  String get removeSupplementBody => 'Những ngày bạn đánh dấu đã dùng cũng sẽ bị xóa theo.';

  @override
  String get suppCreatine => 'Creatin';

  @override
  String get suppVitaminD => 'Vitamin D';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magie';

  @override
  String get suppMultivitamin => 'Vitamin tổng hợp';

  @override
  String get suppCaffeine => 'Caffein';

  @override
  String get myFoods => 'Thực phẩm của tôi';

  @override
  String get newFood => 'Thực phẩm mới';

  @override
  String get editFood => 'Sửa thực phẩm';

  @override
  String get foodNameHint => 'Whey protein, yến mạch, bánh mì…';

  @override
  String get servingLabel => 'KHẨU PHẦN';

  @override
  String get servingHint => '1 muỗng · 30 g';

  @override
  String get perServing => 'MỖI KHẨU PHẦN';

  @override
  String get servingsLabel => 'Số khẩu phần';

  @override
  String get foodPhotoHint => 'Trên nền trơn, ảnh sẽ biến thành nhãn dán.';

  @override
  String get cutoutWorking => 'Đang tách nền…';

  @override
  String get cutoutTry => 'Tách nền';

  @override
  String get cutoutKeep => 'Giữ cả ảnh';

  @override
  String deleteFoodTitle(String name) {
    return 'Xóa $name?';
  }

  @override
  String get deleteFoodBody => 'Sẽ bị gỡ khỏi danh sách thực phẩm của bạn. Những gì đã ghi vẫn được giữ.';

  @override
  String get mealBreakfast => 'Bữa sáng';

  @override
  String get mealLunch => 'Bữa trưa';

  @override
  String get mealDinner => 'Bữa tối';

  @override
  String get mealSnacks => 'Bữa phụ';

  @override
  String get nothingLogged => 'Chưa ghi gì.';

  @override
  String addToMeal(String meal) {
    return 'Thêm vào $meal';
  }

  @override
  String get quickAdd => 'Thêm nhanh';

  @override
  String get quickAddHint => 'Chỉ các con số, không lưu thành thực phẩm.';

  @override
  String get quickAddName => 'Đó là gì? (không bắt buộc)';

  @override
  String get logFood => 'Thêm';

  @override
  String loggedToast(String meal) {
    return 'Đã thêm vào $meal';
  }

  @override
  String get entryRemoved => 'Đã gỡ';

  @override
  String get goalsFromProfile => 'Tính từ hồ sơ của tôi';

  @override
  String get goalsFromProfileHint => 'Calo theo hồ sơ của bạn, 1,8 g đạm và 35 ml nước cho mỗi kg cân nặng.';

  @override
  String get kcalEaten => 'Đã ăn';

  @override
  String get kcalRemaining => 'Còn lại';

  @override
  String waterTapHint(String amount) {
    return 'Chạm vào ly: + $amount';
  }

  @override
  String get shakeEmpty => 'Chạm để chọn ly shake của bạn';

  @override
  String shakeTapHint(String name) {
    return 'Chạm: + $name';
  }

  @override
  String get shakePick => 'Ly shake của bạn';

  @override
  String get shakePickHint => 'Chạm vào bình lắc và nó sẽ được ghi ngay.';

  @override
  String get proteinLetter => 'Đ';

  @override
  String get carbsLetter => 'T';

  @override
  String get fatLetter => 'B';

  @override
  String get addBurnedLabel => 'Cộng calo đã đốt';

  @override
  String get addBurnedHint =>
      'Mục tiêu của bạn đã tính mức hoạt động thường ngày. Chỉ bật mục này nếu bạn chọn mức ít vận động: nó cộng thêm lượng calo mỗi buổi tập đốt được ngoài mức nghỉ ngơi.';

  @override
  String get amountLabel => 'Lượng';

  @override
  String amountIn(String unit) {
    return 'Lượng ($unit)';
  }

  @override
  String get bodyweightLabel => 'Cân nặng';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Đã sao chép $count thực phẩm');
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Những gì bạn đã ghi vẫn giữ nguyên.';

  @override
  String get fiberLabel => 'Chất xơ';

  @override
  String get sugarLabel => 'Đường';

  @override
  String get sodiumLabel => 'Natri';

  @override
  String get foodDatabase => 'Cơ sở dữ liệu thực phẩm';

  @override
  String get kcalBurned => 'Đã đốt';

  @override
  String get mealOptions => 'Tùy chọn bữa ăn';

  @override
  String get moreNutrients => 'Chất xơ, đường và natri';

  @override
  String ofGoal(int goal, String unit) {
    return 'trên $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'mỗi 100 $unit';
  }

  @override
  String get perServingShort => 'mỗi khẩu phần';

  @override
  String get foodCategory => 'DANH MỤC';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count miếng');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count lát');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count muỗng');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count thìa canh');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count thìa cà phê');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count cốc');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ly');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Gần đây';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count thực phẩm');
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Đổi tên';

  @override
  String get repeatFrom => 'Lặp lại từ';

  @override
  String get repeatNone => 'Chưa ghi gì cho bữa này vào các ngày khác.';

  @override
  String get restDayGoals => 'Mục tiêu khác cho ngày nghỉ';

  @override
  String get trainingDays => 'Ngày tập';

  @override
  String get restDays => 'Ngày nghỉ';

  @override
  String get trainingDay => 'Ngày tập';

  @override
  String get saveAsMeal => 'Lưu thành bữa ăn';

  @override
  String get savedMealNameHint => 'Ví dụ: Bữa sáng thường ngày';

  @override
  String get savedMealToast => 'Đã lưu bữa ăn';

  @override
  String get savedMeals => 'Bữa ăn đã lưu';

  @override
  String get searchFoodsHint => 'Tìm thực phẩm';

  @override
  String get searchFoodsEmpty => 'Tìm trong hơn 500 thực phẩm có ảnh, hoặc tự thêm.';

  @override
  String searchFoodsNone(String query) {
    return 'Không tìm thấy gì cho “$query”. Hãy tạo thành thực phẩm của riêng bạn.';
  }

  @override
  String get servingWeight => 'GAM';

  @override
  String get weekAverage => 'Tuần này';

  @override
  String get weekAvgEnergy => 'Trung bình mỗi ngày';

  @override
  String get weekAvgProtein => 'Đạm mỗi ngày';

  @override
  String get weekEnergyOnTarget => 'Calo đạt mục tiêu';

  @override
  String get weekProteinOnTarget => 'Đạm đạt mục tiêu';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g đạm mỗi ngày';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met/$days ngày đạt mục tiêu';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Đã ghi $count ngày');
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Chưa ghi gì';

  @override
  String get weekOnTargetHint =>
      'Đạt mục tiêu: calo chênh không quá 10% so với mục tiêu và đạm đạt ít nhất 90%.';

  @override
  String get weightGoalLabel => 'Cân nặng mục tiêu';

  @override
  String weightGoalTitle(String unit) {
    return 'Cân nặng mục tiêu ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Mục tiêu $weight';
  }

  @override
  String get weightGoalNone => 'Giữ để đặt mục tiêu';

  @override
  String get weightGoalReached => 'Đã đạt mục tiêu';

  @override
  String weightToLose(String weight) {
    return 'Cần giảm $weight';
  }

  @override
  String weightToGain(String weight) {
    return 'Cần tăng $weight';
  }

  @override
  String get aminoHis => 'histidin';

  @override
  String get aminoIle => 'isoleucin';

  @override
  String get aminoLeu => 'leucin';

  @override
  String get aminoLys => 'lysin';

  @override
  String get aminoSaa => 'methionin';

  @override
  String get aminoAaa => 'phenylalanin';

  @override
  String get aminoThr => 'threonin';

  @override
  String get aminoTrp => 'triptophan';

  @override
  String get aminoVal => 'valin';

  @override
  String get animalProtein => 'Đạm động vật';

  @override
  String get proteinQuality => 'Chất lượng đạm';

  @override
  String get qualityComplete => 'Đầy đủ';

  @override
  String get qualityAlmost => 'Gần đủ';

  @override
  String get qualityIncomplete => 'Chưa đủ';

  @override
  String get qualityNoData => 'Chưa có dữ liệu';

  @override
  String get qualityNoDataHint => 'Ghi thực phẩm từ cơ sở dữ liệu để xem các axit amin của bạn.';

  @override
  String get qualityAllCovered => 'Đã đủ cả chín axit amin thiết yếu.';

  @override
  String qualityLimiting(String amino) {
    return 'Thiếu $amino. Hãy ăn kèm thực phẩm giàu chất này.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Dựa trên $pct% lượng đạm của bạn: thực phẩm tự thêm không có dữ liệu axit amin.';
  }

  @override
  String get fatTypes => 'Các loại chất béo';

  @override
  String get fatSaturated => 'Bão hòa';

  @override
  String get fatMono => 'Đơn';

  @override
  String get fatPoly => 'Đa';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Bão hòa $grams g trên tối đa $limit g (10% lượng calo)';
  }

  @override
  String get sugarSodium => 'Đường và natri';

  @override
  String get shakeCard => 'Shake protein';

  @override
  String get mealOther => 'Bữa ăn';

  @override
  String get mealAdd => 'Thêm bữa ăn';

  @override
  String get mealAddHint => 'Ví dụ: Trước buổi tập';

  @override
  String get mealsOfDay => 'Các bữa trong ngày';

  @override
  String get mealsHint =>
      'Tạo bao nhiêu tùy thích. Khi gỡ một bữa, những gì bạn đã ghi trong đó sẽ chuyển sang bữa phía trên.';

  @override
  String get trackersTitle => 'Tùy chỉnh';

  @override
  String get trackersHint => 'Chỉ hiện những gì bạn muốn theo dõi.';

  @override
  String get trackersDaily => 'Tóm tắt hằng ngày';

  @override
  String get trackersDetail => 'Chi tiết';

  @override
  String get trackersCards => 'Thẻ';

  @override
  String get prepTitle => 'Nấu sẵn';

  @override
  String get prepNewShort => 'Mẻ mới';

  @override
  String get prepNew => 'Mẻ mới';

  @override
  String get prepEdit => 'Sửa mẻ';

  @override
  String get prepHint => 'Ghi cả nồi một lần, rồi ăn dần từng phần.';

  @override
  String get prepEmpty =>
      'Đã nấu một mẻ lớn? Ghi một lần rồi chỉ cần cho biết bạn đã ăn bao nhiêu phần còn lại.';

  @override
  String get prepNameHint => 'Ví dụ: Gà và cơm';

  @override
  String get prepDefaultName => 'Mẻ';

  @override
  String get prepIngredients => 'Nguyên liệu';

  @override
  String get prepAddIngredient => 'Thêm nguyên liệu';

  @override
  String get prepCookedWeight => 'KHỐI LƯỢNG SAU KHI NẤU';

  @override
  String prepCookedHint(String grams) {
    return 'Cân cả nồi sau khi nấu để có số liệu chính xác. Để trống sẽ dùng tổng khối lượng sống ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Hãy thêm khối lượng sau khi nấu: một số nguyên liệu không có số gam.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Còn $left trên $total';
  }

  @override
  String get prepOfWhatsLeft => '% phần còn lại';

  @override
  String get prepAll => 'Tất cả';

  @override
  String prepLogAmount(String grams) {
    return 'Ghi $grams';
  }

  @override
  String get prepWeighLeft => 'Cân phần còn lại';

  @override
  String get prepFinished => 'Mẻ này đã hết.';

  @override
  String get approxValues => 'Ước tính';

  @override
  String get editValues => 'Sửa giá trị';

  @override
  String get editValuesHint =>
      'Chỉ thay đổi mục này. Để sửa thực phẩm cho lần sau, hãy sửa trong Thực phẩm của tôi.';

  @override
  String get editLibraryHint => 'Lưu thành thực phẩm của riêng bạn, cùng ảnh';

  @override
  String per100Line(String energy, String unit) {
    return '$energy mỗi 100 $unit';
  }

  @override
  String get rawLabel => 'Sống';

  @override
  String get cookedLabel => 'Chín';

  @override
  String get rawHint => 'Khối lượng trước khi nấu';

  @override
  String cookedHint(String factor) {
    return 'Khối lượng sau khi nấu (×$factor khối lượng sống)';
  }

  @override
  String get servingsUnit => 'khẩu phần';

  @override
  String logAmount(String energy) {
    return 'Ghi · $energy';
  }

  @override
  String get catFruit => 'Trái cây';

  @override
  String get catVeg => 'Rau củ';

  @override
  String get catMeat => 'Thịt';

  @override
  String get catFish => 'Cá';

  @override
  String get catEgg => 'Trứng';

  @override
  String get catDairy => 'Sữa và chế phẩm';

  @override
  String get catGrain => 'Ngũ cốc';

  @override
  String get catBakery => 'Bánh';

  @override
  String get catLegume => 'Đậu';

  @override
  String get catNut => 'Các loại hạt';

  @override
  String get catOil => 'Dầu';

  @override
  String get catPantry => 'Đồ khô';

  @override
  String get catDrink => 'Đồ uống';

  @override
  String get catSauce => 'Nước sốt';

  @override
  String get catSpice => 'Gia vị';

  @override
  String get searchFoodsPrompt => 'Bạn đã ăn gì?';

  @override
  String get shelfEmpty =>
      'Tìm một thực phẩm hoặc chụp ảnh món của bạn: những món bạn ghi nhiều nhất sẽ hiện ở đây.';

  @override
  String get repeatEntry => 'Ghi lại lần nữa';

  @override
  String get notifSuppChannel => 'Thực phẩm bổ sung';

  @override
  String get notifSuppChannelWhy => 'Nhắc nhở hằng ngày để dùng thực phẩm bổ sung';

  @override
  String get energySplit => 'Calo đến từ đâu';

  @override
  String get typicalServing => 'Khẩu phần thường dùng';

  @override
  String cookedYieldLine(String factor) {
    return 'Nặng $factor× khối lượng sống';
  }

  @override
  String get readyDishes => 'Món ăn';

  @override
  String weightLastLine(String weight) {
    return 'Lần cân gần nhất $weight';
  }

  @override
  String get proteinAnimalShort => 'Động vật';

  @override
  String get proteinPlantShort => 'Thực vật';

  @override
  String kcalFromMacros(String value) {
    return 'Các chất đa lượng này cộng lại khoảng $value';
  }

  @override
  String get useValue => 'Dùng';

  @override
  String get suppRowHint => 'Chạm để đánh dấu · giữ để xem chi tiết';

  @override
  String get suppPhoto => 'Ảnh';

  @override
  String get suppDose => 'Liều dùng';

  @override
  String get suppDoseHint => '5 g, 2 viên…';

  @override
  String get suppRemind => 'Nhắc tôi';

  @override
  String mealPlanDefault(int n) {
    return 'Kế hoạch $n';
  }

  @override
  String get mealPlansTitle => 'Kế hoạch ăn uống';

  @override
  String get mealPlanNew => 'Kế hoạch mới';

  @override
  String fromPlan(String name) {
    return 'Từ $name';
  }

  @override
  String get logPlan => 'Ghi';

  @override
  String get planFromDay => 'Sao chép ngày này';

  @override
  String get planNewHint =>
      'Lên kế hoạch cho các ngày như với giáo án tập, rồi ghi cả bữa ăn chỉ với một lần chạm.';

  @override
  String get planLogDay => 'Ghi các bữa còn trống';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã ghi $n thực phẩm');
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Không có kế hoạch';

  @override
  String get planWeekHint => 'Chạm vào một ngày để gán kế hoạch.';

  @override
  String get planDuplicate => 'Nhân bản';

  @override
  String planDeleteTitle(String name) {
    return 'Xóa $name?';
  }

  @override
  String get planDeleteBody => 'Các ngày bạn đã ghi vẫn giữ nguyên.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Dinh dưỡng';

  @override
  String get nutritionBetaHint => 'Bữa ăn, nước và thực phẩm bổ sung';

  @override
  String get nutritionAboutTitle => 'Về Dinh dưỡng';

  @override
  String get nutritionAboutSub => 'Nó là gì, và những gì nó sẽ không bao giờ trở thành.';

  @override
  String get nutritionAboutWhatTitle => 'Một phần của việc tập luyện';

  @override
  String get nutritionAboutWhat =>
      'Cách đơn giản để ghi bữa ăn, nước, đạm và thực phẩm bổ sung ngay cạnh các buổi tập. GymMane trước hết là ứng dụng tập gym: Dinh dưỡng có mặt để bạn giữ mọi thứ ở một chỗ, không phải để thay thế một ứng dụng ăn kiêng chuyên dụng.';

  @override
  String get nutritionAboutScanTitle => 'Không bao giờ quét mã';

  @override
  String get nutritionAboutScan =>
      'Quét mã vạch và được điền sẵn mọi thông tin thì rất tiện. Nhưng việc đó cần internet và một cơ sở dữ liệu thực phẩm trực tuyến khổng lồ, và những gì bạn ăn sẽ nằm trên máy chủ của người khác. Dữ liệu đó cho thấy bạn ăn khi nào, ăn gì và chăm sóc cơ thể ra sao, và có thể bị dùng cho quảng cáo hoặc chuyển cho các công ty lớn. Vì vậy không có trình quét, và sẽ không bao giờ có.';

  @override
  String get nutritionAboutLocalTitle => 'Mọi thứ trên điện thoại của bạn';

  @override
  String get nutritionAboutLocal =>
      'Hơn 500 thực phẩm có ảnh đi kèm sẵn trong ứng dụng. Bạn có thể tự thêm, đổi ảnh và sửa giá trị của chúng. Tất cả đều nằm trên điện thoại của bạn, như phần còn lại của GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Vẫn đang beta';

  @override
  String get nutritionAboutBeta =>
      'Nếu thiếu gì, hãy đề xuất trên GitHub. Chỉ trừ tính năng quét mã hay cơ sở dữ liệu thực phẩm lớn hơn: ngoài quyền riêng tư của bạn, chúng sẽ khiến ứng dụng nặng hơn nhiều. Không cần Dinh dưỡng? Tắt nó trong Cài đặt và dữ liệu của bạn vẫn được giữ.';

  @override
  String get nutritionAboutSuggest => 'Đề xuất ý tưởng';

  @override
  String get nutritionAboutOk => 'Đã hiểu';

  @override
  String get planShare => 'Chia sẻ';

  @override
  String get planImport => 'Nhập kế hoạch';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã nhập $n kế hoạch');
    return '$_temp0';
  }

  @override
  String get planImportNone => 'Tệp đó không có kế hoạch ăn uống nào.';

  @override
  String get planMoveUp => 'Chuyển lên';

  @override
  String get planMoveDown => 'Chuyển xuống';

  @override
  String get cutoutEdit => 'Chỉnh phần tách nền';

  @override
  String get cutoutEditHint =>
      'Kéo để xóa hoặc khôi phục. Chạm vào một vùng để gỡ bỏ hoặc lấy lại toàn bộ vùng đó. Chụm hai ngón để thu phóng.';

  @override
  String get cutoutErase => 'Xóa';

  @override
  String get cutoutRestore => 'Khôi phục';

  @override
  String get cutoutReset => 'Quay lại tự động';

  @override
  String get cutoutByHand => 'Tách nền thủ công';

  @override
  String notifSuppTitleFor(String names) {
    return 'Đến lúc dùng: $names';
  }

  @override
  String get notifSuppTap => 'Đánh dấu trong GymMane sau khi bạn đã dùng.';

  @override
  String get suppNoneToday => 'Hôm nay không cần dùng gì.';

  @override
  String get suppOtherDays => 'Ngày khác';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Mỗi $n ngày', one: 'Mỗi ngày');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Mỗi ngày';

  @override
  String suppFromDate(String date) {
    return 'từ $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'đến $date';
  }

  @override
  String get suppSomeDays => 'Một số ngày';

  @override
  String get suppEveryShort => 'Mỗi X ngày';

  @override
  String get suppWhen => 'Khi nào';

  @override
  String get suppEveryLead => 'Mỗi';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'ngày');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Bắt đầu';

  @override
  String get suppEnds => 'Kết thúc';

  @override
  String get suppTomorrow => 'Ngày mai';

  @override
  String get suppPickDate => 'Chọn ngày';

  @override
  String get suppNever => 'Không bao giờ';

  @override
  String get suppOneWeek => 'Sau 1 tuần';

  @override
  String get suppOneMonth => 'Sau 1 tháng';

  @override
  String get planPickHint => 'Chọn kế hoạch cho ngày này, hoặc tạo kế hoạch mới.';

  @override
  String planSetForDay(String day) {
    return 'Đã đặt kế hoạch cho $day';
  }

  @override
  String get planSaved => 'Đã lưu kế hoạch';

  @override
  String get planDiscardTitle => 'Hủy các thay đổi?';

  @override
  String get planDiscardBody => 'Những gì bạn đã thay đổi sẽ không được lưu.';

  @override
  String get planDiscard => 'Hủy bỏ';

  @override
  String get planEdit => 'Sửa kế hoạch';

  @override
  String get planNameHint => 'Tên kế hoạch';

  @override
  String get planDaysQuestion => 'Những ngày nào?';

  @override
  String get planDaysHint =>
      'Vào những ngày đó, kế hoạch sẽ hiện trong Dinh dưỡng để bạn ghi chỉ với một lần chạm.';

  @override
  String get planDaysNone => 'Hãy chọn ít nhất một ngày, nếu không kế hoạch sẽ không hiện ở đâu cả.';

  @override
  String get planNothingToLog => 'Các bữa đó đã được ghi rồi';

  @override
  String get planSave => 'Lưu kế hoạch';

  @override
  String get planToday => 'Kế hoạch hôm nay';

  @override
  String get planLogRest => 'Ghi phần còn lại';

  @override
  String get dishNew => 'Tạo món của tôi';

  @override
  String get dishNewHint => 'Chọn nguyên liệu và lượng, lưu lại và ghi chỉ với một lần chạm.';

  @override
  String get dishEdit => 'Sửa món';

  @override
  String get dishNameHint => 'Ví dụ: Canh đậu của mẹ';

  @override
  String get dishIngredients => 'Nguyên liệu';

  @override
  String get dishEmptyHint => 'Thêm những gì có trong món với lượng bạn thường ăn.';

  @override
  String get dishSave => 'Lưu món';

  @override
  String get dishNeedsName => 'Hãy đặt tên cho món';

  @override
  String get dishNeedsItems => 'Thêm ít nhất một nguyên liệu';

  @override
  String get suppHistory => '14 ngày qua';

  @override
  String suppTakenOf(int n, int total) {
    return 'Đã dùng $n/$total';
  }

  @override
  String get suppNoReminder => 'Không nhắc';

  @override
  String get suppMarkTaken => 'Đánh dấu đã dùng';

  @override
  String get suppUnmark => 'Bỏ đánh dấu';

  @override
  String get suppEdit => 'Sửa';

  @override
  String get mealMoveTo => 'Chuyển sang';

  @override
  String get mealClear => 'Xóa bữa ăn';

  @override
  String get mealCleared => 'Đã xóa bữa ăn';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Đã chuyển $count thực phẩm');
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Lặp lại cả ngày';

  @override
  String createFoodNamed(String name) {
    return 'Tạo “$name”';
  }

  @override
  String get entryDay => 'Ngày';

  @override
  String get movedToDay => 'Đã chuyển';

  @override
  String get favFoodsHint => 'Chạm ☆ trên một thực phẩm';

  @override
  String get favFoodsEmpty =>
      'Chạm vào ngôi sao trên bất kỳ thực phẩm nào để giữ nó ở đây, chỉ cách một lần chạm.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bữa ăn');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Lưu một bữa ăn từ menu ••• của nó, hoặc tự tạo món của bạn.';

  @override
  String get sugarLimitLabel => 'Giới hạn đường';

  @override
  String get sodiumLimitLabel => 'Giới hạn natri';

  @override
  String get waterOptions => 'Tùy chọn nước';

  @override
  String get waterNone => 'Chưa ghi lượng nước nào.';

  @override
  String get waterDailyGoal => 'Nước mỗi ngày';

  @override
  String get trackersScreen => 'Màn hình';

  @override
  String get vesselMotion => 'Nước và shake chuyển động';

  @override
  String get vesselMotionHint =>
      'Tắt mục này nếu màn hình có vẻ chậm: ly vẫn đầy lên, chỉ là không chuyển động nữa.';

  @override
  String get planFixedWeek => 'Tuần cố định';

  @override
  String get planRotation => 'Luân phiên';

  @override
  String get rotationTitle => 'LUÂN PHIÊN';

  @override
  String get rotationHint => 'Buổi tiếp theo là giáo án nối tiếp buổi tập gần nhất, bất kể là ngày nào.';

  @override
  String get rotationEmpty => 'Thêm các giáo án tập theo thứ tự bạn sẽ tập: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return 'Đã xong $done/$total trong vòng này';
  }

  @override
  String get rotationNext => 'Tiếp theo';

  @override
  String get rotationAdd => 'Thêm giáo án tập';

  @override
  String get rotationPickHint => 'Chúng được xếp theo thứ tự bạn chạm.';

  @override
  String get rotationSkip => 'Bỏ qua, sang giáo án tiếp theo';

  @override
  String get rotationRestart => 'Bắt đầu vòng mới';

  @override
  String get rotationMakeNext => 'Đặt làm giáo án tiếp theo';

  @override
  String get rotationRemove => 'Gỡ khỏi vòng luân phiên';

  @override
  String rotationPlace(int n, int total) {
    return '$n/$total trong vòng luân phiên';
  }

  @override
  String get moveToDay => 'Chuyển sang ngày khác';

  @override
  String get moveToDayHint => 'Chỉ lần này; kế hoạch tuần của bạn vẫn giữ nguyên.';

  @override
  String get movedToast => 'Đã chuyển buổi tập';

  @override
  String get backToPlan => 'Quay lại kế hoạch tuần';

  @override
  String get tomorrow => 'Ngày mai';

  @override
  String get untrainedTab => 'Chưa tập';

  @override
  String get untrainedRecent => 'Gần đây';

  @override
  String get untrainedLong => 'Lâu rồi';

  @override
  String untrainedWaiting(String list) {
    return 'Chờ lâu nhất: $list';
  }

  @override
  String get untrainedAllRecent => 'Tuần này nhóm cơ nào cũng đã được tập. Tốt lắm.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ngày trước',
      one: 'Đã tập hôm qua',
      zero: 'Đã tập hôm nay',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Chưa tập lần nào';

  @override
  String get layoutSetting => 'Bố cục buổi tập';

  @override
  String get layoutCards => 'Thẻ';

  @override
  String get layoutList => 'Danh sách';

  @override
  String get layoutHint =>
      'Thẻ hiện từng bài tập một. Danh sách hiện cả buổi tập trên một màn hình, từng hiệp một.';

  @override
  String get layoutRowHint => 'Từng bài tập một, hoặc cả buổi tập dạng danh sách';

  @override
  String get previousCol => 'LẦN TRƯỚC';

  @override
  String get usePrevious => 'Dùng số liệu lần trước';

  @override
  String get skipShort => 'Bỏ qua';

  @override
  String get moveUp => 'Chuyển lên';

  @override
  String get moveDown => 'Chuyển xuống';

  @override
  String get widgetNutritionOff => 'Bật Dinh dưỡng trong Cài đặt › Beta để dùng tiện ích này.';

  @override
  String get widgetPickShake => 'Chọn ly shake của bạn';

  @override
  String get heatRangeSetting => 'Lịch hoạt động';

  @override
  String get heatRangeWeeks => '12 tuần';

  @override
  String get heatRangeYear => '12 tháng';

  @override
  String get heatRangeHint => '12 tháng hiện cả năm. Vuốt ngang để xem lùi lại, đến tận buổi tập đầu tiên.';

  @override
  String get pdfPlan => 'Kế hoạch dạng PDF';

  @override
  String get pdfPlanHint => 'Một trang gọn gàng với tuần tập và mọi giáo án tập, sẵn sàng để in hoặc gửi.';

  @override
  String get pdfExport => 'Xuất dạng PDF';

  @override
  String get pdfFooter => 'Miễn phí, mã nguồn mở và ngoại tuyến';

  @override
  String get shakeTag => 'Đây là shake';

  @override
  String get shakeTagHint => 'Sẽ hiện trong Ly shake của bạn';

  @override
  String get shakeNone => 'Đánh dấu các ly shake và chỉ chúng mới hiện ở đây.';

  @override
  String get shakeMarkLabel => 'ĐÁNH DẤU LÀ SHAKE';

  @override
  String get shakeNew => 'Shake mới';

  @override
  String get shakeUntag => 'Không phải shake';

  @override
  String get pdfKicker => 'KẾ HOẠCH TẬP LUYỆN';

  @override
  String get pdfStatDays => 'NGÀY / TUẦN';

  @override
  String get pdfStatMinutes => 'PHÚT / BUỔI';

  @override
  String pdfMinutes(int n) {
    return '≈ $n phút';
  }

  @override
  String get workoutNotesTitle => 'Ghi chú bài tập';

  @override
  String get workoutNoteEvery => 'Mọi lần';

  @override
  String get workoutNoteNext => 'Lần sau';

  @override
  String get workoutNoteEveryHint => 'Hiện mỗi lần bạn tập bài này. Hữu ích cho vị trí ghế hoặc ròng rọc.';

  @override
  String get workoutNoteNextHint => 'Chỉ hiện vào lần sau, rồi biến mất.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Từ lần trước · $date';
  }

  @override
  String get workoutNoteHint => 'Ghế ở lỗ 2, ròng rọc ở nấc 19…';

  @override
  String get notePinWorkout => 'Hiện trong buổi tập';

  @override
  String get assistedSetting => 'Máy hỗ trợ';

  @override
  String get assistedSettingHint =>
      'Mức tạ hỗ trợ bạn, nên càng ít càng tốt: kỷ lục và gợi ý của bạn sẽ giảm dần.';

  @override
  String get assistedRecordHint => 'Hỗ trợ ít nhất';

  @override
  String get trainAgainLabel => 'Chưa tập? Nhắc tôi lần nữa';

  @override
  String get trainAgainOff => 'Không';

  @override
  String trainAgainAfter(int n) {
    return '+$n giờ';
  }

  @override
  String get trainAgainHint => 'Chỉ một lần, và chỉ khi bạn chưa ghi buổi tập nào trong ngày đó.';

  @override
  String get notifTrainAgainBody => 'Vẫn còn thời gian để tập hôm nay.';

  @override
  String nextDeload(int n) {
    return 'nhẹ hơn: $n buổi tập liên tiếp chưa đủ mọi lần lặp';
  }

  @override
  String get historyTitle => 'Lịch sử';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n BUỔI TẬP');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Tháng này không có buổi tập nào';

  @override
  String get historyEmptyHint => 'Vuốt ngang hoặc dùng các mũi tên để xem các tháng khác.';

  @override
  String historyMore(int n) {
    return '+$n nữa';
  }

  @override
  String get stopwatch => 'Đồng hồ bấm giờ';

  @override
  String get proteinSource => 'Nguồn đạm';

  @override
  String get proteinMixedShort => 'Hỗn hợp';

  @override
  String get kcalActive => 'hoạt động';

  @override
  String get kcalEstimated => 'ước tính';

  @override
  String get kcalYours => 'giá trị của bạn';

  @override
  String kcalTotalRest(String value) {
    return 'Tổng cộng $value, tính cả lượng đốt khi nghỉ';
  }

  @override
  String get inclineLabel => 'Độ dốc';

  @override
  String get kcalUseOwn => 'Dùng giá trị của tôi';

  @override
  String get kcalBackToEstimate => 'Quay lại giá trị ước tính';

  @override
  String get kcalNeedsData => 'Thêm quãng đường và thời gian để ước tính calo';

  @override
  String get kcalHowEstimated =>
      'Ước tính từ quãng đường, thời gian, độ dốc và cân nặng của bạn (công thức ACSM).';

  @override
  String get kcalOwnTitle => 'Calo hoạt động';

  @override
  String get planMine => 'Kế hoạch của tôi';

  @override
  String get planNew => 'Kế hoạch mới';

  @override
  String get planSaveWeek => 'Lưu tuần này';

  @override
  String get planSaveWeekHint => 'Giữ tuần hiện tại thành một kế hoạch để quay lại sau';

  @override
  String get planEmptyWeek => 'Bắt đầu một tuần trống';

  @override
  String get planEmptyWeekHint => 'Tuần hiện tại của bạn vẫn được lưu thành một kế hoạch';

  @override
  String get planName => 'Tên kế hoạch';

  @override
  String get planRename => 'Đổi tên';

  @override
  String get planDelete => 'Xóa kế hoạch';

  @override
  String get plansHint => 'Các thay đổi trong tuần được lưu vào kế hoạch đã chọn';

  @override
  String get progression => 'Tăng tiến';

  @override
  String get progManual => 'Thủ công';

  @override
  String get progManualHint => 'Không gợi ý: bạn tự chọn mọi mức tạ.';

  @override
  String get progLinear => 'Tuyến tính';

  @override
  String get progLinearHint => 'Đạt đủ mọi lần lặp thì mức tạ tăng lên.';

  @override
  String get progDouble => 'Tăng tiến kép';

  @override
  String get progDoubleHint => 'Thêm lần lặp đến mức trên của khoảng, rồi thêm mức tạ.';

  @override
  String get progVolume => 'Lần lặp, hiệp và mức tạ';

  @override
  String get progVolumeHint => 'Lần lặp lên mức trên, rồi thêm một hiệp, rồi thêm mức tạ.';

  @override
  String get progAmrap => 'Hiệp cuối hết sức';

  @override
  String get progAmrapHint =>
      'Hiệp cuối: càng nhiều lần lặp càng tốt. Gấp đôi mục tiêu thì mức tạ tăng hai bậc.';

  @override
  String get progStep => 'Bước tăng mức tạ';

  @override
  String get progRange => 'Khoảng lần lặp';

  @override
  String get progSets => 'Hiệp';

  @override
  String get progDeload => 'Giảm nhẹ sau';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n lần trượt', one: '1 lần trượt');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Giảm bớt';

  @override
  String get progApply => 'Điền sẵn vào buổi tập tiếp theo';

  @override
  String get progApplyHint => 'Khi tắt, chỉ hiện dưới dạng gợi ý.';

  @override
  String get nextMoreReps => 'giữ mức tạ, thêm một lần lặp';

  @override
  String get nextAddSet => 'thêm một hiệp';

  @override
  String get nextAmrap => 'hiệp cuối: càng nhiều càng tốt';

  @override
  String fillDay(String amount) {
    return 'Lấp đầy ngày của bạn · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Bạn sẽ còn $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Bạn sẽ còn $kcal và $grams g đạm';
  }

  @override
  String leftAfterOver(String kcal) {
    return 'Vượt mục tiêu $kcal';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit mỗi ngày';
  }

  @override
  String get byZone => 'Theo vùng';

  @override
  String get importAlreadyHave => 'Bạn đã có các giáo án tập này. Bạn có thể thêm lại dưới dạng bản sao.';

  @override
  String get importAsCopy => 'Thêm dưới dạng bản sao';

  @override
  String get importOwned => 'Đã có';

  @override
  String get setDuplicated => 'Đã nhân bản hiệp';

  @override
  String get setTypeCluster => 'Hiệp cụm';

  @override
  String get setTypeClusterInfo =>
      'Một hiệp chia thành các khối nhỏ, nghỉ 15–30 giây giữa các khối. Ghi tổng số lần lặp.';

  @override
  String timesBodyweight(String value) {
    return '$value× cân nặng của bạn';
  }

  @override
  String get archiveRoutine => 'Lưu trữ giáo án tập';

  @override
  String get routineArchived => 'Đã lưu trữ giáo án tập';

  @override
  String get archivedRoutines => 'Đã lưu trữ';

  @override
  String get autoBackup => 'Tự động sao lưu';

  @override
  String get autoBackupHint =>
      'Lưu một tệp ZIP chứa toàn bộ dữ liệu của bạn vào thư mục bạn chọn. Trỏ Nextcloud, Syncthing hoặc ứng dụng đồng bộ bất kỳ vào thư mục đó để giữ một bản sao ngoài điện thoại.';

  @override
  String get autoBackupFolder => 'Chọn thư mục';

  @override
  String get autoBackupNoFolder => 'Chưa có thư mục';

  @override
  String get autoBackupOff => 'Tắt';

  @override
  String get autoBackupWorkout => 'Sau mỗi buổi tập';

  @override
  String get autoBackupDaily => 'Mỗi ngày một lần';

  @override
  String get autoBackupWeekly => 'Mỗi tuần một lần';

  @override
  String get autoBackupOnLeave => 'Khi bạn thoát ứng dụng';

  @override
  String get autoBackupKeep => 'Số bản sao giữ lại';

  @override
  String get autoBackupNow => 'Sao lưu ngay';

  @override
  String autoBackupLast(String when) {
    return 'Sao lưu lần cuối $when';
  }

  @override
  String get autoBackupNever => 'Chưa có bản sao lưu';

  @override
  String get autoBackupLost => 'Không lưu được bản sao lưu gần nhất. Hãy chọn lại thư mục.';

  @override
  String get autoBackupSaved => 'Đã lưu bản sao lưu';

  @override
  String get prepPortions => 'Phần ăn';

  @override
  String get rotationAddRest => 'Thêm ngày nghỉ';

  @override
  String get rotationRestHint => 'Tự chuyển tiếp vào ngày hôm sau';

  @override
  String get rotationRestToday => 'Hôm nay';

  @override
  String get rotationSkipRest => 'Bỏ qua ngày nghỉ này';

  @override
  String rotationRestUpNext(String name) {
    return 'Tiếp theo: $name';
  }

  @override
  String get trainAnyway => 'Vẫn tập';

  @override
  String get healthTitle => 'Sức khỏe';

  @override
  String get healthSetting => 'Dữ liệu sức khỏe';

  @override
  String get healthSettingHint => 'Dữ liệu Health Connect trong Tiến độ';

  @override
  String get healthPickTitle => 'Dữ liệu sức khỏe';

  @override
  String get healthPickHint =>
      'Chọn những gì cần lấy từ Health Connect. Android sẽ hỏi một lần cho từng mục. Dữ liệu chỉ được đọc và không bao giờ rời khỏi điện thoại của bạn.';

  @override
  String get healthGroupHeart => 'Tim';

  @override
  String get healthGroupVitals => 'Chỉ số sinh tồn';

  @override
  String get healthGroupActivity => 'Hoạt động';

  @override
  String get healthRestingHr => 'Nhịp tim lúc nghỉ';

  @override
  String get healthHeartRate => 'Nhịp tim trung bình';

  @override
  String get healthHrv => 'Biến thiên nhịp tim';

  @override
  String get healthSpo2 => 'Oxy trong máu';

  @override
  String get healthRespiration => 'Nhịp thở';

  @override
  String get healthBloodPressure => 'Huyết áp';

  @override
  String get healthTemperature => 'Nhiệt độ cơ thể';

  @override
  String get healthSleep => 'Giấc ngủ';

  @override
  String get healthDistance => 'Quãng đường';

  @override
  String get healthFloors => 'Số tầng đã leo';

  @override
  String get healthElevation => 'Độ cao đã leo';

  @override
  String get healthActiveKcal => 'Calo hoạt động';

  @override
  String get healthNoData => 'Chưa có dữ liệu';

  @override
  String get healthReadFailed => 'Không đọc được';

  @override
  String get healthAllow => 'Chạm để cho phép';

  @override
  String get healthLast7 => '7 ngày qua';

  @override
  String get healthAvg30 => 'TB 30 ngày';

  @override
  String get healthLow => 'Thấp nhất';

  @override
  String get healthHigh => 'Cao nhất';

  @override
  String get healthFrom => 'Từ Health Connect · 30 ngày qua';

  @override
  String get healthBpm => 'nhịp/phút';

  @override
  String get healthBreaths => 'lần thở/phút';

  @override
  String get weekTab => 'Tuần';

  @override
  String get muscleSetsList => 'Số hiệp mỗi nhóm cơ';

  @override
  String get fatTrans => 'Chuyển hóa';

  @override
  String get fatTypesHint => 'Không bắt buộc. Để trống những gì nhãn không ghi.';

  @override
  String get sessionPhotos => 'Ảnh buổi tập';

  @override
  String get sessionPhotosAdd => 'Thêm ảnh';

  @override
  String get sessionPhotosHint => 'Ảnh cũng được giữ trong Ảnh của bạn.';

  @override
  String get ladderTitle => 'Lộ trình nâng bậc';

  @override
  String get ladderHint =>
      'Sắp xếp các bậc từ dễ nhất đến khó nhất. Khi bạn tập 3 hiệp 8 lần lặp hai buổi liên tiếp (5 với các bài chậm), GymMane sẽ đề xuất bậc tiếp theo.';

  @override
  String get ladderBuiltIn =>
      'Bắt đầu từ lộ trình có sẵn của ứng dụng. Thêm, gỡ hoặc sắp xếp lại các bậc và nó sẽ trở thành lộ trình riêng của giáo án tập này.';

  @override
  String get ladderNone => 'Chưa có. Chạm để tạo.';

  @override
  String ladderStep(int n, int total) {
    return 'Bậc $n/$total';
  }

  @override
  String get ladderAdd => 'Thêm bậc';

  @override
  String get ladderInRoutine => 'Trong giáo án tập';

  @override
  String get ladderClear => 'Dùng lộ trình của ứng dụng';

  @override
  String get ladderPick => 'Chọn một bậc';

  @override
  String get periodWeek => 'tuần này';

  @override
  String get periodMonth => 'tháng này';

  @override
  String get periodYear => 'năm nay';

  @override
  String get periodAll => 'mọi lúc';

  @override
  String get settingsSearch => 'Tìm trong cài đặt';

  @override
  String get settingsNoResults => 'Không có cài đặt nào có tên đó';

  @override
  String get settingsGroupApp => 'Ứng dụng của bạn';

  @override
  String get settingsGroupHome => 'Trang chủ và tiện ích thêm';

  @override
  String get settingsGroupData => 'Dữ liệu và trợ giúp';

  @override
  String get healthAllowAll => 'Bật tất cả';

  @override
  String get healthSeeAll => 'Xem tất cả';

  @override
  String get healthPinTitle => 'Trên thẻ';

  @override
  String get healthPinHint => 'Chọn tối đa 3 mục cho thẻ Tiến độ.';

  @override
  String get blurSetting => 'Hiệu ứng làm mờ';

  @override
  String get blurSettingHint => 'Tắt nếu điện thoại có vẻ chậm';

  @override
  String get lowEndTitle => 'Điện thoại của bạn có ít bộ nhớ';

  @override
  String get lowEndBody =>
      'Tắt làm mờ sẽ giúp mọi thứ mượt hơn trên máy này. Bạn có thể bật lại trong Cài đặt → Chung.';

  @override
  String get lowEndOff => 'Tắt làm mờ';

  @override
  String get lowEndKeep => 'Giữ nguyên';

  @override
  String get momentsThisMonth => 'Tháng này';

  @override
  String get momentsDays => 'Ngày có ảnh';

  @override
  String get awardsPick => 'Chọn cho hồ sơ của bạn';

  @override
  String get awardsPickHint => 'Chạm vào những huy chương bạn muốn hiện trên hồ sơ';

  @override
  String get gymPassPicture => 'Lưu ảnh của mã';

  @override
  String get gymPassPictureHint => 'Cho những mã ứng dụng không đọc được: hiện ảnh của bạn ở độ sáng tối đa';

  @override
  String get gymPassPictureFormat => 'Ảnh';

  @override
  String get gymPassUsePicture => 'Lưu ảnh';

  @override
  String get gymPassChangePicture => 'Đổi ảnh';

  @override
  String get cropTitle => 'Cắt mã';

  @override
  String get cropHint => 'Kéo các góc để chỉ có mã nằm bên trong';

  @override
  String get rotatePhoto => 'Xoay';

  @override
  String get cardioNoSets => 'Cardio không được cộng vào số hiệp mỗi nhóm cơ trong tuần';

  @override
  String get countsAsWater => 'Tính vào lượng nước';

  @override
  String get countsAsWaterHint => 'Cho các ly shake pha với nước: khi ghi sẽ cộng cả vào lượng nước';

  @override
  String get waterPerServing => 'Lượng nước mỗi khẩu phần';

  @override
  String get estOneRm => '1RM ước tính';

  @override
  String get newInWorkout => 'Mới trong buổi tập này';

  @override
  String newInWorkoutHint(String routine) {
    return 'Thêm vào $routine với các hiệp bạn vừa tập. Phần còn lại của giáo án tập vẫn giữ nguyên.';
  }

  @override
  String get addedToRoutine => 'Đã thêm';

  @override
  String get addShort => 'Thêm';

  @override
  String get allTimeLifted => 'ĐÃ NÂNG';

  @override
  String get pctBodyweight => '% cân nặng';

  @override
  String get ofBodyweight => 'cân nặng của bạn';

  @override
  String get recoveryStateMid => 'Đang phục hồi';

  @override
  String get recoveryStateReady => 'Sẵn sàng';

  @override
  String recoveringIn(String time) {
    return 'Phục hồi sau $time';
  }

  @override
  String readyIn(String time) {
    return 'Sẵn sàng sau $time';
  }

  @override
  String get recoveryReadyNow => 'Sẵn sàng để tập lại';

  @override
  String get restAfterThisSet => 'Nghỉ sau hiệp này';

  @override
  String restUsual(String time) {
    return 'Thường lệ: $time';
  }

  @override
  String get restJustToday => 'Chỉ cho hiệp này, hôm nay';

  @override
  String get restUseUsual => 'Quay lại thời gian nghỉ thường lệ';

  @override
  String get restChange => 'Thay đổi';

  @override
  String get noRestTimer => 'Không hẹn giờ';

  @override
  String get sessionMuscles => 'Các nhóm cơ trong buổi tập này';

  @override
  String get sessionMusclesHint =>
      'Mờ là sắp tập, sáng là đã xong. Số hiệp mỗi nhóm cơ, nhóm cơ phụ tính một nửa.';

  @override
  String get miniBodySetting => 'Bản đồ cơ nhỏ trên giáo án tập';

  @override
  String get miniBodySettingHint => 'Các nhóm cơ mà mỗi giáo án tập tác động';

  @override
  String get balanceTitle => 'Cân bằng sức mạnh';

  @override
  String get balanceWhy => 'Cách hoạt động';

  @override
  String get balanceGood => 'Các bài chính của bạn đang cân bằng';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift đang tụt lại: cần khoảng $gap để bắt kịp';
  }

  @override
  String get balanceHint =>
      'So sánh 1RM ước tính trong 4 tháng qua với tỷ lệ kinh điển: squat 100%, deadlift 120%, đẩy ngực 75%, kéo tạ 52%, đẩy tạ qua đầu 45%. Một bài thấp hơn hẳn các bài còn lại thường là điểm yếu đáng tập thêm.';

  @override
  String get balanceEven => 'Cân bằng';

  @override
  String get balanceBehindShort => 'Tụt lại';

  @override
  String get balanceAheadShort => 'Vượt trước';

  @override
  String get holdProgress => 'Tăng tiến theo thời gian';

  @override
  String get holdProgressHint => 'Thêm giây khi bạn giữ đủ thời gian ở mọi hiệp';

  @override
  String holdProgressOn(int s) {
    return '+$s giây mỗi lần bạn giữ đủ thời gian ở mọi hiệp';
  }

  @override
  String get paceTitle => 'Tốc độ mỗi tuần';

  @override
  String get paceOn => 'Đúng tiến độ';

  @override
  String get paceTooFast => 'Nhanh hơn khoảng bạn đặt';

  @override
  String get paceTooSlow => 'Chậm hơn khoảng bạn đặt';

  @override
  String get paceWrongWay => 'Đang đi ngược hướng';

  @override
  String get paceDrifting => 'Thay đổi nhiều hơn mức cho phép khi giữ cân';

  @override
  String get paceSetAim => 'Chạm để đặt điều bạn hướng tới';

  @override
  String get paceBasis =>
      'Xu hướng các lần cân trong 3 tuần qua, để một bữa tối nhiều muối không đánh lừa được.';

  @override
  String get paceAimTitle => 'Bạn đang hướng tới điều gì?';

  @override
  String get paceAimHint => 'Thẻ sẽ cho biết tốc độ mỗi tuần có phù hợp không';

  @override
  String get paceLose => 'Giảm cân';

  @override
  String get paceHold => 'Giữ cân';

  @override
  String get paceGain => 'Tăng cân';

  @override
  String get paceAuto => 'Tự động';

  @override
  String get paceLoseRange => '0,5 đến 1% cân nặng mỗi tuần';

  @override
  String get paceHoldRange => 'Trong khoảng 0,25% mỗi tuần';

  @override
  String get paceGainRange => '0,25 đến 0,5% cân nặng mỗi tuần';

  @override
  String get paceAutoHint => 'Theo cân nặng mục tiêu của bạn';

  @override
  String get weekShort => 'tuần';

  @override
  String get weightStack => 'Cụm tạ';

  @override
  String get weightStackHint =>
      'Các mức tạ máy này thực sự có. Nút + và −, tăng tiến và giảm tải sẽ chỉ dừng ở các mức này.';

  @override
  String get weightStackOff => 'Tắt: bước tăng mức tạ bình thường';

  @override
  String get stackFrom => 'Từ';

  @override
  String get stackTo => 'Đến';

  @override
  String get stackEvery => 'Mỗi';

  @override
  String get stackFill => 'Điền cụm tạ';

  @override
  String get stackTapToFix => 'Chạm vào một mức tạ để sửa mức lẻ hoặc gỡ bỏ.';

  @override
  String get stackAddWeight => 'Thêm mức tạ';

  @override
  String get stackEditWeight => 'Mức tạ ở chốt';

  @override
  String get stackClear => 'Gỡ cụm tạ';

  @override
  String stackCount(int n) {
    return '$n mức tạ';
  }

  @override
  String get healthLinksTitle => 'Cùng các buổi tập';

  @override
  String get healthLinkHeart => 'Nhịp tim từ đồng hồ';

  @override
  String get healthLinkHeartHint =>
      'Nhịp tim trung bình và cao nhất của mỗi buổi tập, từ bất kỳ đồng hồ nào đã ghi lại';

  @override
  String get healthLinkWeight => 'Các lần cân từ ứng dụng khác';

  @override
  String get healthLinkWeightHint =>
      'Các lần cân từ cân điện tử của bạn trong 30 ngày qua. Không bao giờ ghi đè lần cân bạn tự nhập.';

  @override
  String get healthLinkDenied => 'Health Connect không cấp quyền';

  @override
  String get healthOpenSettings => 'Mở';

  @override
  String hrMaxShort(int bpm) {
    return 'tối đa $bpm';
  }

  @override
  String get setNote => 'Ghi chú cho hiệp này';

  @override
  String get setNoteHint => 'Cách cầm, chỗ đau, một lưu ý hiệu quả…';

  @override
  String setNoteLast(String note) {
    return 'Lần trước: $note';
  }

  @override
  String get lastTimeNotes => 'Lần trước';

  @override
  String setNoteLine(int n, String note) {
    return 'Hiệp $n · $note';
  }

  @override
  String get newMeasure => 'Số đo mới';

  @override
  String get newMeasureHint =>
      'Bất cứ thứ gì bạn muốn theo dõi: cổ tay, mạch lúc nghỉ, lượng nước trong cơ thể…';

  @override
  String get measureKindLength => 'Chiều dài';

  @override
  String get measureKindLengthHint => 'Tính bằng cm hoặc inch, như các số đo khác';

  @override
  String get measureKindOther => 'Khác';

  @override
  String get measureKindOtherHint => 'Với đơn vị của riêng bạn';

  @override
  String get measureUnit => 'Đơn vị';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Cổ tay, mạch lúc nghỉ…';

  @override
  String get measureRename => 'Đổi tên';

  @override
  String measureDeleteTitle(String name) {
    return 'Xóa $name?';
  }

  @override
  String get measureDeleteBody => 'Mọi giá trị bạn đã ghi cho số đo này cũng bị xóa.';

  @override
  String get measureDelete => 'Xóa số đo này';

  @override
  String get measureEvery => 'Nhắc tôi đo';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Sau $n ngày',
      one: 'Ngày mai',
      zero: 'Hôm nay',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'Đến lúc đo';

  @override
  String get notifMeasureChannel => 'Số đo cơ thể';

  @override
  String get notifMeasureChannelWhy => 'Lời nhắc khi đến lúc đo lại.';

  @override
  String get notifMeasureTitle => 'Đến lúc đo';

  @override
  String notifMeasureBody(int n) {
    return 'Đã $n ngày kể từ lần trước. Cùng vị trí, cùng thời điểm trong ngày.';
  }

  @override
  String get healthLinkWrite => 'Lưu buổi tập của bạn';

  @override
  String get healthLinkWriteHint =>
      'Mỗi buổi tập hoàn thành được gửi đến Health Connect cùng thời gian và loại, để các ứng dụng khác cũng tính vào. Gửi cả 30 ngày qua.';

  @override
  String get healthWorkoutTitle => 'Buổi tập';

  @override
  String get circuits => 'Circuit tính giờ';

  @override
  String get circuitsHint => 'Tập và nghỉ theo đồng hồ, hết vòng này đến vòng khác';

  @override
  String get newCircuit => 'Circuit mới';

  @override
  String get editCircuit => 'Sửa circuit';

  @override
  String get circuitDefaultName => 'Circuit';

  @override
  String get circuitNameHint => 'Tên, ví dụ Bài kết thúc cơ lõi';

  @override
  String get circuitRounds => 'Số vòng';

  @override
  String get circuitRoundRest => 'Nghỉ giữa các vòng';

  @override
  String get circuitWork => 'Tập';

  @override
  String get circuitRest => 'Nghỉ';

  @override
  String get circuitAdd => 'Thêm bài tập';

  @override
  String get circuitEmpty =>
      'Thêm các bài tập theo thứ tự bạn sẽ tập. Một bài có thể xuất hiện hai lần, như plank nghiêng cho mỗi bên.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(steps, locale: localeName, other: '$steps bài tập');
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds vòng');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Bắt đầu';

  @override
  String get circuitGetReady => 'Chuẩn bị';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Vòng $n/$total';
  }

  @override
  String circuitNext(String name) {
    return 'Tiếp theo: $name';
  }

  @override
  String get circuitFinishLine => 'Bài cuối cùng, rồi xong';

  @override
  String get circuitDone => 'Đã xong circuit';

  @override
  String circuitDoneBody(String time) {
    return '$time · đã lưu vào lịch sử';
  }

  @override
  String get circuitStopTitle => 'Dừng circuit?';

  @override
  String get circuitStopBody => 'Những gì bạn đã tập đến giờ được lưu vào lịch sử.';

  @override
  String get circuitStop => 'Dừng';

  @override
  String get circuitKeepGoing => 'Tập tiếp';

  @override
  String circuitDeleteTitle(String name) {
    return 'Xóa $name?';
  }

  @override
  String get circuitDeleteBody => 'Các buổi tập bạn đã thực hiện với circuit này vẫn nằm trong lịch sử.';

  @override
  String get circuitPickExercise => 'Chọn bài tập';

  @override
  String get circuitNoSteps => 'Thêm ít nhất một bài tập';

  @override
  String get circuitPrevious => 'Trước đó';

  @override
  String get circuitUpNext => 'Tiếp theo';

  @override
  String get foodGroupNew => 'Danh mục mới';

  @override
  String get foodGroupHint => 'Món ăn sẵn, đồ đông lạnh…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n thực phẩm',
      zero: 'Chưa có thực phẩm',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Xóa $name?';
  }

  @override
  String get foodGroupDeleteBody => 'Thực phẩm của bạn vẫn còn, chỉ không thuộc danh mục này nữa.';

  @override
  String onbHello(String name) {
    return 'Chào $name';
  }

  @override
  String get onbPlaceHero => 'bài tập bạn có thể tập';

  @override
  String get settingsRests => 'Nghỉ';

  @override
  String get settingsDuring => 'Trong khi tập';

  @override
  String get settingsLook => 'Giao diện';

  @override
  String get importCardTitle => 'Đưa các buổi tập của bạn về đây';

  @override
  String get importCardBody => 'Từ Hevy, Strong, FitNotes và nhiều ứng dụng khác';

  @override
  String get checkInTitle => 'Hôm nay bạn đến tập trong trạng thái nào?';

  @override
  String get checkInSleep => 'Giấc ngủ';

  @override
  String get checkInEnergy => 'Năng lượng';

  @override
  String get checkInSkip => 'Không bắt buộc';

  @override
  String get checkInLevel1 => 'Rất tệ';

  @override
  String get checkInLevel2 => 'Kém';

  @override
  String get checkInLevel3 => 'Tạm được';

  @override
  String get checkInLevel4 => 'Tốt';

  @override
  String get checkInLevel5 => 'Rất tốt';

  @override
  String get checkInSetting => 'Giấc ngủ và năng lượng';

  @override
  String get checkInSettingHint => 'Hỏi khi bạn kết thúc buổi tập';

  @override
  String get readinessTitle => 'Giấc ngủ và năng lượng';

  @override
  String get readinessWaiting => 'Hãy tiếp tục đánh giá các buổi tập';

  @override
  String get readinessWaitingHint =>
      'Sau vài ngày tốt và xấu, bạn sẽ thấy chúng ảnh hưởng đến mức tạ ra sao.';

  @override
  String readinessSleepLess(int n) {
    return 'Vào những ngày ngủ ít, bạn nâng kém hơn $n%';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Lạ thật: vào những ngày ngủ ít, bạn nâng nhiều hơn $n%';
  }

  @override
  String get readinessSleepNone => 'Giấc ngủ hầu như không ảnh hưởng đến mức tạ của bạn';

  @override
  String readinessEnergyLess(int n) {
    return 'Vào những ngày ít năng lượng, bạn nâng kém hơn $n%';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'Vào những ngày ít năng lượng, bạn vẫn nâng nhiều hơn $n%';
  }

  @override
  String get readinessEnergyNone => 'Năng lượng hầu như không ảnh hưởng đến mức tạ của bạn';

  @override
  String get readinessHint => 'So sánh mỗi 1RM ước tính với mức tốt nhất của bạn trong 90 ngày trước đó.';

  @override
  String get readinessLast30 => 'Trung bình 30 ngày qua';

  @override
  String get kindSport => 'Thể thao';

  @override
  String get clearWorkouts => 'Chỉ xóa buổi tập';

  @override
  String get clearWorkoutsNone => 'Không có buổi tập nào để xóa';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Xóa $n buổi tập?');
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Lịch sử, kỷ lục và huy chương sẽ bị xóa. Giáo án tập, bài tập, ảnh, số đo, dinh dưỡng và cài đặt vẫn được giữ. Hãy xuất bản sao lưu trước nếu bạn có thể muốn lấy lại chúng.';

  @override
  String get clearWorkoutsConfirm => 'Xóa buổi tập';

  @override
  String get clearWorkoutsDone => 'Đã xóa các buổi tập';

  @override
  String get reportTitle => 'Báo cáo';

  @override
  String get reportHint => 'Chọn ngày và chia sẻ dưới dạng PDF hoặc CSV';

  @override
  String get reportCustom => 'Khác';

  @override
  String get reportPickRange => 'Chọn ngày';

  @override
  String get reportEmpty => 'Không ghi gì trong khoảng ngày này.';

  @override
  String get reportKicker => 'BÁO CÁO TẬP LUYỆN';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ngày');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'BUỔI TẬP';

  @override
  String get reportPerWeek => 'MỖI TUẦN';

  @override
  String get reportHours => 'GIỜ';

  @override
  String get reportVsPrev => 'Phần trăm được so với cùng số ngày ngay trước đó.';

  @override
  String get reportRecords => 'Kỷ lục mới';

  @override
  String get reportLifts => 'Bài tập';

  @override
  String get reportSessionsCol => 'NGÀY';

  @override
  String get reportBestCol => '1RM TỐT NHẤT';

  @override
  String get reportChangeCol => 'THAY ĐỔI';

  @override
  String get reportBestHint =>
      '1RM tốt nhất được ước tính từ các hiệp của bạn. Thay đổi so sánh ngày đầu và ngày cuối của bài tập trong báo cáo này.';

  @override
  String get reportMuscles => 'Số hiệp mỗi nhóm cơ';

  @override
  String get reportBody => 'Cơ thể và phục hồi';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Dinh dưỡng · trung bình $n ngày');
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n kỷ lục mới');
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n bài tập');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal và $protein g đạm mỗi ngày · đã ghi $days ngày';
  }

  @override
  String get reportSharePdf => 'Chia sẻ PDF';

  @override
  String get reportShareCsv => 'Xuất CSV';

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
  String get reportShareCsvBoth => 'Xuất CSV (buổi tập và dinh dưỡng)';

  @override
  String fastMinutes(int n) {
    return '$n phút';
  }

  @override
  String fastHours(int n) {
    return '$n giờ';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h giờ $m phút';
  }

  @override
  String get fastTracker => 'Nhịn ăn gián đoạn';

  @override
  String fastTitle(int fast, int eat) {
    return 'Nhịn ăn $fast:$eat';
  }

  @override
  String get fastOptions => 'Tùy chọn nhịn ăn';

  @override
  String get fastWindowOpen => 'Đang trong khung giờ ăn';

  @override
  String get fastLeft => 'Còn lại';

  @override
  String get fastDoneLabel => 'Đã đạt mục tiêu';

  @override
  String get fastIdle => 'Bắt đầu sau bữa ăn cuối cùng';

  @override
  String fastLast(String time) {
    return 'Lần nhịn gần nhất: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n lần liên tiếp';
  }

  @override
  String fastReached(String time) {
    return 'Vượt mục tiêu $time';
  }

  @override
  String fastEndsAt(String time) {
    return 'Kết thúc lúc $time';
  }

  @override
  String fastSince(String time) {
    return 'Từ $time';
  }

  @override
  String get fastStartedAt => 'Bạn bắt đầu nhịn ăn lúc nào?';

  @override
  String get fastStart => 'Bắt đầu nhịn ăn';

  @override
  String fastFromMeal(String time) {
    return 'Từ $time';
  }

  @override
  String get fastEnd => 'Kết thúc nhịn ăn';

  @override
  String get fastCancel => 'Hủy lần nhịn ăn này';

  @override
  String get fastPlan => 'Kế hoạch nhịn ăn';

  @override
  String get fastPlanHint => 'Số giờ nhịn : số giờ ăn';

  @override
  String get fastThisWeek => '7 ngày qua';

  @override
  String get fastCount => 'Lần nhịn';

  @override
  String get fastReachedCount => 'Đạt';

  @override
  String get fastAverage => 'Trung bình';

  @override
  String get fastHistory => 'Các lần nhịn gần đây';

  @override
  String get notifFastLiveChannel => 'Đang nhịn ăn';

  @override
  String get notifFastLiveChannelWhy => 'Đếm ngược lặng lẽ trong khi bạn nhịn ăn.';

  @override
  String get notifFastChannel => 'Nhịn ăn';

  @override
  String get notifFastChannelWhy => 'Báo cho bạn khi kết thúc thời gian nhịn ăn.';

  @override
  String get notifFastLiveTitle => 'Đang nhịn ăn';

  @override
  String notifFastLiveBody(String time) {
    return 'Khung giờ ăn của bạn mở lúc $time';
  }

  @override
  String get notifFastDoneTitle => 'Đã xong nhịn ăn';

  @override
  String notifFastDoneBody(int n) {
    return '$n giờ. Khung giờ ăn của bạn đã mở.';
  }

  @override
  String get newExerciseHint => 'Chỉ cần tên. Phần còn lại có ích, nhưng bạn có thể thêm sau.';

  @override
  String get supportThanksTitle => 'Cảm ơn bạn đã ở đây 🤍';

  @override
  String get supportThanksBody =>
      'GymMane miễn phí và sẽ luôn như vậy, không quảng cáo và không có gì bị giấu.\n\nNếu ứng dụng giúp ích cho việc tập luyện của bạn, mời tôi một ly cà phê sẽ làm tôi vui cả ngày ☕\nCòn nếu không thể, đừng lo: một ngôi sao trên GitHub cũng vậy ⭐';

  @override
  String get perfSetting => 'Hiệu năng';

  @override
  String get perfSheetHint =>
      'GymMane dùng bao nhiêu tài nguyên điện thoại. Bạn có thể thay đổi từng phần bên dưới.';

  @override
  String get perfLite => 'Tiết kiệm';

  @override
  String get perfLiteHint => 'Không làm mờ và chuyển động nhẹ nhàng hơn. Cho các điện thoại hay bị chậm.';

  @override
  String get perfBalanced => 'Cân bằng';

  @override
  String get perfBalancedHint => 'Làm mờ và hiệu ứng động mà không hao pin.';

  @override
  String get perfMax => 'Tối đa';

  @override
  String perfMaxHint(int hz) {
    return 'Làm mờ mịn hơn và màn hình ở $hz Hz. Cho điện thoại cao cấp.';
  }

  @override
  String get perfMaxHintNoHz => 'Làm mờ mịn hơn ở mọi nơi. Cho điện thoại cao cấp.';

  @override
  String get perfCustom => 'Tùy chỉnh';

  @override
  String get perfTweak => 'Tinh chỉnh';

  @override
  String get perfFine => 'Làm mờ mịn';

  @override
  String get perfFineHint => 'Viền mềm hơn và nền phía sau các bảng sắc nét hơn';

  @override
  String perfHz(int hz) {
    return 'Màn hình ở $hz Hz';
  }

  @override
  String get perfHzHint => 'Mọi thứ cuộn mượt hơn, tốn thêm chút pin';

  @override
  String get lowEndLiteBody =>
      'Chế độ Tiết kiệm (không làm mờ, chuyển động nhẹ nhàng hơn) sẽ chạy mượt hơn trên máy này. Bạn có thể thay đổi trong Cài đặt → Chung → Hiệu năng.';

  @override
  String get lowEndLiteOn => 'Bật Tiết kiệm';

  @override
  String get dayOffHint => 'Chuỗi ngày và lời nhắc sẽ bỏ qua ngày này';

  @override
  String get dayOffTrained => 'Tôi có tập, chỉ là không ghi lại';

  @override
  String get dayOffSick => 'Ốm';

  @override
  String get dayOffTravel => 'Đi xa';

  @override
  String get dayOffInjury => 'Chấn thương';

  @override
  String get dayOffRest => 'Nghỉ ngơi';

  @override
  String get altsTitle => 'Bài thay thế';

  @override
  String get altsHint => 'Phòng khi máy đang có người dùng';

  @override
  String altsPickHint(int count) {
    return 'Chọn tối đa $count. Nếu máy đang có người dùng, đổi chỉ với một lần chạm.';
  }

  @override
  String get placeDumbbells => 'Tạ đơn';

  @override
  String get dumbbellsHint =>
      'Mức tạ của một quả tạ đơn. Tăng tiến và các nút + và − sẽ chỉ dừng ở các mức này tại đây.';

  @override
  String get dumbbellOther => 'Mức tạ khác';

  @override
  String get tuneTitle => 'Khối lượng hôm nay';

  @override
  String get tuneHint => 'Cho tôi biết cảm giác của từng nhóm cơ và tôi sẽ điều chỉnh số hiệp cho lần sau.';

  @override
  String get tuneLess => 'Quá ít';

  @override
  String get tuneRight => 'Vừa';

  @override
  String get tuneMore => 'Quá nhiều';

  @override
  String tuneNext(String sets, String name) {
    return 'Lần sau: $sets $name';
  }

  @override
  String get tuneSame => 'Lần sau giữ nguyên';

  @override
  String get tuneSetting => 'Điều chỉnh số hiệp mỗi nhóm cơ';

  @override
  String get tuneSettingHint => 'Sau một giáo án tập, đánh giá từng nhóm cơ và số hiệp sẽ được điều chỉnh';

  @override
  String insightLoad(int pct) {
    return 'Nhiều hơn $pct % số hiệp so với tuần thường lệ. Hãy chú ý phục hồi.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days ngày chưa tập.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'Bạn tập đẩy nhiều hơn kéo: $a hiệp so với $b trong bốn tuần.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'Bạn tập kéo nhiều hơn đẩy: $a hiệp so với $b trong bốn tuần.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: khỏe hơn $pct % so với tháng trước.';
  }

  @override
  String recapPull(String month) {
    return 'Tiếp tục kéo để xem $month của bạn';
  }

  @override
  String get recapRelease => 'Thả ra';

  @override
  String recapHi(String name) {
    return 'Chào $name';
  }

  @override
  String recapReady(String month) {
    return 'Cùng xem bạn đã làm được gì trong $month nhé?';
  }

  @override
  String get recapGo => 'Xem thôi';

  @override
  String recapEmpty(String month) {
    return 'Chưa có buổi tập nào trong $month. Buổi đầu tiên sẽ mở mục này.';
  }

  @override
  String get recapClose => 'Đóng';

  @override
  String get recapShare => 'Chia sẻ';

  @override
  String get recapWorkoutsKicker => 'Tháng này bạn đã tập';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'buổi tập');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Trong $n ngày khác nhau',
      one: 'Trong một ngày',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Thời gian dưới thanh đòn';

  @override
  String recapLongest(String time, String date) {
    return 'Buổi tập dài nhất: $time, vào $date';
  }

  @override
  String get recapVolumeKicker => 'Bạn đã nâng';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Như nâng $count chiếc ô tô',
      one: 'Như nâng một chiếc ô tô',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Nhiều nhất: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Nhóm cơ của tháng';

  @override
  String get recapRecordsKicker => 'Kỷ lục mới';

  @override
  String recapNoRecords(int n) {
    return 'Lần này không có kỷ lục, nhưng $n hiệp đã được cất vào sổ.';
  }

  @override
  String get recapHabitKicker => 'Khoảnh khắc của bạn';

  @override
  String recapHabitStart(String time) {
    return 'Bạn thường bắt đầu lúc $time';
  }

  @override
  String get recapShareKicker => 'Tháng của bạn, sẵn sàng để chia sẻ';

  @override
  String get recapTickWorkouts => 'Buổi tập';

  @override
  String get recapTickTime => 'Thời gian';

  @override
  String get recapTickVolume => 'Khối lượng';

  @override
  String get recapTickRecords => 'Kỷ lục';

  @override
  String recapAvg(int n) {
    return 'Trung bình $n phút mỗi buổi tập';
  }

  @override
  String get recapLiftKicker => 'Bài tập của tháng';

  @override
  String get recapBest => 'Tốt nhất';

  @override
  String get recapTimes => 'Ngày';

  @override
  String get recapDaysLabel => 'Ngày';

  @override
  String get recapAvgLabel => 'Trung bình';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts buổi tập trong $days ngày';
  }

  @override
  String get recapFavLabel => 'Ngày của bạn';

  @override
  String get recapWatermark => 'nhật ký tập gym miễn phí';

  @override
  String get recapTickSteps => 'Số bước';

  @override
  String get recapTickFood => 'Ăn uống';

  @override
  String get recapCardioKicker => 'Cardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n buổi tập', one: 'một buổi tập');
    return '$minutes phút qua $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n buổi cardio',
      one: 'Một buổi cardio',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Bài ruột của bạn: $name';
  }

  @override
  String get recapStepsKicker => 'Bạn đã đi bộ';

  @override
  String get recapStepsWord => 'bước';

  @override
  String recapStepsAvg(String value) {
    return 'Trung bình $value mỗi ngày';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Ngày tốt nhất: $value, $date';
  }

  @override
  String get recapFoodKicker => 'Trên đĩa của bạn';

  @override
  String get recapLiftRest => 'Theo sát phía sau';

  @override
  String recapSameAs(String month) {
    return 'Bằng với $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return 'Nhiều hơn $value so với $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return 'Ít hơn $value so với $month';
  }

  @override
  String get recapTickMedals => 'Huy chương';

  @override
  String get recapTickSleep => 'Giấc ngủ';

  @override
  String get recapMedalsKicker => 'Huy chương bạn đã giành';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Và thêm $n huy chương nữa',
      one: 'Và thêm một huy chương nữa',
    );
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Bạn đã ngủ';

  @override
  String get recapSleepAvg => 'mỗi đêm trung bình';

  @override
  String recapSleepBest(String value, String date) {
    return 'Đêm ngủ ngon nhất: $value, $date';
  }

  @override
  String get recapCardSummary => 'Tóm tắt';

  @override
  String get recapCardCalendar => 'Lịch';

  @override
  String get recapCardLift => 'Bài tập';

  @override
  String get recapPeakKicker => 'Buổi tập vất vả nhất';

  @override
  String get recapTickPeak => 'Buổi tập';

  @override
  String get recapFreshKicker => 'Lần đầu tiên trong tháng này';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'bài tập mới');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Mới';

  @override
  String recapStreak(int n) {
    return '$n ngày liên tiếp, chuỗi dài nhất của bạn';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n buổi tập', one: '1 buổi tập');
    return 'Một năm trước: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Bị bỏ quên tháng này: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'đạm mỗi ngày · mục tiêu $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Có trên đĩa $n ngày',
      one: 'Có trên đĩa 1 ngày',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Đạm · g/ngày';

  @override
  String get recapFoodGoalDays => 'Đạt mục tiêu';

  @override
  String get recapFoodWaterLabel => 'Nước/ngày';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ngày', one: '1 ngày');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Món ăn của tháng';

  @override
  String get onbSpeedTitle => 'Giúp ứng dụng chạy mượt';

  @override
  String get onbSpeedWhy =>
      'Điện thoại của bạn có vẻ đang phải làm việc vất vả. Tắt những mục này và mọi thứ sẽ trơn tru hơn: hãy thử và xem bản xem trước.';

  @override
  String get onbSpeedMotion => 'Hiệu ứng động';

  @override
  String get onbSpeedBlurHint => 'Kính mờ phía sau các bảng và thanh';

  @override
  String get onbSpeedMotionHint => 'Màn hình và bảng trượt vào';

  @override
  String get onbSpeedLater => 'Bạn có thể thay đổi bất cứ lúc nào trong Cài đặt › Chung › Hiệu năng.';

  @override
  String get notifSoundSetting => 'Âm thanh thông báo';

  @override
  String get notifSoundRowHint => 'Âm thanh của từng loại lời nhắc';

  @override
  String get notifSoundHint =>
      'Chọn một âm thanh cho từng loại lời nhắc. Từ điện thoại sẽ mở âm thanh của điện thoại, và trên hầu hết điện thoại bạn có thể thêm bài hát của riêng mình ở đó.';

  @override
  String get notifSoundTrain => 'Buổi tập';

  @override
  String get notifSoundFood => 'Ăn uống, thực phẩm bổ sung và nhịn ăn';

  @override
  String get notifSoundOther => 'Ảnh và số đo';

  @override
  String get notifSoundNormal => 'Bình thường';

  @override
  String get notifSoundPhone => 'Từ điện thoại';

  @override
  String get notifSoundSilent => 'Im lặng';

  @override
  String get notifSoundPhoneHint => 'Chạm vào một âm để nghe thử. Lựa chọn được lưu ngay.';

  @override
  String get notifSoundMore => 'Tệp khác…';

  @override
  String get notifSoundChange => 'Thay đổi';

  @override
  String get workoutNoteAdd => 'Ghi chú ghim: ghế, cách cầm, máy…';

  @override
  String get autoProgressSetting => 'Tự động tăng tiến';

  @override
  String get autoProgressRowHint => 'Gợi ý cho lần sau';

  @override
  String get autoProgressOff => 'Tắt';

  @override
  String get autoProgressWeight => 'Thêm mức tạ';

  @override
  String get autoProgressReps => 'Thêm lần lặp';

  @override
  String get autoProgressHint =>
      'Khi bạn bắt đầu buổi tập, GymMane sẽ điền bước tiếp theo cho từng bài tập. Với Thêm lần lặp, bạn thêm một lần lặp mỗi hiệp cho đến 12, sau đó mức tạ tăng lên và bạn bắt đầu lại từ 8. Bạn vẫn có thể điều chỉnh từng bài tập trong trang của nó.';

  @override
  String get noteFolders => 'Thư mục';

  @override
  String get noteFolderNew => 'Thư mục mới';

  @override
  String get noteFolderEdit => 'Sửa thư mục';

  @override
  String get noteFolderName => 'Tên thư mục';

  @override
  String get noteFolderLabel => 'Thư mục';

  @override
  String get noteFolderNone => 'Không có thư mục';

  @override
  String get noteFolderDelete => 'Xóa thư mục?';

  @override
  String get noteFolderDeleteBody => 'Ghi chú vẫn được giữ: chúng chỉ rời khỏi thư mục.';

  @override
  String get foodArchivedToast => 'Đã lưu trữ thực phẩm';

  @override
  String get planArchivedToast => 'Đã lưu trữ kế hoạch';

  @override
  String get suppArchivedToast => 'Đã lưu trữ thực phẩm bổ sung';

  @override
  String get voiceSetting => 'Giọng nói khi tập';

  @override
  String get voiceSettingHint =>
      'Đọc hiệp tiếp theo và đếm ngược lúc hết giờ nghỉ, bằng giọng nói của điện thoại';

  @override
  String get voiceHello => 'Đã bật giọng nói';

  @override
  String voiceRest(String time) {
    return 'Nghỉ $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Tiếp theo: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps lần lặp với $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps lần lặp';
  }

  @override
  String get voiceGo => 'Bắt đầu nào!';

  @override
  String get deloadSetting => 'Tuần giảm tải';

  @override
  String get deloadOff => 'Không bao giờ';

  @override
  String deloadEvery(int weeks) {
    return 'Mỗi $weeks tuần';
  }

  @override
  String get deloadHint =>
      'Cứ vài tuần lại có một tuần nhẹ hơn để phục hồi: một nửa số hiệp và giảm 10 % mức tạ. Tuần đó không tính vào tăng tiến.';

  @override
  String get deloadRowHint => 'Một tuần nhẹ sau mỗi vài tuần';

  @override
  String get deloadNow => 'Tuần giảm tải';

  @override
  String get deloadNowHint => 'Hôm nay, một nửa số hiệp và giảm 10 % mức tạ';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'Sau $weeks tuần',
      one: 'Tuần sau',
      zero: 'Tuần này',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Tập như bình thường';

  @override
  String get voiceSheetTitle => 'Cách hoạt động của giọng nói';

  @override
  String get voicePointRest =>
      'Khi bạn đánh dấu một hiệp, giọng nói sẽ cho biết thời gian nghỉ và bài tiếp theo.';

  @override
  String get voicePointCount => 'Giọng nói đếm 3, 2, 1 khi hết giờ nghỉ và gọi bạn quay lại.';

  @override
  String get voicePointPhone => 'Dùng giọng nói của điện thoại và phát đè lên nhạc của bạn.';

  @override
  String get voiceTry => 'Thử giọng nói';

  @override
  String get voiceNoEngine => 'Điện thoại của bạn chưa bật công cụ giọng nói nào.';

  @override
  String get voiceNoLang =>
      'Thiếu giọng nói cho ngôn ngữ của bạn. Hãy tải xuống trong cài đặt giọng nói của điện thoại.';

  @override
  String get voiceOpenSettings => 'Cài đặt giọng nói';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count phút');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count giây');
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'và';

  @override
  String get repRecordsTitle => 'Mức tạ tốt nhất theo số lần';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'viên nang');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'viên');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'muỗng');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'giọt');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'khẩu phần');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'Còn lại';

  @override
  String get suppLeftHint => 'Không bắt buộc';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đủ dùng $n ngày');
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ngày');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Đã hết';

  @override
  String get lightSession => 'Buổi tập nhẹ';

  @override
  String get lightSessionHint =>
      'Được lưu vào lịch sử và thống kê, nhưng không thay đổi mục tiêu tiếp theo của bạn.';

  @override
  String get lightSessionNote => 'Không tính vào tiến độ tăng tạ';

  @override
  String get lightSessionOff => 'Tắt';

  @override
  String get eachSideRepsHint =>
      'Ghi riêng số lần bên trái và bên phải. Tiến độ tăng tạ dựa theo bên yếu hơn.';

  @override
  String get repsLeftCol => 'LẦN T';

  @override
  String get repsRightCol => 'LẦN P';

  @override
  String get repsLeftTitle => 'SỐ LẦN BÊN TRÁI';

  @override
  String get repsRightTitle => 'SỐ LẦN BÊN PHẢI';

  @override
  String sidesReps(int l, int r) {
    return 'T$l P$r';
  }

  @override
  String get progSchemeTitle => 'Tăng tạ dần';

  @override
  String get groupMoveUp => 'Đưa nhóm lên';

  @override
  String get groupMoveDown => 'Đưa nhóm xuống';

  @override
  String get mealAiRow => 'Hỏi AI';

  @override
  String get mealAiRowHint => 'Sao chép yêu cầu, dán câu trả lời';

  @override
  String get mealAiTitle => 'Bữa ăn với AI';

  @override
  String get mealAiSubtitle => 'Dùng được với mọi chatbot. Ứng dụng vẫn ngoại tuyến.';

  @override
  String get mealAiStepAsk => 'Hỏi';

  @override
  String get mealAiStepPaste => 'Dán';

  @override
  String get mealAiWholeDay => 'Cả ngày';

  @override
  String get mealAiTarget => 'Mục tiêu';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'Hôm nay bạn còn $kcal và $protein g đạm';
  }

  @override
  String get mealAiStyle => 'Khẩu vị của bạn';

  @override
  String get mealAiTagProtein => 'Nhiều đạm';

  @override
  String get mealAiTagVeggie => 'Ăn chay';

  @override
  String get mealAiTagVegan => 'Thuần chay';

  @override
  String get mealAiTagNoGluten => 'Không gluten';

  @override
  String get mealAiTagNoLactose => 'Không lactose';

  @override
  String get mealAiTagQuick => 'Nhanh';

  @override
  String get mealAiTagNoCook => 'Không cần nấu';

  @override
  String get mealAiTagCheap => 'Tiết kiệm';

  @override
  String get mealAiNotesHint => 'Nhà có sẵn… Không thích… dị ứng…';

  @override
  String get mealAiOptions => 'Lựa chọn';

  @override
  String get mealAiCopy => 'Sao chép yêu cầu';

  @override
  String get mealAiCopied => 'Đã sao chép yêu cầu';

  @override
  String get mealAiCopiedHint => 'Dán vào AI của bạn rồi quay lại đây với câu trả lời';

  @override
  String get mealAiShowText => 'Xem yêu cầu';

  @override
  String get mealAiHideText => 'Ẩn yêu cầu';

  @override
  String get mealAiPasteHint => 'Dán câu trả lời của AI vào đây';

  @override
  String get mealAiReview => 'Xem lại câu trả lời';

  @override
  String get mealAiUnreadable => 'Mình không tìm thấy món ăn nào trong đoạn văn bản đó';

  @override
  String get mealAiUnreadableHint =>
      'Hãy nhờ AI chỉ gửi JSON, trong một khối mã, theo đúng định dạng của yêu cầu.';

  @override
  String get mealAiCopyFix => 'Sao chép câu đó';

  @override
  String mealAiOption(int n) {
    return 'Lựa chọn $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Thêm vào $meal';
  }

  @override
  String get mealAiAddDay => 'Thêm vào hôm nay';

  @override
  String get mealAiAddPick => 'Thêm';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Đã thêm $n món');
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Lưu thành công thức';

  @override
  String get mealAiSavePlan => 'Lưu thành kế hoạch';

  @override
  String get mealAiRecipeSaved => 'Đã lưu công thức';

  @override
  String get mealAiPlanSaved => 'Đã lưu kế hoạch';

  @override
  String get mealAiFlagEstimated => 'AI ước tính';

  @override
  String get mealAiFlagAdjusted => 'Đã chỉnh calo cho khớp với macro';

  @override
  String get mealAiFlagDoubtful => 'Số liệu không khớp, hãy kiểm tra';

  @override
  String get mealAiFlagNoValues => 'Không có giá trị dinh dưỡng';

  @override
  String get mealAiFlagNoAmount => 'Không có lượng cụ thể';

  @override
  String get mealAiTruncated => 'Câu trả lời có vẻ bị cắt. Mình giữ lại các món đầy đủ.';

  @override
  String get mealAiAmount => 'Lượng';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Mục tiêu $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Hãy bật ít nhất một món';

  @override
  String get cholesterolLabel => 'Cholesterol';

  @override
  String get mealAiFlagMatched => 'Giống một món bạn đã lưu';

  @override
  String get mealAiNotSame => 'Không giống';

  @override
  String get homeOrderRow => 'Thứ tự các mục';

  @override
  String get homeOrderHint => 'Nhấn giữ và kéo để đổi thứ tự trên Trang chủ.';

  @override
  String get homeOrderFolders => 'Lối tắt';

  @override
  String get equipNew => 'Mới';

  @override
  String get equipNewTitle => 'Dụng cụ mới';

  @override
  String get equipNewHint => 'VD: Đai lưng tập tạ';

  @override
  String get homeOrderWeekdays => 'Đánh dấu trong tuần';

  @override
  String get repsMaxTitle => 'Số lần tối đa';

  @override
  String get repsRangeHint => 'Nhấn giữ số lần để đặt khoảng như 8-12.';

  @override
  String get repsRangeClear => 'Bỏ khoảng';

  @override
  String get noteLinksLabel => 'LIÊN KẾT';

  @override
  String get noteLinkAdd => 'Thêm liên kết';

  @override
  String get noteLinkEdit => 'Sửa liên kết';

  @override
  String get noteLinkNameHint => 'Tên';

  @override
  String get noteLinkUrlHint => 'Địa chỉ web';

  @override
  String get noteLinkInvalid => 'Địa chỉ đó có vẻ không đúng';

  @override
  String get changeRest => 'Nghỉ giữa các bài tập';

  @override
  String get changeRestHint => 'Sau hiệp cuối, trước bài tập tiếp theo';

  @override
  String get notifSuppTake => 'Đã uống';

  @override
  String get sideRest => 'Nghỉ giữa hai bên';

  @override
  String get sideRestHint => 'Bài tập từng bên: dấu ✓ đầu tiên kết thúc một bên';

  @override
  String get gfxCompat => 'Đồ họa tương thích';

  @override
  String get gfxCompatHint =>
      'Cho những máy hiển thị chữ bị lỗi. Hiệu ứng mờ vẫn giữ, vài hiệu ứng sẽ đơn giản hơn';

  @override
  String get gfxRestartTitle => 'Khởi động lại GymMane?';

  @override
  String get gfxRestartBody =>
      'Ứng dụng sẽ đóng rồi mở lại để đổi cách vẽ màn hình. Không mất gì bạn đã lưu.';

  @override
  String get gfxRestart => 'Khởi động lại';

  @override
  String get webSynced => 'Đã cập nhật thay đổi từ thiết bị khác';

  @override
  String get webSyncedPhone => 'Đã có thay đổi từ điện thoại của bạn';

  @override
  String get webWelcomeBlurb =>
      'Mọi thứ nằm trên máy chủ của riêng bạn. Không tài khoản, không đám mây, không phải trả tiền.';

  @override
  String get webOwnServer => 'Máy chủ của bạn, luật của bạn';

  @override
  String get webOwnServerWhy => 'Không tài khoản, không đám mây bên thứ ba. Dữ liệu nằm ở nơi bạn chạy nó.';

  @override
  String get webServerSaved => 'Đã lưu trên máy chủ của bạn';

  @override
  String get webServerOffline => 'Không kết nối được máy chủ của bạn';

  @override
  String get webServerLocal => 'Đã lưu trong trình duyệt này';

  @override
  String get webServerTitle => 'Máy chủ của bạn';

  @override
  String webPhoneLast(String date) {
    return 'Bản sao gần nhất từ điện thoại: $date';
  }

  @override
  String get webPhoneNone => 'Chưa có bản sao nào từ điện thoại';

  @override
  String get webPhoneScan => 'Lấy từ điện thoại';

  @override
  String get webPhoneExport => 'Gửi sang điện thoại';

  @override
  String get webPhoneExportDone => 'Đã để trong thư mục chung. Điện thoại sẽ lấy khi đồng bộ';

  @override
  String get webPhoneImported => 'Đã có thay đổi từ điện thoại của bạn';

  @override
  String get webPhoneNothing => 'Không có gì mới từ điện thoại';

  @override
  String get webPhoneHow =>
      'Bật sao lưu tự động trên điện thoại vào một thư mục bạn đồng bộ bằng Syncthing. Máy chủ và điện thoại tự lấy thay đổi của nhau, và việc gộp không bao giờ xóa gì cả.';

  @override
  String get webPhoneGuide => 'Cách thiết lập';

  @override
  String get webPhoneOff => 'Đồng bộ điện thoại đang tắt trên máy chủ này';

  @override
  String get toolGroupBody => 'Cơ thể';

  @override
  String get toolNameProtein => 'Đạm';

  @override
  String get toolTitleProtein => 'Đạm mỗi ngày';

  @override
  String get toolDescProtein => 'Bao nhiêu đạm mỗi ngày';

  @override
  String get toolHintProtein => 'Gam mỗi ngày, chia đều cho các bữa';

  @override
  String get proteinGoalLabel => 'Mục tiêu';

  @override
  String get proteinExplain =>
      'Dựa trên khoảng mà phần lớn nghiên cứu thống nhất cho người tập luyện: nhiều hơn khi bạn giảm cân, để giữ cơ. Vượt qua mức này vẫn an toàn, chỉ là không thêm được bao nhiêu.';

  @override
  String get toolNameWater => 'Nước';

  @override
  String get toolTitleWater => 'Nước mỗi ngày';

  @override
  String get toolDescWater => 'Nên uống bao nhiêu mỗi ngày';

  @override
  String get toolHintWater => 'Lít mỗi ngày, tính cả thức ăn';

  @override
  String get waterTrainingLabel => 'Thời gian tập mỗi ngày';

  @override
  String get waterExplain =>
      'Khoảng 35 ml cho mỗi kg cân nặng, cộng thêm một chút cho mỗi phút tập. Uống nhiều hơn vào ngày nóng.';

  @override
  String get autoBackupSync => 'Đồng bộ ngay';

  @override
  String get autoBackupMerged => 'Đã có thay đổi từ các thiết bị khác của bạn';

  @override
  String get autoBackupSyncHint =>
      'Chia sẻ thư mục này bằng Syncthing và mỗi thiết bị sẽ lấy những gì các thiết bị khác để lại. Việc gộp không bao giờ xóa gì cả.';

  @override
  String get webPhoneFolder => 'Thư mục chung';

  @override
  String get webPhoneFolderHow =>
      'Được chọn khi cài máy chủ. Để đổi, đặt GYMMANE_SYNC trong tệp .env của máy chủ rồi khởi động lại.';

  @override
  String get webPhoneOffHow => 'Để bật, xóa GYMMANE_SYNC=off khỏi tệp .env của máy chủ rồi khởi động lại.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Đã đồng bộ $n điện thoại',
      zero: 'Chưa có điện thoại nào đồng bộ',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Không đọc được thư mục: $error';
  }

  @override
  String get duplicateExercise => 'Nhân bản';

  @override
  String exerciseCopyName(String name) {
    return '$name (bản sao)';
  }
}
