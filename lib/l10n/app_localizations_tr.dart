// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get languageName => 'Türkçe';

  @override
  String vsLastMonthLabel(String pct) {
    return 'Geçen aya göre %$pct';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Seviye $level · $streak';
  }

  @override
  String get save => 'KAYDET';

  @override
  String get cancel => 'İptal';

  @override
  String get cancelCaps => 'İPTAL';

  @override
  String get deleteCaps => 'SİL';

  @override
  String get done => 'TAMAM';

  @override
  String get set => 'Set';

  @override
  String get home => 'ANA SAYFA';

  @override
  String get progress => 'İLERLEME';

  @override
  String get exercises => 'EGZERSİZLER';

  @override
  String get settings => 'AYARLAR';

  @override
  String get today => 'BUGÜN';

  @override
  String get thisWeek => 'BU HAFTA';

  @override
  String get recommended => 'ÖNERİLEN';

  @override
  String get goal => 'HEDEF';

  @override
  String get volume => 'HACİM';

  @override
  String get setsToday => 'BUGÜNKÜ SETLER';

  @override
  String get prs => 'REKORLAR';

  @override
  String get todaysFocus => 'BUGÜNÜN ODAĞI';

  @override
  String get todaysRoutine => 'BUGÜNÜN PROGRAMI';

  @override
  String get startWorkout => 'ANTRENMANA BAŞLA';

  @override
  String get routines => 'PROGRAMLAR';

  @override
  String get tools => 'ARAÇLAR';

  @override
  String get firstSessionHint => 'Kaslarını seç ve ilk antrenmanını kaydet';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n egzersiz', one: '$n egzersiz');
    return '$_temp0';
  }

  @override
  String get pushDay => 'İTİŞ GÜNÜ';

  @override
  String get pullDay => 'ÇEKİŞ GÜNÜ';

  @override
  String get legDay => 'BACAK';

  @override
  String get pushFocus => 'Göğüs · Omuz · Triseps';

  @override
  String get pullFocus => 'Sırt · Biseps · Trapez';

  @override
  String get legFocus => 'Ön bacak · Arka bacak · Kalça';

  @override
  String get train => 'ANTRENMAN';

  @override
  String get step1 => '2 ADIMDAN 1.';

  @override
  String get step2 => '2 ADIMDAN 2.';

  @override
  String get chooseFocus => 'ODAĞINI SEÇ';

  @override
  String get buildSession => 'ANTRENMANINI OLUŞTUR';

  @override
  String get tapMuscles => 'Çalıştırmak istediğin kaslara dokun — ön ve arka.';

  @override
  String get continueBtn => 'DEVAM';

  @override
  String get nothingForFocus => 'Bu odak için egzersiz yok';

  @override
  String get goBackPick => 'Geri dön ve kütüphanende egzersizi olan bir kas seç.';

  @override
  String pickedHint(int n) {
    return 'Senin için bir antrenman hazırladık — $n egzersizden birini eklemek veya çıkarmak için dokun.';
  }

  @override
  String get pickAnExercise => 'EGZERSİZ SEÇ';

  @override
  String get searchAllExercises => 'Egzersiz ara…';

  @override
  String get noExercisesMatch => 'Eşleşen egzersiz yok';

  @override
  String get createItInstead => 'Bunun yerine kendi egzersizini oluştur';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n EGZERSİZ', one: '$n EGZERSİZ');
    return 'BAŞLA · $_temp0';
  }

  @override
  String get inProgress => 'DEVAM EDİYOR';

  @override
  String get paused => 'DURAKLATILDI';

  @override
  String get last => 'SON';

  @override
  String get rest => 'DİNLENME';

  @override
  String get skip => 'ATLA';

  @override
  String get addSet => '+ SET EKLE';

  @override
  String get finishSession => 'ANTRENMANI BİTİR';

  @override
  String get setDone => 'SET TAMAM';

  @override
  String get nextExercise => 'SONRAKİ EGZERSİZ';

  @override
  String get dropExerciseAction => 'Egzersizi çıkar';

  @override
  String get restOff => 'Kapalı';

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'TEKRAR';

  @override
  String weightCol(String unit) {
    return 'AĞIRLIK ($unit)';
  }

  @override
  String get repsTitle => 'TEKRAR';

  @override
  String weightTitle(String unit) {
    return 'AĞIRLIK ($unit)';
  }

  @override
  String get sessionComplete => 'ANTRENMAN KAYDEDİLDİ';

  @override
  String get finishHeadlinePr => 'Yeni kişisel rekor';

  @override
  String get finishHeadlineGoal => 'Haftalık hedefe ulaşıldı';

  @override
  String get finishHeadlineStreak => 'Seri devam ediyor';

  @override
  String get finishHeadlineDefault => 'Bir antrenman daha tamam';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs egzersizde',
      one: 'bir egzersizde',
    );
    return '$_temp0 her zamankinden daha fazla kaldırdın. Artık kayıtlarda.';
  }

  @override
  String get finishBodyGoal => 'Bu hafta planladığın antrenman sayısına ulaştın.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak gün üst üste. En zor kısmı bırakmamak.';
  }

  @override
  String get finishBodyDefault => 'Kaydedildi ve hesaba katıldı. İlerlemenin sırrı istikrar.';

  @override
  String get vsLastTime => 'SON SEFERE GÖRE';

  @override
  String get firstTime => 'İlk kayıt';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n yeni rekor',
      one: '$n yeni rekor',
    );
    return '$_temp0';
  }

  @override
  String get duration => 'SÜRE';

  @override
  String get setsCaps => 'SETLER';

  @override
  String exerciseXofY(int i, int n) {
    return 'EGZERSİZ $i / $n';
  }

  @override
  String get decrease => 'Azalt';

  @override
  String get increase => 'Artır';

  @override
  String markSet(int n) {
    return 'Set $n tamamlandı olarak işaretle';
  }

  @override
  String get pauseWorkout => 'Antrenmanı duraklat';

  @override
  String get resumeWorkout => 'Antrenmana devam et';

  @override
  String get discardTitle => 'Antrenman silinsin mi?';

  @override
  String get discardBody => 'Bu antrenmandaki setlerin kaybolacak.';

  @override
  String get keepTraining => 'Antrenmana devam et';

  @override
  String get discard => 'Sil';

  @override
  String get notifRestChannel => 'Dinlenme zamanlayıcısı';

  @override
  String get notifRestChannelWhy => 'Setler arasındaki dinlenme süren bittiğinde haber verir';

  @override
  String get notifAlertChannel => 'Dinlenme zamanlayıcısı (uyarı)';

  @override
  String get notifAlertChannelWhy => 'Dinlenmen biter bitmez bir bildirim gösterir';

  @override
  String get restOverTitle => 'Dinlenme bitti';

  @override
  String get restOverBody => 'Devam — sıradaki set seni bekliyor.';

  @override
  String get allTimeSessions => 'ANTRENMANLAR';

  @override
  String get allTimeTime => 'SÜRE';

  @override
  String get allTimeSets => 'SETLER';

  @override
  String get consistency => 'İSTİKRAR';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n antrenman kaydedildi',
      one: '$n antrenman kaydedildi',
    );
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return '$n günlük seri';
  }

  @override
  String get bodyweight => 'VÜCUT AĞIRLIĞI';

  @override
  String get logBodyweight => 'KİLOYU KAYDET';

  @override
  String get trackWeight => 'Kilonun zaman içindeki değişimini takip et';

  @override
  String get muscleMap => 'KAS HARİTASI';

  @override
  String get days7 => '7 G';

  @override
  String get days30 => '30 G';

  @override
  String get days90 => '90 G';

  @override
  String get days365 => '1 Y';

  @override
  String get daysAll => 'Tümü';

  @override
  String get weeklyAvgTitle => 'Haftalık ortalama';

  @override
  String weekOfDate(String date) {
    return '$date haftası';
  }

  @override
  String weightChangeRange(String change) {
    return 'Bu dönemde $change';
  }

  @override
  String get heatLow => 'Çalıştırılmadı';

  @override
  String get heatHigh => 'Maksimum hacim';

  @override
  String get muscleMapEmpty => 'Bir antrenman kaydet, vücudun burada renklenmeye başlasın.';

  @override
  String get muscleMapHint => 'Ne kadar çalıştığını görmek için bir kasa dokun.';

  @override
  String muscleMapBehind(String names) {
    return 'Geride: $names';
  }

  @override
  String ofTarget(int pct) {
    return 'Hedefin %$pct\'si';
  }

  @override
  String get muscleSplit => 'KAS DAĞILIMI';

  @override
  String get personalRecords => 'KİŞİSEL REKORLAR';

  @override
  String get strength1rm => 'GÜÇ · TAH. 1RM';

  @override
  String get strengthEmpty => 'Bir egzersizi iki kez kaydet, güç eğrisi burada görünsün.';

  @override
  String oneRmEst(String w) {
    return 'Tah. 1RM: $w';
  }

  @override
  String get restDayShort => 'Dinlenme günü';

  @override
  String get restDay => 'Dinlenme günü — kayıt yok.';

  @override
  String get delete => 'Sil';

  @override
  String get deleteEntry => 'Bu kayıt silinsin mi?';

  @override
  String deleteEntryBody(String name) {
    return '“$name” bu günden, rekorlarından ve grafiklerinden kaldırılacak.';
  }

  @override
  String get bodyweightHistory => 'GEÇMİŞ';

  @override
  String get exercisesCaps => 'EGZERSİZLER';

  @override
  String get timeCaps => 'SÜRE';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Kütüphanende $n egzersiz',
      one: 'Kütüphanende $n egzersiz',
    );
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Egzersiz ara';

  @override
  String get muscleFilter => 'KAS';

  @override
  String get levelFilter => 'SEVİYE';

  @override
  String get kindLabel => 'TÜR';

  @override
  String get kindStrength => 'Kuvvet';

  @override
  String get kindCalisthenics => 'Kalistenik';

  @override
  String get kindCardio => 'Kardiyo';

  @override
  String get kindStretch => 'Esneme';

  @override
  String get newExercise => 'YENİ EGZERSİZ';

  @override
  String get exerciseName => 'Egzersiz adı';

  @override
  String get equipmentLabel => 'EKİPMAN';

  @override
  String get addExercise => 'EGZERSİZ EKLE';

  @override
  String get advanced => 'İLERİ';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Medya ekle';

  @override
  String get mediaHint => 'Görsel, GIF veya video';

  @override
  String get changeMedia => 'Değiştir';

  @override
  String get videoSelected => 'Video seçildi';

  @override
  String get favouritesOnly => 'Favoriler';

  @override
  String get noFavouritesYet => 'Henüz favori yok';

  @override
  String get noFavouritesHint => 'Burada tutmak için egzersizin yıldızına dokun.';

  @override
  String get clearFilters => 'Filtreleri temizle';

  @override
  String get noExercisesFound => 'Egzersiz bulunamadı';

  @override
  String get noExercisesHint => 'Farklı bir arama dene veya filtreleri temizle.';

  @override
  String get personalRecord => 'KİŞİSEL REKOR';

  @override
  String get history => 'GEÇMİŞ';

  @override
  String get noHistory => 'Henüz antrenman kaydı yok. Geçmiş oluşturmak için bu egzersizi yap.';

  @override
  String get notes => 'NOTLAR';

  @override
  String get notePlaceholder => 'İpuçları, kurulum, nasıl hissettirdi…';

  @override
  String notHere(String gear, String place) {
    return '$place konumunda $gear yok';
  }

  @override
  String get notHereWhy => 'Bugün gerçekten kullanabileceğin bir şeyle değiştir.';

  @override
  String get altHere => 'BURADA YAPABİLECEKLERİN';

  @override
  String get places => 'YERLERİM';

  @override
  String get placesHint =>
      'Her yerde hangi ekipmanların bulunduğunu belirt; kütüphanede yalnızca orada yapabileceğin egzersizler gösterilir.';

  @override
  String get placeAll => 'Her yerde';

  @override
  String get placeNew => 'Yeni yer';

  @override
  String get placeNamePlaceholder => 'Ev, spor salonu, park…';

  @override
  String get placeGearLabel => 'MEVCUT EKİPMAN';

  @override
  String placeExercises(int n) {
    return 'Burada $n egzersiz';
  }

  @override
  String get placeEmptyTitle => 'Nerede olursan ol antrenman yap';

  @override
  String get placeEmptyBody =>
      'Bir yer, orada bulunan ekipmanların listesidir. Başlamak için birini seç; daha sonra düzenleyebilirsin.';

  @override
  String get placeDeleteTitle => 'Yeri sil';

  @override
  String get placeDeleteBody => 'Yalnızca yer silinir — egzersizlerin ve antrenmanların kalır.';

  @override
  String get placeGym => 'Spor salonu';

  @override
  String get placeHome => 'Ev';

  @override
  String get placeOutdoors => 'Açık hava';

  @override
  String get placeFilterLabel => 'YER';

  @override
  String get noGearOnly => 'Ekipmansız';

  @override
  String placeActive(String name) {
    return '$name konumunda antrenman';
  }

  @override
  String get journal => 'GÜNLÜK';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n not',
      one: '1 not',
      zero: 'Not yok',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Not';

  @override
  String get noteKindPlan => 'Plan';

  @override
  String get noteKindDone => 'Başarı';

  @override
  String get noteKindPain => 'Rahatsızlık';

  @override
  String get noteFilterAll => 'Tümü';

  @override
  String get newNote => 'Yeni not';

  @override
  String get editNote => 'Notu düzenle';

  @override
  String get addNote => 'NOT EKLE';

  @override
  String get noteEmptyTitle => 'Henüz hiçbir şey yazılmadı';

  @override
  String get noteEmptyBody =>
      'İpuçları, bir sonraki plan, antrenmanın nasıl hissettirdiği — istersen fotoğraf veya video ile.';

  @override
  String get noteNoneForExercise => 'Bu egzersiz için henüz not yok.';

  @override
  String get noteKindLabel => 'TÜR';

  @override
  String get noteTextLabel => 'NOT';

  @override
  String get noteDateLabel => 'TARİH';

  @override
  String get noteExerciseLabel => 'EGZERSİZ';

  @override
  String get noteMediaLabel => 'FOTOĞRAF VE VİDEO';

  @override
  String get noteGeneral => 'Egzersiz yok';

  @override
  String get noteAttach => 'Ekle';

  @override
  String get noteRemoveMedia => 'Eki kaldır';

  @override
  String get deleteNoteTitle => 'Notu sil';

  @override
  String get deleteNoteBody => 'Not ve tüm ekleri kalıcı olarak silinir.';

  @override
  String get noteToday => 'Bugün';

  @override
  String get noteYesterday => 'Dün';

  @override
  String get noteAllNotes => 'Tüm notlar';

  @override
  String get noteCalendar => 'Takvim';

  @override
  String get noteNoneOnDay => 'Bu gün hiçbir şey yazılmadı';

  @override
  String get noteAddOnDay => 'Bu güne not ekle';

  @override
  String get notePrevMonth => 'Önceki ay';

  @override
  String get noteNextMonth => 'Sonraki ay';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Bu ay $n not',
      one: 'Bu ay 1 not',
      zero: 'Bu ay not yok',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'ÖLÇÜLER';

  @override
  String get measuresHint => 'Boyundan baldıra — yalnızca barı değil, vücudundaki değişimi de izle.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ölçüm',
      one: '1 ölçüm',
      zero: 'Ölçüm yok',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Henüz ölçülmedi';

  @override
  String get measureHistory => 'GEÇMİŞ';

  @override
  String get measureNeck => 'Boyun';

  @override
  String get measureShoulders => 'Omuzlar';

  @override
  String get measureChest => 'Göğüs';

  @override
  String get measureArm => 'Kol';

  @override
  String get measureForearm => 'Ön kol';

  @override
  String get measureWaist => 'Bel';

  @override
  String get measureHips => 'Kalça';

  @override
  String get measureThigh => 'Uyluk';

  @override
  String get measureCalf => 'Baldır';

  @override
  String get measureBodyfat => 'Vücut yağı';

  @override
  String get timeline => 'ZAMAN ÇİZELGESİ';

  @override
  String get hidePhotos => 'Fotoğrafları gizle';

  @override
  String get showPhotos => 'Fotoğrafları göster';

  @override
  String get timelineHint => 'Aynı poz, aynı yer, aynı ışık. Bir yıl sonra inanamayacaksın.';

  @override
  String get timelineEmptyTitle => 'İlk fotoğrafın takibi başlatır';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n fotoğraf',
      one: '1 fotoğraf',
      zero: 'Fotoğraf yok',
    );
    return '$_temp0';
  }

  @override
  String get poseFront => 'Ön';

  @override
  String get poseSide => 'Yan';

  @override
  String get poseBack => 'Arka';

  @override
  String get photoEvery => 'HATIRLAT';

  @override
  String photoEveryDays(int n) {
    return 'Her $n günde';
  }

  @override
  String get photoEveryOff => 'Asla';

  @override
  String get timelineEvery => 'ŞU ARALIKLA GRUPLA';

  @override
  String get custom => 'Özel';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Sonraki fotoğraf $n gün sonra',
      one: 'Sonraki fotoğraf yarın',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Fotoğraf zamanı — bugün çek';

  @override
  String get addTodayPhotos => 'BUGÜNÜN FOTOĞRAFLARINI EKLE';

  @override
  String posePhoto(String pose) {
    return '$pose fotoğrafı';
  }

  @override
  String get compare => 'KARŞILAŞTIR';

  @override
  String get compareNeedTwo => 'Aynı pozu iki farklı günde çek, burada karşılaştırabilirsin.';

  @override
  String dayNumber(int n) {
    return 'Gün $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n gün arayla',
      one: '1 gün arayla',
      zero: 'Aynı gün',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Bu günü sil';

  @override
  String get deleteDayBody => 'Bu günün fotoğrafları da kalıcı olarak silinir.';

  @override
  String get timelinePhotos => 'Fotoğraflar';

  @override
  String get timelineBody => 'Kas haritası';

  @override
  String get timelineBodyEmpty =>
      'Bir antrenman kaydet, kas haritan burada dolmaya başlasın — fotoğrafa gerek yok.';

  @override
  String get timelineBodyHint => 'Kendi setlerinden oluşturulur — internete hiçbir şey yüklenmez.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n antrenman',
      one: '1 antrenman',
      zero: 'Antrenman yok',
    );
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'İlerleme fotoğrafları';

  @override
  String get notifPhotoChannelWhy => 'Bir sonraki ilerleme fotoğrafının zamanı geldiğinde hatırlatır.';

  @override
  String get notifPhotoTitle => 'İlerleme fotoğrafı zamanı';

  @override
  String notifPhotoBody(int n) {
    return 'Sonuncudan beri $n gün. Aynı poz, aynı ışık.';
  }

  @override
  String get share => 'PAYLAŞ';

  @override
  String get sharePick => 'Ne göstermek istiyorsun?';

  @override
  String get shareStreak => 'Seri ve istikrar';

  @override
  String get shareBody => 'Çalıştırılan kaslar';

  @override
  String get shareCompare => 'Önce / sonra';

  @override
  String get shareHint =>
      'Kart telefonunda oluşturulur. Nereye göndereceğini seçene kadar hiçbir şey dışarı çıkmaz.';

  @override
  String get shareFailed => 'Kart oluşturulamadı';

  @override
  String get shareWeekOf => 'SON 7 GÜN';

  @override
  String get shareStreakLabel => 'GÜN ÜST ÜSTE';

  @override
  String get shareSessionsLabel => 'ANTRENMANLAR';

  @override
  String get shareVolumeLabel => 'HACİM';

  @override
  String get restForExercise => 'BU EGZERSİZ İÇİN DİNLENME';

  @override
  String get restUsingDefault => 'Varsayılan süre kullanılıyor';

  @override
  String get restCustom => 'Sadece bunun için';

  @override
  String get setType => 'SET TÜRÜ';

  @override
  String get setTypeNormal => 'Çalışma';

  @override
  String get setTypeWarmup => 'Isınma';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'Tükenişe kadar';

  @override
  String get addWarmup => 'ISINMA';

  @override
  String platesPerSide(String plates) {
    return 'Her taraf: $plates';
  }

  @override
  String get howTo => 'NASIL YAPILIR';

  @override
  String get similar => 'BENZER';

  @override
  String get primaryLabel => 'BİRİNCİL';

  @override
  String get secondaryLabel => 'İKİNCİL';

  @override
  String get none => 'Yok';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n set', one: '$n set');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return '$v hacim';
  }

  @override
  String get weeklyPlan => 'HAFTALIK PLAN';

  @override
  String get yourRoutines => 'PROGRAMLARIN';

  @override
  String get noRoutines => 'Henüz program yok. Bir tane oluştur ve egzersizlerini ekle.';

  @override
  String get newRoutine => 'YENİ PROGRAM';

  @override
  String get routineName => 'Program adı';

  @override
  String get schedule => 'TAKVİM';

  @override
  String get addFromList => 'Aşağıdaki listeden egzersiz ekle.';

  @override
  String get addExercises => 'Egzersiz ekle';

  @override
  String get deleteRoutine => 'Bu program silinsin mi?';

  @override
  String exercisesWithCount(int n) {
    return 'EGZERSİZLER · $n';
  }

  @override
  String setDay(String day) {
    return '$day AYARLA';
  }

  @override
  String get newRoutineName => 'Yeni program';

  @override
  String get dragToReorder => 'Sıralamak için noktalı tutamacı sürükle — antrenman sırası budur.';

  @override
  String reorderHandle(String name) {
    return '$name yeniden sırala';
  }

  @override
  String get removeFromRoutine => 'Programdan kaldır';

  @override
  String get dropExercise => 'Bu egzersiz çıkarılsın mı?';

  @override
  String dropExerciseBody(String name) {
    return '“$name” bu antrenmandan çıkarılacak. Kaydedilen hiçbir şey kaybolmaz.';
  }

  @override
  String get drop => 'Çıkar';

  @override
  String get resetData => 'Tüm verilerimi sil';

  @override
  String get resetTitle => 'Her şey silinsin mi?';

  @override
  String get resetBody =>
      'Antrenmanlar, rekorlar, programlar, notlar ve profil silinecek. Bu işlem geri alınamaz — gerekebilecekse önce bir yedek dışa aktar.';

  @override
  String get resetConfirm => 'Her şeyi sil';

  @override
  String get resetDone => 'Tüm veriler silindi';

  @override
  String get support => 'DESTEK';

  @override
  String get reportBug => 'Hata bildir';

  @override
  String get requestFeature => 'Özellik öner';

  @override
  String get starOnGithub => 'GitHub\'da yıldızla';

  @override
  String get buyCoffee => 'Bana kahve ısmarla';

  @override
  String get cantOpenLink => 'Bağlantı açılamadı';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Koyu';

  @override
  String get lightTheme => 'Açık';

  @override
  String get amoledTheme => 'AMOLED siyah';

  @override
  String get editDuration => 'Antrenman süresi';

  @override
  String get sessionName => 'Antrenman adı';

  @override
  String get nameWorkout => 'Ad ver';

  @override
  String get sessionNameHint => 'örn. Bacak, İtiş, Tüm vücut';

  @override
  String get secondaryPickHint => 'Bu hareketin çalıştırdığı diğer kaslara dokun.';

  @override
  String get languageLabel => 'Dil';

  @override
  String get unitsLabel => 'Birimler';

  @override
  String get restTimer => 'Dinlenme zamanlayıcısı';

  @override
  String get alarmBlockedTitle => 'Bildirimler kapalı';

  @override
  String get alarmBlockedBody => 'Ekran kilitliyken dinlenme alarmı çalmaz';

  @override
  String get alarmBlockedAction => 'AÇ';

  @override
  String get alarmSound => 'Alarm sesi';

  @override
  String get alarmDefaultName => 'Varsayılan';

  @override
  String get alarmSoundHint => 'Kendi sesini kullan — en fazla 15 saniye';

  @override
  String get alarmChoose => 'Ses seç…';

  @override
  String get alarmPreview => 'Geçerli sesi çal';

  @override
  String get alarmReset => 'Varsayılana sıfırla';

  @override
  String get alarmTooLong => 'Bu ses 15 saniyeden uzun';

  @override
  String get alarmInvalid => 'Bu ses dosyası okunamadı';

  @override
  String alarmChanged(String name) {
    return 'Alarm sesi “$name” olarak ayarlandı';
  }

  @override
  String get alarmChangedDefault => 'Varsayılan sese dönüldü';

  @override
  String get addActivityWidget => 'Etkinlik widget\'ı ekle';

  @override
  String get addStatsWidget => 'İstatistik widget\'ı ekle';

  @override
  String get pinUnsupported => 'Başlatıcının widget menüsünden ekle';

  @override
  String get background => 'Arka plan';

  @override
  String get bgNone => 'Yok';

  @override
  String get bgDots => 'Noktalar';

  @override
  String get bgGrid => 'Izgara';

  @override
  String get exportCsv => 'Antrenmanları dışa aktar (CSV)';

  @override
  String get exportBackup => 'Yedeği dışa aktar (ZIP)';

  @override
  String get importBackup => 'Yedeği içe aktar';

  @override
  String get importHint =>
      'GymMane\'den dışa aktarılmış bir .zip (veya eski .json) yedeği seç. Medya dâhil mevcut verilerinin üzerine yazılacak.';

  @override
  String get import => 'İçe aktar';

  @override
  String get chooseFile => 'Dosya seç';

  @override
  String get importFromApp => 'Başka bir uygulamadan içe aktar';

  @override
  String get importUnknownFormat => 'Bu dosya tarih, egzersiz, tekrar ve ağırlık sütunlarını içermeli';

  @override
  String get importZipNoWeights => 'Bu zip içinde ağırlık dosyası yok';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n kilo kaydı içe aktarıldı',
      one: '$n kilo kaydı içe aktarıldı',
    );
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'Bu dosya okunamadı';

  @override
  String get importUnitTitle => 'Bu dosya hangi birimi kullanıyor?';

  @override
  String get importUnitBody => 'Bu dışa aktarma ağırlık birimini belirtmiyor.';

  @override
  String get importNothing => 'İçe aktarılacak yeni bir şey yok';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n antrenman içe aktarıldı',
      one: '$n antrenman içe aktarıldı',
    );
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'GymMane hakkında';

  @override
  String get yourProfile => 'PROFİLİN';

  @override
  String get autofills => 'Hesaplayıcılardaki bilgileri otomatik doldurur';

  @override
  String get nameLabel => 'AD';

  @override
  String get sexLabel => 'CİNSİYET';

  @override
  String get macroProtein => 'PROTEİN';

  @override
  String get macroCarbs => 'KARBONHİDRAT';

  @override
  String get macroFat => 'YAĞ';

  @override
  String get male => 'Erkek';

  @override
  String get female => 'Kadın';

  @override
  String get ageLabel => 'YAŞ';

  @override
  String get heightLabel => 'BOY';

  @override
  String get weightLabel => 'KİLO';

  @override
  String get weeklyGoal => 'HAFTALIK HEDEF';

  @override
  String get activityLabel => 'AKTİVİTE';

  @override
  String get addPhoto => 'Fotoğraf ekle';

  @override
  String get removePhoto => 'Fotoğrafı kaldır';

  @override
  String get takePhoto => 'Fotoğraf çek';

  @override
  String get chooseGallery => 'Galeriden seç';

  @override
  String get backupImported => 'Yedek içe aktarıldı';

  @override
  String get backupFailed => 'Bu yedek okunamadı';

  @override
  String get nothingToExport => 'Henüz dışa aktarılacak bir şey yok — önce bir antrenman kaydet';

  @override
  String calculatorsCount(int n) {
    return 'Antrenmanın için $n hesaplayıcı';
  }

  @override
  String get result => 'SONUÇ';

  @override
  String get weightLifted => 'KALDIRILAN AĞIRLIK';

  @override
  String get repsPerformed => 'YAPILAN TEKRAR';

  @override
  String get neck => 'BOYUN';

  @override
  String get waist => 'BEL';

  @override
  String get hip => 'KALÇA (kadınlar)';

  @override
  String get targetWeight => 'HEDEF AĞIRLIK';

  @override
  String get workingWeight => 'ÇALIŞMA AĞIRLIĞI';

  @override
  String get activityLevel => 'AKTİVİTE SEVİYESİ';

  @override
  String get barWeight => 'BAR AĞIRLIĞI';

  @override
  String get perSide => 'HER TARAF';

  @override
  String get justTheBar => 'Sadece bar.';

  @override
  String perSideCount(int n) {
    return 'Her taraf × $n';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'VKİ';

  @override
  String get toolNameCal => 'Kalori';

  @override
  String get toolNameBf => 'Vücut yağı';

  @override
  String get toolNamePlate => 'Plakalar';

  @override
  String get toolNameWarmup => 'Isınma';

  @override
  String get toolTitleRm => '1RM hesaplayıcı';

  @override
  String get toolTitleBmi => 'VKİ hesaplayıcı';

  @override
  String get toolTitleCal => 'Kalori ve makrolar';

  @override
  String get toolTitleBf => 'Vücut yağı %';

  @override
  String get toolTitlePlate => 'Plaka hesaplayıcı';

  @override
  String get toolTitleWarmup => 'Isınma setleri';

  @override
  String get toolHintRm => 'Tahmini 1 tekrar maksimumu (Epley formülü)';

  @override
  String get toolHintCal => 'Tahmini günlük kilo koruma kalorisi';

  @override
  String get toolHintBf => 'ABD Donanması yöntemine göre tahmin';

  @override
  String get toolHintPlate => 'Toplam bar ağırlığı';

  @override
  String get toolHintWarmup => 'Hedef çalışma ağırlığı';

  @override
  String get toolDescRm => 'Tahmini tek tekrar maksimumu';

  @override
  String get toolDescBmi => 'Vücut kitle indeksi';

  @override
  String get toolDescCal => 'Kalori ve makrolar';

  @override
  String get toolDescBf => 'Vücut yağ oranı';

  @override
  String get toolDescPlate => 'Bar plakası hesaplayıcı';

  @override
  String get toolDescWarmup => 'Kademeli ısınma setleri';

  @override
  String get bmiUnderweight => 'Düşük kilo';

  @override
  String get bmiNormal => 'Normal kilo';

  @override
  String get bmiOverweight => 'Fazla kilo';

  @override
  String get bmiObese => 'Obez';

  @override
  String get actSedentary => 'Hareketsiz';

  @override
  String get actLight => 'Hafif';

  @override
  String get actActive => 'Aktif';

  @override
  String get actModerate => 'Orta';

  @override
  String get muscleChest => 'Göğüs';

  @override
  String get muscleBack => 'Sırt';

  @override
  String get muscleLowerBack => 'Bel';

  @override
  String get muscleShoulders => 'Omuzlar';

  @override
  String get muscleBiceps => 'Biseps';

  @override
  String get muscleTriceps => 'Triseps';

  @override
  String get muscleForearm => 'Ön kol';

  @override
  String get muscleTrapezius => 'Trapez';

  @override
  String get muscleAbdomen => 'Karın';

  @override
  String get muscleObliques => 'Yan karın';

  @override
  String get muscleQuads => 'Ön bacak';

  @override
  String get muscleHamstrings => 'Arka bacak';

  @override
  String get muscleGlutes => 'Kalça';

  @override
  String get muscleCalves => 'Baldır';

  @override
  String get mgChest => 'Göğüs';

  @override
  String get mgBack => 'Sırt';

  @override
  String get mgLegs => 'Bacaklar';

  @override
  String get mgShoulders => 'Omuzlar';

  @override
  String get mgArms => 'Kollar';

  @override
  String get mgCore => 'Merkez bölge';

  @override
  String get equipBarbell => 'Bar';

  @override
  String get equipDumbbell => 'Dambıl';

  @override
  String get equipCable => 'Kablo';

  @override
  String get equipMachine => 'Makine';

  @override
  String get equipBodyweight => 'Vücut ağırlığı';

  @override
  String get equipWeighted => 'Ağırlıklı';

  @override
  String get equipBand => 'Direnç bandı';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Halkalar';

  @override
  String get equipOther => 'Diğer';

  @override
  String get diffBeginner => 'Başlangıç';

  @override
  String get diffAdvanced => 'İleri';

  @override
  String get diffIntermediate => 'Orta seviye';

  @override
  String get about => 'HAKKINDA';

  @override
  String version(String v) {
    return 'Sürüm $v';
  }

  @override
  String get aboutBlurb => 'Spor yapanlar tarafından, spor yapanlar için geliştirildi.';

  @override
  String get freeForever => 'Sonsuza kadar ücretsiz';

  @override
  String get freeForeverWhy => 'Abonelik yok, reklam yok, ücret duvarı yok.';

  @override
  String get fullyOffline => '%100 çevrimdışı';

  @override
  String get fullyOfflineWhy => 'Hesap yok, sunucu yok. Antrenman verilerin bu telefondan asla çıkmaz.';

  @override
  String get yoursToTake => 'Verilerin sana ait';

  @override
  String get yoursToTakeWhy => 'İstediğin zaman CSV olarak dışa aktar ve her şeyi tek dokunuşla sil.';

  @override
  String get whatsInside => 'İÇERİK';

  @override
  String exercisesInside(int n) {
    return '$n egzersiz';
  }

  @override
  String get exercisesInsideWhy => 'Her birinde animasyon ve adım adım talimat var.';

  @override
  String get calculatorsInside => '10 hesaplayıcı';

  @override
  String get calculatorsInsideWhy =>
      '1RM, plakalar, VKİ, kalori, vücut yağı, FFMI, ısınma, RPE\'ye göre ağırlık ve DOTS ile Wilks güç puanları — hepsi yayımlanmış formüllere dayanır.';

  @override
  String get mathInside => 'Şeffaf hesaplamalar';

  @override
  String get mathInsideWhy =>
      'Hacim, rekorlar ve seriler kendi setlerinden hesaplanır. Buradaki hiçbir şey göstermelik değil.';

  @override
  String get streakCaps => 'SERİ';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'gün', one: 'gün');
    return '$_temp0';
  }

  @override
  String get reset => 'SIFIRLA';

  @override
  String get welcomeKicker => 'HOŞ GELDİN';

  @override
  String get welcomeBlurb => 'Her şey telefonunda kalır. Hesap yok, internet yok, ödeme yok.';

  @override
  String get welcomeStart => 'BAŞLA';

  @override
  String onbStep(int i, int n) {
    return 'ADIM $i / $n';
  }

  @override
  String get onbNameTitle => 'Sana nasıl hitap edelim?';

  @override
  String get onbNameHint => 'Adın';

  @override
  String get onbPhotoAdd => 'Fotoğraf ekle';

  @override
  String get onbPhotoChange => 'Fotoğrafı değiştir';

  @override
  String get onbPhotoTitle => 'Profiline bir yüz ekle';

  @override
  String get onbPhotoWhy =>
      'İsteğe bağlı. Telefonunda kalır ve profilinden istediğin zaman değiştirebilirsin.';

  @override
  String get onbPhotoLater => 'SONRA';

  @override
  String get onbNameWhy => 'Yalnızca sana hitap etmek için kullanılır. Telefonundan asla çıkmaz.';

  @override
  String get onbBodyTitle => 'Birkaç bilgi';

  @override
  String get onbBodyWhy => 'Hesaplayıcılarda kullanılır. Ayarlar\'dan istediğin zaman değiştirebilirsin.';

  @override
  String get onbGoalTitle => 'Ne sıklıkla antrenman yapıyorsun?';

  @override
  String get onbGoalWhy => 'Haftalık hedef halkasını belirler. İddialı değil, gerçekçi ol.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Haftada $n antrenman',
      one: 'Haftada $n antrenman',
    );
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilo mu pound mu?';

  @override
  String get next => 'İLERİ';

  @override
  String get back => 'GERİ';

  @override
  String get skip2 => 'Atla';

  @override
  String get madeWithLoveBy => 'SEVGİYLE GELİŞTİREN';

  @override
  String get sourceCode => 'KAYNAK KODU';

  @override
  String get suggested => 'ÖNERİLEN';

  @override
  String get results => 'SONUÇLAR';

  @override
  String get noMatches => 'Bu aramayla eşleşen egzersiz yok.';

  @override
  String get tapToEdit => 'Bir kaydı düzeltmek için kaleme, silmek için çöp kutusuna dokun.';

  @override
  String get editEntry => 'Düzenle';

  @override
  String get editEntryHint => 'Herhangi bir setin tekrarını veya ağırlığını düzelt.';

  @override
  String get removeSet => 'Seti sil';

  @override
  String get continueWorkout => 'DEVAM ET';

  @override
  String get continueWorkoutBody =>
      'Antrenman yeniden devam ediyor durumuna alınır ve tamamlanan setler korunur. Tekrar bitirdiğinde ilk tarihine kaydedilir.';

  @override
  String get addBodyWidget => 'Kas haritası widget\'ı ekle';

  @override
  String get repsOnly => 'Sadece tekrar';

  @override
  String get repsOnlyHint => 'Bu egzersizi ağırlıksız kaydet.';

  @override
  String get eachSide => 'Her taraf';

  @override
  String get eachSideHint => 'Süre her taraf için bir kez işler, dinlenme ikisinden sonra başlar.';

  @override
  String get useDefaultArt => 'Varsayılan görsele dön';

  @override
  String daysShort(int n) {
    return '$n g';
  }

  @override
  String get focusCard => 'Bugünün odağı';

  @override
  String get autoAdvance => 'Otomatik sonraki egzersize geç';

  @override
  String get keepScreenOn => 'Antrenman sırasında ekranı açık tut';

  @override
  String get lockWorkout => 'Ekranı kilitle';

  @override
  String get unlockWorkout => 'Kilidi aç';

  @override
  String get holdToUnlock => 'Açmak için basılı tut';

  @override
  String get liveChannel => 'Devam eden antrenman';

  @override
  String get liveChannelWhy => 'Antrenman sırasında mevcut egzersizi, seti ve dinlenme sayacını gösterir';

  @override
  String liveSet(int n, int total) {
    return 'Set $n / $total';
  }

  @override
  String get liveResting => 'Dinlenme';

  @override
  String get liveAllDone => 'Tüm setler bitti';

  @override
  String get autoAdvanceHint =>
      'Bir egzersizin son seti işaretlendiğinde antrenman otomatik olarak sonrakine geçer.';

  @override
  String get placePlates => 'Plakalar ve bar';

  @override
  String get platesAll => 'Hepsi mevcut';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n plaka ağırlığı',
      one: '$n plaka ağırlığı',
    );
    return '$_temp0';
  }

  @override
  String get platePairs => 'ÇİFTLER';

  @override
  String plateAchievable(String w) {
    return 'Yükleyebileceğin en yakın ağırlık: $w';
  }

  @override
  String get autoWarmup => 'Isınma setleriyle başla';

  @override
  String get autoWarmupHint => 'Antrenman açıldığında kademeli ısınma setleri ekler.';

  @override
  String get trainReminder => 'Antrenman hatırlatıcısı';

  @override
  String get trainReminderHint => 'Yalnızca programının olduğu günlerde bu saatte hatırlatır.';

  @override
  String get reminderExactTime => 'Tam saat';

  @override
  String get toastSoundSetting => 'Bildirim sesi';

  @override
  String get toastSoundHint => 'Üstte bir bildirim çıktığında hafif bir ses.';

  @override
  String get notifTrainChannel => 'Antrenman hatırlatıcısı';

  @override
  String get notifTrainChannelWhy => 'Planladığın günlerde antrenman yapman için hatırlatma.';

  @override
  String get notifTrainTitle => 'Antrenman zamanı';

  @override
  String get notifTrainBody => 'Programın seni bekliyor.';

  @override
  String get planIntro =>
      'Yalnızca bu listedeki egzersizleri kullanarak bana bir antrenman programı oluştur.';

  @override
  String get planFormat => 'Yalnızca şu biçimde JSON olarak yanıt ver:';

  @override
  String get planNothing => 'Bu dosyadaki hiçbir egzersiz kütüphanenle eşleşmedi';

  @override
  String get planFailed => 'Bu dosya GymMane\'in okuyabileceği bir program içermiyor';

  @override
  String get routineGroup => 'Grup';

  @override
  String get newGroup => 'Yeni grup';

  @override
  String get noGroup => 'Grup yok';

  @override
  String get groupNameHint => 'İtiş / Çekiş / Bacak, 5×5…';

  @override
  String get filters => 'Filtreler';

  @override
  String get setsPlannedHint =>
      'Her egzersiz için istediğin set sayısını seç. Antrenman, setler hazır biçimde açılır.';

  @override
  String get nextTime => 'BİR DAHAKİ SEFER';

  @override
  String get nextHold => 'tüm tekrarları tamamlayana kadar aynı ağırlığı koru';

  @override
  String get bgPhoto => 'Fotoğrafın';

  @override
  String get bgPhotoPick => 'Fotoğraf seç';

  @override
  String get bgPhotoChange => 'Fotoğrafı değiştir';

  @override
  String get bgPhotoRemove => 'Fotoğrafı kaldır';

  @override
  String get bgDim => 'KARARTMA';

  @override
  String get dimSoft => 'Hafif';

  @override
  String get dimMedium => 'Orta';

  @override
  String get dimStrong => 'Güçlü';

  @override
  String get bgPhotoHint =>
      'Tüm arayüzün arkasında, uygulama okunabilir kalsın diye karartılmış olarak görünür.';

  @override
  String get reminderSmart => 'Akıllı';

  @override
  String get reminderFixed => 'Sabit saat';

  @override
  String get reminderSmartHint =>
      'Gerçekte antrenman yaptığın gün ve saatleri kullanır; o gün zaten antrenman yaptıysan sessiz kalır.';

  @override
  String get reminderSmartEmpty => 'Alışkanlıklarını öğrenmesi için birkaç antrenman daha kaydet.';

  @override
  String habitFocus(String day) {
    return '$day günü genellikle çalıştırdığın kaslar';
  }

  @override
  String get duplicateRoutine => 'Programı çoğalt';

  @override
  String copySuffix(String name) {
    return '$name (kopya)';
  }

  @override
  String get saveAsRoutine => 'PROGRAM OLARAK KAYDET';

  @override
  String get savedAsRoutine => 'Program olarak kaydedildi';

  @override
  String get templates => 'Hazır programlar';

  @override
  String get templatesHint =>
      'Kendi kütüphanendeki egzersizlerle oluşturulan klasik programlar. Daha sonra her şeyi değiştirebilirsin.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n program eklendi',
      one: '$n program eklendi',
    );
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Haftada üç tam vücut antrenmanı. Başlangıç için ideal.';

  @override
  String get tplPpl => 'İtiş, çekiş ve bacak. Haftada üç veya altı gün.';

  @override
  String get tplUpperlower => 'Üst ve alt vücut, haftada dört gün.';

  @override
  String get tplStronglifts => 'Dönüşümlü iki antrenman; beş tekrardan beş set.';

  @override
  String get tplStartingstrength => 'Her antrenmanda squat yapılan, dönüşümlü iki antrenman.';

  @override
  String get tplHome => 'Barfiks demiri ve zemin dışında hiçbir şey yok.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gün', one: '$n gün');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Eforu kaydet (RPE)';

  @override
  String get rpeHint => '10 = artık tekrar yok; 8 = yaklaşık iki tekrar yedekte.';

  @override
  String get superset => 'Süperset';

  @override
  String get supersetLink => 'Sonrakiyle eşleştir';

  @override
  String get supersetHint => 'Bağlı egzersizler arasında dinlenme yok — doğrudan sonrakine geçersin.';

  @override
  String get aiRoutine => 'Yapay zekâ ile program';

  @override
  String get aiIntro =>
      'GymMane hiçbir zaman doğrudan bir yapay zekâyla iletişim kurmaz. Egzersiz listesini dışa aktarır, kullandığın asistana yapıştırır ve yanıtını yeniden içe aktarırsın. Hiçbir şey kendiliğinden telefondan çıkmaz.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ad kütüphanende yoktu',
      one: '1 ad kütüphanende yoktu',
    );
    return '$_temp0';
  }

  @override
  String get importApps => 'Desteklenen uygulamalar';

  @override
  String get importOtherCsv => 'Tarih, egzersiz, tekrar ve ağırlık içeren başka herhangi bir CSV';

  @override
  String get importAskApp => 'Başka bir uygulamaya mı ihtiyacın var? Eklenmesini iste';

  @override
  String get awardFirstStepName => 'İlk adım';

  @override
  String get awardFirstStepLine => 'GymMane\'e hoş geldin. Bu bizden.';

  @override
  String get awardFirstWorkoutName => 'İlk antrenman';

  @override
  String get awardFirstWorkoutLine => 'İlki kaydedildi. En zoru buydu.';

  @override
  String get awardFirstRoutineName => 'İlk program';

  @override
  String get awardFirstRoutineLine => 'Artık geri dönebileceğin bir planın var.';

  @override
  String get awardFirstRecordName => 'İlk rekor';

  @override
  String get awardFirstRecordLine => 'Bir egzersizde en iyi sonucunu geçtin.';

  @override
  String get awardStreak3Name => 'Üç üst üste';

  @override
  String get awardStreak3Line => 'Üç gün üst üste. İşte böyle başlar.';

  @override
  String get awardTonne1Name => 'Bir ton';

  @override
  String get awardTonne1Line => 'Setlerinde toplam bin kilo kaldırdın.';

  @override
  String get awardSets100Name => 'Yüz set';

  @override
  String get awardSets100Line => 'Yüz set tamamlandı, teker teker.';

  @override
  String get awardHours10Name => 'On saat';

  @override
  String get awardHours10Line => 'Toplam on saat antrenman.';

  @override
  String get awardWorkouts50Name => 'Elli antrenman';

  @override
  String get awardWorkouts50Line => 'Elli antrenman geride kaldı.';

  @override
  String get awardHours50Name => 'Elli saat';

  @override
  String get awardHours50Line => 'Elli saat antrenman yaptın.';

  @override
  String get awardsTitle => 'Madalyalar';

  @override
  String get yearTitle => 'Yılın';

  @override
  String get yearBestMonth => 'En iyi ay';

  @override
  String get yearMonths => 'ay';

  @override
  String get awardSpinHint => 'Madalyayı döndürmek için kaydır';

  @override
  String get awardUnlocked => 'Yeni başarı açıldı';

  @override
  String get awardNice => 'Harika!';

  @override
  String get awardSaveImage => 'Görseli kaydet';

  @override
  String get awardSaved => 'Galeriye kaydedildi';

  @override
  String get awardStreak7Name => 'Yedi gün';

  @override
  String get awardStreak7Line => 'Bir gün bile kaçırmadan tam bir hafta.';

  @override
  String get awardStreak30Name => 'Otuz gün';

  @override
  String get awardStreak30Line => 'Bir ay üst üste. Artık bir alışkanlık.';

  @override
  String get awardWorkouts100Name => 'Yüz antrenman';

  @override
  String get awardWorkouts100Line => 'Baştan sona yüz antrenman kaydedildi.';

  @override
  String get awardTonnes100Name => 'Yüz ton';

  @override
  String get awardTonnes100Line => 'Kaldırdığın her şey toplam 100.000 kg\'a ulaştı.';

  @override
  String get awardSets1000Name => 'Bin set';

  @override
  String get awardSets1000Line => 'Her seferinde bir set; toplamda bin set.';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Profili düzenle';

  @override
  String get pickBadge => 'Rozet';

  @override
  String get statWorkouts => 'Antrenmanlar';

  @override
  String get statTrained => 'Antrenman süresi';

  @override
  String get statSets => 'Setler';

  @override
  String get statLifted => 'Kaldırıldı';

  @override
  String get statStreak => 'Seri';

  @override
  String get statDays => 'gün';

  @override
  String get unitHours => 'sa';

  @override
  String get unitDays => 'gün';

  @override
  String get snapshots => 'Fotoğraflar';

  @override
  String get snapNow => 'Şimdi çek';

  @override
  String get addCover => 'Kapak ekle';

  @override
  String get addTodayWidget => 'Bugünkü antrenman durumu';

  @override
  String get photosCard => 'Fotoğrafların';

  @override
  String get handleLabel => 'Kullanıcı adı';

  @override
  String get setupTitle => 'Bu bilgileri doldur, sayfanın geri kalanı otomatik dolsun';

  @override
  String get setupHint => 'Buradaki her sayı kaydettiklerinden gelir. Hiçbir şey hiçbir yere gönderilmez.';

  @override
  String get setupWorkout => 'İlk antrenmanını kaydet';

  @override
  String get setupWeight => 'Vücut ağırlığını kaydet';

  @override
  String get setupMeasures => 'Vücut ölçülerini al';

  @override
  String get setupPhoto => 'İlk ilerleme fotoğrafını çek';

  @override
  String get progressTitle => 'İlerleme';

  @override
  String get tileVolume30 => 'Hacim · 30 g';

  @override
  String get tileAddWeight => 'Kilonu ekle';

  @override
  String get heatToneTitle => 'Isı haritası rengi';

  @override
  String get heatToneHint => 'Yalnızca ızgaranın ve vücudun rengini değiştirir.';

  @override
  String get thisWeekTitle => 'Bu hafta';

  @override
  String get momentsEmptyTitle => 'Burada henüz bir şey yok';

  @override
  String get deletePhotoTitle => 'Bu fotoğraf silinsin mi?';

  @override
  String get deletePhotoBody => 'Kalıcı olarak silinecek.';

  @override
  String get awardsEarned => 'Kazanılan';

  @override
  String get awardsLocked => 'Kilitli';

  @override
  String get awardStreak100Name => 'Yüz gün';

  @override
  String get awardWorkouts10Name => 'On antrenman';

  @override
  String get awardWorkouts10Line => 'Farkı yaratan ilk on tanedir.';

  @override
  String get awardWorkouts365Name => 'Üç yüz altmış beş';

  @override
  String get awardWorkouts365Line => 'Bir yılın her günü için bir antrenman, teker teker kaydedildi.';

  @override
  String get awardTonnes10Name => 'On ton';

  @override
  String get awardTonnes10Line => 'On bin kilo ellerinden geçti.';

  @override
  String get awardHours100Name => 'Yüz saat';

  @override
  String get awardHours100Line => 'Barın altında, kronometre çalışırken yüz saat.';

  @override
  String awardWonOn(String date) {
    return '$date tarihinde kazanıldı';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Altın',
      'blue': 'Mavi',
      'green': 'Yeşil',
      'other': 'Rozet',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return '$date tarihinden beri';
  }

  @override
  String levelShort(int n) {
    return 'Seviye $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Seviye $next için $n antrenman',
      one: 'Seviye $next için 1 antrenman',
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
      'ember': 'Kor',
      'green': 'Yeşil',
      'blue': 'Mavi',
      'mono': 'Gri',
      'other': 'Renk',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n set';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return 'Bu hafta $n / $goal';
  }

  @override
  String momentCount(int n) {
    return '$n fotoğraf';
  }

  @override
  String photosSelected(int n) {
    return '$n seçildi';
  }

  @override
  String deletePhotosTitle(int n) {
    return '$n fotoğraf silinsin mi?';
  }

  @override
  String get momentsEmptyHint =>
      'Spor salonunun, tahtanın, yüklü bir barın fotoğrafını çek — hatırlamak istediğin her şey olabilir. Telefonda kalır ve yalnızca sen görürsün.';

  @override
  String get awardStreak100Line => 'Yüz gün üst üste. Bu artık motivasyon değil, alışkanlık.';

  @override
  String get coverLabel => 'KAPAK';

  @override
  String get removeCover => 'Kapağı kaldır';

  @override
  String get startTitle => 'Antrenmana başla';

  @override
  String get logTitle => 'Antrenmanı kaydet';

  @override
  String get logHint => 'Zamanlayıcı olmadan — sadece ne yaptığını gir.';

  @override
  String get orStartFrom => 'Veya şununla başla';

  @override
  String get pickExercisesOption => 'Egzersiz seç';

  @override
  String get chooseFocusOption => 'Odak seç';

  @override
  String get plannedRoutine => 'PLANLI';

  @override
  String get logWorkoutAction => 'ANTRENMANI KAYDET';

  @override
  String get logging => 'KAYIT';

  @override
  String get placesLabel => 'Yerlerim';

  @override
  String get undo => 'Geri al';

  @override
  String get deleteSet => 'Seti sil';

  @override
  String get setDeleted => 'Set silindi';

  @override
  String get removeWarmup => 'Isınmayı kaldır';

  @override
  String get addWeightAction => 'Ağırlık ekle';

  @override
  String get workoutOverview => 'Bu antrenman';

  @override
  String get allExercisesShort => 'Tümü';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total set';
  }

  @override
  String get nowLabel => 'Şimdi';

  @override
  String get deleteWorkout => 'Antrenmanı sil';

  @override
  String get deleteWorkoutBody => 'Bu antrenman ve tüm setleri geçmişinden silinecek.';

  @override
  String get themeAuto => 'Otomatik';

  @override
  String get themeAutoHint => 'Telefonu takip eder';

  @override
  String get demoSizeTitle => 'Antrenmanda egzersiz demosu';

  @override
  String get demoLarge => 'Büyük';

  @override
  String get demoSmall => 'Küçük';

  @override
  String get demoOff => 'Gizli';

  @override
  String get demoLoopTitle => 'Demo animasyonu';

  @override
  String get demoLoopAlways => 'Döngü';

  @override
  String get demoLoopShort => '10 saniye';

  @override
  String get demoLoopHint =>
      'Yaklaşık 10 saniye oynar ve başlangıç duruşunda durur. Tekrar izlemek için demoya dokun.';

  @override
  String get alarmStyleTitle => 'Dinlenme bitince';

  @override
  String get alarmStyleLoud => 'Her zaman çal';

  @override
  String get alarmStyleQuiet => 'Sessiz modu izle';

  @override
  String get alarmStyleVibrate => 'Sadece titret';

  @override
  String get alarmStyleHint =>
      '\"Her zaman çal\" sessizde bile alarm sesini kullanır. \"Sessiz modu izle\" bildirim sesini kullanır ve telefon sessizdeyken sadece titrer.';

  @override
  String get suggestedPicks => 'Senin için önerilenler';

  @override
  String get moreOptions => 'Daha fazla seçenek';

  @override
  String get suggestInWorkouts => 'Hızlı antrenmanlarda öner';

  @override
  String get suggestInWorkoutsHint => 'Kapalıyken önerilerde çıkmaz. Yine de elle ekleyebilirsin.';

  @override
  String get onbPlaceTitle => 'Nerede antrenman yapıyorsun?';

  @override
  String get onbPlaceWhy => 'Antrenman yaptığın tüm yerleri seç. Her birinde yapabileceklerini önereceğiz.';

  @override
  String get onbPlaceGear => 'Orada neyin var?';

  @override
  String distanceCol(String unit) {
    return 'MESAFE ($unit)';
  }

  @override
  String get timeCol => 'SÜRE';

  @override
  String get timePerSideCol => 'SÜRE / TARAF';

  @override
  String get timeMinutesTitle => 'Süre (dakika)';

  @override
  String get timeSecondsTitle => 'Süre (saniye)';

  @override
  String distanceTitle(String unit) {
    return 'Mesafe ($unit)';
  }

  @override
  String get holdLabel => 'Tut';

  @override
  String get stopLabel => 'Durdur';

  @override
  String startHold(String time) {
    return 'Başla · $time';
  }

  @override
  String get exerciseTypeLabel => 'Kayıt türü';

  @override
  String get typeReps => 'Tekrar ve ağırlık';

  @override
  String get typeTime => 'Süre';

  @override
  String get typeCardio => 'Mesafe ve süre';

  @override
  String get exerciseTypeHint =>
      'Koşu veya yüzme gibi kardiyo mesafe ve süre kaydeder. Plank gibi duruşlar süre kaydeder.';

  @override
  String get howToLabel => 'Nasıl yapılır (isteğe bağlı)';

  @override
  String get howToHint => 'Her satıra bir adım';

  @override
  String get editExercise => 'Egzersizi düzenle';

  @override
  String get saveChanges => 'Değişiklikleri kaydet';

  @override
  String get noStepsYet => 'Henüz adım yok. Nasıl yaptığını hatırlamak için kendi adımlarını yaz.';

  @override
  String get addSteps => 'Adımları yaz';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Normal bir set. Hacmine ve rekorlarına sayılır.';

  @override
  String get setTypeWarmupInfo => 'Isınmak için hafif setler. Hacme ve rekorlara sayılmaz.';

  @override
  String get setTypeDropInfo => 'Setin hemen ardından ağırlığı düşür ve dinlenmeden devam et.';

  @override
  String get setTypeFailureInfo =>
      'Temiz bir tekrar daha yapamayana kadar devam et. Gerçekten yaptığın tekrarları kaydet.';

  @override
  String get setTypeRestPauseInfo => 'Setten sonra 10-20 saniye dinlen, sonra birkaç tekrar daha çıkar.';

  @override
  String get planFormatNotes =>
      'Egzersiz adlarını tam listede göründüğü gibi kullan. \"sets\", \"reps\", \"weight\" (belirtilen birimde), saniye cinsinden \"rest\" ve \"days\" isteğe bağlıdır. \"superset\": true bir egzersizi sonrakine bağlar. Birkaç hafta için programları ikinci örnekteki gibi \"weeks\" içinde grupla.';

  @override
  String get planSets => 'Setleri planla';

  @override
  String get planSetsHint =>
      'Her setin türünü, tekrarını ve ağırlığını seç. Son antrenmanından başlamak için ağırlığı Otomatik bırak.';

  @override
  String get planHintReps => 'Her setin türünü ve tekrarını seç. Otomatik, son seansından başlar.';

  @override
  String get planHintTime => 'Her setin türünü ve süresini seç. Otomatik, son seansından başlar.';

  @override
  String get planHintTimeWeight =>
      'Her setin türünü, süresini ve ağırlığını seç. Otomatik, son seansından başlar.';

  @override
  String get planHintCardio => 'Her setin mesafesini ve süresini seç. Otomatik, son seansından başlar.';

  @override
  String get timeOnly => 'Yalnızca süre';

  @override
  String get autoValue => 'Otomatik';

  @override
  String get clearPlan => 'Planı temizle';

  @override
  String get shareRoutine => 'Programı paylaş';

  @override
  String get shareWeek => 'Haftamı paylaş';

  @override
  String get shareWeekHint => 'Tüm programların ve her birinin planlandığı gün.';

  @override
  String shareMessage(String name) {
    return '$name — eklemek için dosyayı GymMane ile aç.';
  }

  @override
  String get importRoutines => 'Programları içe aktar';

  @override
  String get importPasteHint =>
      'Buraya bir program yapıştır: GymMane\'den paylaşılan bir program, yapay zekâ yanıtı, JSON veya CSV olabilir.';

  @override
  String get pasteAction => 'Yapıştır';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n program', one: '1 program');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Haftalık planını da kullan';

  @override
  String get useTheirScheduleHint => 'Getirdiği günler, o günlerde planladıklarının yerine geçer.';

  @override
  String get addToMyRoutines => 'Programlarıma ekle';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n program eklendi',
      one: '1 program eklendi',
    );
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Burada GymMane\'in içe aktarabileceği bir şey yok';

  @override
  String get aiStepCopy => 'İsteği kopyala. Egzersiz listeni ve GymMane\'in okuduğu biçimi içerir.';

  @override
  String get aiStepAsk =>
      'Herhangi bir yapay zekâya yapıştır ve ne istediğini söyle: haftada kaç gün, hedef, kaç hafta.';

  @override
  String get aiStepPaste => 'Yanıtını aşağıya yapıştır ve içe aktar. Dosya gerekmez.';

  @override
  String get copyForAi => 'Yapay zekâ için kopyala';

  @override
  String get copiedDone => 'Kopyalandı';

  @override
  String get aiPasteHint => 'Yapay zekânın yanıtını buraya yapıştır';

  @override
  String get importAction => 'İçe aktar';

  @override
  String get showFormat => 'Biçimi gör';

  @override
  String get shareAsFile => 'Dosya olarak paylaş';

  @override
  String get recoveryTab => 'Toparlanma';

  @override
  String recoveryOverall(int pct) {
    return 'Vücut %$pct toparlandı';
  }

  @override
  String get recoveryAllFresh => 'Her şey toparlandı. Her şeyi çalışmak için iyi bir gün.';

  @override
  String recoveryStill(String muscles) {
    return 'Hâlâ toparlanıyor: $muscles';
  }

  @override
  String get recoveryTired => 'Yorgun';

  @override
  String get recoveryFresh => 'Dinç';

  @override
  String get recoveryHint =>
      'Ne kadar toparlandığını görmek için bir kasa dokun. Yakın zamanda yapılan setler daha çok, daha zor olanlar (RPE\'ye göre) daha da fazla hesaba katılır.';

  @override
  String recoveryPct(int pct) {
    return '%$pct toparlandı';
  }

  @override
  String readyInHours(int h) {
    return '~$h sa içinde hazır';
  }

  @override
  String get tplAbcd => 'Dört gün: göğüs ve arka kol, sırt ve ön kol, bacak, omuz ve karın.';

  @override
  String get tplAbcde => 'Beş gün, her gün bir kas grubu: göğüs, sırt, bacak, omuz, kol.';

  @override
  String get elapsedCaps => 'GEÇEN SÜRE';

  @override
  String get tapToChange => 'Değiştirmek için dokun';

  @override
  String get swipeToSkipHint => 'Dinlenmeyi geçmek için zamanlayıcıyı yana kaydır.';

  @override
  String get screenLocked => 'Ekran kilitli';

  @override
  String get lockedHint => 'Kilidi açmak için üstteki parmak izine basılı tut';

  @override
  String get liveDoneSet => 'Set tamam';

  @override
  String get liveSkipRest => 'Dinlenmeyi geç';

  @override
  String get livePause => 'Duraklat';

  @override
  String get liveResume => 'Devam et';

  @override
  String get liveNext => 'Sonraki';

  @override
  String liveUpNext(String name) {
    return 'Sırada: $name';
  }

  @override
  String get stickerOpen => 'Bir fotoğrafta paylaş';

  @override
  String get stickerNoPhoto => 'Fotoğrafsız';

  @override
  String get stickerWorkout => 'Antrenman';

  @override
  String get stickerStreak => 'Seri';

  @override
  String get stickerDate => 'Tarih';

  @override
  String get stickerHint =>
      'Taşımak için sürükle, boyutunu değiştirmek veya döndürmek için iki parmakla sıkıştır';

  @override
  String get stickerSaved => 'Galeriye kaydedildi';

  @override
  String get stickerWeek => 'Bu hafta';

  @override
  String get getReady => 'Hazırlan';

  @override
  String sideOfTwo(String n) {
    return 'Taraf $n/2';
  }

  @override
  String get switchSides => 'Taraf değiştir';

  @override
  String get stickerGallery => 'Galeri';

  @override
  String get stickerCamera => 'Kamera';

  @override
  String get shareIntroTitle => 'Bu programı paylaş';

  @override
  String get shareIntroBody =>
      'Partnerine, bir arkadaşına ya da ailene gönder. GymMane ile açılan küçük dosyayı, setleri ve ağırlıklarıyla birlikte tek dokunuşla ekleyebilirler.';

  @override
  String get removedFromRoutine => 'Programdan çıkarıldı';

  @override
  String get radarTitle => 'Son 30 gün';

  @override
  String get radarHint => 'Hangi bölgelerin daha fazla çalışmaya ihtiyacı olduğunu gör';

  @override
  String get radarEmpty => 'Dengeni görmek için birkaç gün çalış';

  @override
  String get radarBalanced => 'Şimdilik dengeli';

  @override
  String radarFocus(String list) {
    return 'Daha fazlası gerek: $list';
  }

  @override
  String get countdownReady => 'Hazırlan';

  @override
  String get countdownSkip => 'Hemen başlamak için dokun';

  @override
  String get countdownSetting => 'Başlamadan önce geri sayım';

  @override
  String get effortSetting => 'Eforu kaydet';

  @override
  String get effortHint =>
      'RPE: 10 bir tekrar daha yapamamak, 8 iki tekrar daha yapabilmek demek. RIR kalan tekrarları sayar. Sette varsa tahmini 1RM, RPE tablosunu kullanır.';

  @override
  String get rirHint => '0 bir tekrar daha yapamamak, 2 iki tekrar daha yapabilmek demek.';

  @override
  String get addWeekWidget => 'Hafta widget\'ı ekle';

  @override
  String get gamificationSetting => 'Madalyalar ve seviyeler';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n tekrar', one: '$n tekrar');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'En iyi set';

  @override
  String get weekStartSetting => 'Hafta başlangıcı';

  @override
  String get stepOutOfWorkout => 'Duraklat ve çık';

  @override
  String get saveToRoutine => 'DEĞİŞİKLİKLERİ PROGRAMA KAYDET';

  @override
  String get routineUpdated => 'Program güncellendi';

  @override
  String saveChangesTitle(String name) {
    return 'Değişiklikler $name programına kaydedilsin mi?';
  }

  @override
  String get saveChangesBody => 'Bir dahaki sefere başlattığında program bu değişiklikleri içerecek.';

  @override
  String get routineOrderChanged => 'Yeni egzersiz sırası';

  @override
  String get mineOnly => 'Senin oluşturdukların';

  @override
  String createNamed(String name) {
    return 'Yok mu? “$name” oluştur';
  }

  @override
  String get orStartWith => 'Ya da şununla başla';

  @override
  String get warmupFocus => 'Isınma';

  @override
  String get warmupFocusHint => 'Ekipmanlı ya da ekipmansız mobilite ve aktivasyon';

  @override
  String get cardioFocus => 'Kardiyo';

  @override
  String get cardioFocusHint => 'Koşu, bisiklet, kürek ya da ip, mesafe ve süreyle';

  @override
  String get homeRecommended => 'Ana ekranda öneriler';

  @override
  String get homeRoutines => 'Ana ekranda programlar';

  @override
  String get homeRoutinesHint => 'Programların, en son yaptığın önce. Başlatmak için birine dokun.';

  @override
  String get homeWeekStats => 'Ana ekranda bu hafta';

  @override
  String get homeWeekStatsHint => 'Haftanın hacmi, setleri ve rekorları.';

  @override
  String get stepsSetting => 'Health Connect adımları';

  @override
  String get stepsSettingHint => 'Bugünkü adımları Ana sayfada gösterir. Hiçbir şey telefondan çıkmaz.';

  @override
  String get stepsToday => 'Bugünkü adımlar';

  @override
  String stepsOfGoal(String goal) {
    return '/ $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return 'Bugün $count adım';
  }

  @override
  String get stepsGoal => 'Günlük adım hedefi';

  @override
  String get stepsNoAccess => 'Adımlarına erişim yok';

  @override
  String get stepsGrant => 'Health Connect\'te izin vermek için dokun';

  @override
  String get stepsInfoRead =>
      'Yalnızca adım sayını okur. Başka hiçbir şey okumaz ve Health Connect\'e yazmaz.';

  @override
  String get stepsInfoLocal => 'Adımların telefonunda kalır. GymMane asla internete bağlanmaz.';

  @override
  String get stepsInfoOff => 'İstediğin zaman Ayarlar\'dan veya Health Connect\'ten kapatabilirsin.';

  @override
  String get stepsManage => 'İzni yönet';

  @override
  String get routineDoneToday => 'Bugünlük bitti · harika iş';

  @override
  String get trainAgain => 'Tekrar antrenman yap';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n gün önce',
      one: 'Dün yapıldı',
      zero: 'Bugün yapıldı',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Arşivlenenler';

  @override
  String get archiveExercise => 'Egzersizi arşivle';

  @override
  String get restoreExercise => 'Geri al';

  @override
  String get archivedToast => 'Egzersiz arşivlendi';

  @override
  String get archivedToastHint => 'Egzersizler › Arşivlenenler altında';

  @override
  String get archivedBanner => 'Arşivlendi. Listelerde ve önerilerde çıkmaz; geçmişin korunur.';

  @override
  String get videoMarksHint => 'Bir adımda duraklat ve bir dahaki sefere oraya atlamak için raptiyeye dokun.';

  @override
  String get videoMarkHere => 'Bu adımı burada işaretle';

  @override
  String get sectionGeneral => 'Genel';

  @override
  String get sectionTraining => 'Antrenman';

  @override
  String get sectionAlerts => 'Hatırlatıcılar ve alarm';

  @override
  String get sectionHome => 'Ana sayfa';

  @override
  String get sectionWidgets => 'Widget’lar';

  @override
  String get sectionData => 'Veriler ve yedek';

  @override
  String get multiPlanSetting => 'Günde birden fazla program';

  @override
  String get multiPlanHint => 'Bu günün her programına dokun. Eklediğin sırayla gelirler.';

  @override
  String routineOfDay(int n, int total) {
    return 'Bugün $n/$total';
  }

  @override
  String get nextToday => 'Bugün sıradaki';

  @override
  String get planAboutMe => 'Hakkımda:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age yaşında, boy $height, kilo $weight.';
  }

  @override
  String planDays(int n) {
    return 'Haftada $n gün antrenman yapmak istiyorum.';
  }

  @override
  String get planNoHistory =>
      'Henüz kayıtlı antrenmanım yok: beni yeni başlayan olarak düşün, hacim ve ağırlıklarda temkinli ol.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Son 30 günde $n antrenman.',
      one: 'Son 30 günde 1 antrenman.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Son en iyi setler';

  @override
  String get planAskFirst =>
      'Hedefimi (güç, kas, yağ yakımı ya da genel form) veya bir seansın ne kadar sürebileceğini bilmiyorsan önce bana kısa bir mesajla sor. Sonra yalnızca JSON ile cevap ver.';

  @override
  String get backToTop => 'Başa dön';

  @override
  String get deleteExerciseTitle => 'Bu egzersiz silinsin mi?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" kütüphanenden ve programlarından kaldırılacak. Önceki setlerin korunur.';
  }

  @override
  String get exportForStravaHint =>
      'Tarayıcıdan strava.com/upload/select adresine yükle (Strava uygulaması dosya içe aktaramaz). Setlerinle birlikte ağırlık antrenmanı olarak görünür.';

  @override
  String get manualStartTime => 'Başlangıç saati';

  @override
  String get manualDuration => 'Süre';

  @override
  String get manualDurationUnset => 'Süre ekle';

  @override
  String get stravaRow => 'Strava’ya aktar (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Strava’ya götürmek için bir antrenman seç. Bir .fit dosyası alırsın: tarayıcıdan strava.com/upload/select adresine yükle, setlerinle birlikte ağırlık antrenmanı olarak görünür.';

  @override
  String get stravaEmpty => 'Henüz dışa aktarılacak antrenman yok.';

  @override
  String get tapToPause => 'Duraklatmak için dokun';

  @override
  String get holdPausedHint => 'Duraklatıldı · devam için dokun';

  @override
  String get finishHoldNow => 'Seti şimdi bitir';

  @override
  String get barWeightExercise => 'Bar ya da kızak ağırlığı';

  @override
  String get barWeightHint => 'Plaka hesaplayıcı bunu kullanır';

  @override
  String get barWeightCustom => 'Kendi değerin · sıfırlamak için dokun';

  @override
  String get groupRename => 'Grubu yeniden adlandır';

  @override
  String get groupUngroup => 'Grubu kaldır, rutinleri koru';

  @override
  String get groupDeleteAll => 'Grubu ve rutinleri sil';

  @override
  String groupDeleteTitle(String name) {
    return '“$name” silinsin mi?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count silinecek. Antrenman geçmişin korunur.';
  }

  @override
  String get tplRr =>
      'r/bodyweightfitness klasiği: haftada üç gün tüm vücut. Kolaylaşınca bir sonraki aşamaya geç.';

  @override
  String get levelUpKicker => 'SONRAKİ ADIM';

  @override
  String levelUpBody(int reps, String name) {
    return '$name hareketinde üst üste iki antrenmanda 3×$reps. Sonraki adıma hazır mısın?';
  }

  @override
  String levelUpSwap(String routine) {
    return '$routine içinde değiştir';
  }

  @override
  String get levelUpSee => 'Nasıl yapıldığını gör';

  @override
  String get levelUpLater => 'Şimdi değil';

  @override
  String get levelUpStay => 'Bununla devam';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name artık $routine içinde';
  }

  @override
  String get levelUpStayed => 'Bu hareket için artık seviye önerisi yok';

  @override
  String get levelHintsSetting => 'Sonraki adımı öner';

  @override
  String get heatmapLabelsSetting => 'Aktivite haritasında gün ve aylar';

  @override
  String get rmPercent => 'YÜZDE';

  @override
  String rmAtPercent(String pct) {
    return 'Maksimumunun $pct kadarı';
  }

  @override
  String get copyWorkout => 'Metin olarak kopyala';

  @override
  String get goalSet => 'Hedef belirle';

  @override
  String get goalTargetReps => 'HEDEF TEKRAR';

  @override
  String goalToGo(String value) {
    return '$value kaldı';
  }

  @override
  String get goalReached => 'Hedefe ulaşıldı';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gün kaldı', one: '1 gün kaldı');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Tarih geçti';

  @override
  String get goalDeadline => 'SON TARİH';

  @override
  String get goalNoDeadline => 'Tarih yok';

  @override
  String get goalRemove => 'Hedefi kaldır';

  @override
  String get exerciseNameMissing => 'Bir ad ver';

  @override
  String get aliasesLabel => 'Diğer adları (isteğe bağlı)';

  @override
  String get aliasesHint => 'Diğer adlar, virgülle ayrılmış';

  @override
  String alsoCalled(String names) {
    return 'Diğer adı: $names';
  }

  @override
  String get addToRoutine => 'Programa ekle';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n programda',
      one: '1 programda',
      zero: 'Henüz hiçbir programda yok',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Zaten içinde';

  @override
  String get restInRoutine => 'Bu programda dinlenme';

  @override
  String get restInRoutineHint => 'Egzersizdekiyle aynı';

  @override
  String get restInRoutineReset => 'Yalnızca burada · geri almak için dokun';

  @override
  String get swapExercise => 'Egzersizi değiştir';

  @override
  String get swapShort => 'Değiştir';

  @override
  String swapHint(String name) {
    return 'Sadece bugün $name yerine. Bitirince programda tutabilirsin.';
  }

  @override
  String get swapKeepsDone => 'Yaptığın setler kalır; yenisi kalanlarla devam eder.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Aynı kas · $muscle';
  }

  @override
  String get swapDoneBefore => 'Daha önce yaptın';

  @override
  String get multiPlanSettingHint => 'Haftanın aynı gününde birden fazla program.';

  @override
  String get levelHintsHint => 'Bir egzersiz kolaylaşınca daha zor versiyonunu önerir.';

  @override
  String get focusCardHint => 'Bugünün programı, Ana sayfanın en üstünde.';

  @override
  String get gamificationHint => 'Madalyalar, seviyen ve bitirince kutlama.';

  @override
  String get exerciseSettings => 'Bu egzersizin ayarları';

  @override
  String get placeActiveNow => 'Buradasın';

  @override
  String get placeTapToUse => 'burada çalışmak için dokun';

  @override
  String get intervalDays => 'gün';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target gün';
  }

  @override
  String get toolNameRpe => 'RPE’ye göre ağırlık';

  @override
  String get toolTitleRpe => 'RPE’ye göre ağırlık';

  @override
  String get toolDescRpe => 'İstediğin efor için hangi ağırlık';

  @override
  String get toolNameDots => 'Güç seviyesi';

  @override
  String get toolTitleDots => 'Güç seviyesi (DOTS)';

  @override
  String get toolDescDots => 'Kilona göre gücün';

  @override
  String rpeResultHint(int reps, String rpe) {
    return '$reps tekrar, RPE $rpe için';
  }

  @override
  String get rpeYourSet => 'Az önce yaptığın bir set';

  @override
  String get rpeGoal => 'Ne yapmak istiyorsun';

  @override
  String rpeOneRmLine(String value) {
    return 'Tahmini 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 bir tekrar daha yapamamak; 8 iki tekrar kalmış demek.';

  @override
  String get dotsBestLifts => 'En iyi kaldırışların';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'BENCH PRESS';

  @override
  String get dotsDeadlift => 'DEADLIFT';

  @override
  String dotsTotalLine(String value) {
    return 'Toplam: $value';
  }

  @override
  String get dotsExplain =>
      'Gücünü, kilosu ne olursa olsun herkesinkiyle karşılaştırır. En iyi tek tekrarını ya da tahmini 1RM’ini kullan.';

  @override
  String get dotsLevel0 => 'Başlangıç';

  @override
  String get dotsLevel1 => 'Orta';

  @override
  String get dotsLevel2 => 'İleri';

  @override
  String get dotsLevel3 => 'Çok ileri';

  @override
  String get dotsLevel4 => 'Elit';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Wilks puanı';

  @override
  String get toolDescWilks => 'Powerlifting’in klasik puanı';

  @override
  String get wilksExplain =>
      'Powerlifting’in klasik formülü. 2020’de yerini DOTS aldı ama birçok yarışma ve sıralama hâlâ kullanıyor.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Yağsız kütle indeksi';

  @override
  String get toolDescFfmi => 'Boyuna göre ne kadar kasın var';

  @override
  String get ffmiBodyFat => 'VÜCUT YAĞI';

  @override
  String ffmiLeanLine(String value) {
    return 'Yağsız kütle: $value';
  }

  @override
  String get ffmiExplain =>
      'VKİ gibi ama yağ olmadan: yalnızca yağsız kütleni sayar. Boyuna göre düzeltilir, böylece uzun ve kısa boylular adilce karşılaştırılır.';

  @override
  String get ffmiLevel0 => 'Ortalamanın altında';

  @override
  String get ffmiLevel1 => 'Ortalama';

  @override
  String get ffmiLevel2 => 'Ortalamanın üstünde';

  @override
  String get ffmiLevel3 => 'Mükemmel';

  @override
  String get ffmiLevel4 => 'Olağanüstü';

  @override
  String get rpeEffortLabel => 'Efor (RPE)';

  @override
  String get restRowHint => 'Setler arası, egzersizin kendi süresi yoksa.';

  @override
  String get effortRowHint => 'Her sette RPE veya RIR kaydet.';

  @override
  String get countdownHint => 'İlk setten önce 3, 2, 1.';

  @override
  String get keepScreenOnHint => 'Antrenman sırasında ekran kapanmaz.';

  @override
  String get demoSizeRowHint => 'Antrenman sırasında egzersiz çizimi.';

  @override
  String get demoLoopRowHint => 'Animasyon tekrar mı eder, durur mu.';

  @override
  String get trainReminderRowHint => 'Antrenman günlerinde bir hatırlatma.';

  @override
  String get alarmSoundRowHint => 'Dinlenme bitince çalan ses.';

  @override
  String get alarmStyleRowHint => 'Sessiz modda çalıp çalmayacağı.';

  @override
  String get recommendedRowHint => 'Ana sayfada önerdiğimiz egzersizler.';

  @override
  String get weightStepSetting => 'Ağırlık adımı';

  @override
  String get weightStepHint => '− ve + düğmelerinin eklediği miktar.';

  @override
  String get prBestWorkout => 'En iyi antrenman';

  @override
  String get mergeExercise => 'Birleştir';

  @override
  String mergeExerciseInto(String name) {
    return '$name şununla birleştir…';
  }

  @override
  String get mergeExerciseTitle => 'Egzersizler birleştirilsin mi?';

  @override
  String mergeExerciseBody(String from, String to) {
    return '“$from” geçmişinin tamamı “$to” egzersizine taşınır. “$from” kitaplığında kalır. Bu geri alınamaz.';
  }

  @override
  String get mergedToast => 'Geçmiş birleştirildi';

  @override
  String get nutrition => 'Beslenme';

  @override
  String get nutritionHomeEmpty => 'Su, protein ve kalori';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g protein';
  }

  @override
  String get nutritionToday => 'Bugün';

  @override
  String get nutritionYesterday => 'Dün';

  @override
  String get nutritionGoals => 'Günlük hedefler';

  @override
  String get kcalLabel => 'KALORİ';

  @override
  String get kcalOver => 'fazla';

  @override
  String get waterLabel => 'SU';

  @override
  String get waterDone => 'Hedefe ulaşıldı';

  @override
  String get waterCustom => 'Başka miktar';

  @override
  String get glassSize => 'Bardak boyutu';

  @override
  String get supplementsLabel => 'TAKVİYELER';

  @override
  String get supplementsEmpty => 'Eklemek için birine dokun ya da kendin için +.';

  @override
  String get addSupplement => 'Yeni takviye';

  @override
  String get supplementNameHint => 'Kreatin, D vitamini…';

  @override
  String removeSupplementTitle(String name) {
    return '$name silinsin mi?';
  }

  @override
  String get removeSupplementBody => 'İşaretlediğin günler de onunla gider.';

  @override
  String get suppCreatine => 'Kreatin';

  @override
  String get suppVitaminD => 'D vitamini';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magnezyum';

  @override
  String get suppMultivitamin => 'Multivitamin';

  @override
  String get suppCaffeine => 'Kafein';

  @override
  String get myFoods => 'Yiyeceklerim';

  @override
  String get newFood => 'Yeni yiyecek';

  @override
  String get editFood => 'Yiyeceği düzenle';

  @override
  String get foodNameHint => 'Whey, yulaf, ekmek…';

  @override
  String get servingLabel => 'PORSİYON';

  @override
  String get servingHint => '1 ölçek · 30 g';

  @override
  String get perServing => 'PORSİYON BAŞINA';

  @override
  String get servingsLabel => 'Porsiyon';

  @override
  String get foodPhotoHint => 'Düz bir zeminde çıkartmaya dönüşür.';

  @override
  String get cutoutWorking => 'Kesiliyor…';

  @override
  String get cutoutTry => 'Kes';

  @override
  String get cutoutKeep => 'Fotoğrafın tamamı';

  @override
  String deleteFoodTitle(String name) {
    return '$name silinsin mi?';
  }

  @override
  String get deleteFoodBody => 'Yiyeceklerinden çıkar. Kaydettiklerin kalır.';

  @override
  String get mealBreakfast => 'Kahvaltı';

  @override
  String get mealLunch => 'Öğle yemeği';

  @override
  String get mealDinner => 'Akşam yemeği';

  @override
  String get mealSnacks => 'Ara öğün';

  @override
  String get nothingLogged => 'Henüz bir şey kaydedilmedi.';

  @override
  String addToMeal(String meal) {
    return 'Ekle: $meal';
  }

  @override
  String get quickAdd => 'Hızlı ekle';

  @override
  String get quickAddHint => 'Sadece sayılar, yiyecek kaydetmeden.';

  @override
  String get quickAddName => 'Neydi? (isteğe bağlı)';

  @override
  String get logFood => 'Ekle';

  @override
  String loggedToast(String meal) {
    return 'Eklendi: $meal';
  }

  @override
  String get entryRemoved => 'Silindi';

  @override
  String get goalsFromProfile => 'Profilimden hesapla';

  @override
  String get goalsFromProfileHint => 'Profilindeki kalori, kilogram başına 1,8 g protein ve 35 ml su.';

  @override
  String get kcalEaten => 'Yenen';

  @override
  String get kcalRemaining => 'Kalan';

  @override
  String waterTapHint(String amount) {
    return 'Bardağa dokun: + $amount';
  }

  @override
  String get shakeEmpty => 'Shake’ini seçmek için dokun';

  @override
  String shakeTapHint(String name) {
    return 'Dokun: + $name';
  }

  @override
  String get shakePick => 'Shake’in';

  @override
  String get shakePickHint => 'Bardağa dokun, tek seferde kaydedilsin.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'K';

  @override
  String get fatLetter => 'Y';

  @override
  String get addBurnedLabel => 'Yakılan kaloriyi ekle';

  @override
  String get addBurnedHint => 'Yakılan kalori antrenman süren ve kilondan tahmin edilir.';

  @override
  String get amountLabel => 'Miktar';

  @override
  String amountIn(String unit) {
    return 'Miktar ($unit)';
  }

  @override
  String get bodyweightLabel => 'Kilo';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yiyecek kopyalandı',
      one: '1 yiyecek kopyalandı',
    );
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Kaydettiklerin olduğu gibi kalır.';

  @override
  String get fiberLabel => 'Lif';

  @override
  String get sugarLabel => 'Şeker';

  @override
  String get sodiumLabel => 'Sodyum';

  @override
  String get foodDatabase => 'Yiyecek veritabanı';

  @override
  String get kcalBurned => 'Yakılan';

  @override
  String get mealOptions => 'Öğün seçenekleri';

  @override
  String get moreNutrients => 'Lif, şeker ve sodyum';

  @override
  String ofGoal(int goal, String unit) {
    return '$goal $unit hedefin';
  }

  @override
  String per100(String unit) {
    return '100 $unit başına';
  }

  @override
  String get perServingShort => 'porsiyon başına';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count adet', one: '1 adet');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count dilim', one: '1 dilim');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count ölçek', one: '1 ölçek');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yemek kaşığı',
      one: '1 yemek kaşığı',
    );
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count çay kaşığı',
      one: '1 çay kaşığı',
    );
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count su bardağı',
      one: '1 su bardağı',
    );
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count bardak', one: '1 bardak');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Son kullanılanlar';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yiyecek',
      one: '1 yiyecek',
    );
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Yeniden adlandır';

  @override
  String get repeatFrom => 'Şuradan tekrarla';

  @override
  String get repeatNone => 'Bu öğün için başka günlerde henüz kayıt yok.';

  @override
  String get restDayGoals => 'Dinlenme günlerinde farklı hedefler';

  @override
  String get trainingDays => 'Antrenman günleri';

  @override
  String get restDays => 'Dinlenme günleri';

  @override
  String get trainingDay => 'Antrenman günü';

  @override
  String get saveAsMeal => 'Öğün olarak kaydet';

  @override
  String get savedMealNameHint => 'ör. Her zamanki kahvaltı';

  @override
  String get savedMealToast => 'Öğün kaydedildi';

  @override
  String get savedMeals => 'Kayıtlı öğünler';

  @override
  String get searchFoodsHint => 'Yiyecek ara';

  @override
  String get searchFoodsEmpty => '500’den fazla fotoğraflı yiyecek arasında ara ya da kendininkini ekle.';

  @override
  String searchFoodsNone(String query) {
    return '“$query” için sonuç yok. Kendi yiyeceğin olarak oluştur.';
  }

  @override
  String get servingWeight => 'GRAM';

  @override
  String get weekAverage => 'Bu hafta';

  @override
  String get weekAvgEnergy => 'Günlük ortalama';

  @override
  String get weekAvgProtein => 'Günlük protein';

  @override
  String get weekEnergyOnTarget => 'Hedefte kalori';

  @override
  String get weekProteinOnTarget => 'Hedefte protein';

  @override
  String weekProteinAvg(int grams) {
    return 'Günde $grams g protein';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$days günün $met günü hedefte';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün kaydedildi',
      one: '1 gün kaydedildi',
    );
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Henüz bir şey kaydedilmedi';

  @override
  String get weekOnTargetHint => 'Hedefte: kalori hedefin %10 yakınında ve proteinin en az %90’ı.';

  @override
  String get weightGoalLabel => 'Hedef kilo';

  @override
  String weightGoalTitle(String unit) {
    return 'Hedef kilo ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Hedef $weight';
  }

  @override
  String get weightGoalNone => 'Hedef koymak için basılı tut';

  @override
  String get weightGoalReached => 'Hedefe ulaşıldı';

  @override
  String weightToLose(String weight) {
    return 'Verilecek $weight';
  }

  @override
  String weightToGain(String weight) {
    return 'Alınacak $weight';
  }

  @override
  String get aminoHis => 'histidin';

  @override
  String get aminoIle => 'izolösin';

  @override
  String get aminoLeu => 'lösin';

  @override
  String get aminoLys => 'lizin';

  @override
  String get aminoSaa => 'metiyonin';

  @override
  String get aminoAaa => 'fenilalanin';

  @override
  String get aminoThr => 'treonin';

  @override
  String get aminoTrp => 'triptofan';

  @override
  String get aminoVal => 'valin';

  @override
  String get animalProtein => 'Hayvansal protein';

  @override
  String get proteinQuality => 'Protein kalitesi';

  @override
  String get qualityComplete => 'Tam';

  @override
  String get qualityAlmost => 'Neredeyse tam';

  @override
  String get qualityIncomplete => 'Eksik';

  @override
  String get qualityNoData => 'Henüz veri yok';

  @override
  String get qualityNoDataHint => 'Amino asitlerini görmek için veritabanından yiyecek kaydet.';

  @override
  String get qualityAllCovered => 'Dokuz temel amino asidin hepsi karşılanıyor.';

  @override
  String qualityLimiting(String amino) {
    return '$amino eksik. Bundan zengin yiyeceklerle birleştir.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Proteininin %$pct’i ile hesaplandı: kendi yiyeceklerinde amino asit verisi yok.';
  }

  @override
  String get fatTypes => 'Yağ türleri';

  @override
  String get fatSaturated => 'Doymuş';

  @override
  String get fatMono => 'Tekli';

  @override
  String get fatPoly => 'Çoklu';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Doymuş $grams g, en fazla $limit g (kalorinin %10’u)';
  }

  @override
  String get sugarSodium => 'Şeker ve sodyum';

  @override
  String get shakeCard => 'Protein shake';

  @override
  String get mealOther => 'Öğün';

  @override
  String get mealAdd => 'Öğün ekle';

  @override
  String get mealAddHint => 'ör. Antrenman öncesi';

  @override
  String get mealsOfDay => 'Günün öğünleri';

  @override
  String get mealsHint => 'İstediğin kadar oluştur. Birini silersen içindekiler üsttekine geçer.';

  @override
  String get trackersTitle => 'Özelleştir';

  @override
  String get trackersHint => 'Sadece takip etmek istediklerini bırak.';

  @override
  String get trackersDaily => 'Günün özeti';

  @override
  String get trackersDetail => 'Ayrıntılı';

  @override
  String get trackersCards => 'Kartlar';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Yeni parti';

  @override
  String get prepNew => 'Yeni parti';

  @override
  String get prepEdit => 'Partiyi düzenle';

  @override
  String get prepHint => 'Tencerenin tamamını bir kez kaydet, sonra azar azar ye.';

  @override
  String get prepEmpty =>
      'Birkaç günlük mü pişirdin? Bir kez kaydet, sonra kalandan ne kadar yediğini söyle yeter.';

  @override
  String get prepNameHint => 'ör. Tavuklu pilav';

  @override
  String get prepDefaultName => 'Parti';

  @override
  String get prepIngredients => 'Malzemeler';

  @override
  String get prepAddIngredient => 'Malzeme ekle';

  @override
  String get prepCookedWeight => 'PİŞMİŞ AĞIRLIK';

  @override
  String prepCookedHint(String grams) {
    return 'Kesin sayılar için tencereyi pişince tart. Boş = toplam çiğ ağırlık ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Pişmiş ağırlığı gir: bazı malzemelerin gramı yok.';

  @override
  String prepLeftOf(String left, String total) {
    return '$total’nin $left’ı kaldı';
  }

  @override
  String get prepOfWhatsLeft => 'Kalanın %’si';

  @override
  String get prepAll => 'Hepsi';

  @override
  String prepLogAmount(String grams) {
    return '$grams kaydet';
  }

  @override
  String get prepWeighLeft => 'Kalanı tart';

  @override
  String get prepFinished => 'Bu parti bitti.';

  @override
  String get approxValues => 'Yaklaşık';

  @override
  String get editValues => 'Değerleri düzenle';

  @override
  String get editValuesHint =>
      'Sadece bu kaydı değiştirir. Yiyeceği bir dahaki sefer için düzeltmek istersen Yiyeceklerim’den düzenle.';

  @override
  String get editLibraryHint => 'Aynı fotoğrafla senin yiyeceğin olarak kaydedilir';

  @override
  String per100Line(String energy, String unit) {
    return '100 $unit başına $energy';
  }

  @override
  String get rawLabel => 'Çiğ';

  @override
  String get cookedLabel => 'Pişmiş';

  @override
  String get rawHint => 'Pişirmeden önceki ağırlık';

  @override
  String cookedHint(String factor) {
    return 'Pişmiş ağırlık (çiğ ağırlığın ×$factor katı)';
  }

  @override
  String get servingsUnit => 'porsiyon';

  @override
  String logAmount(String energy) {
    return 'Kaydet · $energy';
  }

  @override
  String get catFruit => 'Meyve';

  @override
  String get catVeg => 'Sebze';

  @override
  String get catMeat => 'Et';

  @override
  String get catFish => 'Balık';

  @override
  String get catEgg => 'Yumurta';

  @override
  String get catDairy => 'Süt ürünleri';

  @override
  String get catGrain => 'Tahıllar';

  @override
  String get catBakery => 'Ekmek';

  @override
  String get catLegume => 'Baklagiller';

  @override
  String get catNut => 'Kuruyemiş';

  @override
  String get catOil => 'Yağlar';

  @override
  String get catPantry => 'Kiler';

  @override
  String get catDrink => 'İçecekler';

  @override
  String get catSauce => 'Soslar';

  @override
  String get catSpice => 'Baharatlar';

  @override
  String get searchFoodsPrompt => 'Ne yedin?';

  @override
  String get shelfEmpty =>
      'Bir yiyecek ara ya da kendininkinin fotoğrafını çek: en çok kaydettiklerin burada çıkar.';

  @override
  String get repeatEntry => 'Tekrarla';

  @override
  String get notifSuppChannel => 'Takviyeler';

  @override
  String get notifSuppChannelWhy => 'Takviyelerini almak için günlük hatırlatma';

  @override
  String get energySplit => 'Kaloriler nereden geliyor';

  @override
  String get typicalServing => 'Tipik porsiyon';

  @override
  String cookedYieldLine(String factor) {
    return 'Çiğ ağırlığının $factor katı gelir';
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
  String get planDeleteBody => 'Rutinlerin kalır. Sadece bu kayıtlı hafta silinir.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Beslenme';

  @override
  String get nutritionBetaHint =>
      'Öğünler, su, protein ve takviyeler. Hâlâ yapım aşamasında: kapatsan bile verilerin kalır.';

  @override
  String get nutritionAboutTitle => 'Beslenme hakkında';

  @override
  String get nutritionAboutSub => 'Ne olduğu ve asla ne olmayacağı.';

  @override
  String get nutritionAboutWhatTitle => 'Antrenmanının bir parçası';

  @override
  String get nutritionAboutWhat =>
      'Öğünlerini, suyunu, proteinini ve takviyelerini antrenmanlarının hemen yanında kaydetmenin basit bir yolu. GymMane her şeyden önce bir spor salonu uygulaması: Beslenme her şeyi tek bir yerde tutman için var, bir diyet uygulamasının yerini almak için değil.';

  @override
  String get nutritionAboutScanTitle => 'Tarayıcı yok, asla';

  @override
  String get nutritionAboutScan =>
      'Bir barkodu tarayıp her şeyin kendiliğinden dolması kullanışlı olurdu. Ama bunun için internet ve devasa bir çevrimiçi gıda veritabanı gerekir ve yediklerin başkalarının sunucularına gider. Bu veriler ne zaman yediğini, ne yediğini ve vücuduna nasıl baktığını gösterir; reklam için kullanılabilir ya da büyük şirketlerin eline geçebilir. Bu yüzden tarayıcı yok ve olmayacak.';

  @override
  String get nutritionAboutLocalTitle => 'Her şey telefonunda';

  @override
  String get nutritionAboutLocal =>
      'Uygulamada fotoğraflı 500’den fazla yiyecek var. Kendi yiyeceklerini ekleyebilir, fotoğraflarını değiştirebilir ve değerlerini düzenleyebilirsin. GymMane’in geri kalanı gibi her şey telefonunda kalır.';

  @override
  String get nutritionAboutBetaTitle => 'Hâlâ beta';

  @override
  String get nutritionAboutBeta =>
      'Eksik bir şey varsa GitHub’da öner. Yalnızca tarayıcı ya da daha büyük bir gıda veritabanı olmasın: gizliliğinin yanı sıra uygulamayı çok daha ağır yapar. Beslenmeye ihtiyacın yok mu? Ayarlar’dan kapat, verilerin kalır.';

  @override
  String get nutritionAboutSuggest => 'Fikir öner';

  @override
  String get nutritionAboutOk => 'Anladım';

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
  String get planNameHint => 'Yaz, seyahat…';

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
  String get planFixedWeek => 'Sabit hafta';

  @override
  String get planRotation => 'Rotasyon';

  @override
  String get rotationTitle => 'ROTASYON';

  @override
  String get rotationHint => 'Sıradaki, gün fark etmeksizin son antrenmanından sonra gelendir.';

  @override
  String get rotationEmpty => 'Rutinlerini yapacağın sırayla ekle: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return 'Bu turda $total içinden $done tamam';
  }

  @override
  String get rotationNext => 'Sıradaki';

  @override
  String get rotationAdd => 'Rutin ekle';

  @override
  String get rotationPickHint => 'Dokunduğun sırayla eklenir.';

  @override
  String get rotationSkip => 'Sıradakine geç';

  @override
  String get rotationRestart => 'Yeni tura başla';

  @override
  String get rotationMakeNext => 'Sıradaki yap';

  @override
  String get rotationRemove => 'Rotasyondan çıkar';

  @override
  String rotationPlace(int n, int total) {
    return 'Rotasyonda $total içinden $n';
  }

  @override
  String get moveToDay => 'Başka bir güne taşı';

  @override
  String get moveToDayHint => 'Sadece bu sefer; haftalık planın aynı kalır.';

  @override
  String get movedToast => 'Antrenman taşındı';

  @override
  String get backToPlan => 'Haftalık plana dön';

  @override
  String get tomorrow => 'Yarın';

  @override
  String get untrainedTab => 'Çalışılmayan';

  @override
  String get untrainedRecent => 'Yakın';

  @override
  String get untrainedLong => 'Uzun süre önce';

  @override
  String untrainedWaiting(String list) {
    return 'En uzun süredir bekleyen: $list';
  }

  @override
  String get untrainedAllRecent => 'Bu hafta her kas çalıştı. Güzel.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n gün önce',
      one: 'Dün çalışıldı',
      zero: 'Bugün çalışıldı',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Henüz çalışılmadı';

  @override
  String get layoutSetting => 'Antrenman görünümü';

  @override
  String get layoutCards => 'Kartlar';

  @override
  String get layoutList => 'Liste';

  @override
  String get layoutHint =>
      'Kartlar her seferinde bir egzersiz gösterir. Liste tüm antrenmanı tek ekranda, set set gösterir.';

  @override
  String get layoutRowHint => 'Tek tek egzersiz ya da hepsi liste halinde';

  @override
  String get previousCol => 'ÖNCEKİ';

  @override
  String get usePrevious => 'Geçen seferki değerleri kullan';

  @override
  String get skipShort => 'Geç';

  @override
  String get moveUp => 'Yukarı taşı';

  @override
  String get moveDown => 'Aşağı taşı';

  @override
  String get widgetNutritionOff => 'Turn on Nutrition in Settings › Beta to use this widget.';

  @override
  String get widgetPickShake => 'Pick your shake';

  @override
  String get heatRangeSetting => 'Aktivite takvimi';

  @override
  String get heatRangeWeeks => '12 hafta';

  @override
  String get heatRangeYear => '12 ay';

  @override
  String get heatRangeHint => '12 ay tüm yılı gösterir. İlk antrenmanına kadar geri gitmek için yana kaydır.';

  @override
  String get pdfPlan => 'PDF olarak plan';

  @override
  String get pdfPlanHint =>
      'Haftan ve tüm rutinlerinle düzenli bir sayfa; yazdırmaya ya da göndermeye hazır.';

  @override
  String get pdfExport => 'PDF olarak dışa aktar';

  @override
  String get pdfFooter => 'Ücretsiz, açık kaynak ve çevrimdışı';

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
  String get pdfKicker => 'ANTRENMAN PLANI';

  @override
  String get pdfStatDays => 'GÜN / HAFTA';

  @override
  String get pdfStatMinutes => 'DK / ANTRENMAN';

  @override
  String pdfMinutes(int n) {
    return '≈ $n dk';
  }

  @override
  String get workoutNotesTitle => 'Egzersiz notları';

  @override
  String get workoutNoteEvery => 'Her seferinde';

  @override
  String get workoutNoteNext => 'Bir dahaki sefere';

  @override
  String get workoutNoteEveryHint =>
      'Bu egzersizi her yaptığında görünür. Koltuk veya makara ayarı için ideal.';

  @override
  String get workoutNoteNextHint => 'Sadece bir dahaki sefere görünür, sonra kaybolur.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Geçen seferden · $date';
  }

  @override
  String get workoutNoteHint => 'Koltuk 2. delikte, makara 19’da…';

  @override
  String get notePinWorkout => 'Antrenmanda göster';

  @override
  String get assistedSetting => 'Destekli makine';

  @override
  String get assistedSettingHint =>
      'Ağırlık sana yardım eder, yani az olan daha iyi: rekorlar ve öneriler aşağı iner.';

  @override
  String get assistedRecordHint => 'En az destek';

  @override
  String get trainAgainLabel => 'Henüz antrenman yapmadın mı? Tekrar hatırlat';

  @override
  String get trainAgainOff => 'Hayır';

  @override
  String trainAgainAfter(int n) {
    return '+$n sa';
  }

  @override
  String get trainAgainHint => 'Yalnızca bir kez ve o gün antrenman kaydetmediysen.';

  @override
  String get notifTrainAgainBody => 'Bugün antrenman için hâlâ vaktin var.';

  @override
  String nextDeload(int n) {
    return 'daha hafif: üst üste $n antrenmanda tüm tekrarlar yok';
  }

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ANTRENMAN');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Bu ay antrenman yok';

  @override
  String get historyEmptyHint => 'Diğer ayları görmek için yana kaydır ya da okları kullan.';

  @override
  String historyMore(int n) {
    return '+$n daha';
  }

  @override
  String get stopwatch => 'Kronometre';

  @override
  String get proteinSource => 'Protein source';

  @override
  String get proteinMixedShort => 'Mixed';

  @override
  String get kcalActive => 'aktif';

  @override
  String get kcalEstimated => 'tahmini';

  @override
  String get kcalYours => 'senin değerin';

  @override
  String kcalTotalRest(String value) {
    return 'toplam $value, dinlenirken yaktıkların dahil';
  }

  @override
  String get inclineLabel => 'Eğim';

  @override
  String get kcalUseOwn => 'Kendi değerimi kullan';

  @override
  String get kcalBackToEstimate => 'Tahmine dön';

  @override
  String get kcalNeedsData => 'Kaloriyi tahmin etmek için mesafe ve süre ekle';

  @override
  String get kcalHowEstimated => 'Mesafe, süre, eğim ve kilona göre tahmin edildi (ACSM formülü).';

  @override
  String get kcalOwnTitle => 'Aktif kalori';

  @override
  String get planMine => 'Planım';

  @override
  String get planNew => 'Yeni plan';

  @override
  String get planSaveWeek => 'Bu haftayı kaydet';

  @override
  String get planSaveWeekHint => 'Mevcut haftayı dönebileceğin bir plan olarak sakla';

  @override
  String get planEmptyWeek => 'Boş bir hafta başlat';

  @override
  String get planEmptyWeekHint => 'Mevcut haftan plan olarak kayıtlı kalır';

  @override
  String get planName => 'Plan adı';

  @override
  String get planRename => 'Yeniden adlandır';

  @override
  String get planDelete => 'Planı sil';

  @override
  String get plansHint => 'Haftadaki değişiklikler seçili plana kaydedilir';

  @override
  String get progression => 'İlerleme';

  @override
  String get progManual => 'Manuel';

  @override
  String get progManualHint => 'Öneri yok: her ağırlığı sen seçersin.';

  @override
  String get progLinear => 'Doğrusal';

  @override
  String get progLinearHint => 'Tüm tekrarları yap, ağırlık artsın.';

  @override
  String get progDouble => 'Çift ilerleme';

  @override
  String get progDoubleHint => 'Aralığın üstüne kadar daha çok tekrar, sonra daha çok ağırlık.';

  @override
  String get progVolume => 'Tekrar, set ve ağırlık';

  @override
  String get progVolumeHint => 'Tekrarlar üste kadar, sonra bir set daha, sonra daha çok ağırlık.';

  @override
  String get progAmrap => 'Son set sonuna kadar';

  @override
  String get progAmrapHint => 'Son set: yapabildiğin kadar tekrar. Hedefi ikiye katlarsan iki kat artar.';

  @override
  String get progStep => 'Ağırlık artışı';

  @override
  String get progRange => 'Tekrar aralığı';

  @override
  String get progSets => 'Setler';

  @override
  String get progDeload => 'Hafiflet:';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n başarısızlıktan sonra',
      one: '1 başarısızlıktan sonra',
    );
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Azalt';

  @override
  String get progApply => 'Sonraki antrenmanı doldur';

  @override
  String get progApplyHint => 'Kapalıyken sadece öneri olarak görünür.';

  @override
  String get nextMoreReps => 'aynı ağırlık, bir tekrar fazla';

  @override
  String get nextAddSet => 'bir set fazla';

  @override
  String get nextAmrap => 'son set: yapabildiğin kadar';

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
  String get byZone => 'Bölgeye göre';

  @override
  String get importAlreadyHave => 'Bu programlar sende zaten var. Kopya olarak yeniden ekleyebilirsin.';

  @override
  String get importAsCopy => 'Kopya olarak ekle';

  @override
  String get importOwned => 'Zaten var';

  @override
  String get setDuplicated => 'Set kopyalandı';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Aralarında 15–30 saniye olan küçük bloklara bölünmüş bir set. Toplam tekrarı yaz.';

  @override
  String timesBodyweight(String value) {
    return 'vücut ağırlığının $value×';
  }

  @override
  String get archiveRoutine => 'Programı arşivle';

  @override
  String get routineArchived => 'Program arşivlendi';

  @override
  String get archivedRoutines => 'Arşivlenenler';

  @override
  String get autoBackup => 'Otomatik yedek';

  @override
  String get autoBackupHint =>
      'Tüm verilerini içeren bir ZIP dosyasını seçtiğin klasöre kaydeder. Bu klasörü Nextcloud, Syncthing veya başka bir uygulamayla eşitleyerek telefon dışında da bir kopya tut.';

  @override
  String get autoBackupFolder => 'Klasör seç';

  @override
  String get autoBackupNoFolder => 'Klasör yok';

  @override
  String get autoBackupOff => 'Kapalı';

  @override
  String get autoBackupWorkout => 'Her antrenmandan sonra';

  @override
  String get autoBackupDaily => 'Günde bir';

  @override
  String get autoBackupWeekly => 'Haftada bir';

  @override
  String get autoBackupOnLeave => 'Uygulamadan çıkınca';

  @override
  String get autoBackupKeep => 'Saklanacak kopya';

  @override
  String get autoBackupNow => 'Şimdi yedekle';

  @override
  String autoBackupLast(String when) {
    return 'Son yedek $when';
  }

  @override
  String get autoBackupNever => 'Henüz yedek yok';

  @override
  String get autoBackupLost => 'Son yedek kaydedilemedi. Klasörü yeniden seç.';

  @override
  String get autoBackupSaved => 'Yedek kaydedildi';

  @override
  String get prepPortions => 'Porsiyon';
}
