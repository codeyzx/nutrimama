import 'package:nutrimama/src/features/nutrition/domain/nutrition.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class NutritionState {
  final AsyncValue<Nutrition> nutrition;

  NutritionState({
    this.nutrition = const AsyncLoading(),
  });

  NutritionState copyWith({
    AsyncValue<Nutrition>? nutrition,
  }) {
    return NutritionState(
      nutrition: nutrition ?? this.nutrition,
    );
  }
}
