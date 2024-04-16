class Fetal {
  final String id;
  final String fetalId;
  final double weight;
  final double length;
  final int heartRate;
  final DateTime? date;
  final DateTime fetalDate;
  final bool isBorn;

  Fetal({
    required this.id,
    required this.fetalId,
    required this.weight,
    required this.length,
    required this.heartRate,
    required this.date,
    required this.fetalDate,
    this.isBorn = false,
  });

  factory Fetal.fromJson(Map<String, dynamic> json) {
    return Fetal(
      id: json['id'] ?? '',
      fetalId: json['fetalId'] ?? '',
      weight: json['weight'] == null ? 0 : json['weight'].toDouble(),
      length: json['length'] == null ? 0 : json['length'].toDouble(),
      heartRate: json['heartRate'] ?? 0,
      date: json['date'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['date']),
      fetalDate: json['fetalDate'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json['fetalDate']),
      isBorn: json['isBorn'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fetalId': fetalId,
      'weight': weight,
      'length': length,
      'heartRate': heartRate,
      'date': date?.millisecondsSinceEpoch,
      'fetalDate': fetalDate.millisecondsSinceEpoch,
      'isBorn': isBorn,
    };
  }

  Fetal copyWith({
    String? id,
    String? fetalId,
    double? weight,
    double? length,
    int? heartRate,
    DateTime? date,
    DateTime? fetalDate,
    bool? isBorn,
  }) {
    return Fetal(
      id: id ?? this.id,
      fetalId: fetalId ?? this.fetalId,
      weight: weight ?? this.weight,
      length: length ?? this.length,
      heartRate: heartRate ?? this.heartRate,
      date: date ?? this.date,
      fetalDate: fetalDate ?? this.fetalDate,
      isBorn: isBorn ?? this.isBorn,
    );
  }
}
