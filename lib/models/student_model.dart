class Student {
  final String name;
  final String email;
  final String instrument;
  final String skillLevel;

  Student({
    required this.name,
    required this.email,
    required this.instrument,
    required this.skillLevel,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      instrument: json['instrument'] ?? '',
      skillLevel: json['skill_level'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'instrument': instrument,
      'skill_level': skillLevel,
    };
  }
}
