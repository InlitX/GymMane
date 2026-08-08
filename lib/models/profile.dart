class Profile {
  Profile({
    this.name = 'InlitX',
    this.sex = 'male',
    this.age = 28,
    this.heightCm = 175,
    this.weightKg = 75,
    this.activity = 1.55,
    this.weeklyGoal = 4,
    this.photo = '',
  });

  String name;
  String sex;
  int age;
  double heightCm;
  double weightKg;
  double activity;
  int weeklyGoal;
  String photo;

  Map<String, dynamic> toJson() => {
        'name': name,
        'sex': sex,
        'age': age,
        'h': heightCm,
        'w': weightKg,
        'act': activity,
        'goal': weeklyGoal,
        if (photo.isNotEmpty) 'photo': photo,
      };
  factory Profile.fromJson(Map<String, dynamic> j) => Profile(
        name: (j['name'] as String?) ?? 'InlitX',
        sex: (j['sex'] as String?) ?? 'male',
        age: (j['age'] as num?)?.toInt() ?? 28,
        heightCm: (j['h'] as num?)?.toDouble() ?? 175,
        weightKg: (j['w'] as num?)?.toDouble() ?? 75,
        activity: (j['act'] as num?)?.toDouble() ?? 1.55,
        weeklyGoal: (j['goal'] as num?)?.toInt() ?? 4,
        photo: (j['photo'] as String?) ?? '',
      );
}
