class Nutrition {
  final int age;
  final double weight;
  final double height;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;
  final double iron;
  final double calcium;
  final double folate;

  Nutrition({
    required this.age,
    required this.weight,
    required this.height,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.iron,
    required this.calcium,
    required this.folate,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      age: json['age'] ?? 0,
      weight: json['weight'] == null ? 0 : json['weight'].toDouble(),
      height: json['height'] == null ? 0 : json['height'].toDouble(),
      calories: json['calories'] == null ? 0 : json['calories'].toDouble(),
      carbs: json['carbs'] == null ? 0 : json['carbs'].toDouble(),
      fat: json['fat'] == null ? 0 : json['fat'].toDouble(),
      protein: json['protein'] == null ? 0 : json['protein'].toDouble(),
      iron: json['iron'] == null ? 0 : json['iron'].toDouble(),
      calcium: json['calcium'] == null ? 0 : json['calcium'].toDouble(),
      folate: json['folate'] == null ? 0 : json['folate'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'age': age,
      'weight': weight,
      'height': height,
      'calories': calories,
      'carbs': carbs,
      'fat': fat,
      'protein': protein,
      'iron': iron,
      'calcium': calcium,
      'folate': folate,
    };
  }

  Nutrition copyWith({
    int? age,
    double? weight,
    double? height,
    double? calories,
    double? carbs,
    double? fat,
    double? protein,
    double? iron,
    double? calcium,
    double? folate,
  }) {
    return Nutrition(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      calories: calories ?? this.calories,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      iron: iron ?? this.iron,
      calcium: calcium ?? this.calcium,
      folate: folate ?? this.folate,
    );
  }
}
