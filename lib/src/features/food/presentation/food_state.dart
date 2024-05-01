import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FoodState {
  final AsyncValue<List<Food>?> searchFoods;
  final AsyncValue<List<Food>?> foods;
  final AsyncValue<Food?> food;
  final TextEditingController searchController;
  final bool isGuide;

  FoodState({
    this.searchFoods = const AsyncLoading(),
    this.foods = const AsyncLoading(),
    this.food = const AsyncLoading(),
    required this.searchController,
    this.isGuide = false,
  });

  FoodState copyWith({
    AsyncValue<List<Food>?>? searchFoods,
    AsyncValue<List<Food>?>? foods,
    AsyncValue<Food?>? food,
    TextEditingController? searchController,
    bool? isGuide,
  }) {
    return FoodState(
      searchFoods: searchFoods ?? this.searchFoods,
      foods: foods ?? this.foods,
      food: food ?? this.food,
      searchController: searchController ?? this.searchController,
      isGuide: isGuide ?? this.isGuide,
    );
  }
}
