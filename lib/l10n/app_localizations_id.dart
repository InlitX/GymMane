// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get languageName => 'Bahasa Indonesia';

  @override
  String vsLastMonthLabel(String pct) {
    return '$pct% vs bulan lalu';
  }

  @override
  String levelStreakLabel(int level, String streak) {
    return 'Level $level · $streak';
  }

  @override
  String get save => 'SIMPAN';

  @override
  String get cancel => 'Batal';

  @override
  String get cancelCaps => 'BATAL';

  @override
  String get deleteCaps => 'HAPUS';

  @override
  String get done => 'SELESAI';

  @override
  String get set => 'Set';

  @override
  String get home => 'BERANDA';

  @override
  String get progress => 'PROGRES';

  @override
  String get exercises => 'GERAKAN';

  @override
  String get settings => 'PENGATURAN';

  @override
  String get today => 'HARI INI';

  @override
  String get thisWeek => 'MINGGU INI';

  @override
  String get recommended => 'DISARANKAN';

  @override
  String get goal => 'TARGET';

  @override
  String get volume => 'VOLUME';

  @override
  String get setsToday => 'SET HARI INI';

  @override
  String get prs => 'PR';

  @override
  String get todaysFocus => 'FOKUS HARI INI';

  @override
  String get todaysRoutine => 'RUTINITAS HARI INI';

  @override
  String get startWorkout => 'MULAI LATIHAN';

  @override
  String get routines => 'RUTINITAS';

  @override
  String get tools => 'ALAT';

  @override
  String get firstSessionHint => 'Pilih ototmu dan catat sesi pertamamu';

  @override
  String exerciseCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gerakan');
    return '$_temp0';
  }

  @override
  String get pushDay => 'HARI PUSH';

  @override
  String get pullDay => 'HARI PULL';

  @override
  String get legDay => 'HARI KAKI';

  @override
  String get pushFocus => 'Dada · Bahu · Trisep';

  @override
  String get pullFocus => 'Punggung · Bisep · Trapezius';

  @override
  String get legFocus => 'Paha depan · Paha belakang · Bokong';

  @override
  String get train => 'LATIHAN';

  @override
  String get step1 => 'LANGKAH 1 DARI 2';

  @override
  String get step2 => 'LANGKAH 2 DARI 2';

  @override
  String get chooseFocus => 'PILIH FOKUSMU';

  @override
  String get buildSession => 'SUSUN SESIMU';

  @override
  String get tapMuscles => 'Ketuk otot yang ingin kamu latih, depan dan belakang.';

  @override
  String get continueBtn => 'LANJUT';

  @override
  String get nothingForFocus => 'Belum ada untuk fokus ini';

  @override
  String get goBackPick => 'Kembali dan pilih otot yang punya gerakan di pustakamu.';

  @override
  String pickedHint(int n) {
    return 'Kami pilihkan sesi untukmu. Ketuk untuk menambah atau membuang salah satu dari $n gerakan.';
  }

  @override
  String get pickAnExercise => 'PILIH GERAKAN';

  @override
  String get searchAllExercises => 'Cari gerakan apa pun…';

  @override
  String get noExercisesMatch => 'Tidak ada gerakan yang cocok';

  @override
  String get createItInstead => 'Buat sebagai gerakanmu sendiri';

  @override
  String startCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n GERAKAN');
    return 'MULAI · $_temp0';
  }

  @override
  String get inProgress => 'BERLANGSUNG';

  @override
  String get paused => 'DIJEDA';

  @override
  String get last => 'TERAKHIR';

  @override
  String get rest => 'ISTIRAHAT';

  @override
  String get skip => 'LEWATI';

  @override
  String get addSet => '+ TAMBAH SET';

  @override
  String get finishSession => 'SELESAIKAN SESI';

  @override
  String get setDone => 'SET SELESAI';

  @override
  String get nextExercise => 'GERAKAN BERIKUTNYA';

  @override
  String get dropExerciseAction => 'Buang gerakan';

  @override
  String get restOff => 'Mati';

  @override
  String get miniRest => 'Istirahat rest-pause dan cluster';

  @override
  String get miniRestHint => 'Sebelum set rest-pause atau cluster';

  @override
  String get gymPass => 'Kartu gym';

  @override
  String get gymPassEmpty => 'Simpan kode gym-mu di sini dan masuk tanpa kartu';

  @override
  String get gymPassAdd => 'Tambah kartu';

  @override
  String get gymPassScan => 'Foto kodenya';

  @override
  String get gymPassScanHint => 'Dengan kamera ponselmu';

  @override
  String get gymPassPhoto => 'Dari foto atau tangkapan layar';

  @override
  String get gymPassPhotoHint => 'Misalnya tangkapan layar dari aplikasi gym-mu';

  @override
  String get gymPassType => 'Ketik nomornya';

  @override
  String get gymPassTypeHint => 'Untuk barcode: nomor yang tercetak di bawahnya';

  @override
  String get gymPassNotFound => 'Tidak ada kode QR di gambar itu. Coba yang lebih tajam atau ketik nomornya.';

  @override
  String get gymPassName => 'Nama gym';

  @override
  String get gymPassDefaultName => 'Gym-ku';

  @override
  String get gymPassCode => 'Kode';

  @override
  String get gymPassFormat => 'Jenis kode';

  @override
  String get gymPassInvalid => 'Nomor itu tidak cocok dengan jenis kode ini';

  @override
  String get gymPassShowHint => 'Dekatkan ke pembaca. Kecerahan naik sendiri.';

  @override
  String get gymPassDeleted => 'Kartu dihapus';

  @override
  String get gymPassEdit => 'Edit kartu';

  @override
  String get gymPassShow => 'Tunjukkan di pintu';

  @override
  String get gymPassPrivate => 'Hanya tersimpan di ponselmu. Tidak ada yang diunggah.';

  @override
  String get gymPassColor => 'Warna';

  @override
  String get gymPassRescan => 'Baca kodenya lagi';

  @override
  String get gymPassReading => 'Membaca kode…';

  @override
  String get gymPassSettingHint => 'Kartu gym-mu di profil';

  @override
  String get gymPassMember => 'Anggota';

  @override
  String get widgetHintActivity => 'Peta hari-hari latihanmu';

  @override
  String get widgetHintStats => 'Runtutan, volume, dan sesi minggu ini';

  @override
  String get widgetHintBody => 'Otot yang sudah kamu latih';

  @override
  String get widgetHintToday => 'Sekilas: sudah latihan hari ini?';

  @override
  String get widgetHintWeek => 'Rencana minggumu, hari demi hari';

  @override
  String get supportHintBug => 'Ceritakan apa yang rusak, di GitHub';

  @override
  String get supportHintFeature => 'Usulkan ide untuk aplikasi';

  @override
  String get supportHintStar => 'Membantu lebih banyak orang menemukannya';

  @override
  String get supportHintCoffee => 'Mendukung pengembangan. Gratis dan tanpa iklan';

  @override
  String get bodyweightNoteHint =>
      'Tambah catatan: apa yang kamu rasakan, apa yang sedang kamu coba… (opsional)';

  @override
  String exerciseUnitSwitch(String unit) {
    return 'Pakai $unit untuk gerakan ini';
  }

  @override
  String get setCol => '#';

  @override
  String get repsCol => 'REPETISI';

  @override
  String weightCol(String unit) {
    return 'BEBAN ($unit)';
  }

  @override
  String get repsTitle => 'REPETISI';

  @override
  String weightTitle(String unit) {
    return 'BEBAN ($unit)';
  }

  @override
  String get sessionComplete => 'LATIHAN TERCATAT';

  @override
  String get finishHeadlinePr => 'Rekor pribadi baru';

  @override
  String get finishHeadlineGoal => 'Target mingguan tercapai';

  @override
  String get finishHeadlineStreak => 'Runtutan terjaga';

  @override
  String get finishHeadlineDefault => 'Satu lagi masuk catatan';

  @override
  String finishBodyPr(int prs) {
    String _temp0 = intl.Intl.pluralLogic(
      prs,
      locale: localeName,
      other: '$prs gerakan',
      one: 'satu gerakan',
    );
    return 'Kamu mengangkat lebih berat dari sebelumnya di $_temp0. Sekarang sudah masuk rekormu.';
  }

  @override
  String get finishBodyGoal => 'Kamu memenuhi jumlah sesi yang kamu rencanakan minggu ini.';

  @override
  String finishBodyStreak(int streak) {
    return '$streak hari berturut-turut. Bagian tersulitnya adalah tidak berhenti.';
  }

  @override
  String get finishBodyDefault => 'Tercatat dan terhitung. Konsistensi yang menggerakkan angka.';

  @override
  String get vsLastTime => 'VS TERAKHIR KALI';

  @override
  String get firstTime => 'Pertama kali dicatat';

  @override
  String prCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rekor baru');
    return '$_temp0';
  }

  @override
  String get duration => 'DURASI';

  @override
  String get setsCaps => 'SET';

  @override
  String exerciseXofY(int i, int n) {
    return 'GERAKAN $i DARI $n';
  }

  @override
  String get decrease => 'Kurangi';

  @override
  String get increase => 'Tambah';

  @override
  String markSet(int n) {
    return 'Tandai set $n selesai';
  }

  @override
  String get pauseWorkout => 'Jeda latihan';

  @override
  String get resumeWorkout => 'Lanjutkan latihan';

  @override
  String get discardTitle => 'Buang latihan?';

  @override
  String get discardBody => 'Set dari sesi ini akan hilang.';

  @override
  String get keepTraining => 'Lanjut latihan';

  @override
  String get discard => 'Buang';

  @override
  String get notifRestChannel => 'Timer istirahat';

  @override
  String get notifRestChannelWhy => 'Memberi tahu saat istirahat antarset selesai';

  @override
  String get notifAlertChannel => 'Timer istirahat (peringatan)';

  @override
  String get notifAlertChannelWhy => 'Menampilkan banner tepat saat istirahatmu selesai';

  @override
  String get restOverTitle => 'Istirahat selesai';

  @override
  String get restOverBody => 'Ayo lanjut, set berikutnya menunggu.';

  @override
  String get allTimeSessions => 'SESI';

  @override
  String get allTimeTime => 'WAKTU';

  @override
  String get allTimeSets => 'SET';

  @override
  String get consistency => 'KONSISTENSI';

  @override
  String sessionsLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sesi tercatat');
    return '$_temp0';
  }

  @override
  String streakDays(int n) {
    return 'Runtutan $n hari';
  }

  @override
  String get bodyweight => 'BERAT BADAN';

  @override
  String get logBodyweight => 'CATAT BERAT BADAN';

  @override
  String get trackWeight => 'Pantau berat badanmu dari waktu ke waktu';

  @override
  String get muscleMap => 'PETA OTOT';

  @override
  String get days7 => '7H';

  @override
  String get days30 => '30H';

  @override
  String get days90 => '90H';

  @override
  String get days365 => '1T';

  @override
  String get daysAll => 'Semua';

  @override
  String get weeklyAvgTitle => 'Rata-rata mingguan';

  @override
  String weekOfDate(String date) {
    return 'Minggu $date';
  }

  @override
  String weightChangeRange(String change) {
    return '$change dalam periode ini';
  }

  @override
  String get heatLow => 'Belum dilatih';

  @override
  String get heatHigh => 'Volume penuh';

  @override
  String get muscleMapEmpty => 'Catat satu sesi dan tubuhmu mulai menyala di sini.';

  @override
  String get muscleMapHint => 'Ketuk otot untuk melihat apa yang didapatnya.';

  @override
  String muscleMapBehind(String names) {
    return 'Tertinggal: $names';
  }

  @override
  String ofTarget(int pct) {
    return '$pct% dari target';
  }

  @override
  String get muscleSplit => 'PEMBAGIAN OTOT';

  @override
  String get personalRecords => 'REKOR PRIBADI';

  @override
  String get strength1rm => 'KEKUATAN · PERKIRAAN 1RM';

  @override
  String get strengthEmpty => 'Catat sebuah gerakan dua kali dan kurva kekuatannya muncul di sini.';

  @override
  String oneRmEst(String w) {
    return 'Perkiraan 1RM $w';
  }

  @override
  String get restDayShort => 'Hari istirahat';

  @override
  String get restDay => 'Hari istirahat, tidak ada catatan.';

  @override
  String get delete => 'Hapus';

  @override
  String get deleteEntry => 'Hapus entri ini?';

  @override
  String deleteEntryBody(String name) {
    return '\"$name\" akan dihapus dari hari ini, juga dari rekor dan grafikmu.';
  }

  @override
  String get bodyweightHistory => 'RIWAYAT';

  @override
  String get exercisesCaps => 'GERAKAN';

  @override
  String get timeCaps => 'WAKTU';

  @override
  String libraryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gerakan di pustakamu');
    return '$_temp0';
  }

  @override
  String get searchExercises => 'Cari gerakan';

  @override
  String get muscleFilter => 'OTOT';

  @override
  String get levelFilter => 'TINGKAT';

  @override
  String get kindLabel => 'JENIS';

  @override
  String get kindStrength => 'Kekuatan';

  @override
  String get kindCalisthenics => 'Kalistenik';

  @override
  String get kindCardio => 'Kardio';

  @override
  String get kindStretch => 'Peregangan';

  @override
  String get newExercise => 'GERAKAN BARU';

  @override
  String get exerciseName => 'Nama gerakan';

  @override
  String get equipmentLabel => 'PERALATAN';

  @override
  String get addExercise => 'TAMBAH GERAKAN';

  @override
  String get advanced => 'LANJUTAN';

  @override
  String get demoMedia => 'DEMO';

  @override
  String get addMedia => 'Tambah media';

  @override
  String get mediaHint => 'Gambar, GIF, atau video';

  @override
  String get changeMedia => 'Ganti';

  @override
  String get videoSelected => 'Video dipilih';

  @override
  String get favouritesOnly => 'Favorit';

  @override
  String get noFavouritesYet => 'Belum ada favorit';

  @override
  String get noFavouritesHint => 'Ketuk bintang pada gerakan untuk menyimpannya di sini.';

  @override
  String get clearFilters => 'Hapus filter';

  @override
  String get quickAddAmount => 'Berapa banyak yang kamu makan';

  @override
  String get homeCardsTitle => 'Kartu beranda';

  @override
  String get homeCardsHint => 'Yang kamu nyalakan muncul di Beranda';

  @override
  String get homeCardFocus => 'Hari ini';

  @override
  String get homeCardSteps => 'Langkah';

  @override
  String get homeCardWeek => 'Minggu ini';

  @override
  String get homeCardRoutines => 'Rutinitas';

  @override
  String get homeCardRecommended => 'Disarankan';

  @override
  String get textSizeSetting => 'Ukuran teks';

  @override
  String get textSizeSmall => 'Kecil';

  @override
  String get textSizeNormal => 'Normal';

  @override
  String get textSizeLarge => 'Besar';

  @override
  String get textSizeHint => 'Di atas ukuran teks ponselmu';

  @override
  String get calmMotionSetting => 'Kurangi gerakan';

  @override
  String get calmMotionHint => 'Layar muncul tanpa bergeser masuk';

  @override
  String get dishArchive => 'Arsipkan';

  @override
  String get dishUnarchive => 'Pulihkan';

  @override
  String get dishArchivedToast => 'Hidangan diarsipkan';

  @override
  String get filterShowLabel => 'Tampilkan';

  @override
  String get noExercisesFound => 'Tidak ada gerakan ditemukan';

  @override
  String get noExercisesHint => 'Coba pencarian lain atau hapus filternya.';

  @override
  String get personalRecord => 'REKOR PRIBADI';

  @override
  String get history => 'RIWAYAT';

  @override
  String get noHistory => 'Belum ada sesi tercatat. Latih gerakan ini untuk membangun riwayat.';

  @override
  String get notes => 'CATATAN';

  @override
  String get notePlaceholder => 'Petunjuk, pengaturan, rasanya bagaimana…';

  @override
  String notHere(String gear, String place) {
    return 'Tidak ada $gear di $place';
  }

  @override
  String get notHereWhy => 'Ganti dengan sesuatu yang benar-benar bisa kamu pakai hari ini.';

  @override
  String get altHere => 'YANG BISA KAMU LAKUKAN DI SINI';

  @override
  String get places => 'TEMPATKU';

  @override
  String get placesHint =>
      'Sebutkan apa yang kamu punya di setiap tempat, dan pustaka hanya menampilkan yang benar-benar bisa kamu lakukan di sana.';

  @override
  String get placeAll => 'Di mana saja';

  @override
  String get placeNew => 'Tempat baru';

  @override
  String get placeNamePlaceholder => 'Rumah, gym, taman…';

  @override
  String get placeGearLabel => 'YANG ADA DI SANA';

  @override
  String placeExercises(int n) {
    return '$n gerakan di sini';
  }

  @override
  String get placeEmptyTitle => 'Latihan di mana pun kamu berada';

  @override
  String get placeEmptyBody =>
      'Tempat adalah daftar alat yang kamu punya di sana. Pilih satu untuk mulai dan edit nanti.';

  @override
  String get placeDeleteTitle => 'Hapus tempat';

  @override
  String get placeDeleteBody => 'Hanya tempatnya yang hilang. Gerakan dan sesimu tetap ada.';

  @override
  String get placeGym => 'Gym';

  @override
  String get placeHome => 'Rumah';

  @override
  String get placeOutdoors => 'Luar ruangan';

  @override
  String get placeFilterLabel => 'TEMPAT';

  @override
  String get noGearOnly => 'Tanpa alat';

  @override
  String placeActive(String name) {
    return 'Latihan di $name';
  }

  @override
  String get journal => 'JURNAL';

  @override
  String noteCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n catatan',
      zero: 'Tidak ada catatan',
    );
    return '$_temp0';
  }

  @override
  String get noteKindNote => 'Catatan';

  @override
  String get noteKindPlan => 'Rencana';

  @override
  String get noteKindDone => 'Pencapaian';

  @override
  String get noteKindPain => 'Keluhan';

  @override
  String get noteFilterAll => 'Semua';

  @override
  String get newNote => 'Catatan baru';

  @override
  String get editNote => 'Edit catatan';

  @override
  String get addNote => 'TAMBAH CATATAN';

  @override
  String get noteEmptyTitle => 'Belum ada yang ditulis';

  @override
  String get noteEmptyBody =>
      'Petunjuk, rencana untuk lain kali, rasanya sebuah sesi. Dengan foto atau video kalau mau.';

  @override
  String get noteNoneForExercise => 'Belum ada catatan untuk gerakan ini.';

  @override
  String get noteKindLabel => 'JENIS';

  @override
  String get noteTextLabel => 'CATATAN';

  @override
  String get noteDateLabel => 'TANGGAL';

  @override
  String get noteExerciseLabel => 'GERAKAN';

  @override
  String get noteMediaLabel => 'FOTO & VIDEO';

  @override
  String get noteGeneral => 'Tanpa gerakan';

  @override
  String get noteAttach => 'Lampirkan';

  @override
  String get noteRemoveMedia => 'Hapus lampiran';

  @override
  String get deleteNoteTitle => 'Hapus catatan';

  @override
  String get deleteNoteBody => 'Catatan dan semua lampirannya hilang untuk selamanya.';

  @override
  String get noteToday => 'Hari ini';

  @override
  String get noteYesterday => 'Kemarin';

  @override
  String get noteAllNotes => 'Semua catatan';

  @override
  String get noteCalendar => 'Kalender';

  @override
  String get noteNoneOnDay => 'Tidak ada tulisan di hari ini';

  @override
  String get noteAddOnDay => 'Catatan di hari ini';

  @override
  String get notePrevMonth => 'Bulan sebelumnya';

  @override
  String get noteNextMonth => 'Bulan berikutnya';

  @override
  String noteMonthCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n catatan bulan ini',
      zero: 'Tidak ada catatan bulan ini',
    );
    return '$_temp0';
  }

  @override
  String get measures => 'UKURAN TUBUH';

  @override
  String get measuresHint => 'Dari leher sampai betis: lihat tubuhmu berubah, bukan hanya bebannya.';

  @override
  String measureCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n pengukuran',
      zero: 'Belum ada catatan',
    );
    return '$_temp0';
  }

  @override
  String get measureNoneYet => 'Belum dicatat';

  @override
  String get measureHistory => 'RIWAYAT';

  @override
  String get measureNeck => 'Leher';

  @override
  String get measureShoulders => 'Bahu';

  @override
  String get measureChest => 'Dada';

  @override
  String get measureArm => 'Lengan';

  @override
  String get measureForearm => 'Lengan bawah';

  @override
  String get measureWaist => 'Pinggang';

  @override
  String get measureHips => 'Pinggul';

  @override
  String get measureThigh => 'Paha';

  @override
  String get measureCalf => 'Betis';

  @override
  String get measureBodyfat => 'Lemak tubuh';

  @override
  String get timeline => 'LINIMASA';

  @override
  String get hidePhotos => 'Sembunyikan foto';

  @override
  String get showPhotos => 'Tampilkan foto';

  @override
  String get timelineHint => 'Pose sama, tempat sama, cahaya sama. Setahun lagi kamu tidak akan percaya.';

  @override
  String get timelineEmptyTitle => 'Foto pertamamu memulai hitungan';

  @override
  String photoCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n foto', zero: 'Tidak ada foto');
    return '$_temp0';
  }

  @override
  String get poseFront => 'Depan';

  @override
  String get poseSide => 'Samping';

  @override
  String get poseBack => 'Belakang';

  @override
  String get photoEvery => 'INGATKAN AKU';

  @override
  String photoEveryDays(int n) {
    return 'Setiap $n hari';
  }

  @override
  String get photoEveryOff => 'Tidak pernah';

  @override
  String get timelineEvery => 'KELOMPOKKAN SETIAP';

  @override
  String get custom => 'Kustom';

  @override
  String photoNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Foto berikutnya dalam $n hari',
      one: 'Foto berikutnya besok',
    );
    return '$_temp0';
  }

  @override
  String get photoDueNow => 'Waktunya foto: ambil hari ini';

  @override
  String get addTodayPhotos => 'TAMBAH FOTO HARI INI';

  @override
  String posePhoto(String pose) {
    return 'Foto $pose';
  }

  @override
  String get compare => 'BANDINGKAN';

  @override
  String get compareNeedTwo => 'Foto berikutnya akan menampilkan sebelum dan sesudah di sini.';

  @override
  String dayNumber(int n) {
    return 'Hari $n';
  }

  @override
  String daysApart(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Selisih $n hari',
      zero: 'Hari yang sama',
    );
    return '$_temp0';
  }

  @override
  String get deleteEntryTitle => 'Hapus hari ini';

  @override
  String get deleteDayBody => 'Fotonya ikut terhapus, untuk selamanya.';

  @override
  String get timelinePhotos => 'Foto';

  @override
  String get timelineBody => 'Peta otot';

  @override
  String get timelineBodyEmpty => 'Catat satu sesi dan peta ototmu mulai terisi di sini, tanpa perlu foto.';

  @override
  String get timelineBodyHint => 'Dibangun dari set-mu sendiri, tidak ada yang diunggah.';

  @override
  String timelineWindow(String from, String to) {
    return '$from – $to';
  }

  @override
  String sessionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sesi', zero: 'Tidak ada sesi');
    return '$_temp0';
  }

  @override
  String get notifPhotoChannel => 'Foto progres';

  @override
  String get notifPhotoChannelWhy => 'Pengingat saat foto progres berikutnya tiba.';

  @override
  String get notifPhotoTitle => 'Waktunya foto progres';

  @override
  String notifPhotoBody(int n) {
    return '$n hari sejak yang terakhir. Pose sama, cahaya sama.';
  }

  @override
  String get share => 'BAGIKAN';

  @override
  String get sharePick => 'Apa yang ingin kamu tunjukkan?';

  @override
  String get shareStreak => 'Runtutan dan konsistensi';

  @override
  String get shareBody => 'Otot yang dilatih';

  @override
  String get shareCompare => 'Sebelum dan sesudah';

  @override
  String get shareHint => 'Kartunya dibuat di ponselmu. Tidak ada yang keluar sampai kamu memilih tujuannya.';

  @override
  String get shareFailed => 'Kartunya tidak bisa dibuat';

  @override
  String get shareWeekOf => '7 HARI TERAKHIR';

  @override
  String get shareStreakLabel => 'HARI BERUNTUN';

  @override
  String get shareSessionsLabel => 'SESI';

  @override
  String get shareVolumeLabel => 'VOLUME';

  @override
  String get restForExercise => 'ISTIRAHAT UNTUK GERAKAN INI';

  @override
  String get restUsingDefault => 'Memakai bawaanmu';

  @override
  String get restCustom => 'Khusus yang ini';

  @override
  String get setType => 'JENIS SET';

  @override
  String get setTypeNormal => 'Kerja';

  @override
  String get setTypeWarmup => 'Pemanasan';

  @override
  String get setTypeDrop => 'Drop set';

  @override
  String get setTypeFailure => 'Sampai gagal';

  @override
  String get addWarmup => 'PEMANASAN';

  @override
  String platesPerSide(String plates) {
    return 'Per sisi: $plates';
  }

  @override
  String get howTo => 'CARA MELAKUKAN';

  @override
  String get similar => 'SERUPA';

  @override
  String get primaryLabel => 'UTAMA';

  @override
  String get secondaryLabel => 'SEKUNDER';

  @override
  String get none => 'Tidak ada';

  @override
  String setCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n set');
    return '$_temp0';
  }

  @override
  String volumeSuffix(String v) {
    return 'volume $v';
  }

  @override
  String get weeklyPlan => 'RENCANA MINGGUAN';

  @override
  String get yourRoutines => 'RUTINITASMU';

  @override
  String get noRoutines => 'Belum ada rutinitas. Buat satu dan tambahkan gerakanmu.';

  @override
  String get newRoutine => 'RUTINITAS BARU';

  @override
  String get routineName => 'Nama rutinitas';

  @override
  String get schedule => 'JADWAL';

  @override
  String get addFromList => 'Tambahkan gerakan dari daftar di bawah.';

  @override
  String get addExercises => 'Tambah gerakan';

  @override
  String get deleteRoutine => 'Hapus rutinitas ini?';

  @override
  String exercisesWithCount(int n) {
    return 'GERAKAN · $n';
  }

  @override
  String setDay(String day) {
    return 'ATUR $day';
  }

  @override
  String get newRoutineName => 'Rutinitas baru';

  @override
  String get dragToReorder => 'Seret pegangan bertitik untuk mengubah urutan, ini urutan latihanmu.';

  @override
  String reorderHandle(String name) {
    return 'Ubah urutan $name';
  }

  @override
  String get removeFromRoutine => 'Hapus dari rutinitas';

  @override
  String get dropExercise => 'Buang gerakan ini?';

  @override
  String dropExerciseBody(String name) {
    return '\"$name\" keluar dari latihan ini. Tidak ada catatan yang hilang.';
  }

  @override
  String get drop => 'Buang';

  @override
  String get resetData => 'Hapus semua dataku';

  @override
  String get resetTitle => 'Hapus semuanya?';

  @override
  String get resetBody =>
      'Sesi, rekor, rutinitas, catatan, dan profil. Ini tidak bisa dibatalkan: ekspor cadangan dulu kalau mungkin kamu butuh.';

  @override
  String get resetConfirm => 'Hapus semuanya';

  @override
  String get resetDone => 'Semua data dihapus';

  @override
  String get support => 'DUKUNGAN';

  @override
  String get reportBug => 'Laporkan bug';

  @override
  String get requestFeature => 'Minta fitur';

  @override
  String get starOnGithub => 'Beri bintang di GitHub';

  @override
  String get buyCoffee => 'Traktir aku kopi';

  @override
  String get cantOpenLink => 'Tautan tidak bisa dibuka';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Gelap';

  @override
  String get lightTheme => 'Terang';

  @override
  String get amoledTheme => 'Hitam AMOLED';

  @override
  String get editDuration => 'Durasi latihan';

  @override
  String get sessionName => 'Nama latihan';

  @override
  String get nameWorkout => 'Beri nama';

  @override
  String get sessionNameHint => 'mis. Kaki, Push, Seluruh tubuh';

  @override
  String get secondaryPickHint => 'Ketuk otot lain yang dilatih gerakan ini.';

  @override
  String get languageLabel => 'Bahasa';

  @override
  String get unitsLabel => 'Satuan';

  @override
  String get restTimer => 'Timer istirahat';

  @override
  String get alarmBlockedTitle => 'Notifikasi mati';

  @override
  String get alarmBlockedBody => 'Alarm istirahat tidak akan berbunyi saat layar terkunci';

  @override
  String get alarmBlockedAction => 'NYALAKAN';

  @override
  String get alarmSound => 'Suara alarm';

  @override
  String get alarmDefaultName => 'Bawaan';

  @override
  String get alarmSoundHint => 'Pakai suaramu sendiri, maksimal 15 detik';

  @override
  String get alarmChoose => 'Pilih suara…';

  @override
  String get alarmPreview => 'Putar suara saat ini';

  @override
  String get alarmReset => 'Kembalikan ke bawaan';

  @override
  String get alarmTooLong => 'Suara itu lebih dari 15 detik';

  @override
  String get alarmInvalid => 'File audio itu tidak bisa dibaca';

  @override
  String alarmChanged(String name) {
    return 'Suara alarm diatur ke \"$name\"';
  }

  @override
  String get alarmChangedDefault => 'Kembali ke suara bawaan';

  @override
  String get addActivityWidget => 'Tambah widget aktivitas';

  @override
  String get addStatsWidget => 'Tambah widget statistik';

  @override
  String get pinUnsupported => 'Tambahkan dari menu widget peluncurmu';

  @override
  String get background => 'Latar';

  @override
  String get bgNone => 'Tidak ada';

  @override
  String get bgDots => 'Titik';

  @override
  String get bgGrid => 'Kisi';

  @override
  String get exportCsv => 'Ekspor latihan (CSV)';

  @override
  String get exportBackup => 'Ekspor cadangan (ZIP)';

  @override
  String get importBackup => 'Impor cadangan';

  @override
  String get importHint =>
      'Pilih cadangan .zip (atau .json lama) yang diekspor dari GymMane. Ini menggantikan datamu saat ini, termasuk media.';

  @override
  String get import => 'Impor';

  @override
  String get chooseFile => 'Pilih file';

  @override
  String get importFromApp => 'Impor dari aplikasi lain';

  @override
  String get importUnknownFormat => 'File itu butuh kolom tanggal, gerakan, repetisi, dan beban';

  @override
  String get importZipNoWeights => 'Zip itu tidak berisi file berat badan';

  @override
  String importWeights(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n catatan berat badan diimpor');
    return '$_temp0';
  }

  @override
  String get importReadFailed => 'File itu tidak bisa dibaca';

  @override
  String get importUnitTitle => 'File itu memakai satuan apa?';

  @override
  String get importUnitBody => 'Ekspor ini tidak menyebutkan satuan bebannya.';

  @override
  String get importNothing => 'Tidak ada yang baru untuk diimpor';

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sesi diimpor');
    return '$_temp0';
  }

  @override
  String get aboutGymmane => 'Tentang GymMane';

  @override
  String get yourProfile => 'PROFILMU';

  @override
  String get autofills => 'Mengisi kalkulator secara otomatis';

  @override
  String get onbUnitsWhy => 'Untuk beban, ukuran tubuh, dan jarak. Bisa diubah kapan saja di Pengaturan.';

  @override
  String get nameLabel => 'NAMA';

  @override
  String get sexLabel => 'JENIS KELAMIN';

  @override
  String get macroProtein => 'PROTEIN';

  @override
  String get macroCarbs => 'KARBO';

  @override
  String get macroFat => 'LEMAK';

  @override
  String get male => 'Pria';

  @override
  String get female => 'Wanita';

  @override
  String get ageLabel => 'USIA';

  @override
  String get heightLabel => 'TINGGI';

  @override
  String get weightLabel => 'BERAT';

  @override
  String get weeklyGoal => 'TARGET MINGGUAN';

  @override
  String get activityLabel => 'AKTIVITAS';

  @override
  String get addPhoto => 'Tambah foto';

  @override
  String get removePhoto => 'Hapus foto';

  @override
  String get takePhoto => 'Ambil foto';

  @override
  String get chooseGallery => 'Pilih dari galeri';

  @override
  String get backupImported => 'Cadangan diimpor';

  @override
  String get backupFailed => 'Cadangan itu tidak bisa dibaca';

  @override
  String get nothingToExport => 'Belum ada yang bisa diekspor: catat satu sesi dulu';

  @override
  String calculatorsCount(int n) {
    return '$n kalkulator untuk latihanmu';
  }

  @override
  String get result => 'HASIL';

  @override
  String get weightLifted => 'BEBAN DIANGKAT';

  @override
  String get repsPerformed => 'REPETISI DILAKUKAN';

  @override
  String get neck => 'LEHER';

  @override
  String get waist => 'PINGGANG';

  @override
  String get hip => 'PINGGUL (untuk wanita)';

  @override
  String get targetWeight => 'BERAT TARGET';

  @override
  String get workingWeight => 'BEBAN KERJA';

  @override
  String get activityLevel => 'TINGKAT AKTIVITAS';

  @override
  String get barWeight => 'BERAT BARBEL';

  @override
  String get perSide => 'PER SISI';

  @override
  String get justTheBar => 'Barbelnya saja.';

  @override
  String perSideCount(int n) {
    return '× $n per sisi';
  }

  @override
  String get toolNameRm => '1RM';

  @override
  String get toolNameBmi => 'IMT';

  @override
  String get toolNameCal => 'Kalori';

  @override
  String get toolNameBf => 'Lemak Tubuh';

  @override
  String get toolNamePlate => 'Pelat';

  @override
  String get toolNameWarmup => 'Pemanasan';

  @override
  String get toolTitleRm => 'Kalkulator 1RM';

  @override
  String get toolTitleBmi => 'Kalkulator IMT';

  @override
  String get toolTitleCal => 'Kalori & Makro';

  @override
  String get toolTitleBf => 'Lemak Tubuh %';

  @override
  String get toolTitlePlate => 'Kalkulator Pelat';

  @override
  String get toolTitleWarmup => 'Set Pemanasan';

  @override
  String get toolHintRm => 'Perkiraan maksimal 1 repetisi (rumus Epley)';

  @override
  String get toolHintCal => 'Perkiraan kebutuhan harian';

  @override
  String get toolHintBf => 'Perkiraan metode US Navy';

  @override
  String get toolHintPlate => 'Total berat barbel';

  @override
  String get toolHintWarmup => 'Target beban kerja';

  @override
  String get toolDescRm => 'Perkiraan maksimal satu repetisi';

  @override
  String get toolDescBmi => 'Indeks massa tubuh';

  @override
  String get toolDescCal => 'Kalori & makro';

  @override
  String get toolDescBf => 'Persentase lemak tubuh';

  @override
  String get toolDescPlate => 'Kalkulator pelat barbel';

  @override
  String get toolDescWarmup => 'Set bertahap';

  @override
  String get bmiUnderweight => 'Kurus';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Kelebihan berat';

  @override
  String get bmiObese => 'Obesitas';

  @override
  String get actSedentary => 'Jarang bergerak';

  @override
  String get actLight => 'Ringan';

  @override
  String get actActive => 'Aktif';

  @override
  String get actModerate => 'Sedang';

  @override
  String get muscleChest => 'Dada';

  @override
  String get muscleBack => 'Punggung';

  @override
  String get muscleLowerBack => 'Punggung bawah';

  @override
  String get muscleShoulders => 'Bahu';

  @override
  String get muscleBiceps => 'Bisep';

  @override
  String get muscleTriceps => 'Trisep';

  @override
  String get muscleForearm => 'Lengan bawah';

  @override
  String get muscleTrapezius => 'Trapezius';

  @override
  String get muscleAbdomen => 'Perut';

  @override
  String get muscleObliques => 'Oblik';

  @override
  String get muscleQuads => 'Paha depan';

  @override
  String get muscleHamstrings => 'Paha belakang';

  @override
  String get muscleGlutes => 'Bokong';

  @override
  String get muscleCalves => 'Betis';

  @override
  String get mgChest => 'Dada';

  @override
  String get mgBack => 'Punggung';

  @override
  String get mgLegs => 'Kaki';

  @override
  String get mgShoulders => 'Bahu';

  @override
  String get mgArms => 'Lengan';

  @override
  String get mgCore => 'Inti';

  @override
  String get equipBarbell => 'Barbel';

  @override
  String get equipDumbbell => 'Dumbel';

  @override
  String get equipCable => 'Kabel';

  @override
  String get equipMachine => 'Mesin';

  @override
  String get equipBodyweight => 'Berat badan';

  @override
  String get equipWeighted => 'Dengan beban';

  @override
  String get equipBand => 'Band';

  @override
  String get equipKettlebell => 'Kettlebell';

  @override
  String get equipRings => 'Ring';

  @override
  String get equipOther => 'Lainnya';

  @override
  String get diffBeginner => 'Pemula';

  @override
  String get diffAdvanced => 'Mahir';

  @override
  String get diffIntermediate => 'Menengah';

  @override
  String get about => 'TENTANG';

  @override
  String version(String v) {
    return 'Versi $v';
  }

  @override
  String get aboutBlurb => 'Dibuat oleh orang yang angkat beban, untuk orang yang angkat beban.';

  @override
  String get freeForever => 'Gratis selamanya';

  @override
  String get freeForeverWhy => 'Tanpa langganan, tanpa iklan, tidak ada yang dikunci di balik pembayaran.';

  @override
  String get fullyOffline => 'Sepenuhnya offline';

  @override
  String get fullyOfflineWhy => 'Tanpa akun, tanpa server. Latihanmu tidak pernah meninggalkan ponsel ini.';

  @override
  String get yoursToTake => 'Datamu milikmu';

  @override
  String get yoursToTakeWhy => 'Ekspor ke CSV kapan pun kamu mau, dan hapus semuanya dengan satu ketukan.';

  @override
  String get whatsInside => 'ISINYA';

  @override
  String exercisesInside(int n) {
    return '$n gerakan';
  }

  @override
  String get exercisesInsideWhy => 'Masing-masing dengan animasi dan petunjuk langkah demi langkah.';

  @override
  String get calculatorsInside => '10 kalkulator';

  @override
  String get calculatorsInsideWhy =>
      '1RM, pelat, IMT, kalori, lemak tubuh, FFMI, pemanasan, beban RPE, serta skor kekuatan DOTS dan Wilks, semuanya dengan rumus yang dipublikasikan.';

  @override
  String get mathInside => 'Hitungan jujur';

  @override
  String get mathInsideWhy =>
      'Volume, rekor, dan runtutan berasal dari set-mu sendiri. Tidak ada yang sekadar hiasan.';

  @override
  String get streakCaps => 'RUNTUTAN';

  @override
  String daysUnit(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'hari');
    return '$_temp0';
  }

  @override
  String get reset => 'ATUR ULANG';

  @override
  String get welcomeKicker => 'SELAMAT DATANG DI';

  @override
  String get welcomeBlurb => 'Semuanya tetap di ponselmu. Tanpa akun, tanpa internet, tanpa bayar.';

  @override
  String get welcomeStart => 'MULAI';

  @override
  String onbStep(int i, int n) {
    return 'LANGKAH $i DARI $n';
  }

  @override
  String get onbNameTitle => 'Kamu mau dipanggil apa?';

  @override
  String get onbNameHint => 'Namamu';

  @override
  String get onbPhotoAdd => 'Tambah foto';

  @override
  String get onbPhotoChange => 'Ganti foto';

  @override
  String get onbPhotoTitle => 'Beri wajah pada profilmu';

  @override
  String get onbPhotoWhy => 'Opsional. Tetap di ponselmu dan bisa kamu ganti kapan saja dari profil.';

  @override
  String get onbPhotoLater => 'NANTI';

  @override
  String get onbNameWhy => 'Hanya dipakai untuk menyapamu. Tidak pernah keluar dari ponsel.';

  @override
  String get onbBodyTitle => 'Beberapa angka';

  @override
  String get onbBodyWhy => 'Dipakai oleh kalkulator. Bisa diubah kapan saja di Pengaturan.';

  @override
  String get onbGoalTitle => 'Seberapa sering kamu latihan?';

  @override
  String get onbGoalWhy => 'Mengatur cincin target mingguanmu. Jujur saja, tidak perlu ambisius.';

  @override
  String perWeek(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sesi seminggu');
    return '$_temp0';
  }

  @override
  String get onbUnitsTitle => 'Kilo atau pon?';

  @override
  String get next => 'BERIKUTNYA';

  @override
  String get back => 'KEMBALI';

  @override
  String get skip2 => 'Lewati';

  @override
  String get madeWithLoveBy => 'DIBUAT DENGAN CINTA OLEH';

  @override
  String get sourceCode => 'KODE SUMBER';

  @override
  String get suggested => 'DISARANKAN';

  @override
  String get results => 'HASIL';

  @override
  String get noMatches => 'Tidak ada gerakan yang cocok dengan pencarian itu.';

  @override
  String get tapToEdit => 'Ketuk pensil untuk memperbaiki entri, atau tempat sampah untuk menghapusnya.';

  @override
  String get editEntry => 'Edit';

  @override
  String get editEntryHint => 'Perbaiki repetisi atau beban set mana pun.';

  @override
  String get removeSet => 'Hapus set';

  @override
  String get continueWorkout => 'LANJUTKAN';

  @override
  String get continueWorkoutBody =>
      'Latihan kembali berlangsung, dengan set yang sudah dicentang. Menyelesaikannya lagi menyimpannya di hari aslinya.';

  @override
  String get addBodyWidget => 'Tambah widget peta otot';

  @override
  String get repsOnly => 'Repetisi saja';

  @override
  String get repsOnlyHint => 'Catat gerakan ini tanpa beban.';

  @override
  String get eachSide => 'Tiap sisi';

  @override
  String get eachSideHint => 'Timer berjalan sekali per sisi dan istirahat dimulai setelah keduanya.';

  @override
  String get useDefaultArt => 'Kembali ke gambar bawaan';

  @override
  String daysShort(int n) {
    return '${n}h';
  }

  @override
  String get focusCard => 'Fokus hari ini';

  @override
  String get autoAdvance => 'Lanjut otomatis';

  @override
  String get keepScreenOn => 'Biarkan layar menyala saat latihan';

  @override
  String get lockWorkout => 'Kunci layar';

  @override
  String get unlockWorkout => 'Buka kunci';

  @override
  String get holdToUnlock => 'Tahan untuk membuka';

  @override
  String get liveChannel => 'Latihan berlangsung';

  @override
  String get liveChannelWhy => 'Menampilkan gerakan, set, dan timer istirahat saat ini selama kamu latihan';

  @override
  String liveSet(int n, int total) {
    return 'Set $n dari $total';
  }

  @override
  String get liveResting => 'Istirahat';

  @override
  String get liveAllDone => 'Semua set selesai';

  @override
  String get autoAdvanceHint => 'Lanjut setelah set terakhir';

  @override
  String get placePlates => 'Pelat dan barbel';

  @override
  String get platesAll => 'Semua tersedia';

  @override
  String platesOwned(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ukuran');
    return '$_temp0';
  }

  @override
  String get platePairs => 'PASANG';

  @override
  String plateAchievable(String w) {
    return 'Paling dekat yang bisa dipasang: $w';
  }

  @override
  String get autoWarmup => 'Mulai dengan set pemanasan';

  @override
  String get autoWarmupHint => 'Menambahkan set bertahap saat latihan dibuka.';

  @override
  String get trainReminder => 'Pengingat latihan';

  @override
  String get trainReminderHint => 'Pengingat di jam ini, hanya di hari rutinitasmu dijadwalkan.';

  @override
  String get reminderExactTime => 'Waktu tepat';

  @override
  String get toastSoundSetting => 'Suara pemberitahuan';

  @override
  String get toastSoundHint => 'Denting lembut di setiap pemberitahuan';

  @override
  String get notifTrainChannel => 'Pengingat latihan';

  @override
  String get notifTrainChannelWhy => 'Pengingat untuk latihan di hari yang kamu rencanakan.';

  @override
  String get notifTrainTitle => 'Waktunya latihan';

  @override
  String get notifTrainBody => 'Rutinitasmu menunggu.';

  @override
  String get planIntro => 'Buatkan aku rutinitas latihan yang hanya memakai gerakan dari daftar ini.';

  @override
  String get planFormat => 'Jawab hanya dengan JSON, dalam bentuk ini:';

  @override
  String get planNothing => 'Tidak ada gerakan di file itu yang cocok dengan pustakamu';

  @override
  String get planFailed => 'File itu bukan rutinitas yang bisa kami baca';

  @override
  String get routineGroup => 'Grup';

  @override
  String get newGroup => 'Grup baru';

  @override
  String get noGroup => 'Tanpa grup';

  @override
  String get groupNameHint => 'Push / Pull / Kaki, 5×5…';

  @override
  String get filters => 'Filter';

  @override
  String get setsPlannedHint =>
      'Pilih berapa set yang kamu mau untuk masing-masing. Latihan dibuka dengan set itu sudah siap.';

  @override
  String get nextTime => 'BERIKUTNYA';

  @override
  String get nextHold => 'beban sama sampai semua repetisi tercapai';

  @override
  String get bgPhoto => 'Fotomu';

  @override
  String get bgPhotoPick => 'Pilih foto';

  @override
  String get bgPhotoChange => 'Ganti foto';

  @override
  String get bgPhotoRemove => 'Hapus foto';

  @override
  String get bgDim => 'SEBERAPA GELAP';

  @override
  String get dimSoft => 'Lembut';

  @override
  String get dimMedium => 'Sedang';

  @override
  String get dimStrong => 'Kuat';

  @override
  String get bgPhotoHint => 'Berada di balik semuanya, digelapkan agar aplikasi tetap terbaca.';

  @override
  String get reminderSmart => 'Pintar';

  @override
  String get reminderFixed => 'Waktu tetap';

  @override
  String get reminderSmartHint =>
      'Memakai hari dan jam kamu benar-benar latihan, dan diam di hari kamu sudah latihan.';

  @override
  String get reminderSmartEmpty => 'Catat beberapa sesi lagi dan ia akan mempelajari harimu.';

  @override
  String habitFocus(String day) {
    return 'yang biasanya kamu latih di hari $day';
  }

  @override
  String get duplicateRoutine => 'Duplikat rutinitas';

  @override
  String copySuffix(String name) {
    return '$name (salinan)';
  }

  @override
  String get saveAsRoutine => 'SIMPAN SEBAGAI RUTINITAS';

  @override
  String get savedAsRoutine => 'Disimpan sebagai rutinitas';

  @override
  String get templates => 'Program siap pakai';

  @override
  String get templatesHint =>
      'Program klasik, disusun dari pustakamu sendiri. Kamu bisa mengubah apa pun setelahnya.';

  @override
  String templateAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rutinitas ditambahkan');
    return '$_temp0';
  }

  @override
  String get tplFullbody => 'Tiga hari seluruh tubuh seminggu. Yang paling cocok untuk mulai.';

  @override
  String get tplPpl => 'Push, pull, dan kaki. Tiga atau enam hari seminggu.';

  @override
  String get tplArnold => 'Dada dan punggung, bahu dan lengan, kaki. Pembagian klasik enam hari.';

  @override
  String get tplUpperlower => 'Tubuh atas dan bawah, empat hari seminggu.';

  @override
  String get tplStronglifts => 'Dua latihan, lima set lima repetisi, bergantian.';

  @override
  String get tplStartingstrength => 'Squat setiap sesi, dua latihan bergantian.';

  @override
  String get tplHome => 'Hanya butuh palang untuk bergantung dan lantai.';

  @override
  String dayCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari');
    return '$_temp0';
  }

  @override
  String get logRpe => 'Catat usaha (RPE)';

  @override
  String get rpeHint => '10 berarti tenaga habis, 8 berarti masih sisa dua repetisi.';

  @override
  String get superset => 'Superset';

  @override
  String get supersetLink => 'Rangkai dengan berikutnya';

  @override
  String get supersetUnlink => 'Lepas dari berikutnya';

  @override
  String get supersetHint => 'Tanpa istirahat di antara gerakan yang dirangkai, langsung ke berikutnya.';

  @override
  String get aiRoutine => 'Rutinitas dengan AI';

  @override
  String get aiIntro =>
      'GymMane tidak pernah berbicara dengan AI. Kamu mengambil daftar gerakanmu, menempelkannya ke asisten apa pun yang sudah kamu pakai, lalu membawa jawabannya kembali. Tidak ada yang keluar dari ponsel dengan sendirinya.';

  @override
  String aiMissing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n nama tidak ada di pustakamu');
    return '$_temp0';
  }

  @override
  String get importApps => 'Aplikasi yang bisa dibaca';

  @override
  String get importOtherCsv => 'CSV lain apa pun dengan tanggal, gerakan, repetisi, dan beban';

  @override
  String get importAskApp => 'Butuh aplikasi lain? Minta saja';

  @override
  String get awardFirstStepName => 'Langkah pertama';

  @override
  String get awardFirstStepLine => 'Selamat datang di GymMane. Yang ini gratis.';

  @override
  String get awardFirstWorkoutName => 'Latihan pertama';

  @override
  String get awardFirstWorkoutLine => 'Yang pertama sudah tercatat. Itu yang paling berat.';

  @override
  String get awardFirstRoutineName => 'Rutinitas pertama';

  @override
  String get awardFirstRoutineLine => 'Kamu punya rencana untuk kembali.';

  @override
  String get awardFirstRecordName => 'Rekor pertama';

  @override
  String get awardFirstRecordLine => 'Kamu mengalahkan angkatan terbaikmu di sebuah gerakan.';

  @override
  String get awardStreak3Name => 'Tiga berturut-turut';

  @override
  String get awardStreak3Line => 'Tiga hari berturut-turut. Beginilah awalnya.';

  @override
  String get awardTonne1Name => 'Satu ton';

  @override
  String get awardTonne1Line => 'Seribu kilo terangkat di semua set-mu.';

  @override
  String get awardSets100Name => 'Seratus set';

  @override
  String get awardSets100Line => 'Seratus set selesai, satu per satu.';

  @override
  String get awardHours10Name => 'Sepuluh jam';

  @override
  String get awardHours10Line => 'Sepuluh jam latihan tercatat.';

  @override
  String get awardWorkouts50Name => 'Lima puluh latihan';

  @override
  String get awardWorkouts50Line => 'Lima puluh sesi sudah kamu lalui.';

  @override
  String get awardHours50Name => 'Lima puluh jam';

  @override
  String get awardHours50Line => 'Lima puluh jam di dalam gym.';

  @override
  String get awardsTitle => 'Medali';

  @override
  String get yearTitle => 'Tahunmu';

  @override
  String get yearBestMonth => 'Bulan terbaik';

  @override
  String get yearMonths => 'bulan';

  @override
  String get awardSpinHint => 'Seret medali untuk memutarnya';

  @override
  String get awardUnlocked => 'Pencapaian baru terbuka';

  @override
  String get awardNice => 'Keren!';

  @override
  String get awardSaveImage => 'Simpan gambar';

  @override
  String get awardSaved => 'Tersimpan di galerimu';

  @override
  String get awardStreak7Name => 'Tujuh hari';

  @override
  String get awardStreak7Line => 'Seminggu penuh tanpa absen sehari pun.';

  @override
  String get awardStreak30Name => 'Tiga puluh hari';

  @override
  String get awardStreak30Line => 'Sebulan berturut-turut. Sekarang ini sudah kebiasaan.';

  @override
  String get awardWorkouts100Name => 'Seratus latihan';

  @override
  String get awardWorkouts100Line => 'Seratus sesi tercatat, dari awal sampai akhir.';

  @override
  String get awardTonnes100Name => 'Seratus ton';

  @override
  String get awardTonnes100Line => 'Semua yang pernah kamu angkat berjumlah 100.000 kg.';

  @override
  String get awardSets1000Name => 'Seribu set';

  @override
  String get awardSets1000Line => 'Satu set demi satu set, seribu jumlahnya.';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Edit profil';

  @override
  String get pickBadge => 'Lencana';

  @override
  String get statWorkouts => 'Latihan';

  @override
  String get statTrained => 'Dilatih';

  @override
  String get statSets => 'Set';

  @override
  String get statLifted => 'Diangkat';

  @override
  String get statStreak => 'Runtutan';

  @override
  String get statDays => 'hari';

  @override
  String get unitHours => 'j';

  @override
  String get unitDays => 'hari';

  @override
  String get snapshots => 'Foto';

  @override
  String get snapNow => 'Ambil satu';

  @override
  String get addCover => 'Tambah sampul';

  @override
  String get addTodayWidget => 'Hari ini sudah atau belum';

  @override
  String get photosCard => 'Foto-fotomu';

  @override
  String get handleLabel => 'Nama pengguna';

  @override
  String get setupTitle => 'Isi ini dan sisa halaman terisi sendiri';

  @override
  String get setupHint =>
      'Setiap angka di sini berasal dari yang kamu catat. Tidak ada yang dikirim ke mana pun.';

  @override
  String get setupWorkout => 'Catat latihan pertamamu';

  @override
  String get setupWeight => 'Tulis berat badanmu';

  @override
  String get setupMeasures => 'Ukur tubuhmu';

  @override
  String get setupPhoto => 'Ambil foto progres pertamamu';

  @override
  String get progressTitle => 'Progres';

  @override
  String get tileVolume30 => 'Volume · 30h';

  @override
  String get tileAddWeight => 'Tambahkan punyamu';

  @override
  String get heatToneTitle => 'Warna panas';

  @override
  String get heatToneHint => 'Hanya mengubah cara kisi dan tubuh diwarnai.';

  @override
  String get thisWeekTitle => 'Minggu ini';

  @override
  String get momentsEmptyTitle => 'Belum ada apa-apa di sini';

  @override
  String get deletePhotoTitle => 'Hapus foto ini?';

  @override
  String get deletePhotoBody => 'Foto ini hilang untuk selamanya.';

  @override
  String get awardsEarned => 'Diraih';

  @override
  String get awardsLocked => 'Terkunci';

  @override
  String get awardStreak100Name => 'Seratus hari';

  @override
  String get awardWorkouts10Name => 'Sepuluh latihan';

  @override
  String get awardWorkouts10Line => 'Sepuluh yang pertama adalah penentunya.';

  @override
  String get awardWorkouts365Name => 'Tiga ratus enam puluh lima';

  @override
  String get awardWorkouts365Line => 'Satu latihan untuk setiap hari dalam setahun, dicatat satu per satu.';

  @override
  String get awardTonnes10Name => 'Sepuluh ton';

  @override
  String get awardTonnes10Line => 'Sepuluh ribu kilo sudah melewati tanganmu.';

  @override
  String get awardHours100Name => 'Seratus jam';

  @override
  String get awardHours100Line => 'Seratus jam di bawah barbel, stopwatch di tangan.';

  @override
  String awardWonOn(String date) {
    return 'Diraih pada $date';
  }

  @override
  String badgeName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'gold': 'Emas',
      'blue': 'Biru',
      'green': 'Hijau',
      'other': 'Lencana',
    });
    return '$_temp0';
  }

  @override
  String memberSince(String date) {
    return 'Sejak $date';
  }

  @override
  String levelShort(int n) {
    return 'Level $n';
  }

  @override
  String levelToNext(int n, int next) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n latihan lagi ke level $next');
    return '$_temp0';
  }

  @override
  String heightCm(int n) {
    return '$n cm';
  }

  @override
  String heatToneName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'ember': 'Bara',
      'green': 'Hijau',
      'blue': 'Biru',
      'mono': 'Abu-abu',
      'other': 'Warna',
    });
    return '$_temp0';
  }

  @override
  String setsThisWeek(int n) {
    return '$n set';
  }

  @override
  String weekOfGoal(int n, int goal) {
    return '$n dari $goal minggu ini';
  }

  @override
  String momentCount(int n) {
    return '$n foto';
  }

  @override
  String photosSelected(int n) {
    return '$n dipilih';
  }

  @override
  String deletePhotosTitle(int n) {
    return 'Hapus $n foto?';
  }

  @override
  String get momentsEmptyHint =>
      'Potret gym, papan tulis, susunan pelat. Apa pun yang ingin kamu ingat. Semua tetap di ponsel dan hanya kamu yang melihatnya.';

  @override
  String get awardStreak100Line => 'Seratus hari berturut-turut. Ini bukan lagi motivasi, ini sudah dirimu.';

  @override
  String get coverLabel => 'SAMPUL';

  @override
  String get removeCover => 'Hapus sampul';

  @override
  String get startTitle => 'Mulai latihan';

  @override
  String get logTitle => 'Catat latihan';

  @override
  String get logHint => 'Tanpa timer, cukup isi apa yang kamu lakukan.';

  @override
  String get orStartFrom => 'Atau mulai dari';

  @override
  String get pickExercisesOption => 'Pilih gerakan';

  @override
  String get chooseFocusOption => 'Pilih fokus';

  @override
  String get plannedRoutine => 'DIRENCANAKAN';

  @override
  String get logWorkoutAction => 'CATAT LATIHAN';

  @override
  String get logging => 'MENCATAT';

  @override
  String get placesLabel => 'Tempatku';

  @override
  String get undo => 'Urungkan';

  @override
  String get deleteSet => 'Hapus set';

  @override
  String get setDeleted => 'Set dihapus';

  @override
  String get removeWarmup => 'Hapus pemanasan';

  @override
  String get addWeightAction => 'Tambah beban';

  @override
  String get workoutOverview => 'Latihan ini';

  @override
  String get allExercisesShort => 'Semua';

  @override
  String setsDoneOf(int done, int total) {
    return '$done/$total set';
  }

  @override
  String get nowLabel => 'Sekarang';

  @override
  String get deleteWorkout => 'Hapus latihan';

  @override
  String get deleteWorkoutBody => 'Latihan ini dan semua set-nya akan dihapus dari riwayatmu.';

  @override
  String get themeAuto => 'Otomatis';

  @override
  String get themeAutoHint => 'Mengikuti ponselmu';

  @override
  String get demoSizeTitle => 'Demo gerakan saat latihan';

  @override
  String get demoLarge => 'Besar';

  @override
  String get demoSmall => 'Kecil';

  @override
  String get demoOff => 'Tersembunyi';

  @override
  String get demoLoopTitle => 'Animasi demo';

  @override
  String get demoLoopAlways => 'Berulang';

  @override
  String get demoLoopShort => '10 detik';

  @override
  String get demoLoopHint =>
      'Diputar sekitar 10 detik lalu berhenti di posisi awal. Ketuk demo untuk menontonnya lagi.';

  @override
  String get alarmStyleTitle => 'Saat istirahat selesai';

  @override
  String get alarmStyleLoud => 'Selalu berbunyi';

  @override
  String get alarmStyleQuiet => 'Ikuti mode senyap';

  @override
  String get alarmStyleVibrate => 'Getar saja';

  @override
  String get alarmStyleHint =>
      'Selalu berbunyi memakai volume alarm, bahkan saat senyap. Ikuti mode senyap memakai volume notifikasi dan hanya bergetar saat ponselmu dibisukan.';

  @override
  String get suggestedPicks => 'Disarankan untukmu';

  @override
  String get moreOptions => 'Opsi lainnya';

  @override
  String get suggestInWorkouts => 'Sarankan di latihan cepat';

  @override
  String get suggestInWorkoutsHint =>
      'Mati berarti tidak masuk pilihan yang dibuat untukmu. Kamu tetap bisa menambahkannya manual.';

  @override
  String get onbPlaceTitle => 'Di mana kamu latihan?';

  @override
  String get onbPlaceWhy =>
      'Pilih semua tempat kamu latihan. Kami hanya akan menyarankan yang bisa kamu lakukan di masing-masing.';

  @override
  String get onbPlaceGear => 'Apa yang ada di sana?';

  @override
  String distanceCol(String unit) {
    return 'JARAK ($unit)';
  }

  @override
  String get timeCol => 'WAKTU';

  @override
  String get timePerSideCol => 'WAKTU / SISI';

  @override
  String get timeMinutesTitle => 'Waktu (menit)';

  @override
  String get timeSecondsTitle => 'Waktu (detik)';

  @override
  String distanceTitle(String unit) {
    return 'Jarak ($unit)';
  }

  @override
  String get holdLabel => 'Tahan';

  @override
  String get stopLabel => 'Berhenti';

  @override
  String startHold(String time) {
    return 'Mulai · $time';
  }

  @override
  String get exerciseTypeLabel => 'Catat berdasarkan';

  @override
  String get typeReps => 'Repetisi & beban';

  @override
  String get typeTime => 'Waktu';

  @override
  String get typeCardio => 'Jarak & waktu';

  @override
  String get exerciseTypeHint =>
      'Kardio seperti lari atau renang mencatat jarak dan waktu. Gerakan tahan seperti plank mencatat waktu.';

  @override
  String get howToLabel => 'Cara melakukan (opsional)';

  @override
  String get howToHint => 'Satu langkah per baris';

  @override
  String get editExercise => 'Edit gerakan';

  @override
  String get saveChanges => 'Simpan perubahan';

  @override
  String get noStepsYet => 'Belum ada langkah. Tulis sendiri supaya kamu ingat caranya.';

  @override
  String get addSteps => 'Tulis langkahnya';

  @override
  String get setTypeRestPause => 'Rest-pause';

  @override
  String get setTypeNormalInfo => 'Set biasa. Dihitung ke volume dan rekormu.';

  @override
  String get setTypeWarmupInfo => 'Set ringan untuk bersiap. Tidak dihitung ke volume atau rekor.';

  @override
  String get setTypeDropInfo => 'Langsung setelah satu set, turunkan beban dan lanjutkan tanpa istirahat.';

  @override
  String get setTypeFailureInfo =>
      'Terus sampai kamu tidak bisa melakukan satu repetisi bersih lagi. Catat repetisi yang benar-benar kamu lakukan.';

  @override
  String get setTypeRestPauseInfo =>
      'Istirahat 10 sampai 20 detik setelah set, lalu peras beberapa repetisi lagi.';

  @override
  String get planFormatNotes =>
      'Pakai nama gerakan persis seperti di daftar. \"sets\", \"reps\" (angka atau rentang seperti \"8-12\"), \"weight\" (dalam satuan yang diberikan), \"rest\" dalam detik, dan \"days\" bersifat opsional. Untuk gerakan yang ditandai kardio atau waktu di daftar, pakai \"time\" (detik, atau seperti \"30:00\") dan \"distance\" (dalam km) sebagai ganti \"reps\"; untuk memberi tiap set nilainya sendiri, tuliskan di \"plan\", satu entri per set dengan \"reps\" dan \"weight\"-nya sendiri (tambahkan \"type\": \"warmup\" untuk set pemanasan). \"superset\": true merangkai gerakan dengan yang berikutnya. Untuk beberapa minggu, kelompokkan rutinitas di dalam \"weeks\" seperti contoh kedua.';

  @override
  String get planSets => 'Rencanakan set';

  @override
  String get planSetsHint =>
      'Pilih jenis, repetisi, dan beban tiap set. Biarkan beban di Otomatis untuk mulai dari sesi terakhirmu.';

  @override
  String get planHintReps => 'Pilih jenis dan repetisi tiap set. Otomatis mulai dari sesi terakhirmu.';

  @override
  String get planHintTime => 'Pilih jenis dan waktu tiap set. Otomatis mulai dari sesi terakhirmu.';

  @override
  String get planHintTimeWeight =>
      'Pilih jenis, waktu, dan beban tiap set. Otomatis mulai dari sesi terakhirmu.';

  @override
  String get planHintCardio => 'Pilih jarak dan waktu tiap set. Otomatis mulai dari sesi terakhirmu.';

  @override
  String get timeOnly => 'Waktu saja';

  @override
  String get autoValue => 'Otomatis';

  @override
  String get clearPlan => 'Hapus rencana';

  @override
  String get shareRoutine => 'Bagikan rutinitas';

  @override
  String get shareWeek => 'Bagikan mingguku';

  @override
  String get shareWeekHint => 'Semua rutinitasmu dan hari masing-masing.';

  @override
  String shareMessage(String name) {
    return '$name: buka file ini dengan GymMane untuk menambahkannya.';
  }

  @override
  String get importRoutines => 'Impor rutinitas';

  @override
  String get importPasteHint =>
      'Tempel rutinitas di sini: yang dibagikan dari GymMane, jawaban AI, JSON, atau CSV.';

  @override
  String get pasteAction => 'Tempel';

  @override
  String routineCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rutinitas');
    return '$_temp0';
  }

  @override
  String get useTheirSchedule => 'Pakai juga jadwal mingguannya';

  @override
  String get useTheirScheduleHint => 'Hari-hari yang dibawanya menggantikan rencanamu di hari itu.';

  @override
  String get addToMyRoutines => 'Tambahkan ke rutinitasku';

  @override
  String routinesAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rutinitas ditambahkan');
    return '$_temp0';
  }

  @override
  String get nothingToImport => 'Tidak ada yang bisa diimpor GymMane di sini';

  @override
  String get aiStepCopy => 'Salin permintaannya. Isinya daftar gerakanmu dan format yang dibaca GymMane.';

  @override
  String get aiStepAsk =>
      'Tempel ke AI mana pun dan sebutkan maumu: berapa hari seminggu, tujuan, berapa minggu.';

  @override
  String get aiStepPaste => 'Tempel jawabannya di bawah dan impor. Tidak perlu file.';

  @override
  String get copyForAi => 'Salin untuk AI';

  @override
  String get copiedDone => 'Disalin';

  @override
  String get aiPasteHint => 'Tempel jawaban AI di sini';

  @override
  String get importAction => 'Impor';

  @override
  String get showFormat => 'Lihat formatnya';

  @override
  String get shareAsFile => 'Bagikan sebagai file';

  @override
  String get recoveryTab => 'Pemulihan';

  @override
  String recoveryOverall(int pct) {
    return 'Tubuh $pct% pulih';
  }

  @override
  String get recoveryAllFresh => 'Semuanya sudah pulih. Hari yang bagus untuk melatih apa saja.';

  @override
  String recoveryStill(String muscles) {
    return 'Masih pulih: $muscles';
  }

  @override
  String get recoveryTired => 'Lelah';

  @override
  String get recoveryFresh => 'Segar';

  @override
  String get recoveryHint =>
      'Ketuk otot untuk melihat seberapa pulih. Set terbaru lebih berpengaruh, dan yang lebih berat (menurut RPE) lebih lagi.';

  @override
  String recoveryPct(int pct) {
    return '$pct% pulih';
  }

  @override
  String readyInHours(int h) {
    return 'siap dalam ~$h j';
  }

  @override
  String get tplAbcd => 'Empat hari: dada dan trisep, punggung dan bisep, kaki, bahu dan perut.';

  @override
  String get tplAbcde => 'Lima hari, satu kelompok otot per hari: dada, punggung, kaki, bahu, lengan.';

  @override
  String get elapsedCaps => 'BERLALU';

  @override
  String get tapToChange => 'Ketuk untuk mengubah';

  @override
  String get swipeToSkipHint => 'Geser timer ke samping untuk melewati istirahat.';

  @override
  String get screenLocked => 'Layar terkunci';

  @override
  String get lockedHint => 'Tekan dan tahan sidik jari di atas untuk membuka';

  @override
  String get liveDoneSet => 'Set selesai';

  @override
  String get liveSkipRest => 'Lewati istirahat';

  @override
  String get livePause => 'Jeda';

  @override
  String get liveResume => 'Lanjutkan';

  @override
  String get liveNext => 'Berikutnya';

  @override
  String liveUpNext(String name) {
    return 'Berikutnya: $name';
  }

  @override
  String get stickerOpen => 'Bagikan di atas foto';

  @override
  String get stickerNoPhoto => 'Tanpa foto';

  @override
  String get stickerWorkout => 'Latihan';

  @override
  String get stickerStreak => 'Runtutan';

  @override
  String get stickerDate => 'Tanggal';

  @override
  String get stickerHint => 'Seret untuk memindahkan, cubit untuk mengubah ukuran atau memutarnya';

  @override
  String get stickerSaved => 'Tersimpan di galerimu';

  @override
  String get stickerWeek => 'Minggu ini';

  @override
  String get getReady => 'Bersiap';

  @override
  String sideOfTwo(String n) {
    return 'Sisi $n dari 2';
  }

  @override
  String get switchSides => 'Ganti sisi';

  @override
  String get stickerGallery => 'Galeri';

  @override
  String get stickerCamera => 'Kamera';

  @override
  String get shareIntroTitle => 'Bagikan rutinitas ini';

  @override
  String get shareIntroBody =>
      'Kirim ke pasangan, teman, atau keluargamu. Mereka mendapat file kecil yang terbuka di GymMane dan menambahkannya dengan satu ketukan, lengkap dengan set dan bebannya.';

  @override
  String get removedFromRoutine => 'Dihapus dari rutinitas';

  @override
  String get radarTitle => '30 hari terakhir';

  @override
  String get radarHint => 'Lihat area mana yang perlu lebih banyak latihan';

  @override
  String get radarEmpty => 'Latihan beberapa hari untuk melihat keseimbanganmu';

  @override
  String get radarBalanced => 'Keseimbangan bagus sejauh ini';

  @override
  String radarFocus(String list) {
    return 'Perlu lebih banyak: $list';
  }

  @override
  String get countdownReady => 'Bersiap';

  @override
  String get countdownSkip => 'Ketuk untuk mulai sekarang';

  @override
  String get countdownSetting => 'Hitung mundur sebelum mulai';

  @override
  String get effortSetting => 'Catat usaha per set';

  @override
  String get effortHint =>
      'RPE: 10 berarti tenaga habis, 8 berarti sisa dua repetisi. RIR menghitung repetisi yang masih tersisa. Jika set punya nilai ini, perkiraan 1RM memakai tabel RPE.';

  @override
  String get rirHint => '0 berarti tenaga habis, 2 berarti sisa dua repetisi.';

  @override
  String get addWeekWidget => 'Tambah widget minggu';

  @override
  String get gamificationSetting => 'Medali dan level';

  @override
  String repCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n repetisi');
    return '$_temp0';
  }

  @override
  String get prBestSet => 'Set terbaik';

  @override
  String get weekStartSetting => 'Minggu dimulai pada';

  @override
  String get stepOutOfWorkout => 'Jeda dan keluar';

  @override
  String get saveToRoutine => 'SIMPAN PERUBAHAN KE RUTINITAS';

  @override
  String get routineUpdated => 'Rutinitas diperbarui';

  @override
  String saveChangesTitle(String name) {
    return 'Simpan perubahan ke $name?';
  }

  @override
  String get saveChangesBody => 'Lain kali kamu memulainya, rutinitas akan memuat perubahan ini.';

  @override
  String get routineOrderChanged => 'Urutan gerakan baru';

  @override
  String get mineOnly => 'Buatanmu';

  @override
  String createNamed(String name) {
    return 'Tidak ada? Buat “$name”';
  }

  @override
  String get orStartWith => 'Atau mulai dengan';

  @override
  String get warmupFocus => 'Pemanasan';

  @override
  String get warmupFocusHint => 'Mobilitas dan aktivasi, dengan atau tanpa alat';

  @override
  String get cardioFocus => 'Kardio';

  @override
  String get cardioFocusHint => 'Lari, sepeda, dayung, atau lompat tali, berdasarkan jarak dan waktu';

  @override
  String get homeRecommended => 'Disarankan di beranda';

  @override
  String get homeRoutines => 'Rutinitas di beranda';

  @override
  String get homeRoutinesHint => 'Yang terakhir dilakukan lebih dulu';

  @override
  String get homeWeekStats => 'Minggu ini di beranda';

  @override
  String get homeWeekStatsHint => 'Volume, set, dan PR minggu ini';

  @override
  String get stepsSetting => 'Langkah dari Health Connect';

  @override
  String get stepsSettingHint => 'Langkah hari ini di Beranda';

  @override
  String get stepsToday => 'Langkah hari ini';

  @override
  String stepsOfGoal(String goal) {
    return 'dari $goal';
  }

  @override
  String stepsTodayCount(String count) {
    return '$count langkah hari ini';
  }

  @override
  String get stepsGoal => 'Target langkah harian';

  @override
  String get stepsNoAccess => 'Tidak ada akses ke langkahmu';

  @override
  String get stepsGrant => 'Ketuk untuk mengizinkannya di Health Connect';

  @override
  String get stepsInfoRead =>
      'Hanya membaca jumlah langkahmu. Tidak pernah membaca yang lain atau menulis ke Health Connect.';

  @override
  String get stepsInfoLocal => 'Langkahmu tetap di ponselmu. GymMane tidak pernah terhubung ke internet.';

  @override
  String get stepsInfoOff => 'Matikan kapan saja di Pengaturan atau di Health Connect.';

  @override
  String get stepsManage => 'Kelola izin';

  @override
  String get routineDoneToday => 'Selesai hari ini · kerja bagus';

  @override
  String get trainAgain => 'Latihan lagi';

  @override
  String lastDoneAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n hari lalu',
      one: 'Selesai kemarin',
      zero: 'Selesai hari ini',
    );
    return '$_temp0';
  }

  @override
  String get archivedFilter => 'Diarsipkan';

  @override
  String get archiveExercise => 'Arsipkan gerakan';

  @override
  String get restoreExercise => 'Pulihkan';

  @override
  String get archivedToast => 'Gerakan diarsipkan';

  @override
  String get archivedToastHint => 'Temukan di Gerakan › Diarsipkan';

  @override
  String get archivedBanner => 'Diarsipkan. Tidak muncul di daftar dan saran; riwayatmu tetap disimpan.';

  @override
  String get videoMarksHint => 'Jeda di sebuah langkah dan ketuk pin untuk melompat ke sana lain kali.';

  @override
  String get videoMarkHere => 'Tandai langkah ini di sini';

  @override
  String get sectionGeneral => 'Umum';

  @override
  String get sectionTraining => 'Latihan';

  @override
  String get sectionAlerts => 'Pengingat & alarm';

  @override
  String get sectionHome => 'Beranda';

  @override
  String get sectionWidgets => 'Widget';

  @override
  String get sectionData => 'Data & cadangan';

  @override
  String get multiPlanSetting => 'Beberapa rutinitas sehari';

  @override
  String get multiPlanHint =>
      'Ketuk setiap rutinitas untuk hari ini. Urutannya sesuai urutan kamu menambahkannya.';

  @override
  String routineOfDay(int n, int total) {
    return '$n dari $total hari ini';
  }

  @override
  String get nextToday => 'Berikutnya hari ini';

  @override
  String get planAboutMe => 'Tentang aku:';

  @override
  String planBody(String sex, int age, String height, String weight) {
    return '$sex, $age tahun, tinggi $height, $weight.';
  }

  @override
  String planDays(int n) {
    return 'Aku ingin latihan $n hari seminggu.';
  }

  @override
  String get planNoHistory =>
      'Belum ada latihan tercatat: anggap aku pemula dan jaga volume serta beban tetap konservatif.';

  @override
  String planHistory(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n latihan tercatat dalam 30 hari terakhir.',
    );
    return '$_temp0';
  }

  @override
  String get planBestLifts => 'Set terbaik baru-baru ini';

  @override
  String get planAskFirst =>
      'Kalau kamu tidak tahu tujuanku (kekuatan, otot, turun lemak, atau kebugaran umum) atau berapa lama setiap sesi boleh berlangsung, tanyakan dulu dalam satu pesan singkat. Setelah itu, jawab hanya dengan JSON.';

  @override
  String get backToTop => 'Kembali ke atas';

  @override
  String get deleteExerciseTitle => 'Hapus gerakan ini?';

  @override
  String deleteExerciseBody(String name) {
    return '\"$name\" akan dihapus dari pustaka dan rutinitasmu. Set lamamu tetap disimpan.';
  }

  @override
  String get exportForStravaHint =>
      'Unggah lewat browser di strava.com/upload/select (aplikasi Strava tidak bisa mengimpor file). Akan muncul sebagai Weight Training dengan set-mu.';

  @override
  String get manualStartTime => 'Waktu mulai';

  @override
  String get manualDuration => 'Durasi';

  @override
  String get manualDurationUnset => 'Tambah durasi';

  @override
  String get stravaRow => 'Ekspor ke Strava (beta)';

  @override
  String get stravaBeta => 'BETA';

  @override
  String get stravaIntro =>
      'Pilih latihan untuk dibawa ke Strava. Kamu mendapat file .fit: unggah lewat browser di strava.com/upload/select dan akan muncul sebagai Weight Training dengan set-mu.';

  @override
  String get stravaEmpty => 'Belum ada latihan untuk diekspor.';

  @override
  String get tapToPause => 'Ketuk untuk jeda';

  @override
  String get holdPausedHint => 'Dijeda · ketuk untuk lanjut';

  @override
  String get finishHoldNow => 'Selesaikan set sekarang';

  @override
  String get barWeightExercise => 'Berat barbel atau sled';

  @override
  String get barWeightHint => 'Dipakai oleh kalkulator pelat';

  @override
  String get barWeightCustom => 'Milikmu · ketuk untuk reset';

  @override
  String get groupRename => 'Ganti nama grup';

  @override
  String get groupUngroup => 'Hapus grup, simpan rutinitas';

  @override
  String get groupDeleteAll => 'Hapus grup dan rutinitasnya';

  @override
  String groupDeleteTitle(String name) {
    return 'Hapus “$name”?';
  }

  @override
  String groupDeleteBody(String count) {
    return '$count akan dihapus. Riwayat latihanmu tetap disimpan.';
  }

  @override
  String get tplRr =>
      'Klasik r/bodyweightfitness: seluruh tubuh tiga hari seminggu. Naik satu tingkat saat sudah terasa mudah.';

  @override
  String get levelUpKicker => 'LANGKAH BERIKUTNYA';

  @override
  String levelUpBody(int reps, String name) {
    return '3×$reps di $name dua latihan berturut-turut. Siap untuk langkah berikutnya?';
  }

  @override
  String levelUpSwap(String routine) {
    return 'Ganti di $routine';
  }

  @override
  String get levelUpSee => 'Lihat caranya';

  @override
  String get levelUpLater => 'Jangan sekarang';

  @override
  String get levelUpStay => 'Tetap yang ini';

  @override
  String levelUpSwapped(String name, String routine) {
    return '$name sekarang ada di $routine';
  }

  @override
  String get levelUpStayed => 'Tidak ada lagi saran naik tingkat untuk yang ini';

  @override
  String get levelHintsSetting => 'Sarankan langkah berikutnya';

  @override
  String get heatmapLabelsSetting => 'Hari dan bulan di peta aktivitas';

  @override
  String get rmPercent => 'PERSENTASE';

  @override
  String rmAtPercent(String pct) {
    return '$pct dari maksimalmu';
  }

  @override
  String get copyWorkout => 'Salin sebagai teks';

  @override
  String get goalSet => 'Pasang target';

  @override
  String get goalTargetReps => 'TARGET REPETISI';

  @override
  String goalToGo(String value) {
    return '$value lagi';
  }

  @override
  String get goalReached => 'Target tercapai';

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari lagi');
    return '$_temp0';
  }

  @override
  String get goalOverdue => 'Lewat tanggal';

  @override
  String get goalDeadline => 'TENGGAT';

  @override
  String get goalNoDeadline => 'Tanpa tenggat';

  @override
  String get goalRemove => 'Hapus target';

  @override
  String get exerciseNameMissing => 'Beri nama';

  @override
  String get aliasesLabel => 'Juga disebut (opsional)';

  @override
  String get aliasesHint => 'Nama lain, dipisahkan koma';

  @override
  String alsoCalled(String names) {
    return 'Juga: $names';
  }

  @override
  String get addToRoutine => 'Tambahkan ke rutinitas';

  @override
  String inRoutines(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Di $n rutinitas',
      zero: 'Belum ada di rutinitas mana pun',
    );
    return '$_temp0';
  }

  @override
  String get alreadyInRoutine => 'Sudah ada di dalamnya';

  @override
  String get restInRoutine => 'Istirahat di rutinitas ini';

  @override
  String get restInRoutineHint => 'Sama dengan gerakannya';

  @override
  String get restInRoutineReset => 'Hanya di sini · ketuk untuk batal';

  @override
  String get swapExercise => 'Tukar gerakan';

  @override
  String get swapShort => 'Tukar';

  @override
  String swapHint(String name) {
    return 'Sebagai ganti $name, hanya untuk hari ini. Setelah selesai, kamu bisa menyimpannya di rutinitas.';
  }

  @override
  String get swapKeepsDone => 'Set yang sudah kamu lakukan tetap tercatat; gerakan baru melanjutkan sisanya.';

  @override
  String swapSameMuscle(String muscle) {
    return 'Otot yang sama · $muscle';
  }

  @override
  String get swapDoneBefore => 'Pernah dilakukan';

  @override
  String get multiPlanSettingHint => 'Lebih dari satu rutinitas di hari yang sama';

  @override
  String get levelHintsHint => 'Menyarankan versi yang lebih sulit';

  @override
  String get focusCardHint => 'Rutinitas hari ini, di atas Beranda';

  @override
  String get gamificationHint => 'Medali, level, dan perayaan';

  @override
  String get exerciseSettings => 'Pengaturan gerakan ini';

  @override
  String get placeActiveNow => 'Kamu di sini';

  @override
  String get placeTapToUse => 'ketuk untuk latihan di sini';

  @override
  String get intervalDays => 'hari';

  @override
  String goalDaysShort(int done, int target) {
    return '$done/$target hari';
  }

  @override
  String get toolNameRpe => 'Beban RPE';

  @override
  String get toolTitleRpe => 'Beban menurut RPE';

  @override
  String get toolDescRpe => 'Beban untuk usaha yang kamu inginkan';

  @override
  String get toolNameDots => 'Tingkat kekuatan';

  @override
  String get toolTitleDots => 'Tingkat kekuatan (DOTS)';

  @override
  String get toolDescDots => 'Kekuatanmu dibanding berat badanmu';

  @override
  String rpeResultHint(int reps, String rpe) {
    return 'Untuk $reps repetisi di RPE $rpe';
  }

  @override
  String get rpeYourSet => 'Set yang baru kamu lakukan';

  @override
  String get rpeGoal => 'Yang ingin kamu lakukan';

  @override
  String rpeOneRmLine(String value) {
    return 'Perkiraan 1RM: $value';
  }

  @override
  String get rpeExplain => 'RPE 10 berarti tidak bisa satu lagi; 8 berarti masih sisa dua.';

  @override
  String get dotsBestLifts => 'Angkatan terbaikmu';

  @override
  String get dotsSquat => 'SQUAT';

  @override
  String get dotsBench => 'BENCH PRESS';

  @override
  String get dotsDeadlift => 'DEADLIFT';

  @override
  String dotsTotalLine(String value) {
    return 'Total: $value';
  }

  @override
  String get dotsExplain =>
      'Membandingkan kekuatanmu dengan siapa pun, berapa pun berat badannya. Pakai repetisi tunggal terbaikmu, atau perkiraan 1RM.';

  @override
  String get dotsLevel0 => 'Pemula';

  @override
  String get dotsLevel1 => 'Menengah';

  @override
  String get dotsLevel2 => 'Mahir';

  @override
  String get dotsLevel3 => 'Sangat mahir';

  @override
  String get dotsLevel4 => 'Elit';

  @override
  String get toolNameWilks => 'Wilks';

  @override
  String get toolTitleWilks => 'Skor Wilks';

  @override
  String get toolDescWilks => 'Skor powerlifting klasik';

  @override
  String get wilksExplain =>
      'Rumus powerlifting klasik. DOTS menggantikannya pada 2020, tapi banyak kompetisi dan peringkat masih memakainya.';

  @override
  String get toolNameFfmi => 'FFMI';

  @override
  String get toolTitleFfmi => 'Indeks massa bebas lemak';

  @override
  String get toolDescFfmi => 'Seberapa banyak otot untuk tinggimu';

  @override
  String get ffmiBodyFat => 'LEMAK TUBUH';

  @override
  String ffmiLeanLine(String value) {
    return 'Massa tanpa lemak: $value';
  }

  @override
  String get ffmiExplain =>
      'Seperti IMT, tapi tanpa lemak: hanya menghitung massa tanpa lemakmu. Disesuaikan dengan tinggi supaya orang tinggi dan pendek bisa dibandingkan dengan adil.';

  @override
  String get ffmiLevel0 => 'Di bawah rata-rata';

  @override
  String get ffmiLevel1 => 'Rata-rata';

  @override
  String get ffmiLevel2 => 'Di atas rata-rata';

  @override
  String get ffmiLevel3 => 'Sangat baik';

  @override
  String get ffmiLevel4 => 'Luar biasa';

  @override
  String get rpeEffortLabel => 'Usaha (RPE)';

  @override
  String get restRowHint => 'Antarset, kecuali gerakan punya pengaturan sendiri';

  @override
  String get effortRowHint => 'Catat RPE atau RIR di setiap set';

  @override
  String get countdownHint => '3, 2, 1 sebelum set pertama';

  @override
  String get keepScreenOnHint => 'Layar tetap menyala selama latihan';

  @override
  String get demoSizeRowHint => 'Gambar gerakan selama latihan';

  @override
  String get demoLoopRowHint => 'Apakah animasinya berulang atau berhenti';

  @override
  String get trainReminderRowHint => 'Pengingat di hari-hari latihanmu';

  @override
  String get alarmSoundRowHint => 'Yang diputar saat istirahat selesai';

  @override
  String get alarmStyleRowHint => 'Apakah berbunyi di mode senyap';

  @override
  String get recommendedRowHint => 'Gerakan yang kami sarankan di Beranda';

  @override
  String get weightStepSetting => 'Langkah beban';

  @override
  String get weightStepHint => 'Yang ditambahkan tombol − dan +';

  @override
  String get prBestWorkout => 'Latihan terbaik';

  @override
  String get mergeExercise => 'Gabungkan';

  @override
  String mergeExerciseInto(String name) {
    return 'Gabungkan $name ke…';
  }

  @override
  String get mergeExerciseTitle => 'Gabungkan gerakan?';

  @override
  String mergeExerciseBody(String from, String to) {
    return 'Seluruh riwayat \"$from\" pindah ke \"$to\". \"$from\" tetap ada di pustakamu. Ini tidak bisa dibatalkan.';
  }

  @override
  String get mergedToast => 'Riwayat digabungkan';

  @override
  String get nutrition => 'Nutrisi';

  @override
  String get nutritionHomeEmpty => 'Air, protein, dan kalori';

  @override
  String nutritionHomeDetail(String energy, int protein) {
    return '$energy · $protein g protein';
  }

  @override
  String get nutritionToday => 'Hari ini';

  @override
  String get nutritionYesterday => 'Kemarin';

  @override
  String get nutritionGoals => 'Target harian';

  @override
  String get kcalLabel => 'KALORI';

  @override
  String get kcalOver => 'lebih';

  @override
  String get waterLabel => 'AIR';

  @override
  String get waterDone => 'Target tercapai';

  @override
  String get waterCustom => 'Jumlah lain';

  @override
  String get glassSize => 'Ukuran gelas';

  @override
  String get supplementsLabel => 'SUPLEMEN';

  @override
  String get supplementsEmpty => 'Ketuk salah satu untuk menambahkannya, atau + untuk punyamu sendiri.';

  @override
  String get addSupplement => 'Suplemen baru';

  @override
  String get supplementNameHint => 'Kreatin, vitamin D…';

  @override
  String removeSupplementTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get removeSupplementBody => 'Hari-hari yang kamu tandai sebagai diminum ikut terhapus.';

  @override
  String get suppCreatine => 'Kreatin';

  @override
  String get suppVitaminD => 'Vitamin D';

  @override
  String get suppOmega3 => 'Omega-3';

  @override
  String get suppMagnesium => 'Magnesium';

  @override
  String get suppMultivitamin => 'Multivitamin';

  @override
  String get suppCaffeine => 'Kafein';

  @override
  String get myFoods => 'Makananku';

  @override
  String get newFood => 'Makanan baru';

  @override
  String get editFood => 'Edit makanan';

  @override
  String get foodNameHint => 'Whey protein, oat, roti…';

  @override
  String get servingLabel => 'PORSI';

  @override
  String get servingHint => '1 sendok takar · 30 g';

  @override
  String get perServing => 'PER PORSI';

  @override
  String get servingsLabel => 'Porsi';

  @override
  String get foodPhotoHint => 'Dengan latar polos, foto berubah jadi stiker.';

  @override
  String get cutoutWorking => 'Memotong…';

  @override
  String get cutoutTry => 'Potong latar';

  @override
  String get cutoutKeep => 'Foto utuh';

  @override
  String deleteFoodTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get deleteFoodBody => 'Akan keluar dari makananmu. Yang sudah kamu catat tetap ada.';

  @override
  String get mealBreakfast => 'Sarapan';

  @override
  String get mealLunch => 'Makan siang';

  @override
  String get mealDinner => 'Makan malam';

  @override
  String get mealSnacks => 'Camilan';

  @override
  String get nothingLogged => 'Belum ada yang dicatat.';

  @override
  String addToMeal(String meal) {
    return 'Tambah ke $meal';
  }

  @override
  String get quickAdd => 'Tambah cepat';

  @override
  String get quickAddHint => 'Angkanya saja, tanpa menyimpan makanan.';

  @override
  String get quickAddName => 'Apa itu? (opsional)';

  @override
  String get logFood => 'Tambah';

  @override
  String loggedToast(String meal) {
    return 'Ditambahkan ke $meal';
  }

  @override
  String get entryRemoved => 'Dihapus';

  @override
  String get goalsFromProfile => 'Hitung dari profilku';

  @override
  String get goalsFromProfileHint => 'Kalori dari profilmu, 1,8 g protein dan 35 ml air per kg berat badan.';

  @override
  String get kcalEaten => 'Dimakan';

  @override
  String get kcalRemaining => 'Sisa';

  @override
  String waterTapHint(String amount) {
    return 'Ketuk gelas: + $amount';
  }

  @override
  String get shakeEmpty => 'Ketuk untuk memilih shake-mu';

  @override
  String shakeTapHint(String name) {
    return 'Ketuk: + $name';
  }

  @override
  String get shakePick => 'Shake-mu';

  @override
  String get shakePickHint => 'Ketuk shaker dan langsung tercatat sekaligus.';

  @override
  String get proteinLetter => 'P';

  @override
  String get carbsLetter => 'K';

  @override
  String get fatLetter => 'L';

  @override
  String get addBurnedLabel => 'Tambah kalori terbakar';

  @override
  String get addBurnedHint =>
      'Targetmu sudah menghitung aktivitas biasamu. Nyalakan ini hanya jika kamu memilih jarang bergerak: ini menambahkan yang dibakar tiap latihan di atas kebutuhan istirahat.';

  @override
  String get amountLabel => 'Jumlah';

  @override
  String amountIn(String unit) {
    return 'Jumlah ($unit)';
  }

  @override
  String get bodyweightLabel => 'Berat badan';

  @override
  String copiedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count makanan disalin');
    return '$_temp0';
  }

  @override
  String get deleteSavedMealBody => 'Yang sudah kamu catat tetap seperti semula.';

  @override
  String get fiberLabel => 'Serat';

  @override
  String get sugarLabel => 'Gula';

  @override
  String get sodiumLabel => 'Natrium';

  @override
  String get foodDatabase => 'Basis data makanan';

  @override
  String get kcalBurned => 'Terbakar';

  @override
  String get mealOptions => 'Opsi makan';

  @override
  String get moreNutrients => 'Serat, gula, dan natrium';

  @override
  String ofGoal(int goal, String unit) {
    return 'dari $goal $unit';
  }

  @override
  String per100(String unit) {
    return 'per 100 $unit';
  }

  @override
  String get perServingShort => 'per porsi';

  @override
  String get foodCategory => 'KATEGORI';

  @override
  String portionUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count buah');
    return '$_temp0';
  }

  @override
  String portionSlice(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count iris');
    return '$_temp0';
  }

  @override
  String portionScoop(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sendok takar');
    return '$_temp0';
  }

  @override
  String portionTbsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sdm');
    return '$_temp0';
  }

  @override
  String portionTsp(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count sdt');
    return '$_temp0';
  }

  @override
  String portionCup(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count cangkir');
    return '$_temp0';
  }

  @override
  String portionGlass(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count gelas');
    return '$_temp0';
  }

  @override
  String get recentFoods => 'Terbaru';

  @override
  String recipeItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count makanan');
    return '$_temp0';
  }

  @override
  String get renameLabel => 'Ganti nama';

  @override
  String get repeatFrom => 'Ulangi dari';

  @override
  String get repeatNone => 'Belum ada yang dicatat untuk waktu makan ini di hari lain.';

  @override
  String get restDayGoals => 'Target berbeda di hari istirahat';

  @override
  String get trainingDays => 'Hari latihan';

  @override
  String get restDays => 'Hari istirahat';

  @override
  String get trainingDay => 'Hari latihan';

  @override
  String get saveAsMeal => 'Simpan sebagai menu';

  @override
  String get savedMealNameHint => 'mis. Sarapan biasa';

  @override
  String get savedMealToast => 'Menu disimpan';

  @override
  String get savedMeals => 'Menu tersimpan';

  @override
  String get searchFoodsHint => 'Cari makanan';

  @override
  String get searchFoodsEmpty => 'Cari lebih dari 500 makanan berfoto, atau tambahkan punyamu.';

  @override
  String searchFoodsNone(String query) {
    return 'Tidak ada hasil untuk \"$query\". Buat sebagai makananmu sendiri.';
  }

  @override
  String get servingWeight => 'GRAM';

  @override
  String get weekAverage => 'Minggu ini';

  @override
  String get weekAvgEnergy => 'Rata-rata harian';

  @override
  String get weekAvgProtein => 'Protein per hari';

  @override
  String get weekEnergyOnTarget => 'Kalori sesuai target';

  @override
  String get weekProteinOnTarget => 'Protein sesuai target';

  @override
  String weekProteinAvg(int grams) {
    return '$grams g protein sehari';
  }

  @override
  String weekDaysOnTarget(int met, int days) {
    return '$met dari $days hari sesuai target';
  }

  @override
  String weekLoggedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count hari tercatat');
    return '$_temp0';
  }

  @override
  String get weekNoData => 'Belum ada yang dicatat';

  @override
  String get weekOnTargetHint => 'Sesuai target: kalori dalam 10% dari target dan setidaknya 90% protein.';

  @override
  String get weightGoalLabel => 'Berat target';

  @override
  String weightGoalTitle(String unit) {
    return 'Berat target ($unit)';
  }

  @override
  String weightGoalLine(String weight) {
    return 'Target $weight';
  }

  @override
  String get weightGoalNone => 'Tahan untuk memasang target';

  @override
  String get weightGoalReached => 'Target tercapai';

  @override
  String weightToLose(String weight) {
    return '$weight lagi untuk turun';
  }

  @override
  String weightToGain(String weight) {
    return '$weight lagi untuk naik';
  }

  @override
  String get aminoHis => 'histidin';

  @override
  String get aminoIle => 'isoleusin';

  @override
  String get aminoLeu => 'leusin';

  @override
  String get aminoLys => 'lisin';

  @override
  String get aminoSaa => 'metionin';

  @override
  String get aminoAaa => 'fenilalanin';

  @override
  String get aminoThr => 'treonin';

  @override
  String get aminoTrp => 'triptofan';

  @override
  String get aminoVal => 'valin';

  @override
  String get animalProtein => 'Protein hewani';

  @override
  String get proteinQuality => 'Kualitas protein';

  @override
  String get qualityComplete => 'Lengkap';

  @override
  String get qualityAlmost => 'Hampir lengkap';

  @override
  String get qualityIncomplete => 'Tidak lengkap';

  @override
  String get qualityNoData => 'Belum ada data';

  @override
  String get qualityNoDataHint => 'Catat makanan dari basis data untuk melihat asam aminomu.';

  @override
  String get qualityAllCovered => 'Kesembilan asam amino esensial terpenuhi.';

  @override
  String qualityLimiting(String amino) {
    return 'Kurang $amino. Padukan dengan makanan yang kaya akan itu.';
  }

  @override
  String qualityCoverage(int pct) {
    return 'Berdasarkan $pct% proteinmu: makanan buatanmu tidak punya data asam amino.';
  }

  @override
  String get fatTypes => 'Jenis lemak';

  @override
  String get fatSaturated => 'Jenuh';

  @override
  String get fatMono => 'Tunggal';

  @override
  String get fatPoly => 'Ganda';

  @override
  String satLimitLine(String grams, int limit) {
    return 'Jenuh $grams g dari maks $limit g (10% kalori)';
  }

  @override
  String get sugarSodium => 'Gula dan natrium';

  @override
  String get shakeCard => 'Shake protein';

  @override
  String get mealOther => 'Makan';

  @override
  String get mealAdd => 'Tambah waktu makan';

  @override
  String get mealAddHint => 'mis. Sebelum latihan';

  @override
  String get mealsOfDay => 'Waktu makan hari ini';

  @override
  String get mealsHint =>
      'Buat sebanyak yang kamu mau. Menghapus satu memindahkan catatannya ke yang di atasnya.';

  @override
  String get trackersTitle => 'Sesuaikan';

  @override
  String get trackersHint => 'Tampilkan hanya yang ingin kamu pantau.';

  @override
  String get trackersDaily => 'Ringkasan harian';

  @override
  String get trackersDetail => 'Secara rinci';

  @override
  String get trackersCards => 'Kartu';

  @override
  String get prepTitle => 'Meal prep';

  @override
  String get prepNewShort => 'Masakan baru';

  @override
  String get prepNew => 'Masakan baru';

  @override
  String get prepEdit => 'Edit masakan';

  @override
  String get prepHint => 'Catat seluruh panci sekali, lalu makan sedikit demi sedikit.';

  @override
  String get prepEmpty =>
      'Masak banyak sekaligus? Catat sekali, lalu cukup sebutkan berapa dari sisanya yang kamu makan.';

  @override
  String get prepNameHint => 'mis. Ayam dan nasi';

  @override
  String get prepDefaultName => 'Masakan';

  @override
  String get prepIngredients => 'Bahan';

  @override
  String get prepAddIngredient => 'Tambah bahan';

  @override
  String get prepCookedWeight => 'BERAT MATANG';

  @override
  String prepCookedHint(String grams) {
    return 'Timbang pancinya setelah matang untuk angka yang tepat. Kosong memakai total mentah ($grams g).';
  }

  @override
  String get prepNeedWeight => 'Tambahkan berat matangnya: beberapa bahan tidak punya gram.';

  @override
  String prepLeftOf(String left, String total) {
    return 'Sisa $left dari $total';
  }

  @override
  String get prepOfWhatsLeft => '% dari sisanya';

  @override
  String get prepAll => 'Semua';

  @override
  String prepLogAmount(String grams) {
    return 'Catat $grams';
  }

  @override
  String get prepWeighLeft => 'Timbang sisanya';

  @override
  String get prepFinished => 'Masakan ini sudah habis.';

  @override
  String get approxValues => 'Perkiraan';

  @override
  String get editValues => 'Edit nilai';

  @override
  String get editValuesHint =>
      'Hanya mengubah entri ini. Untuk memperbaiki makanannya ke depan, edit dari Makananku.';

  @override
  String get editLibraryHint => 'Disimpan sebagai makananmu sendiri, dengan foto yang sama';

  @override
  String per100Line(String energy, String unit) {
    return '$energy per 100 $unit';
  }

  @override
  String get rawLabel => 'Mentah';

  @override
  String get cookedLabel => 'Matang';

  @override
  String get rawHint => 'Berat sebelum dimasak';

  @override
  String cookedHint(String factor) {
    return 'Berat setelah matang (×$factor berat mentah)';
  }

  @override
  String get servingsUnit => 'porsi';

  @override
  String logAmount(String energy) {
    return 'Catat · $energy';
  }

  @override
  String get catFruit => 'Buah';

  @override
  String get catVeg => 'Sayur';

  @override
  String get catMeat => 'Daging';

  @override
  String get catFish => 'Ikan';

  @override
  String get catEgg => 'Telur';

  @override
  String get catDairy => 'Susu & olahan';

  @override
  String get catGrain => 'Biji-bijian';

  @override
  String get catBakery => 'Roti & kue';

  @override
  String get catLegume => 'Kacang-kacangan';

  @override
  String get catNut => 'Kacang & biji';

  @override
  String get catOil => 'Minyak';

  @override
  String get catPantry => 'Bahan dapur';

  @override
  String get catDrink => 'Minuman';

  @override
  String get catSauce => 'Saus';

  @override
  String get catSpice => 'Bumbu';

  @override
  String get searchFoodsPrompt => 'Kamu makan apa?';

  @override
  String get shelfEmpty =>
      'Cari makanan atau foto punyamu: yang paling sering kamu catat akan muncul di sini.';

  @override
  String get repeatEntry => 'Catat lagi';

  @override
  String get notifSuppChannel => 'Suplemen';

  @override
  String get notifSuppChannelWhy => 'Pengingat harian untuk minum suplemenmu';

  @override
  String get energySplit => 'Asal kalorinya';

  @override
  String get typicalServing => 'Porsi umum';

  @override
  String cookedYieldLine(String factor) {
    return 'Beratnya $factor× berat mentah';
  }

  @override
  String get readyDishes => 'Hidangan';

  @override
  String weightLastLine(String weight) {
    return 'Timbangan terakhir $weight';
  }

  @override
  String get proteinAnimalShort => 'Hewani';

  @override
  String get proteinPlantShort => 'Nabati';

  @override
  String kcalFromMacros(String value) {
    return 'Makro ini berjumlah sekitar $value';
  }

  @override
  String get useValue => 'Pakai';

  @override
  String get suppRowHint => 'Ketuk untuk menandai · tahan untuk detail';

  @override
  String get suppPhoto => 'Foto';

  @override
  String get suppDose => 'Dosis';

  @override
  String get suppDoseHint => '5 g, 2 kapsul…';

  @override
  String get suppRemind => 'Ingatkan aku';

  @override
  String mealPlanDefault(int n) {
    return 'Rencana $n';
  }

  @override
  String get mealPlansTitle => 'Rencana makan';

  @override
  String get mealPlanNew => 'Rencana baru';

  @override
  String fromPlan(String name) {
    return 'Dari $name';
  }

  @override
  String get logPlan => 'Catat';

  @override
  String get planFromDay => 'Salin hari ini';

  @override
  String get planNewHint =>
      'Rencanakan harimu seperti rutinitasmu, lalu catat satu waktu makan utuh dengan satu ketukan.';

  @override
  String get planLogDay => 'Catat waktu makan yang kosong';

  @override
  String planLogged(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n makanan dicatat');
    return '$_temp0';
  }

  @override
  String get planNoPlan => 'Tanpa rencana';

  @override
  String get planWeekHint => 'Ketuk sebuah hari untuk memberinya rencana.';

  @override
  String get planDuplicate => 'Duplikat';

  @override
  String planDeleteTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get planDeleteBody => 'Hari-hari yang sudah kamu catat tetap seperti semula.';

  @override
  String get sectionBeta => 'Beta';

  @override
  String get nutritionBeta => 'Nutrisi';

  @override
  String get nutritionBetaHint => 'Makanan, air, dan suplemen';

  @override
  String get nutritionAboutTitle => 'Tentang Nutrisi';

  @override
  String get nutritionAboutSub => 'Apa itu, dan apa yang tidak akan pernah menjadi.';

  @override
  String get nutritionAboutWhatTitle => 'Bagian dari latihanmu';

  @override
  String get nutritionAboutWhat =>
      'Cara sederhana mencatat makanan, air, protein, dan suplemen tepat di samping latihanmu. GymMane adalah aplikasi gym lebih dulu: Nutrisi ada supaya semuanya bisa di satu tempat, bukan untuk menggantikan aplikasi diet khusus.';

  @override
  String get nutritionAboutScanTitle => 'Tanpa pemindaian, selamanya';

  @override
  String get nutritionAboutScan =>
      'Memindai barcode lalu semua detail terisi otomatis memang praktis. Tapi itu butuh internet dan basis data makanan online yang sangat besar, dan apa yang kamu makan berakhir di server orang lain. Data itu menunjukkan kapan kamu makan, apa yang kamu makan, dan bagaimana kamu merawat tubuhmu, dan bisa dipakai untuk iklan atau diberikan ke perusahaan besar. Karena itu tidak ada pemindai, dan tidak akan pernah ada.';

  @override
  String get nutritionAboutLocalTitle => 'Semuanya di ponselmu';

  @override
  String get nutritionAboutLocal =>
      'Lebih dari 500 makanan berfoto sudah ada di dalam aplikasi. Kamu bisa menambahkan punyamu, mengganti fotonya, dan mengedit nilainya. Semuanya tetap di ponselmu, seperti bagian lain GymMane.';

  @override
  String get nutritionAboutBetaTitle => 'Masih beta';

  @override
  String get nutritionAboutBeta =>
      'Kalau ada yang kurang, usulkan di GitHub. Hanya saja bukan pemindaian atau basis data makanan yang lebih besar: selain soal privasimu, itu akan membuat aplikasi jauh lebih berat. Tidak butuh Nutrisi? Matikan di Pengaturan dan datamu tetap ada.';

  @override
  String get nutritionAboutSuggest => 'Usulkan ide';

  @override
  String get nutritionAboutOk => 'Mengerti';

  @override
  String get planShare => 'Bagikan';

  @override
  String get planImport => 'Impor rencana';

  @override
  String planImported(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rencana diimpor');
    return '$_temp0';
  }

  @override
  String get planImportNone => 'File itu tidak berisi rencana makan.';

  @override
  String get planMoveUp => 'Pindah ke atas';

  @override
  String get planMoveDown => 'Pindah ke bawah';

  @override
  String get cutoutEdit => 'Rapikan potongan';

  @override
  String get cutoutEditHint =>
      'Seret untuk menghapus atau mengembalikan. Ketuk satu area untuk membuang atau mengembalikannya utuh. Cubit untuk memperbesar.';

  @override
  String get cutoutErase => 'Hapus';

  @override
  String get cutoutRestore => 'Kembalikan';

  @override
  String get cutoutReset => 'Kembali ke otomatis';

  @override
  String get cutoutByHand => 'Potong manual';

  @override
  String notifSuppTitleFor(String names) {
    return 'Waktunya minum: $names';
  }

  @override
  String get notifSuppTap => 'Centang di GymMane setelah kamu meminumnya.';

  @override
  String get suppNoneToday => 'Tidak ada yang perlu diminum hari ini.';

  @override
  String get suppOtherDays => 'Hari lain';

  @override
  String suppEveryN(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Setiap $n hari', one: 'Setiap hari');
    return '$_temp0';
  }

  @override
  String get suppDaily => 'Setiap hari';

  @override
  String suppFromDate(String date) {
    return 'mulai $date';
  }

  @override
  String suppUntilDate(String date) {
    return 'sampai $date';
  }

  @override
  String get suppSomeDays => 'Beberapa hari';

  @override
  String get suppEveryShort => 'Setiap X hari';

  @override
  String get suppWhen => 'Kapan';

  @override
  String get suppEveryLead => 'Setiap';

  @override
  String suppEveryTail(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'hari');
    return '$_temp0';
  }

  @override
  String get suppStarts => 'Mulai';

  @override
  String get suppEnds => 'Berakhir';

  @override
  String get suppTomorrow => 'Besok';

  @override
  String get suppPickDate => 'Pilih tanggal';

  @override
  String get suppNever => 'Tidak pernah';

  @override
  String get suppOneWeek => 'Dalam 1 minggu';

  @override
  String get suppOneMonth => 'Dalam 1 bulan';

  @override
  String get planPickHint => 'Pilih rencana untuk hari ini, atau buat yang baru.';

  @override
  String planSetForDay(String day) {
    return 'Rencana diatur untuk $day';
  }

  @override
  String get planSaved => 'Rencana disimpan';

  @override
  String get planDiscardTitle => 'Buang perubahan?';

  @override
  String get planDiscardBody => 'Yang kamu ubah tidak akan disimpan.';

  @override
  String get planDiscard => 'Buang';

  @override
  String get planEdit => 'Edit rencana';

  @override
  String get planNameHint => 'Nama rencana';

  @override
  String get planDaysQuestion => 'Hari apa saja?';

  @override
  String get planDaysHint =>
      'Di hari-hari itu, rencana muncul di Nutrisi supaya bisa kamu catat dengan satu ketukan.';

  @override
  String get planDaysNone => 'Pilih setidaknya satu hari, kalau tidak rencananya tidak muncul di mana pun.';

  @override
  String get planNothingToLog => 'Waktu makan itu sudah dicatat';

  @override
  String get planSave => 'Simpan rencana';

  @override
  String get planToday => 'Rencana hari ini';

  @override
  String get planLogRest => 'Catat sisanya';

  @override
  String get dishNew => 'Buat hidanganku';

  @override
  String get dishNewHint => 'Pilih bahan dan jumlahnya, simpan, lalu catat dengan satu ketukan.';

  @override
  String get dishEdit => 'Edit hidangan';

  @override
  String get dishNameHint => 'Mis. Lentil buatan ibu';

  @override
  String get dishIngredients => 'Bahan';

  @override
  String get dishEmptyHint => 'Tambahkan isinya dengan jumlah yang biasa kamu makan.';

  @override
  String get dishSave => 'Simpan hidangan';

  @override
  String get dishNeedsName => 'Beri nama';

  @override
  String get dishNeedsItems => 'Tambahkan setidaknya satu bahan';

  @override
  String get suppHistory => '14 hari terakhir';

  @override
  String suppTakenOf(int n, int total) {
    return '$n dari $total diminum';
  }

  @override
  String get suppNoReminder => 'Tanpa pengingat';

  @override
  String get suppMarkTaken => 'Tandai sudah diminum';

  @override
  String get suppUnmark => 'Hapus tanda';

  @override
  String get suppEdit => 'Edit';

  @override
  String get mealMoveTo => 'Pindahkan ke';

  @override
  String get mealClear => 'Kosongkan waktu makan';

  @override
  String get mealCleared => 'Waktu makan dikosongkan';

  @override
  String movedMealToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count makanan dipindahkan');
    return '$_temp0';
  }

  @override
  String get repeatWholeDay => 'Ulangi seharian';

  @override
  String createFoodNamed(String name) {
    return 'Buat “$name”';
  }

  @override
  String get entryDay => 'Hari';

  @override
  String get movedToDay => 'Dipindahkan';

  @override
  String get favFoodsHint => 'Ketuk ☆ pada makanan';

  @override
  String get favFoodsEmpty =>
      'Ketuk bintang pada makanan mana pun untuk menyimpannya di sini, tinggal satu ketukan.';

  @override
  String savedMealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count menu');
    return '$_temp0';
  }

  @override
  String get savedMealsEmpty => 'Simpan menu dari menu ••• miliknya, atau susun hidanganmu sendiri.';

  @override
  String get sugarLimitLabel => 'Batas gula';

  @override
  String get sodiumLimitLabel => 'Batas natrium';

  @override
  String get waterOptions => 'Opsi air';

  @override
  String get waterNone => 'Belum ada air yang dicatat.';

  @override
  String get waterDailyGoal => 'Air harian';

  @override
  String get trackersScreen => 'Layar';

  @override
  String get vesselMotion => 'Air bergerak dan shaker';

  @override
  String get vesselMotionHint =>
      'Matikan jika layar terasa lambat: gelas tetap terisi, hanya berhenti bergerak.';

  @override
  String get planFixedWeek => 'Minggu tetap';

  @override
  String get planRotation => 'Rotasi';

  @override
  String get rotationTitle => 'ROTASI';

  @override
  String get rotationHint => 'Berikutnya adalah yang mengikuti latihan terakhirmu, apa pun harinya.';

  @override
  String get rotationEmpty => 'Tambahkan rutinitasmu sesuai urutan kamu melakukannya: A, B, C…';

  @override
  String rotationProgress(int done, int total) {
    return '$done dari $total selesai di putaran ini';
  }

  @override
  String get rotationNext => 'Berikutnya';

  @override
  String get rotationAdd => 'Tambah rutinitas';

  @override
  String get rotationPickHint => 'Urutannya sesuai urutan kamu mengetuknya.';

  @override
  String get rotationSkip => 'Lompat ke berikutnya';

  @override
  String get rotationRestart => 'Mulai putaran baru';

  @override
  String get rotationMakeNext => 'Jadikan berikutnya';

  @override
  String get rotationRemove => 'Hapus dari rotasi';

  @override
  String rotationPlace(int n, int total) {
    return '$n dari $total di rotasi';
  }

  @override
  String get moveToDay => 'Pindahkan ke hari lain';

  @override
  String get moveToDayHint => 'Hanya kali ini; rencana mingguanmu tetap sama.';

  @override
  String get movedToast => 'Latihan dipindahkan';

  @override
  String get backToPlan => 'Kembali ke rencana mingguan';

  @override
  String get tomorrow => 'Besok';

  @override
  String get untrainedTab => 'Belum dilatih';

  @override
  String get untrainedRecent => 'Baru-baru ini';

  @override
  String get untrainedLong => 'Sudah lama';

  @override
  String untrainedWaiting(String list) {
    return 'Paling lama menunggu: $list';
  }

  @override
  String get untrainedAllRecent => 'Setiap otot sudah dilatih minggu ini. Mantap.';

  @override
  String trainedAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n hari lalu',
      one: 'Dilatih kemarin',
      zero: 'Dilatih hari ini',
    );
    return '$_temp0';
  }

  @override
  String get neverTrained => 'Belum pernah dilatih';

  @override
  String get layoutSetting => 'Tata letak latihan';

  @override
  String get layoutCards => 'Kartu';

  @override
  String get layoutList => 'Daftar';

  @override
  String get layoutHint =>
      'Kartu menampilkan satu gerakan sekaligus. Daftar menampilkan seluruh latihan dalam satu layar, set demi set.';

  @override
  String get layoutRowHint => 'Satu gerakan sekaligus, atau seluruh latihan sebagai daftar';

  @override
  String get previousCol => 'SEBELUMNYA';

  @override
  String get usePrevious => 'Pakai angka terakhir kali';

  @override
  String get skipShort => 'Lewati';

  @override
  String get moveUp => 'Pindah ke atas';

  @override
  String get moveDown => 'Pindah ke bawah';

  @override
  String get widgetNutritionOff => 'Nyalakan Nutrisi di Pengaturan › Beta untuk memakai widget ini.';

  @override
  String get widgetPickShake => 'Pilih shake-mu';

  @override
  String get heatRangeSetting => 'Kalender aktivitas';

  @override
  String get heatRangeWeeks => '12 minggu';

  @override
  String get heatRangeYear => '12 bulan';

  @override
  String get heatRangeHint =>
      '12 bulan menampilkan setahun penuh. Geser ke samping untuk mundur, sampai ke latihan pertamamu.';

  @override
  String get pdfPlan => 'Rencana sebagai PDF';

  @override
  String get pdfPlanHint => 'Lembar rapi berisi minggumu dan setiap rutinitas, siap dicetak atau dikirim.';

  @override
  String get pdfExport => 'Ekspor sebagai PDF';

  @override
  String get pdfFooter => 'Gratis, sumber terbuka, dan offline';

  @override
  String get shakeTag => 'Ini shake';

  @override
  String get shakeTagHint => 'Muncul di Shake-mu';

  @override
  String get shakeNone => 'Tandai shake-mu dan hanya itu yang muncul di sini.';

  @override
  String get shakeMarkLabel => 'TANDAI SEBAGAI SHAKE';

  @override
  String get shakeNew => 'Shake baru';

  @override
  String get shakeUntag => 'Bukan shake';

  @override
  String get pdfKicker => 'RENCANA LATIHAN';

  @override
  String get pdfStatDays => 'HARI / MINGGU';

  @override
  String get pdfStatMinutes => 'MENIT / LATIHAN';

  @override
  String pdfMinutes(int n) {
    return '≈ $n menit';
  }

  @override
  String get workoutNotesTitle => 'Catatan gerakan';

  @override
  String get workoutNoteEvery => 'Setiap kali';

  @override
  String get workoutNoteNext => 'Lain kali';

  @override
  String get workoutNoteEveryHint =>
      'Muncul setiap kali kamu melakukan gerakan ini. Cocok untuk pengaturan kursi atau katrol.';

  @override
  String get workoutNoteNextHint => 'Hanya muncul lain kali, lalu hilang.';

  @override
  String workoutNoteFromLast(String date) {
    return 'Dari terakhir kali · $date';
  }

  @override
  String get workoutNoteHint => 'Kursi di lubang 2, katrol di 19…';

  @override
  String get notePinWorkout => 'Tampilkan saat latihan';

  @override
  String get assistedSetting => 'Mesin bantuan';

  @override
  String get assistedSettingHint =>
      'Bebannya membantumu, jadi makin sedikit makin baik: rekor dan saranmu turun.';

  @override
  String get assistedRecordHint => 'Bantuan paling sedikit';

  @override
  String get trainAgainLabel => 'Belum latihan? Ingatkan lagi';

  @override
  String get trainAgainOff => 'Tidak';

  @override
  String trainAgainAfter(int n) {
    return '+$n j';
  }

  @override
  String get trainAgainHint => 'Hanya sekali, dan hanya jika kamu belum mencatat latihan hari itu.';

  @override
  String get notifTrainAgainBody => 'Masih ada waktu untuk latihan hari ini.';

  @override
  String nextDeload(int n) {
    return 'lebih ringan: $n latihan berturut-turut tanpa semua repetisi';
  }

  @override
  String get historyTitle => 'Riwayat';

  @override
  String historyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n LATIHAN');
    return '$_temp0';
  }

  @override
  String get historyEmpty => 'Tidak ada latihan bulan ini';

  @override
  String get historyEmptyHint => 'Geser ke samping atau pakai panah untuk melihat bulan lain.';

  @override
  String historyMore(int n) {
    return '+$n lagi';
  }

  @override
  String get stopwatch => 'Stopwatch';

  @override
  String get proteinSource => 'Sumber protein';

  @override
  String get proteinMixedShort => 'Campuran';

  @override
  String get kcalActive => 'aktif';

  @override
  String get kcalEstimated => 'perkiraan';

  @override
  String get kcalYours => 'nilaimu';

  @override
  String kcalTotalRest(String value) {
    return '$value total, termasuk yang terbakar saat istirahat';
  }

  @override
  String get inclineLabel => 'Kemiringan';

  @override
  String get kcalUseOwn => 'Pakai nilaiku';

  @override
  String get kcalBackToEstimate => 'Kembali ke perkiraan';

  @override
  String get kcalNeedsData => 'Tambahkan jarak dan waktu untuk memperkirakan kalori';

  @override
  String get kcalHowEstimated => 'Diperkirakan dari jarak, waktu, kemiringan, dan beratmu (rumus ACSM).';

  @override
  String get kcalOwnTitle => 'Kalori aktif';

  @override
  String get planMine => 'Rencanaku';

  @override
  String get planNew => 'Rencana baru';

  @override
  String get planSaveWeek => 'Simpan minggu ini';

  @override
  String get planSaveWeekHint => 'Simpan minggu saat ini sebagai rencana yang bisa kamu buka lagi';

  @override
  String get planEmptyWeek => 'Mulai minggu kosong';

  @override
  String get planEmptyWeekHint => 'Minggumu saat ini tetap tersimpan sebagai rencana';

  @override
  String get planName => 'Nama rencana';

  @override
  String get planRename => 'Ganti nama';

  @override
  String get planDelete => 'Hapus rencana';

  @override
  String get plansHint => 'Perubahan pada minggu disimpan di rencana yang dipilih';

  @override
  String get progression => 'Progresi';

  @override
  String get progManual => 'Manual';

  @override
  String get progManualHint => 'Tanpa saran: kamu memilih setiap beban.';

  @override
  String get progLinear => 'Linear';

  @override
  String get progLinearHint => 'Capai semua repetisi dan bebannya naik.';

  @override
  String get progDouble => 'Progresi ganda';

  @override
  String get progDoubleHint => 'Tambah repetisi sampai batas atas rentang, lalu tambah beban.';

  @override
  String get progVolume => 'Repetisi, set, dan beban';

  @override
  String get progVolumeHint => 'Repetisi sampai atas, lalu tambah satu set, lalu tambah beban.';

  @override
  String get progAmrap => 'Set terakhir habis-habisan';

  @override
  String get progAmrapHint =>
      'Set terakhir: sebanyak mungkin repetisi. Dua kali target, bebannya naik dua kali.';

  @override
  String get progStep => 'Lonjakan beban';

  @override
  String get progRange => 'Rentang repetisi';

  @override
  String get progSets => 'Set';

  @override
  String get progDeload => 'Lebih ringan setelah';

  @override
  String progFails(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gagal');
    return '$_temp0';
  }

  @override
  String get progDeloadPct => 'Ringankan sebesar';

  @override
  String get progApply => 'Isi latihan berikutnya';

  @override
  String get progApplyHint => 'Jika mati, hanya muncul sebagai saran.';

  @override
  String get nextMoreReps => 'beban sama, tambah satu repetisi';

  @override
  String get nextAddSet => 'tambah satu set';

  @override
  String get nextAmrap => 'set terakhir: sebanyak mungkin';

  @override
  String fillDay(String amount) {
    return 'Lengkapi harimu · $amount';
  }

  @override
  String leftAfterKcal(String kcal) {
    return 'Kamu akan sisa $kcal';
  }

  @override
  String leftAfterBoth(String kcal, String grams) {
    return 'Kamu akan sisa $kcal dan $grams g protein';
  }

  @override
  String leftAfterOver(String kcal) {
    return '$kcal melebihi targetmu';
  }

  @override
  String perDayUnit(String unit) {
    return '$unit sehari';
  }

  @override
  String get byZone => 'Per area';

  @override
  String get importAlreadyHave =>
      'Kamu sudah punya rutinitas ini. Kamu bisa menambahkannya lagi sebagai salinan.';

  @override
  String get importAsCopy => 'Tambah sebagai salinan';

  @override
  String get routineExerciseNote => 'Routine note';

  @override
  String get importRoutineNotes => 'Add missing routine notes';

  @override
  String get routineNotesAdded => 'Routine notes added';

  @override
  String get importOwned => 'Sudah milikmu';

  @override
  String get setDuplicated => 'Set diduplikasi';

  @override
  String get setTypeCluster => 'Cluster';

  @override
  String get setTypeClusterInfo =>
      'Satu set dibagi menjadi blok kecil dengan jeda 15–30 detik. Catat total repetisinya.';

  @override
  String timesBodyweight(String value) {
    return '$value× berat badanmu';
  }

  @override
  String get archiveRoutine => 'Arsipkan rutinitas';

  @override
  String get routineArchived => 'Rutinitas diarsipkan';

  @override
  String get archivedRoutines => 'Diarsipkan';

  @override
  String get autoBackup => 'Cadangan otomatis';

  @override
  String get autoBackupHint =>
      'Menyimpan ZIP berisi semua datamu ke folder yang kamu pilih. Arahkan Nextcloud, Syncthing, atau aplikasi sinkronisasi apa pun ke folder itu agar ada salinan di luar ponselmu.';

  @override
  String get autoBackupFolder => 'Pilih folder';

  @override
  String get autoBackupNoFolder => 'Belum ada folder';

  @override
  String get autoBackupOff => 'Mati';

  @override
  String get autoBackupWorkout => 'Setelah setiap latihan';

  @override
  String get autoBackupDaily => 'Sekali sehari';

  @override
  String get autoBackupWeekly => 'Sekali seminggu';

  @override
  String get autoBackupOnLeave => 'Saat kamu keluar dari aplikasi';

  @override
  String get autoBackupKeep => 'Salinan yang disimpan';

  @override
  String get autoBackupNow => 'Cadangkan sekarang';

  @override
  String autoBackupLast(String when) {
    return 'Cadangan terakhir $when';
  }

  @override
  String get autoBackupNever => 'Belum ada cadangan';

  @override
  String get autoBackupLost => 'Cadangan terakhir tidak bisa disimpan. Pilih foldernya lagi.';

  @override
  String get autoBackupSaved => 'Cadangan disimpan';

  @override
  String get prepPortions => 'Porsi';

  @override
  String get rotationAddRest => 'Tambah hari istirahat';

  @override
  String get rotationRestHint => 'Lanjut sendiri keesokan harinya';

  @override
  String get rotationRestToday => 'Hari ini';

  @override
  String get rotationSkipRest => 'Lewati hari istirahat ini';

  @override
  String rotationRestUpNext(String name) {
    return 'Berikutnya: $name';
  }

  @override
  String get trainAnyway => 'Tetap latihan';

  @override
  String get healthTitle => 'Kesehatan';

  @override
  String get healthSetting => 'Data kesehatan';

  @override
  String get healthSettingHint => 'Data Health Connect di Progres';

  @override
  String get healthPickTitle => 'Data kesehatan';

  @override
  String get healthPickHint =>
      'Pilih apa yang dibawa dari Health Connect. Android meminta izin sekali untuk masing-masing. Hanya dibaca, dan tidak pernah keluar dari ponselmu.';

  @override
  String get healthGroupHeart => 'Jantung';

  @override
  String get healthGroupVitals => 'Tanda vital';

  @override
  String get healthGroupActivity => 'Aktivitas';

  @override
  String get healthRestingHr => 'Detak jantung istirahat';

  @override
  String get healthHeartRate => 'Detak jantung rata-rata';

  @override
  String get healthHrv => 'Variabilitas detak jantung';

  @override
  String get healthSpo2 => 'Oksigen darah';

  @override
  String get healthRespiration => 'Laju napas';

  @override
  String get healthBloodPressure => 'Tekanan darah';

  @override
  String get healthTemperature => 'Suhu tubuh';

  @override
  String get healthSleep => 'Tidur';

  @override
  String get healthDistance => 'Jarak';

  @override
  String get healthFloors => 'Lantai dinaiki';

  @override
  String get healthElevation => 'Ketinggian didaki';

  @override
  String get healthActiveKcal => 'Kalori aktif';

  @override
  String get healthNoData => 'Belum ada data';

  @override
  String get healthReadFailed => 'Tidak bisa dibaca';

  @override
  String get healthAllow => 'Ketuk untuk mengizinkan';

  @override
  String get healthLast7 => '7 hari terakhir';

  @override
  String get healthAvg30 => 'Rata-rata 30 hari';

  @override
  String get healthLow => 'Terendah';

  @override
  String get healthHigh => 'Tertinggi';

  @override
  String get healthFrom => 'Dari Health Connect · 30 hari terakhir';

  @override
  String get healthBpm => 'bpm';

  @override
  String get healthBreaths => 'napas/mnt';

  @override
  String get weekTab => 'Minggu';

  @override
  String get muscleSetsList => 'Set per otot';

  @override
  String get fatTrans => 'Trans';

  @override
  String get fatTypesHint => 'Opsional. Biarkan kosong yang tidak tercantum di label.';

  @override
  String get sessionPhotos => 'Foto latihan';

  @override
  String get sessionPhotosAdd => 'Tambah foto';

  @override
  String get sessionPhotosHint => 'Juga disimpan di Foto-fotomu.';

  @override
  String get ladderTitle => 'Progresi';

  @override
  String get ladderHint =>
      'Urutkan langkah dari yang termudah ke tersulit. Saat kamu melakukan 3 set 8 repetisi dua sesi berturut-turut (5 untuk yang lambat), GymMane menawarkan langkah berikutnya.';

  @override
  String get ladderBuiltIn =>
      'Dimulai dari progresi aplikasi. Tambah, hapus, atau ubah urutan langkah dan ini menjadi milik rutinitas ini.';

  @override
  String get ladderNone => 'Belum ada. Ketuk untuk membuatnya.';

  @override
  String ladderStep(int n, int total) {
    return 'Langkah $n dari $total';
  }

  @override
  String get ladderAdd => 'Tambah langkah';

  @override
  String get ladderInRoutine => 'Di rutinitas';

  @override
  String get ladderClear => 'Pakai progresi aplikasi';

  @override
  String get ladderPick => 'Pilih langkah';

  @override
  String get periodWeek => 'minggu ini';

  @override
  String get periodMonth => 'bulan ini';

  @override
  String get periodYear => 'tahun ini';

  @override
  String get periodAll => 'sepanjang waktu';

  @override
  String get settingsSearch => 'Cari pengaturan';

  @override
  String get settingsNoResults => 'Tidak ada pengaturan dengan nama itu';

  @override
  String get settingsGroupApp => 'Aplikasimu';

  @override
  String get settingsGroupHome => 'Beranda dan tambahan';

  @override
  String get settingsGroupData => 'Data dan bantuan';

  @override
  String get healthAllowAll => 'Nyalakan semua';

  @override
  String get healthSeeAll => 'Lihat semua';

  @override
  String get healthPinTitle => 'Di kartu';

  @override
  String get healthPinHint => 'Pilih hingga 3 untuk kartu Progres.';

  @override
  String get blurSetting => 'Efek blur';

  @override
  String get blurSettingHint => 'Matikan jika ponselmu terasa lambat';

  @override
  String get lowEndTitle => 'Memori ponselmu terbatas';

  @override
  String get lowEndBody =>
      'Mematikan blur membuat semuanya lebih lancar di ponsel ini. Kamu bisa menyalakannya lagi di Pengaturan → Umum.';

  @override
  String get lowEndOff => 'Matikan blur';

  @override
  String get lowEndKeep => 'Biarkan';

  @override
  String get momentsThisMonth => 'Bulan ini';

  @override
  String get momentsDays => 'Hari dengan foto';

  @override
  String get awardsPick => 'Pilih untuk profilmu';

  @override
  String get awardsPickHint => 'Ketuk yang ingin kamu tampilkan di profil';

  @override
  String get gymPassPicture => 'Simpan gambar kodenya';

  @override
  String get gymPassPictureHint =>
      'Untuk kode yang tidak bisa dibaca aplikasi: fotomu ditampilkan dengan kecerahan penuh';

  @override
  String get gymPassPictureFormat => 'Foto';

  @override
  String get gymPassUsePicture => 'Simpan fotonya';

  @override
  String get gymPassChangePicture => 'Ganti fotonya';

  @override
  String get cropTitle => 'Potong kodenya';

  @override
  String get cropHint => 'Seret sudut-sudutnya agar hanya kode yang ada di dalam';

  @override
  String get rotatePhoto => 'Putar';

  @override
  String get cardioNoSets => 'Kardio tidak menambah set mingguanmu per otot';

  @override
  String get countsAsWater => 'Dihitung sebagai air';

  @override
  String get countsAsWaterHint => 'Untuk shake yang dibuat dengan air: mencatatnya juga menambah airmu';

  @override
  String get waterPerServing => 'Air per porsi';

  @override
  String get estOneRm => 'perk. 1RM';

  @override
  String get newInWorkout => 'Baru di latihan ini';

  @override
  String newInWorkoutHint(String routine) {
    return 'Tambahkan ke $routine dengan set yang baru kamu lakukan. Sisa rutinitas tetap seperti semula.';
  }

  @override
  String get addedToRoutine => 'Ditambahkan';

  @override
  String get addShort => 'Tambah';

  @override
  String get allTimeLifted => 'DIANGKAT';

  @override
  String get pctBodyweight => '% berat badan';

  @override
  String get ofBodyweight => 'dari berat badanmu';

  @override
  String get recoveryStateMid => 'Memulihkan';

  @override
  String get recoveryStateReady => 'Siap';

  @override
  String recoveringIn(String time) {
    return 'Pulih dalam $time';
  }

  @override
  String readyIn(String time) {
    return 'Siap dalam $time';
  }

  @override
  String get recoveryReadyNow => 'Siap dilatih lagi';

  @override
  String get restAfterThisSet => 'Istirahat setelah set ini';

  @override
  String restUsual(String time) {
    return 'Biasanya: $time';
  }

  @override
  String get restJustToday => 'Hanya untuk set ini, hari ini';

  @override
  String get restUseUsual => 'Kembali ke istirahat biasa';

  @override
  String get restChange => 'Ubah';

  @override
  String get noRestTimer => 'Tanpa timer';

  @override
  String get sessionMuscles => 'Otot di latihan ini';

  @override
  String get sessionMusclesHint =>
      'Pudar berarti belum, terang berarti sudah. Set per otot, otot sekunder dihitung setengah.';

  @override
  String get miniBodySetting => 'Peta tubuh kecil di rutinitas';

  @override
  String get miniBodySettingHint => 'Otot yang dilatih tiap rutinitas';

  @override
  String get balanceTitle => 'Keseimbangan kekuatan';

  @override
  String get balanceWhy => 'Cara kerjanya';

  @override
  String get balanceGood => 'Angkatan utamamu seimbang';

  @override
  String balanceBehind(String lift, String gap) {
    return '$lift tertinggal: sekitar $gap untuk mengejar';
  }

  @override
  String get balanceHint =>
      'Membandingkan perkiraan 1RM-mu dari 4 bulan terakhir dengan proporsi klasik: squat 100%, deadlift 120%, bench 75%, row 52%, overhead press 45%. Angkatan yang jauh di bawah yang lain biasanya titik lemah yang layak dilatih lebih.';

  @override
  String get balanceEven => 'Seimbang';

  @override
  String get balanceBehindShort => 'Tertinggal';

  @override
  String get balanceAheadShort => 'Unggul';

  @override
  String get holdProgress => 'Progres berdasarkan waktu';

  @override
  String get holdProgressHint => 'Menambah detik saat kamu menahan semua set';

  @override
  String holdProgressOn(int s) {
    return '+$s dtk setiap kali kamu menahan semua set';
  }

  @override
  String get paceTitle => 'Laju mingguan';

  @override
  String get paceOn => 'Sesuai laju';

  @override
  String get paceTooFast => 'Lebih cepat dari rentang yang kamu atur';

  @override
  String get paceTooSlow => 'Lebih lambat dari rentang yang kamu atur';

  @override
  String get paceWrongWay => 'Bergerak ke arah sebaliknya';

  @override
  String get paceDrifting => 'Berubah lebih banyak dari yang dibolehkan untuk menjaga';

  @override
  String get paceSetAim => 'Ketuk untuk mengatur tujuanmu';

  @override
  String get paceBasis =>
      'Tren timbanganmu 3 minggu terakhir, jadi satu makan malam asin tidak bisa mengelabuinya.';

  @override
  String get paceAimTitle => 'Apa tujuanmu?';

  @override
  String get paceAimHint => 'Kartu ini memberi tahu apakah laju mingguanmu sesuai';

  @override
  String get paceLose => 'Turun';

  @override
  String get paceHold => 'Jaga';

  @override
  String get paceGain => 'Naik';

  @override
  String get paceAuto => 'Otomatis';

  @override
  String get paceLoseRange => '0,5 sampai 1% berat badanmu per minggu';

  @override
  String get paceHoldRange => 'Dalam 0,25% per minggu';

  @override
  String get paceGainRange => '0,25 sampai 0,5% berat badanmu per minggu';

  @override
  String get paceAutoHint => 'Dari berat targetmu';

  @override
  String get weekShort => 'mgg';

  @override
  String get weightStack => 'Tumpukan beban';

  @override
  String get weightStackHint =>
      'Beban yang benar-benar ada di mesin ini. Tombol + dan −, progresi, dan deload hanya mendarat di sini.';

  @override
  String get weightStackOff => 'Mati: langkah beban normal';

  @override
  String get stackFrom => 'Dari';

  @override
  String get stackTo => 'Sampai';

  @override
  String get stackEvery => 'Setiap';

  @override
  String get stackFill => 'Isi tumpukan';

  @override
  String get stackTapToFix => 'Ketuk beban untuk memperbaiki yang janggal atau menghapusnya.';

  @override
  String get stackAddWeight => 'Tambah beban';

  @override
  String get stackEditWeight => 'Beban di pin';

  @override
  String get stackClear => 'Hapus tumpukan';

  @override
  String stackCount(int n) {
    return '$n beban';
  }

  @override
  String get healthLinksTitle => 'Dengan latihanmu';

  @override
  String get healthLinkHeart => 'Detak jantung dari jam tanganmu';

  @override
  String get healthLinkHeartHint =>
      'Detak jantung rata-rata dan puncak tiap latihan, dari jam tangan apa pun yang merekamnya';

  @override
  String get healthLinkWeight => 'Timbangan dari aplikasi lain';

  @override
  String get healthLinkWeightHint =>
      'Timbangan dari timbanganmu selama 30 hari terakhir. Tidak pernah menimpa yang kamu ketik.';

  @override
  String get healthLinkDenied => 'Health Connect tidak memberi izin';

  @override
  String get healthOpenSettings => 'Buka';

  @override
  String hrMaxShort(int bpm) {
    return 'maks $bpm';
  }

  @override
  String get setNote => 'Catatan untuk set ini';

  @override
  String get setNoteHint => 'Pegangan, nyeri, petunjuk yang berhasil…';

  @override
  String setNoteLast(String note) {
    return 'Terakhir kali: $note';
  }

  @override
  String get lastTimeNotes => 'Terakhir kali';

  @override
  String setNoteLine(int n, String note) {
    return 'Set $n · $note';
  }

  @override
  String get newMeasure => 'Ukuran baru';

  @override
  String get newMeasureHint => 'Apa pun yang ingin kamu pantau: pergelangan, denyut istirahat, air tubuh…';

  @override
  String get measureKindLength => 'Panjang';

  @override
  String get measureKindLengthHint => 'Dalam cm atau inci, seperti yang lain';

  @override
  String get measureKindOther => 'Lainnya';

  @override
  String get measureKindOtherHint => 'Dengan satuanmu sendiri';

  @override
  String get measureUnit => 'Satuan';

  @override
  String get measureUnitHint => 'mm, bpm, kg…';

  @override
  String get measureNameHint => 'Pergelangan, denyut istirahat…';

  @override
  String get measureRename => 'Ganti nama';

  @override
  String measureDeleteTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get measureDeleteBody => 'Semua nilai yang kamu catat untuknya ikut terhapus.';

  @override
  String get measureDelete => 'Hapus ukuran ini';

  @override
  String get measureEvery => 'Ingatkan aku untuk mengukur';

  @override
  String measureNextIn(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dalam $n hari',
      one: 'Besok',
      zero: 'Hari ini',
    );
    return '$_temp0';
  }

  @override
  String get measureDueNow => 'Waktunya mengukur';

  @override
  String get notifMeasureChannel => 'Ukuran tubuh';

  @override
  String get notifMeasureChannelWhy => 'Pengingat saat waktunya mengukur lagi.';

  @override
  String get notifMeasureTitle => 'Waktunya mengukur';

  @override
  String notifMeasureBody(int n) {
    return '$n hari sejak terakhir kali. Titik yang sama, waktu yang sama.';
  }

  @override
  String get healthLinkWrite => 'Simpan latihanmu';

  @override
  String get healthLinkWriteHint =>
      'Setiap latihan yang selesai dikirim ke Health Connect dengan waktu dan jenisnya, jadi aplikasi lain ikut menghitungnya. Juga mengirim 30 hari terakhir.';

  @override
  String get healthWorkoutTitle => 'Latihan';

  @override
  String get circuits => 'Sirkuit berwaktu';

  @override
  String get circuitsHint => 'Kerja dan istirahat mengikuti jam, putaran demi putaran';

  @override
  String get newCircuit => 'Sirkuit baru';

  @override
  String get editCircuit => 'Edit sirkuit';

  @override
  String get circuitDefaultName => 'Sirkuit';

  @override
  String get circuitNameHint => 'Nama, misalnya Penutup core';

  @override
  String get circuitRounds => 'Putaran';

  @override
  String get circuitRoundRest => 'Istirahat antarputaran';

  @override
  String get circuitWork => 'Kerja';

  @override
  String get circuitRest => 'Istirahat';

  @override
  String get circuitAdd => 'Tambah gerakan';

  @override
  String get circuitEmpty =>
      'Tambahkan gerakan sesuai urutan kamu melakukannya. Satu gerakan bisa muncul dua kali, misalnya side plank untuk tiap sisi.';

  @override
  String circuitSummary(int steps, int rounds, String time) {
    String _temp0 = intl.Intl.pluralLogic(steps, locale: localeName, other: '$steps gerakan');
    String _temp1 = intl.Intl.pluralLogic(rounds, locale: localeName, other: '$rounds putaran');
    return '$_temp0 · $_temp1 · $time';
  }

  @override
  String get circuitStart => 'Mulai';

  @override
  String get circuitGetReady => 'Bersiap';

  @override
  String circuitRoundOf(int n, int total) {
    return 'Putaran $n dari $total';
  }

  @override
  String circuitNext(String name) {
    return 'Berikutnya: $name';
  }

  @override
  String get circuitFinishLine => 'Satu lagi, lalu selesai';

  @override
  String get circuitDone => 'Sirkuit selesai';

  @override
  String circuitDoneBody(String time) {
    return '$time · tersimpan di riwayatmu';
  }

  @override
  String get circuitStopTitle => 'Hentikan sirkuit?';

  @override
  String get circuitStopBody => 'Yang sudah kamu lakukan sejauh ini tersimpan di riwayatmu.';

  @override
  String get circuitStop => 'Hentikan';

  @override
  String get circuitKeepGoing => 'Lanjutkan';

  @override
  String circuitDeleteTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get circuitDeleteBody => 'Latihan yang sudah kamu lakukan dengannya tetap ada di riwayatmu.';

  @override
  String get circuitPickExercise => 'Pilih gerakan';

  @override
  String get circuitNoSteps => 'Tambahkan setidaknya satu gerakan';

  @override
  String get circuitPrevious => 'Sebelumnya';

  @override
  String get circuitUpNext => 'Berikutnya';

  @override
  String get foodGroupNew => 'Kategori baru';

  @override
  String get foodGroupHint => 'Makanan siap saji, beku…';

  @override
  String foodGroupCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n makanan',
      zero: 'Belum ada makanan',
    );
    return '$_temp0';
  }

  @override
  String foodGroupDeleteTitle(String name) {
    return 'Hapus $name?';
  }

  @override
  String get foodGroupDeleteBody => 'Makananmu tetap ada, hanya tanpa kategori ini.';

  @override
  String onbHello(String name) {
    return 'Hai, $name';
  }

  @override
  String get onbPlaceHero => 'gerakan yang bisa kamu lakukan';

  @override
  String get settingsRests => 'Istirahat';

  @override
  String get settingsDuring => 'Selama latihan';

  @override
  String get settingsLook => 'Tampilan';

  @override
  String get importCardTitle => 'Bawa latihanmu ke sini';

  @override
  String get importCardBody => 'Dari Hevy, Strong, FitNotes, dan lainnya';

  @override
  String get checkInTitle => 'Bagaimana kondisimu hari ini?';

  @override
  String get checkInSleep => 'Tidur';

  @override
  String get checkInEnergy => 'Energi';

  @override
  String get checkInSkip => 'Opsional';

  @override
  String get checkInLevel1 => 'Buruk sekali';

  @override
  String get checkInLevel2 => 'Kurang';

  @override
  String get checkInLevel3 => 'Lumayan';

  @override
  String get checkInLevel4 => 'Baik';

  @override
  String get checkInLevel5 => 'Sangat baik';

  @override
  String get checkInSetting => 'Tidur dan energi';

  @override
  String get checkInSettingHint => 'Ditanyakan saat kamu menyelesaikan latihan';

  @override
  String get readinessTitle => 'Tidur dan energi';

  @override
  String get readinessWaiting => 'Terus nilai latihanmu';

  @override
  String get readinessWaitingHint =>
      'Setelah beberapa hari baik dan buruk, kamu akan melihat pengaruhnya pada angkatanmu.';

  @override
  String readinessSleepLess(int n) {
    return 'Di hari kurang tidur kamu mengangkat $n% lebih sedikit';
  }

  @override
  String readinessSleepMore(int n) {
    return 'Lucunya: di hari kurang tidur kamu mengangkat $n% lebih banyak';
  }

  @override
  String get readinessSleepNone => 'Tidur hampir tidak mengubah angkatanmu';

  @override
  String readinessEnergyLess(int n) {
    return 'Di hari energi rendah kamu mengangkat $n% lebih sedikit';
  }

  @override
  String readinessEnergyMore(int n) {
    return 'Di hari energi rendah kamu tetap mengangkat $n% lebih banyak';
  }

  @override
  String get readinessEnergyNone => 'Energimu hampir tidak mengubah angkatanmu';

  @override
  String get readinessHint => 'Membandingkan setiap perkiraan 1RM dengan yang terbaik di 90 hari sebelumnya.';

  @override
  String get readinessLast30 => 'Rata-rata 30 hari terakhir';

  @override
  String get kindSport => 'Olahraga';

  @override
  String get clearWorkouts => 'Hapus latihannya saja';

  @override
  String get clearWorkoutsNone => 'Tidak ada latihan untuk dihapus';

  @override
  String clearWorkoutsTitle(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Hapus $n latihan?');
    return '$_temp0';
  }

  @override
  String get clearWorkoutsBody =>
      'Riwayat, rekor, dan medalimu hilang. Rutinitas, gerakan, foto, ukuran tubuh, nutrisi, dan pengaturan tetap ada. Ekspor cadangan dulu kalau mungkin ingin mengembalikannya.';

  @override
  String get clearWorkoutsConfirm => 'Hapus latihan';

  @override
  String get clearWorkoutsDone => 'Latihan dihapus';

  @override
  String get reportTitle => 'Laporan';

  @override
  String get reportHint => 'Pilih tanggalnya dan bagikan sebagai PDF atau CSV';

  @override
  String get reportCustom => 'Lainnya';

  @override
  String get reportPickRange => 'Pilih tanggal';

  @override
  String get reportEmpty => 'Tidak ada yang dicatat di antara tanggal ini.';

  @override
  String get reportKicker => 'LAPORAN LATIHAN';

  @override
  String reportDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari');
    return '$_temp0';
  }

  @override
  String get reportWorkouts => 'LATIHAN';

  @override
  String get reportPerWeek => 'PER MINGGU';

  @override
  String get reportHours => 'JAM';

  @override
  String get reportVsPrev => 'Persentase dibandingkan dengan jumlah hari yang sama tepat sebelumnya.';

  @override
  String get reportRecords => 'Rekor baru';

  @override
  String get reportLifts => 'Gerakan';

  @override
  String get reportSessionsCol => 'HARI';

  @override
  String get reportBestCol => '1RM TERBAIK';

  @override
  String get reportChangeCol => 'PERUBAHAN';

  @override
  String get reportBestHint =>
      '1RM terbaik diperkirakan dari set-mu. Perubahan membandingkan hari pertama dan terakhir gerakan dalam laporan ini.';

  @override
  String get reportMuscles => 'Set per otot';

  @override
  String get reportBody => 'Tubuh dan pemulihan';

  @override
  String reportFood(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Nutrisi · rata-rata $n hari');
    return '$_temp0';
  }

  @override
  String reportRecordsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n rekor baru');
    return '$_temp0';
  }

  @override
  String reportLiftsLine(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gerakan');
    return '$_temp0';
  }

  @override
  String reportFoodLine(String kcal, int protein, int days) {
    return '$kcal dan $protein g protein sehari · $days hari tercatat';
  }

  @override
  String get reportSharePdf => 'Bagikan PDF';

  @override
  String get reportShareCsv => 'Ekspor CSV';

  @override
  String get reportShareCsvBoth => 'Ekspor CSV (latihan dan nutrisi)';

  @override
  String fastMinutes(int n) {
    return '$n mnt';
  }

  @override
  String fastHours(int n) {
    return '$n j';
  }

  @override
  String fastHoursMinutes(int h, int m) {
    return '$h j $m mnt';
  }

  @override
  String get fastTracker => 'Puasa intermiten';

  @override
  String fastTitle(int fast, int eat) {
    return 'Puasa $fast:$eat';
  }

  @override
  String get fastOptions => 'Opsi puasa';

  @override
  String get fastWindowOpen => 'Jendela makan terbuka';

  @override
  String get fastLeft => 'Sisa';

  @override
  String get fastDoneLabel => 'Target tercapai';

  @override
  String get fastIdle => 'Mulai setelah makan terakhirmu';

  @override
  String fastLast(String time) {
    return 'Puasa terakhir: $time';
  }

  @override
  String fastStreak(int n) {
    return '$n berturut-turut';
  }

  @override
  String fastReached(String time) {
    return '$time melewati targetmu';
  }

  @override
  String fastEndsAt(String time) {
    return 'Berakhir pukul $time';
  }

  @override
  String fastSince(String time) {
    return 'Sejak $time';
  }

  @override
  String get fastStartedAt => 'Kapan kamu mulai puasa?';

  @override
  String get fastStart => 'Mulai puasa';

  @override
  String fastFromMeal(String time) {
    return 'Sejak $time';
  }

  @override
  String get fastEnd => 'Akhiri puasa';

  @override
  String get fastCancel => 'Batalkan puasa ini';

  @override
  String get fastPlan => 'Rencana puasa';

  @override
  String get fastPlanHint => 'Jam puasa : jam makan';

  @override
  String get fastThisWeek => '7 hari terakhir';

  @override
  String get fastCount => 'Puasa';

  @override
  String get fastReachedCount => 'Tercapai';

  @override
  String get fastAverage => 'Rata-rata';

  @override
  String get fastHistory => 'Puasa terbaru';

  @override
  String get notifFastLiveChannel => 'Puasa berlangsung';

  @override
  String get notifFastLiveChannelWhy => 'Hitung mundur yang tenang selama kamu puasa.';

  @override
  String get notifFastChannel => 'Puasa';

  @override
  String get notifFastChannelWhy => 'Memberi tahu saat puasamu selesai.';

  @override
  String get notifFastLiveTitle => 'Puasa';

  @override
  String notifFastLiveBody(String time) {
    return 'Jendela makanmu terbuka pukul $time';
  }

  @override
  String get notifFastDoneTitle => 'Puasa selesai';

  @override
  String notifFastDoneBody(int n) {
    return '$n jam. Jendela makanmu terbuka.';
  }

  @override
  String get newExerciseHint => 'Hanya nama yang wajib. Sisanya membantu, tapi bisa kamu tambahkan nanti.';

  @override
  String get supportThanksTitle => 'Terima kasih sudah di sini 🤍';

  @override
  String get supportThanksBody =>
      'GymMane gratis dan akan selalu begitu, tanpa iklan dan tanpa ada yang disembunyikan.\n\nKalau aplikasi ini membantumu latihan, mentraktirku kopi bikin hariku senang ☕\nKalau tidak bisa, tidak apa-apa: bintang di GitHub juga sangat berarti ⭐';

  @override
  String get perfSetting => 'Performa';

  @override
  String get perfSheetHint =>
      'Seberapa banyak GymMane memakai ponselmu. Kamu bisa mengubah tiap bagian di bawah.';

  @override
  String get perfLite => 'Hemat';

  @override
  String get perfLiteHint => 'Tanpa blur dan gerakan lebih tenang. Untuk ponsel yang kewalahan.';

  @override
  String get perfBalanced => 'Seimbang';

  @override
  String get perfBalancedHint => 'Blur dan animasi tanpa menguras baterai.';

  @override
  String get perfMax => 'Maksimal';

  @override
  String perfMaxHint(int hz) {
    return 'Blur lebih halus dan layar $hz Hz. Untuk ponsel kelas atas.';
  }

  @override
  String get perfMaxHintNoHz => 'Blur lebih halus di mana-mana. Untuk ponsel kelas atas.';

  @override
  String get perfCustom => 'Kustom';

  @override
  String get perfTweak => 'Penyesuaian halus';

  @override
  String get perfFine => 'Blur halus';

  @override
  String get perfFineHint => 'Tepi lebih lembut dan latar lebih tajam di balik panel';

  @override
  String perfHz(int hz) {
    return 'Layar $hz Hz';
  }

  @override
  String get perfHzHint => 'Semua bergulir lebih mulus, dengan sedikit baterai lebih';

  @override
  String get lowEndLiteBody =>
      'Mode Hemat (tanpa blur, gerakan lebih tenang) akan lebih lancar di ponsel ini. Kamu bisa mengubahnya di Pengaturan → Umum → Performa.';

  @override
  String get lowEndLiteOn => 'Nyalakan Hemat';

  @override
  String get dayOffHint => 'Runtutan dan pengingatmu tidak mengusik hari ini';

  @override
  String get dayOffTrained => 'Aku latihan, hanya tidak mencatatnya';

  @override
  String get dayOffSick => 'Sakit';

  @override
  String get dayOffTravel => 'Bepergian';

  @override
  String get dayOffInjury => 'Cedera';

  @override
  String get dayOffRest => 'Istirahat';

  @override
  String get altsTitle => 'Cadangan';

  @override
  String get altsHint => 'Kalau mesinnya sedang dipakai';

  @override
  String altsPickHint(int count) {
    return 'Pilih hingga $count. Kalau mesinnya dipakai, tukar dengan satu ketukan.';
  }

  @override
  String get placeDumbbells => 'Dumbel';

  @override
  String get dumbbellsHint =>
      'Berat satu dumbel. Progresi dan tombol + dan − hanya akan mendarat di nilai ini di sini.';

  @override
  String get dumbbellOther => 'Berat lain';

  @override
  String get tuneTitle => 'Volume hari ini';

  @override
  String get tuneHint => 'Ceritakan rasanya tiap otot dan aku akan menyesuaikan set untuk lain kali.';

  @override
  String get tuneLess => 'Terlalu sedikit';

  @override
  String get tuneRight => 'Pas';

  @override
  String get tuneMore => 'Terlalu banyak';

  @override
  String tuneNext(String sets, String name) {
    return 'Lain kali: $sets untuk $name';
  }

  @override
  String get tuneSame => 'Tetap sama lain kali';

  @override
  String get tuneSetting => 'Sesuaikan set per otot';

  @override
  String get tuneSettingHint => 'Setelah rutinitas, nilai tiap otot dan set-nya menyesuaikan';

  @override
  String insightLoad(int pct) {
    return '$pct % lebih banyak set dari minggu biasamu. Perhatikan pemulihanmu.';
  }

  @override
  String insightMuscle(String muscle, int days) {
    return '$muscle: $days hari tidak dilatih.';
  }

  @override
  String insightPushHeavy(int a, int b) {
    return 'Kamu lebih banyak mendorong daripada menarik: $a set lawan $b dalam empat minggu.';
  }

  @override
  String insightPullHeavy(int a, int b) {
    return 'Kamu lebih banyak menarik daripada mendorong: $a set lawan $b dalam empat minggu.';
  }

  @override
  String insightStronger(String name, int pct) {
    return '$name: $pct % lebih kuat dari bulan lalu.';
  }

  @override
  String recapPull(String month) {
    return 'Terus tarik untuk melihat $month-mu';
  }

  @override
  String get recapRelease => 'Lepaskan';

  @override
  String recapHi(String name) {
    return 'Hai, $name';
  }

  @override
  String recapReady(String month) {
    return 'Mau lihat apa yang kamu lakukan di $month?';
  }

  @override
  String get recapGo => 'Ayo';

  @override
  String recapEmpty(String month) {
    return 'Belum ada latihan di $month. Latihan pertamamu membukanya.';
  }

  @override
  String get recapClose => 'Tutup';

  @override
  String get recapShare => 'Bagikan';

  @override
  String get recapWorkoutsKicker => 'Bulan ini kamu latihan';

  @override
  String recapWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'latihan');
    return '$_temp0';
  }

  @override
  String recapDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Dalam $n hari berbeda',
      one: 'Dalam satu hari',
    );
    return '$_temp0';
  }

  @override
  String get recapTimeKicker => 'Waktu di bawah barbel';

  @override
  String recapLongest(String time, String date) {
    return 'Sesi terlama: $time, pada $date';
  }

  @override
  String get recapVolumeKicker => 'Kamu memindahkan';

  @override
  String recapCars(int n, String count) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Seperti mengangkat $count mobil',
      one: 'Seperti mengangkat sebuah mobil',
    );
    return '$_temp0';
  }

  @override
  String recapTop(String name, String volume) {
    return 'Paling banyak: $name, $volume';
  }

  @override
  String get recapMuscleKicker => 'Otot bulan ini';

  @override
  String get recapRecordsKicker => 'Rekor baru';

  @override
  String recapNoRecords(int n) {
    return 'Tidak ada rekor kali ini, tapi $n set sudah masuk catatan.';
  }

  @override
  String get recapHabitKicker => 'Waktumu';

  @override
  String recapHabitStart(String time) {
    return 'Kamu biasanya mulai pukul $time';
  }

  @override
  String get recapShareKicker => 'Bulanmu, siap dibagikan';

  @override
  String get recapTickWorkouts => 'Latihan';

  @override
  String get recapTickTime => 'Waktu';

  @override
  String get recapTickVolume => 'Beban';

  @override
  String get recapTickRecords => 'Rekor';

  @override
  String recapAvg(int n) {
    return 'Rata-rata $n menit per latihan';
  }

  @override
  String get recapLiftKicker => 'Gerakan bulan ini';

  @override
  String get recapBest => 'Terbaik';

  @override
  String get recapTimes => 'Hari';

  @override
  String get recapDaysLabel => 'Hari';

  @override
  String get recapAvgLabel => 'Rata-rata';

  @override
  String recapCalendarLine(int workouts, int days) {
    return '$workouts latihan dalam $days hari';
  }

  @override
  String get recapFavLabel => 'Harimu';

  @override
  String get recapWatermark => 'catatan gym gratis';

  @override
  String get recapTickSteps => 'Langkah';

  @override
  String get recapTickFood => 'Makanan';

  @override
  String get recapCardioKicker => 'Kardio';

  @override
  String recapCardioTime(int minutes, int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n latihan', one: 'satu latihan');
    return '$minutes menit dalam $_temp0';
  }

  @override
  String recapCardioCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n latihan kardio',
      one: 'Satu latihan kardio',
    );
    return '$_temp0';
  }

  @override
  String recapCardioTop(String name) {
    return 'Andalanmu: $name';
  }

  @override
  String get recapStepsKicker => 'Kamu berjalan';

  @override
  String get recapStepsWord => 'langkah';

  @override
  String recapStepsAvg(String value) {
    return 'rata-rata $value sehari';
  }

  @override
  String recapStepsBest(String value, String date) {
    return 'Hari terbaik: $value, $date';
  }

  @override
  String get recapFoodKicker => 'Di piringmu';

  @override
  String get recapLiftRest => 'Tepat di belakangnya';

  @override
  String recapSameAs(String month) {
    return 'Sama seperti di $month';
  }

  @override
  String recapMoreThan(String value, String month) {
    return '$value lebih banyak dari $month';
  }

  @override
  String recapLessThan(String value, String month) {
    return '$value lebih sedikit dari $month';
  }

  @override
  String get recapTickMedals => 'Medali';

  @override
  String get recapTickSleep => 'Tidur';

  @override
  String get recapMedalsKicker => 'Medali yang kamu raih';

  @override
  String recapMedalsMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Dan $n lagi', one: 'Dan satu lagi');
    return '$_temp0';
  }

  @override
  String get recapSleepKicker => 'Kamu tidur';

  @override
  String get recapSleepAvg => 'rata-rata semalam';

  @override
  String recapSleepBest(String value, String date) {
    return 'Malam terbaik: $value, $date';
  }

  @override
  String get recapCardSummary => 'Ringkasan';

  @override
  String get recapCardCalendar => 'Kalender';

  @override
  String get recapCardLift => 'Gerakan';

  @override
  String get recapPeakKicker => 'Sesi terberatmu';

  @override
  String get recapTickPeak => 'Sesi';

  @override
  String get recapFreshKicker => 'Pertama kali bulan ini';

  @override
  String recapFresh(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'gerakan baru');
    return '$_temp0';
  }

  @override
  String get recapTickFresh => 'Baru';

  @override
  String recapStreak(int n) {
    return '$n hari berturut-turut, runtutan terpanjangmu';
  }

  @override
  String recapYearAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n latihan');
    return 'Setahun lalu: $_temp0';
  }

  @override
  String recapForgot(String muscle) {
    return 'Terlewat bulan ini: $muscle';
  }

  @override
  String recapFoodProtein(int goal) {
    return 'protein sehari · target $goal g';
  }

  @override
  String recapFoodStarDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Di piringmu $n hari',
      one: 'Di piringmu 1 hari',
    );
    return '$_temp0';
  }

  @override
  String get recapFoodProteinLabel => 'Protein · g/hari';

  @override
  String get recapFoodGoalDays => 'Target tercapai';

  @override
  String get recapFoodWaterLabel => 'Air/hari';

  @override
  String recapFoodTimes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari');
    return '$_temp0';
  }

  @override
  String get recapFoodStarKicker => 'Makananmu bulan ini';

  @override
  String get onbSpeedTitle => 'Biar lancar';

  @override
  String get onbSpeedWhy =>
      'Ponselmu sepertinya bekerja keras. Matikan ini dan semuanya akan lebih lancar: coba dan lihat pratinjaunya.';

  @override
  String get onbSpeedMotion => 'Animasi';

  @override
  String get onbSpeedBlurHint => 'Kaca buram di balik panel dan bilah';

  @override
  String get onbSpeedMotionHint => 'Layar dan panel yang bergeser masuk';

  @override
  String get onbSpeedLater => 'Kamu bisa mengubahnya kapan saja di Pengaturan › Umum › Performa.';

  @override
  String get notifSoundSetting => 'Suara notifikasi';

  @override
  String get notifSoundRowHint => 'Suara tiap jenis pengingat';

  @override
  String get notifSoundHint =>
      'Pilih suara untuk tiap jenis pengingat. Dari ponsel membuka suara ponselmu, dan di kebanyakan ponsel kamu bisa menambahkan lagumu sendiri di sana.';

  @override
  String get notifSoundTrain => 'Latihan';

  @override
  String get notifSoundFood => 'Makanan, suplemen, dan puasa';

  @override
  String get notifSoundOther => 'Foto dan ukuran tubuh';

  @override
  String get notifSoundNormal => 'Normal';

  @override
  String get notifSoundPhone => 'Dari ponsel';

  @override
  String get notifSoundSilent => 'Senyap';

  @override
  String get notifSoundPhoneHint => 'Ketuk salah satu untuk mendengarnya. Langsung tersimpan.';

  @override
  String get notifSoundMore => 'File lain…';

  @override
  String get notifSoundChange => 'Ubah';

  @override
  String get workoutNoteAdd => 'Catatan tersemat: kursi, pegangan, mesin…';

  @override
  String get autoProgressSetting => 'Progresi otomatis';

  @override
  String get autoProgressRowHint => 'Yang disarankan untuk lain kali';

  @override
  String get autoProgressOff => 'Mati';

  @override
  String get autoProgressWeight => 'Tambah beban';

  @override
  String get autoProgressReps => 'Tambah repetisi';

  @override
  String get autoProgressHint =>
      'Saat kamu memulai latihan, GymMane mengisi langkah berikutnya untuk tiap gerakan. Dengan Tambah repetisi kamu menambah satu repetisi per set sampai 12, lalu beban naik dan kamu mulai lagi dari 8. Kamu tetap bisa menyesuaikan tiap gerakan di halamannya.';

  @override
  String get noteFolders => 'Folder';

  @override
  String get noteFolderNew => 'Folder baru';

  @override
  String get noteFolderEdit => 'Edit folder';

  @override
  String get noteFolderName => 'Nama folder';

  @override
  String get noteFolderLabel => 'Folder';

  @override
  String get noteFolderNone => 'Tanpa folder';

  @override
  String get noteFolderDelete => 'Hapus foldernya?';

  @override
  String get noteFolderDeleteBody => 'Catatan tetap disimpan: hanya keluar dari folder.';

  @override
  String get foodArchivedToast => 'Makanan diarsipkan';

  @override
  String get planArchivedToast => 'Rencana diarsipkan';

  @override
  String get suppArchivedToast => 'Suplemen diarsipkan';

  @override
  String get voiceSetting => 'Suara latihan';

  @override
  String get voiceSettingHint =>
      'Menyebutkan set berikutnya dan menghitung mundur akhir istirahat, dengan suara ponsel';

  @override
  String get voiceHello => 'Suara aktif';

  @override
  String voiceRest(String time) {
    return 'Istirahat $time.';
  }

  @override
  String voiceNext(String name, String load) {
    return 'Berikutnya: $name, $load.';
  }

  @override
  String voiceLoad(int reps, String weight) {
    return '$reps repetisi dengan $weight';
  }

  @override
  String voiceReps(int reps) {
    return '$reps repetisi';
  }

  @override
  String get voiceGo => 'Ayo!';

  @override
  String get deloadSetting => 'Minggu deload';

  @override
  String get deloadOff => 'Tidak pernah';

  @override
  String deloadEvery(int weeks) {
    return 'Setiap $weeks minggu';
  }

  @override
  String get deloadHint =>
      'Setiap beberapa minggu, satu minggu lebih ringan untuk pulih: setengah set dan beban 10 % lebih ringan. Minggu itu tidak dihitung untuk progresi.';

  @override
  String get deloadRowHint => 'Minggu ringan setiap beberapa minggu';

  @override
  String get deloadNow => 'Minggu deload';

  @override
  String get deloadNowHint => 'Hari ini setengah set dan beban 10 % lebih ringan';

  @override
  String deloadIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: 'Dalam $weeks minggu',
      one: 'Minggu depan',
      zero: 'Minggu ini',
    );
    return '$_temp0';
  }

  @override
  String get deloadSkip => 'Latihan seperti biasa';

  @override
  String get voiceSheetTitle => 'Cara kerja suara';

  @override
  String get voicePointRest =>
      'Saat kamu mencentang set, ia memberi tahu waktu istirahat dan apa berikutnya.';

  @override
  String get voicePointCount => 'Ia menghitung 3, 2, 1 di akhir istirahat dan memanggilmu kembali.';

  @override
  String get voicePointPhone => 'Memakai suara ponselmu dan diputar di atas musikmu.';

  @override
  String get voiceTry => 'Coba suaranya';

  @override
  String get voiceNoEngine => 'Ponselmu tidak punya mesin suara yang aktif.';

  @override
  String get voiceNoLang => 'Suara untuk bahasamu belum ada. Unduh di pengaturan suara ponselmu.';

  @override
  String get voiceOpenSettings => 'Pengaturan suara';

  @override
  String voiceMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count menit');
    return '$_temp0';
  }

  @override
  String voiceSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count detik');
    return '$_temp0';
  }

  @override
  String get voiceAnd => 'dan';

  @override
  String get repRecordsTitle => 'Beban terbaik per repetisi';

  @override
  String suppUnitCapsule(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'kapsul');
    return '$_temp0';
  }

  @override
  String suppUnitPill(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'tablet');
    return '$_temp0';
  }

  @override
  String suppUnitScoop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'sendok takar');
    return '$_temp0';
  }

  @override
  String suppUnitDrop(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'tetes');
    return '$_temp0';
  }

  @override
  String suppUnitServing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'porsi');
    return '$_temp0';
  }

  @override
  String get suppUnitIu => 'IU';

  @override
  String get suppLeft => 'Sisa';

  @override
  String get suppLeftHint => 'Opsional';

  @override
  String suppLeftFor(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Cukup untuk $n hari');
    return '$_temp0';
  }

  @override
  String suppForDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari');
    return '$_temp0';
  }

  @override
  String get suppRanOut => 'Habis';

  @override
  String get lightSession => 'Sesi ringan';

  @override
  String get lightSessionHint =>
      'Disimpan di riwayat dan statistikmu, tapi tidak mengubah target berikutnya.';

  @override
  String get lightSessionNote => 'Tidak dihitung untuk progresi';

  @override
  String get lightSessionOff => 'Matikan';

  @override
  String get eachSideRepsHint =>
      'Catat repetisi kiri dan kanan secara terpisah. Progresi mengikuti sisi yang lebih lemah.';

  @override
  String get repsLeftCol => 'REP KI';

  @override
  String get repsRightCol => 'REP KA';

  @override
  String get repsLeftTitle => 'REPETISI KIRI';

  @override
  String get repsRightTitle => 'REPETISI KANAN';

  @override
  String sidesReps(int l, int r) {
    return 'Ki$l Ka$r';
  }

  @override
  String get progSchemeTitle => 'Progresi beban';

  @override
  String get groupMoveUp => 'Pindahkan grup ke atas';

  @override
  String get groupMoveDown => 'Pindahkan grup ke bawah';

  @override
  String get mealAiRow => 'Tanya AI';

  @override
  String get mealAiRowHint => 'Salin permintaan, tempel jawabannya';

  @override
  String get mealAiTitle => 'Menu dengan AI';

  @override
  String get mealAiSubtitle => 'Bisa dengan chatbot apa pun. Aplikasi tetap offline.';

  @override
  String get mealAiStepAsk => 'Tanya';

  @override
  String get mealAiStepPaste => 'Tempel';

  @override
  String get mealAiWholeDay => 'Seharian';

  @override
  String get mealAiTarget => 'Target';

  @override
  String mealAiLeft(String kcal, int protein) {
    return 'Hari ini kamu masih punya $kcal dan $protein g protein';
  }

  @override
  String get mealAiStyle => 'Seleramu';

  @override
  String get mealAiTagProtein => 'Tinggi protein';

  @override
  String get mealAiTagVeggie => 'Vegetarian';

  @override
  String get mealAiTagVegan => 'Vegan';

  @override
  String get mealAiTagNoGluten => 'Bebas gluten';

  @override
  String get mealAiTagNoLactose => 'Bebas laktosa';

  @override
  String get mealAiTagQuick => 'Cepat';

  @override
  String get mealAiTagNoCook => 'Tanpa masak';

  @override
  String get mealAiTagCheap => 'Hemat';

  @override
  String get mealAiNotesHint => 'Di rumah ada… Aku tidak suka… alergi…';

  @override
  String get mealAiOptions => 'Pilihan';

  @override
  String get mealAiCopy => 'Salin permintaan';

  @override
  String get mealAiCopied => 'Permintaan disalin';

  @override
  String get mealAiCopiedHint => 'Tempel ke AI-mu dan kembali ke sini dengan jawabannya';

  @override
  String get mealAiShowText => 'Lihat permintaan';

  @override
  String get mealAiHideText => 'Sembunyikan permintaan';

  @override
  String get mealAiPasteHint => 'Tempel jawaban AI di sini';

  @override
  String get mealAiReview => 'Periksa jawaban';

  @override
  String get mealAiUnreadable => 'Aku tidak menemukan makanan apa pun di teks itu';

  @override
  String get mealAiUnreadableHint =>
      'Minta AI mengirim JSON-nya saja, dalam satu blok kode, dengan format permintaan.';

  @override
  String get mealAiCopyFix => 'Salin kalimat itu';

  @override
  String mealAiOption(int n) {
    return 'Pilihan $n';
  }

  @override
  String mealAiAddTo(String meal) {
    return 'Tambah ke $meal';
  }

  @override
  String get mealAiAddDay => 'Tambah ke hari ini';

  @override
  String get mealAiAddPick => 'Tambah';

  @override
  String mealAiAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n makanan ditambahkan');
    return '$_temp0';
  }

  @override
  String get mealAiSaveRecipe => 'Simpan sebagai resep';

  @override
  String get mealAiSavePlan => 'Simpan sebagai rencana';

  @override
  String get mealAiRecipeSaved => 'Resep disimpan';

  @override
  String get mealAiPlanSaved => 'Rencana disimpan';

  @override
  String get mealAiFlagEstimated => 'Perkiraan AI';

  @override
  String get mealAiFlagAdjusted => 'Kalori disesuaikan dengan makro';

  @override
  String get mealAiFlagDoubtful => 'Angkanya tidak cocok, periksa';

  @override
  String get mealAiFlagNoValues => 'Tidak ada nilai gizi';

  @override
  String get mealAiFlagNoAmount => 'Jumlah tidak disebutkan';

  @override
  String get mealAiTruncated => 'Jawabannya sepertinya terpotong. Aku menyimpan makanan yang lengkap.';

  @override
  String get mealAiAmount => 'Jumlah';

  @override
  String mealAiTargetLine(String kcal) {
    return 'Target $kcal';
  }

  @override
  String get mealAiNothingChosen => 'Nyalakan setidaknya satu makanan';

  @override
  String get cholesterolLabel => 'Kolesterol';

  @override
  String get mealAiFlagMatched => 'Sama dengan makanan yang kamu simpan';

  @override
  String get mealAiNotSame => 'Tidak sama';

  @override
  String get homeOrderRow => 'Urutan bagian';

  @override
  String get homeOrderHint => 'Tahan dan seret untuk mengubah urutan Beranda.';

  @override
  String get homeOrderFolders => 'Pintasan';

  @override
  String get equipNew => 'Baru';

  @override
  String get equipNewTitle => 'Peralatan baru';

  @override
  String get equipNewHint => 'mis. Sabuk angkat beban';

  @override
  String get homeOrderWeekdays => 'Centang mingguan';

  @override
  String get repsMaxTitle => 'Repetisi hingga';

  @override
  String get repsRangeHint => 'Tekan lama repetisi untuk mengatur rentang seperti 8-12.';

  @override
  String get repsRangeClear => 'Hapus rentang';

  @override
  String get noteLinksLabel => 'TAUTAN';

  @override
  String get noteLinkAdd => 'Tambah tautan';

  @override
  String get noteLinkEdit => 'Edit tautan';

  @override
  String get noteLinkNameHint => 'Nama';

  @override
  String get noteLinkUrlHint => 'Alamat web';

  @override
  String get noteLinkInvalid => 'Alamat itu sepertinya tidak benar';

  @override
  String get changeRest => 'Istirahat antargerakan';

  @override
  String get changeRestHint => 'Setelah set terakhir, sebelum gerakan berikutnya';

  @override
  String get notifSuppTake => 'Sudah';

  @override
  String get sideRest => 'Istirahat antarsisi';

  @override
  String get sideRestHint => 'Gerakan per sisi: ✓ pertama menyelesaikan satu sisi';

  @override
  String get gfxCompat => 'Grafis kompatibel';

  @override
  String get gfxCompatHint =>
      'Untuk ponsel yang hurufnya tampak rusak. Blur tetap ada, beberapa efek jadi lebih sederhana';

  @override
  String get gfxRestartTitle => 'Mulai ulang GymMane?';

  @override
  String get gfxRestartBody =>
      'Aplikasi ditutup dan dibuka lagi untuk mengubah cara menggambar layar. Tidak ada yang kamu simpan yang hilang.';

  @override
  String get gfxRestart => 'Mulai ulang';

  @override
  String get webSynced => 'Diperbarui dengan perubahan dari perangkat lain';

  @override
  String get webSyncedPhone => 'Perubahan dari ponselmu sudah masuk';

  @override
  String get webWelcomeBlurb => 'Semuanya tetap di servermu sendiri. Tanpa akun, tanpa cloud, tanpa bayar.';

  @override
  String get webOwnServer => 'Servermu, aturanmu';

  @override
  String get webOwnServerWhy =>
      'Tanpa akun dan tanpa cloud pihak ketiga. Datamu ada di tempat kamu menjalankannya.';

  @override
  String get webServerSaved => 'Tersimpan di servermu';

  @override
  String get webServerOffline => 'Tidak bisa menjangkau servermu';

  @override
  String get webServerLocal => 'Tersimpan di browser ini';

  @override
  String get webServerTitle => 'Servermu';

  @override
  String webPhoneLast(String date) {
    return 'Salinan terakhir dari ponselmu: $date';
  }

  @override
  String get webPhoneNone => 'Belum ada salinan dari ponselmu';

  @override
  String get webPhoneScan => 'Ambil dari ponsel';

  @override
  String get webPhoneExport => 'Kirim ke ponsel';

  @override
  String get webPhoneExportDone => 'Disimpan di folder bersama. Ponselmu mengambilnya saat sinkronisasi';

  @override
  String get webPhoneImported => 'Perubahan dari ponselmu sudah masuk';

  @override
  String get webPhoneNothing => 'Tidak ada yang baru dari ponselmu';

  @override
  String get webPhoneHow =>
      'Nyalakan cadangan otomatis di ponselmu ke folder yang kamu sinkronkan dengan Syncthing. Server dan ponsel saling mengambil perubahan dengan sendirinya, dan penggabungan tidak pernah menghapus apa pun.';

  @override
  String get webPhoneGuide => 'Cara mengaturnya';

  @override
  String get webPhoneOff => 'Sinkronisasi ponsel mati di server ini';

  @override
  String get toolGroupBody => 'Tubuh';

  @override
  String get toolNameProtein => 'Protein';

  @override
  String get toolTitleProtein => 'Protein harian';

  @override
  String get toolDescProtein => 'Berapa protein sehari';

  @override
  String get toolHintProtein => 'Gram sehari, dibagi ke waktu makanmu';

  @override
  String get proteinGoalLabel => 'Target';

  @override
  String get proteinExplain =>
      'Berdasarkan rentang yang disepakati sebagian besar penelitian untuk orang yang berlatih: lebih banyak saat kamu menurunkan berat badan, untuk menjaga ototmu. Melebihinya aman, hanya menambah sedikit manfaat.';

  @override
  String get toolNameWater => 'Air';

  @override
  String get toolTitleWater => 'Air harian';

  @override
  String get toolDescWater => 'Berapa banyak minum sehari';

  @override
  String get toolHintWater => 'Liter sehari, termasuk dari makanan';

  @override
  String get waterTrainingLabel => 'Latihan per hari';

  @override
  String get waterExplain =>
      'Sekitar 35 ml per kilo berat badan, ditambah sedikit untuk tiap menit latihan. Minum lebih banyak saat cuaca panas.';

  @override
  String get autoBackupSync => 'Sinkronkan sekarang';

  @override
  String get autoBackupMerged => 'Perubahan dari perangkatmu yang lain sudah masuk';

  @override
  String get autoBackupSyncHint =>
      'Bagikan folder ini dengan Syncthing dan tiap perangkat mengambil yang ditinggalkan perangkat lain di sini. Penggabungan tidak pernah menghapus apa pun.';

  @override
  String get webPhoneFolder => 'Folder bersama';

  @override
  String get webPhoneFolderHow =>
      'Dipilih saat memasang server. Untuk mengubahnya, atur GYMMANE_SYNC di file .env server lalu mulai ulang.';

  @override
  String get webPhoneOffHow =>
      'Untuk menyalakannya, hapus GYMMANE_SYNC=off dari file .env server lalu mulai ulang.';

  @override
  String webPhoneDevices(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ponsel tersinkron',
      zero: 'Belum ada ponsel yang tersinkron',
    );
    return '$_temp0';
  }

  @override
  String webPhoneError(String error) {
    return 'Folder tidak bisa dibaca: $error';
  }

  @override
  String get duplicateExercise => 'Duplikat';

  @override
  String exerciseCopyName(String name) {
    return '$name (salinan)';
  }
}
