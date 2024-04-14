import 'package:nutrimama/src/features/food/domain/ingredients.dart';
import 'package:nutrimama/src/features/food/domain/instructions.dart';

class Food {
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
  final List<Ingredients> ingredients;
  final List<Instructions> instructions;
  final String imageUrl;

  Food({
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
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
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
      ingredients: json['ingredients'] == null
          ? []
          : List<Ingredients>.from(
              json['ingredients'].map((x) => Ingredients.fromJson(x))),
      instructions: json['instructions'] == null
          ? []
          : List<Instructions>.from(
              json['instructions'].map((x) => Instructions.fromJson(x))),
      imageUrl: json['imageUrl'] ?? '',
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
      'ingredients': List<dynamic>.from(ingredients.map((x) => x.toJson())),
      'instructions': List<dynamic>.from(instructions.map((x) => x.toJson())),
      'imageUrl': imageUrl,
    };
  }

  Food copyWith({
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
    List<Ingredients>? ingredients,
    List<Instructions>? instructions,
    String? imageUrl,
  }) {
    return Food(
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
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
