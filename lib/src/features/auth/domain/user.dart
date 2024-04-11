enum Gender {
  male('Male'),
  female('Female');

  final String value;
  const Gender(this.value);
}

enum Activity {
  rare('Little or no exercise'),
  medium('2-3 exercise/weeks'),
  active('Very active');

  final String value;
  const Activity(this.value);
}

enum WeightGoal {
  gain('Gain weight'),
  maintain('Maintain weight'),
  lose('Lose weight');

  final String value;
  const WeightGoal(this.value);
}

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String fetalId;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.fetalId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      fetalId: json['fetalId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'fetalId': fetalId,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? fetalId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      fetalId: fetalId ?? this.fetalId,
    );
  }
}
