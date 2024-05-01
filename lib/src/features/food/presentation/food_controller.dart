import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/food/data/food_repository.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/features/food/presentation/food_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_controller.g.dart';

@riverpod
class FoodController extends _$FoodController {
  @override
  FoodState build() {
    getFoods();
    return FoodState(
      searchController: TextEditingController(),
    );
  }

  Future<void> getFoods() async {
    final result = await ref.read(foodRepositoryProvider).getFoods();
    result.when(
      success: (foods) {
        state = state.copyWith(
            foods: AsyncData(foods), searchFoods: AsyncData(foods));
      },
      failure: (e, s) {
        state = state.copyWith(
            foods: AsyncError(e, s), searchFoods: AsyncError(e, s));
      },
    );
  }

  Future<void> getFood(String id) async {
    final result = await ref.read(foodRepositoryProvider).getFood(id);
    result.when(
      success: (food) {
        state = state.copyWith(food: AsyncData(food));
      },
      failure: (e, s) {
        state = state.copyWith(food: AsyncError(e, s));
      },
    );
  }

  Future<void> searchFoods() async {
    final query = state.searchController.text;
    if (query.isEmpty) {
      state = state.copyWith(searchFoods: state.foods);
    }
    List<Food> foods = state.foods.asData!.value ?? [];
    final result = foods
        .where((food) => food.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = state.copyWith(searchFoods: AsyncData(result));
  }

  Future<void> addFood() async {
    await ref.read(foodRepositoryProvider).addFood();
  }

  void setGuide() {
    state = state.copyWith(isGuide: !state.isGuide);
  }
}
