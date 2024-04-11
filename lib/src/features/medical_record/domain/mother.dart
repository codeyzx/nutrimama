class Mother {
  final String id;
  final DateTime date;
  final double weight;
  final String bloodPressure;

  Mother({
    required this.id,
    required this.date,
    required this.weight,
    required this.bloodPressure,
  });

  factory Mother.fromJson(Map<String, dynamic> json) {
    return Mother(
      id: json['id'] ?? '',
      date: json['date'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json['date']),
      weight: json['weight'] == null ? 0 : json['weight'].toDouble(),
      bloodPressure: json['bloodPressure'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'weight': weight,
      'bloodPressure': bloodPressure,
    };
  }

  Mother copyWith({
    String? id,
    DateTime? date,
    double? weight,
    String? bloodPressure,
  }) {
    return Mother(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bloodPressure: bloodPressure ?? this.bloodPressure,
    );
  }
}
