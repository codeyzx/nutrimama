import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/nutrition/domain/nutrition.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class NutritionState {
  final AsyncValue<Nutrition> nutrition;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String? age;
  final List<Map<String, String>> ageList;

  NutritionState({
    this.nutrition = const AsyncLoading(),
    required this.weightController,
    required this.heightController,
    this.age,
  }) : ageList = List.generate(91, (index) => index + 20)
            .map((e) => {'value': e.toString(), 'text': e.toString()})
            .toList();

  NutritionState copyWith({
    AsyncValue<Nutrition>? nutrition,
    TextEditingController? weightController,
    TextEditingController? heightController,
    String? age,
  }) {
    return NutritionState(
      nutrition: nutrition ?? this.nutrition,
      weightController: weightController ?? this.weightController,
      heightController: heightController ?? this.heightController,
      age: age ?? this.age,
    );
  }
}
