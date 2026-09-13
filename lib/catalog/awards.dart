import '../l10n/l10n.dart';
import '../state/fit_state.dart';

String medalAsset(AwardId id) => 'assets/badges/${id.name}.webp';

String medalOffAsset(AwardId id) => 'assets/badges/${id.name}_off.webp';

String medalSpinAsset(AwardId id) => 'assets/badges/spin/${id.name}.webp';

String awardName(AwardId id) => switch (id) {
      AwardId.firstStep => t.awardFirstStepName,
      AwardId.firstWorkout => t.awardFirstWorkoutName,
      AwardId.firstRoutine => t.awardFirstRoutineName,
      AwardId.firstRecord => t.awardFirstRecordName,
      AwardId.streak3 => t.awardStreak3Name,
      AwardId.streak7 => t.awardStreak7Name,
      AwardId.workouts10 => t.awardWorkouts10Name,
      AwardId.tonne1 => t.awardTonne1Name,
      AwardId.sets100 => t.awardSets100Name,
      AwardId.hours10 => t.awardHours10Name,
      AwardId.workouts50 => t.awardWorkouts50Name,
      AwardId.tonnes10 => t.awardTonnes10Name,
      AwardId.hours50 => t.awardHours50Name,
      AwardId.streak30 => t.awardStreak30Name,
      AwardId.sets1000 => t.awardSets1000Name,
      AwardId.workouts100 => t.awardWorkouts100Name,
      AwardId.hours100 => t.awardHours100Name,
      AwardId.streak100 => t.awardStreak100Name,
      AwardId.tonnes100 => t.awardTonnes100Name,
      AwardId.workouts365 => t.awardWorkouts365Name,
    };

String awardLine(AwardId id) => switch (id) {
      AwardId.firstStep => t.awardFirstStepLine,
      AwardId.firstWorkout => t.awardFirstWorkoutLine,
      AwardId.firstRoutine => t.awardFirstRoutineLine,
      AwardId.firstRecord => t.awardFirstRecordLine,
      AwardId.streak3 => t.awardStreak3Line,
      AwardId.streak7 => t.awardStreak7Line,
      AwardId.workouts10 => t.awardWorkouts10Line,
      AwardId.tonne1 => t.awardTonne1Line,
      AwardId.sets100 => t.awardSets100Line,
      AwardId.hours10 => t.awardHours10Line,
      AwardId.workouts50 => t.awardWorkouts50Line,
      AwardId.tonnes10 => t.awardTonnes10Line,
      AwardId.hours50 => t.awardHours50Line,
      AwardId.streak30 => t.awardStreak30Line,
      AwardId.sets1000 => t.awardSets1000Line,
      AwardId.workouts100 => t.awardWorkouts100Line,
      AwardId.hours100 => t.awardHours100Line,
      AwardId.streak100 => t.awardStreak100Line,
      AwardId.tonnes100 => t.awardTonnes100Line,
      AwardId.workouts365 => t.awardWorkouts365Line,
    };
