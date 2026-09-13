part of 'fit_state.dart';

enum AwardId {
  firstStep,
  firstWorkout,
  firstRoutine,
  firstRecord,
  streak3,
  streak7,
  workouts10,
  tonne1,
  sets100,
  hours10,
  workouts50,
  tonnes10,
  hours50,
  streak30,
  sets1000,
  workouts100,
  hours100,
  streak100,
  tonnes100,
  workouts365,
}

mixin AwardsState on FitCore, StatsState, SettingsState {
  final Map<String, DateTime> awards = {};
  final List<AwardId> pendingAwards = [];
  final Set<String> awardsSeen = {};

  int awardGoal(AwardId id) => switch (id) {
        AwardId.firstStep ||
        AwardId.firstWorkout ||
        AwardId.firstRoutine ||
        AwardId.firstRecord =>
          1,
        AwardId.streak3 => 3,
        AwardId.streak7 => 7,
        AwardId.streak30 => 30,
        AwardId.streak100 => 100,
        AwardId.workouts10 => 10,
        AwardId.workouts50 => 50,
        AwardId.workouts100 => 100,
        AwardId.workouts365 => 365,
        AwardId.tonne1 => 1000,
        AwardId.tonnes10 => 10000,
        AwardId.tonnes100 => 100000,
        AwardId.sets100 => 100,
        AwardId.sets1000 => 1000,
        AwardId.hours10 => 10,
        AwardId.hours50 => 50,
        AwardId.hours100 => 100,
      };

  int awardValue(AwardId id) => switch (id) {
        AwardId.firstStep => onboarded ? 1 : 0,
        AwardId.firstRoutine => routines.length,
        AwardId.firstRecord => personalRecords.length,
        AwardId.streak3 ||
        AwardId.streak7 ||
        AwardId.streak30 ||
        AwardId.streak100 =>
          currentStreak,
        AwardId.firstWorkout ||
        AwardId.workouts10 ||
        AwardId.workouts50 ||
        AwardId.workouts100 ||
        AwardId.workouts365 =>
          totalSessions,
        AwardId.tonne1 || AwardId.tonnes10 || AwardId.tonnes100 => totalVolumeKg.round(),
        AwardId.sets100 || AwardId.sets1000 => totalSets,
        AwardId.hours10 || AwardId.hours50 || AwardId.hours100 => totalTime.inHours,
      };

  double awardProgress(AwardId id) =>
      (awardValue(id) / awardGoal(id)).clamp(0.0, 1.0);

  bool hasAward(AwardId id) => awards.containsKey(id.name);

  DateTime? awardWonAt(AwardId id) => awards[id.name];

  int get awardCount => awards.length;

  List<AwardId> get unseenAwards =>
      AwardId.values.where((a) => hasAward(a) && !awardsSeen.contains(a.name)).toList();

  @override
  void refreshAwards({bool silent = false}) {
    var won = false;
    for (final id in AwardId.values) {
      if (hasAward(id) || awardValue(id) < awardGoal(id)) continue;
      awards[id.name] = DateTime.now();
      if (!silent) pendingAwards.add(id);
      won = true;
    }
    if (!won) return;
    _persist();
    notifyListeners();
  }

  void goAwards() => pushRoute('awards');

  void backFromAwards() => popRoute(fallback: 'settings');

  AwardId? get nextCelebration => pendingAwards.isEmpty ? null : pendingAwards.first;

  void celebrationShown() {
    if (pendingAwards.isEmpty) return;
    awardsSeen.add(pendingAwards.removeAt(0).name);
    _persist();
    notifyListeners();
  }

  void markAwardsSeen() {
    if (unseenAwards.isEmpty) return;
    awardsSeen.addAll(awards.keys);
    _persist();
    notifyListeners();
  }
}
