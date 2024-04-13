import 'package:nutrimama/src/features/nutrition/data/nutrition_repository.dart';
import 'package:nutrimama/src/features/nutrition/presentation/common_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nutrition_controller.g.dart';

@Riverpod(keepAlive: true)
class NutritionController extends _$NutritionController {
  @override
  NutritionState build() {
    return NutritionState();
  }

  Map<String, dynamic> calculateNutrition(
      {required double weight,
      required double height,
      required int age,
      bool? isUpdateProfile}) {
    double bmr = (10 * weight) + (6.25 * height) - (5 * age) + (-161);

    // Activity level multiplier
    double activityLevelMultiplier = 1.2;

    // Calculate Daily Calories
    double dailyCalories = bmr * activityLevelMultiplier;

    // Macronutrient percentages
    double proteinPercentage = 0.4;

    double fatsPercentage = 0.4;

    double carbsPercentage = 0.3;

    double sugarPercentage = 0.1;

    // Calculate grams of each macronutrient
    double protein = (proteinPercentage * dailyCalories / 4);
    double fats = (fatsPercentage * dailyCalories / 9);
    double carbs = (carbsPercentage * dailyCalories / 4);
    double sugar = (sugarPercentage * dailyCalories / 4);
    double calcium = 1000;
    double iron = 27;

    // take the ceiling of each value
    dailyCalories = dailyCalories.ceilToDouble();
    protein = protein.ceilToDouble();
    fats = fats.ceilToDouble();
    carbs = carbs.ceilToDouble();
    sugar = sugar.ceilToDouble();

    // Display results
    if (isUpdateProfile != null && isUpdateProfile) {
      return {
        'calories': dailyCalories.toInt(),
        'carbs': carbs.toInt(),
        'fat': fats.toInt(),
        'protein': protein.toInt(),
        'iron': iron.toInt(),
        'calcium': calcium.toInt(),
        'sugars': sugar.toInt(),
      };
    } else {
      return {
        'age': age,
        'weight': weight,
        'height': height,
        'calories': dailyCalories.toInt(),
        'carbs': carbs.toInt(),
        'fat': fats.toInt(),
        'protein': protein.toInt(),
        'iron': iron.toInt(),
        'calcium': calcium.toInt(),
        'sugars': sugar.toInt(),
      };
    }
  }

  Future<void> getNutrition(String uid) async {
    state = state.copyWith(
      nutrition: const AsyncLoading(),
    );

    final result =
        await ref.read(nutritionRepositoryProvider).getNutrition(uid);

    result.when(
      success: (data) {
        state = state.copyWith(
          nutrition: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          nutrition: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> updateNutrition(
      Map<String, dynamic> nutrition, String uid) async {
    state = state.copyWith(
      nutrition: const AsyncLoading(),
    );

    final result = await ref
        .read(nutritionRepositoryProvider)
        .updateNutrition(nutrition, uid);

    result.when(
      success: (data) {
        state = state.copyWith(
          nutrition: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          nutrition: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
