class ProgramDay {
  const ProgramDay(this.name, this.exercises, {this.weekday});

  final String name;
  final List<(String, int)> exercises;
  final int? weekday;
}

class ProgramTemplate {
  const ProgramTemplate(this.id, this.name, this.days);

  final String id;
  final String name;
  final List<ProgramDay> days;
}

const List<ProgramTemplate> kProgramTemplates = [
  ProgramTemplate('fullbody', 'Full Body', [
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 1),
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 3),
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 5),
  ]),
  ProgramTemplate('ppl', 'Push Pull Legs', [
    ProgramDay('Push', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 3),
      ('Overhead Press', 3),
      ('Lateral Raise', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 1),
    ProgramDay('Pull', [
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Lat Pulldown', 3),
      ('Face Pull', 3),
      ('Barbell Curl', 3),
    ], weekday: 3),
    ProgramDay('Legs', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 5),
  ]),
  ProgramTemplate('upperlower', 'Upper Lower', [
    ProgramDay('Upper', [
      ('Barbell Bench Press', 4),
      ('Barbell Row', 4),
      ('Overhead Press', 3),
      ('Lat Pulldown', 3),
      ('Barbell Curl', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 1),
    ProgramDay('Lower', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 2),
    ProgramDay('Upper', [
      ('Incline Dumbbell Press', 4),
      ('Pull Up', 4),
      ('Dumbbell Standing Overhead Press', 3),
      ('Seated Cable Row', 3),
      ('Hammer Curl', 3),
      ('Triceps Dip', 3),
    ], weekday: 4),
    ProgramDay('Lower', [
      ('Deadlift', 3),
      ('Front Squat', 3),
      ('Leg Extension', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 5),
  ]),
  ProgramTemplate('stronglifts', 'StrongLifts 5×5', [
    ProgramDay('Workout A', [
      ('Barbell Squat', 5),
      ('Barbell Bench Press', 5),
      ('Barbell Row', 5),
    ], weekday: 1),
    ProgramDay('Workout B', [
      ('Barbell Squat', 5),
      ('Overhead Press', 5),
      ('Deadlift', 1),
    ], weekday: 3),
  ]),
  ProgramTemplate('startingstrength', 'Starting Strength', [
    ProgramDay('Workout A', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Deadlift', 1),
    ], weekday: 1),
    ProgramDay('Workout B', [
      ('Barbell Squat', 3),
      ('Overhead Press', 3),
      ('Barbell Row', 3),
    ], weekday: 3),
  ]),
  ProgramTemplate('home', 'No Kit', [
    ProgramDay('Home A', [
      ('Push Up', 3),
      ('Pull Up', 3),
      ('Bodyweight Squat', 3),
      ('Plank', 3),
    ], weekday: 2),
    ProgramDay('Home B', [
      ('Triceps Dip', 3),
      ('Chin Up', 3),
      ('Lunge', 3),
      ('Hanging Leg Raise', 3),
    ], weekday: 5),
  ]),
];
