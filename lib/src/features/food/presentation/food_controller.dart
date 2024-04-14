import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nutrimama/src/features/food/data/food_repository.dart';
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
    Logger().i('getFoods');
    state = state.copyWith(foods: const AsyncLoading());
    final result = await ref.read(foodRepositoryProvider).getFoods();
    result.when(
      success: (foods) {
        state = state.copyWith(foods: AsyncData(foods));
      },
      failure: (e, s) {
        state = state.copyWith(foods: AsyncError(e, s));
      },
    );
  }

  Future<void> getFood(String id) async {
    state = state.copyWith(food: const AsyncLoading());
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

  //add FOod
  Future<void> addFood() async {
    await ref.read(foodRepositoryProvider).addFood();
  }
}
