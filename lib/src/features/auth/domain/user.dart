class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String fetalId;
  final DateTime? fetalDate;
  final bool isSuccessRegister;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.fetalId,
    required this.fetalDate,
    required this.isSuccessRegister,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      fetalId: json['fetalId'] ?? '',
      fetalDate: json['fetalDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['fetalDate']),
      isSuccessRegister: json['isSuccessRegister'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'fetalId': fetalId,
      'fetalDate': fetalDate?.millisecondsSinceEpoch,
      'isSuccessRegister': isSuccessRegister,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? fetalId,
    DateTime? fetalDate,
    bool? isSuccessRegister,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      fetalId: fetalId ?? this.fetalId,
      fetalDate: fetalDate ?? this.fetalDate,
      isSuccessRegister: isSuccessRegister ?? this.isSuccessRegister,
    );
  }
}
