import 'package:nutrimama/src/features/food/domain/food.dart';

class ConsumeFood {
  final String id;
  final String name;
  final String type;
  final int calories;
  final int protein;
  final int carbs;
  final int sugars;
  final int fat;
  final int iron;
  final int calcium;
  final String imageUrl;
  final String consumeAt;

  ConsumeFood({
    required this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.sugars,
    required this.fat,
    required this.iron,
    required this.calcium,
    required this.imageUrl,
    required this.consumeAt,
  });

  factory ConsumeFood.fromFood(Food food, String consumeAt) {
    return ConsumeFood(
      id: food.id,
      name: food.name,
      type: food.type,
      calories: food.calories,
      protein: food.protein,
      carbs: food.carbs,
      sugars: food.sugars,
      fat: food.fat,
      iron: food.iron,
      calcium: food.calcium,
      imageUrl: food.imageUrl,
      consumeAt: consumeAt,
    );
  }

  factory ConsumeFood.fromJson(Map<String, dynamic> json) {
    return ConsumeFood(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      calories: json['calories'] ?? 0,
      protein: json['protein'] ?? 0,
      carbs: json['carbs'] ?? 0,
      sugars: json['sugars'] ?? 0,
      fat: json['fat'] ?? 0,
      iron: json['iron'] ?? 0,
      calcium: json['calcium'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      consumeAt: json['consumeAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'sugars': sugars,
      'fat': fat,
      'iron': iron,
      'calcium': calcium,
      'imageUrl': imageUrl,
      'consumeAt': consumeAt,
    };
  }

  ConsumeFood copyWith({
    String? id,
    String? name,
    String? type,
    int? calories,
    int? protein,
    int? carbs,
    int? sugars,
    int? fat,
    int? iron,
    int? calcium,
    String? imageUrl,
    String? consumeAt,
  }) {
    return ConsumeFood(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      sugars: sugars ?? this.sugars,
      fat: fat ?? this.fat,
      iron: iron ?? this.iron,
      calcium: calcium ?? this.calcium,
      imageUrl: imageUrl ?? this.imageUrl,
      consumeAt: consumeAt ?? this.consumeAt,
    );
  }
}
