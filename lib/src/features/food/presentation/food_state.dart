import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FoodState {
  final AsyncValue<List<Food>?> foods;
  final AsyncValue<Food?> food;
  final TextEditingController searchController;

  FoodState({
    this.foods = const AsyncLoading(),
    this.food = const AsyncLoading(),
    required this.searchController,
  });

  FoodState copyWith({
    AsyncValue<List<Food>?>? foods,
    AsyncValue<Food?>? food,
    TextEditingController? searchController,
  }) {
    return FoodState(
      foods: foods ?? this.foods,
      food: food ?? this.food,
      searchController: searchController ?? this.searchController,
    );
  }
}
