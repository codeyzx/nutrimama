class Nutrition {
  final String id;
  final int age;
  final double weight;
  final double height;
  final int calories;
  final int carbs;
  final int fat;
  final int protein;
  final int iron;
  final int calcium;
  final int sugars;

  Nutrition({
    required this.id,
    required this.age,
    required this.weight,
    required this.height,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.iron,
    required this.calcium,
    required this.sugars,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'] ?? '',
      age: json['age'] ?? 0,
      weight: json['weight'] == null ? 0 : json['weight'].toDouble(),
      height: json['height'] == null ? 0 : json['height'].toDouble(),
      calories: json['calories'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fat: json['fat'] ?? 0,
      protein: json['protein'] ?? 0,
      iron: json['iron'] ?? 0,
      calcium: json['calcium'] ?? 0,
      sugars: json['sugars'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'age': age,
      'weight': weight,
      'height': height,
      'calories': calories,
      'carbs': carbs,
      'fat': fat,
      'protein': protein,
      'iron': iron,
      'calcium': calcium,
      'sugars': sugars,
    };
  }

  Nutrition copyWith({
    String? id,
    int? age,
    double? weight,
    double? height,
    int? calories,
    int? carbs,
    int? fat,
    int? protein,
    int? iron,
    int? calcium,
    int? sugars,
  }) {
    return Nutrition(
      id: id ?? this.id,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      calories: calories ?? this.calories,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      iron: iron ?? this.iron,
      calcium: calcium ?? this.calcium,
      sugars: sugars ?? this.sugars,
    );
  }
}
